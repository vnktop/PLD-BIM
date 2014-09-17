using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLDWS.DataAccess.Context;

using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Web;

using System.Configuration;

using Seguridad.Logic.Utilidades;

namespace BIM.DataAccess
{
    public class VerificadorPLDDataAccess
    {
        #region variables globales
        private enum TipoLista
        {
            NORMAL = 1,
            PEP = 2,
            VENC = 3,
            NEGRA = 4
        }

        private enum CRUD
        {
            insertar = 1,
            leerBusqueda = 2,
            leerTotalCorreo = 3,
            desbloquearUsuario = 4,
            //actualizar = 5,
            desbloquearUsuarioServicio = 5,
            eliminar = 7,
            LeerBusquedaIdAE = 8,
        }

        #endregion

        #region [1] Acceso Servicio
        /// <summary>
        /// Entrada general de servicio
        /// </summary>
        /// <param name="parametros">Parámetros de configuración: persona incidencia, usuario, sucursal, cliente, sistema, etc. Para generar bitácora</param>
        /// <returns>Configuración del comportamiento del sistema, según los parámetros enviados</returns>
        public VerificadorPLD ServicioVerificadorPLD(BitacoraPLD parametros)
        {

            List<ResultadoBusquedaPLD> results = new List<ResultadoBusquedaPLD>();
            VerificadorPLD _resultadoServicio = new VerificadorPLD();

            try
            {
                results = BusquedaListaNegra(parametros.vchNombre, parametros.vchApPaterno, parametros.vchApMaterno, parametros.vchPersonaIncidencia);
                _resultadoServicio = resultadoServicio(results, parametros);
            }
            catch (Exception ex)
            {

                throw ex;
            }

            return _resultadoServicio;
        }

        private VerificadorPLD resultadoDefault()
        {
            VerificadorPLD _resultadoDefault = new VerificadorPLD();
            _resultadoDefault.Tipificacion = 1;
            _resultadoDefault.BloqueoUsuario = false;
            _resultadoDefault.BloqueoProceso = false;
            _resultadoDefault.Mensaje = "";
            _resultadoDefault.CreoBitacora = false;
            _resultadoDefault.EnvioCorreo = false;
            return _resultadoDefault;
        }

        private VerificadorPLD resultadoServicio(List<ResultadoBusquedaPLD> results, BitacoraPLD parametros)
        {
            VerificadorPLD _resultadoServicio = new VerificadorPLD();
            List<ConfiguracionPLD> configuracion = new List<ConfiguracionPLD>();
            ConfiguracionPLDDataAccess ConfiguracionPLDDA = new ConfiguracionPLDDataAccess();
            string cuentasTo;
            string cuentasCC;
            int? result = 0;
            try
            {
                // Ordena
                var query = from item in results
                            orderby item.vchIdentificadorInterno ascending //primero lista NEGRA, PEP y luego VENC
                            select item;

                //vchidqeq, es identificador único en lista negra: 173802, 
                VerificadorPLDDataContext bitacoraDA = new VerificadorPLDDataContext();
                if (results.Count > 0)
                    bitacoraDA.stp_CRUDBitacoraPLD(
                         ref result, (int)CRUD.desbloquearUsuarioServicio, null, results.First().VCHIDQEQ, parametros.vchUsuario, null, parametros.intSistema, null, null, null, null, null, null, null, null, null, null, null, null, false,null);
                //Existe registro con BE - BA en true
                if (result > 0)
                {
                    //respuesta default     
                    _resultadoServicio = resultadoDefault();
                    return _resultadoServicio;
                }
                
                if (query.Count() != 0 && parametros.intSistema != null)
                {
                    configuracion = ConfiguracionPLDDA.ListadoBusquedaConfiguracionPLD((int)query.First().intTipoTipificacionID, (Int16)parametros.intSistema);
                }
                else
                {
                    if (query.Count() == 0)
                        _resultadoServicio = resultadoDefault();
                }

                foreach (ResultadoBusquedaPLD item in query)
                {
                    //manejo de escenarios por configuración: Implementar respuesta por default(normal; BA, BE = true) y escenarios

                    //Tipificacion  
                    _resultadoServicio.Tipificacion = query.First().intTipoTipificacionID != null ? (int)query.First().intTipoTipificacionID : 1;

                    //BloqueoUsuario  
                    _resultadoServicio.BloqueoUsuario = configuracion.Count != 0 ? configuracion.First().bitBloqueoUsuario : false;

                    //BloqueoProceso   ----- Automatizar        
                    _resultadoServicio.BloqueoProceso = configuracion.Count != 0 ? configuracion.First().bitBloqueoProceso : false;

                    //Mensaje  
                    _resultadoServicio.Mensaje = configuracion.Count != 0 ? configuracion.First().vchMensaje : "";

                    //CreoBitacora      
                    int regresoBitacora = 0;
                    if (configuracion.Count != 0)
                    {
                        if ((bool)configuracion.First().bitBitacora)
                        {
                            regresoBitacora = escribirBitacora(item, parametros);
                            _resultadoServicio.CreoBitacora = regresoBitacora == 0 ? configuracion.First().bitBitacora : regresoBitacora > 0 ? true : false;
                        }
                    }
                    else
                    {
                        _resultadoServicio.CreoBitacora = false;
                    }


                    //EnvioCorreo --- al final se sustituye las listas por el hardcode. Además de agregar la posibilidad de CC                       
                    if (configuracion.Count != 0)
                    {
                        string servidor = CuentaSistema;

                        cuentasTo = configuracion.First().vchCorreosPara != null ? configuracion.First().vchCorreosPara : "";
                        cuentasCC = configuracion.First().vchCorreosCC != null ? configuracion.First().vchCorreosCC : "";

                        //correo con uso de parámetros en app.config de testHost
                        _resultadoServicio.EnvioCorreo = regresoBitacora == 0 ? configuracion.First().bitEnvioCorreo : configuracion.First().bitEnvioCorreo == true ? enviarCorreo(cuentasTo, CuentaSistema, cuentasCC, Servidor, Puerto, parametros, item, configuracion.First()) : false;
                    }
                    else
                    {
                        _resultadoServicio.EnvioCorreo = false;
                    }


                    if (item.vchIdentificadorInterno == TipoLista.NEGRA.ToString() || item.vchIdentificadorInterno == TipoLista.PEP.ToString())
                    {
                        break;
                    }
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }


            return _resultadoServicio;
        }

        #endregion

        #region [2] Búsqueda persona
        private List<ResultadoBusquedaPLD> BusquedaListaNegra(string @vchPersonaIncidenciaNombre,
                                                  string @vchPersonaIncidenciaApPat,
                                                  string @vchPersonaIncidenciaApMat,
                                                  string @vchNombreCompleto)
        {
            List<ResultadoBusquedaPLD> results = new List<ResultadoBusquedaPLD>();
            try
            {
                using (VerificadorPLDDataContext dc = new VerificadorPLDDataContext(Helper.ConnectionString()))
                {
                    var query = from item in dc.stp_BuscarListaNegra(@vchPersonaIncidenciaNombre, @vchPersonaIncidenciaApPat, @vchPersonaIncidenciaApMat, @vchNombreCompleto)
                                select new ResultadoBusquedaPLD
                                {
                                    VCHIDQEQ = item.VCHIDQEQ,
                                    VCHTIPOLISTA = item.VCHTIPOLISTA,
                                    vchIdentificadorInterno = item.vchIdentificadorInterno,
                                    VCHNOMCOMPLETO = item.VCHNOMCOMPLETO,
                                    intTipoTipificacionID = item.intTipoTipificacionID
                                };
                    results.AddRange(query);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return results;
        }
        #endregion

        #region [4] Bitácora
        private int escribirBitacora(ResultadoBusquedaPLD _item, BitacoraPLD _parametros)
        {
            int? RegistroInsert = 0;
            try
            {
                using (VerificadorPLDDataContext dc = new VerificadorPLDDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDBitacoraPLD(
                        ref RegistroInsert, (int)CRUD.insertar, null, _item.VCHIDQEQ, _parametros.vchUsuario,
                        _parametros.vchSucursal, _parametros.intSistema, _parametros.vchPersonaIncidencia,
                        _parametros.vchNombre, _parametros.vchApPaterno, _parametros.vchApMaterno, _parametros.vchNombreBusq,
                        _parametros.vchCliente, _parametros.vchRelacionCliente, null, null, null, null, null, null,null
                        );
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;

        }

        public List<BitacoraPLD> ListadoBusquedaBitacoraPLD(BitacoraPLD bitacora)
        {
            List<BitacoraPLD> results = new List<BitacoraPLD>();
            try
            {
                using (VerificadorPLDDataContext dc = new VerificadorPLDDataContext(Helper.ConnectionString()))
                {
                    int? res = 0;
                    var query = from item in dc.stp_CRUDBitacoraPLD(
                                       ref res, (int)CRUD.leerBusqueda, null, null, bitacora.vchUsuario, null, bitacora.intSistema, null, null, null, null, null, bitacora.vchCliente, null, null, null, null, null, null, bitacora.bitHistorial,null)
                                select new BitacoraPLD()
                                {
                                    intBitacoraID = item.intBitacoraID,
                                    vchidqeq = item.vchidqeq,
                                    vchUsuario = item.vchUsuario,
                                    vchSucursal = item.vchSucursal,
                                    intSistema = item.intSistema,
                                    vchPersonaIncidencia = item.vchPersonaIncidencia,
                                    vchNombre = item.vchNombre,
                                    vchApPaterno = item.vchApPaterno,
                                    vchApMaterno = item.vchApMaterno,
                                    vchCliente = item.vchCliente,
                                    vchRelacionCliente = item.vchRelacionCliente,
                                    vchComentario = item.vchComentario,
                                    bitAutorizaProc = item.bitAutorizaProc,
                                    bitHomonimo = item.bitHomonimo,
                                    intTipoTipificacionID = item.intTipoTipificacionID,
                                    datFecha = item.datFecha,
                                    datFechaRespuesta = item.datFechaRespuesta,
                                    vchNombreSistema = item.vchNombreSistema,
                                    vchTipoLista = item.vchTipoLista,
                                    vchIdentificadorInterno = item.vchIdentificadorInterno,
                                    vchCorreoHCM = item.vchCorreoHCM,
                                    vchUsuarioAudit=item.vchUsuarioAudit,
                                    vchUsuarioNombre = (item.vchUsuarioNombre.Contains('.') ? getNamebyLogin(item.vchUsuarioNombre) : item.vchUsuarioNombre)
                                };
                    results.AddRange(query);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return results;
        }

        public string getNamebyLogin(string strLogin)
        {
            string strName = string.Empty;           
            try
            {
                using (VerificadorPLDDataContext dc = new VerificadorPLDDataContext(Helper.ConnectionString()))
                {
                     dc.stp_GetUserName(strLogin, ref strName);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return strName;
        }

        public List<BitacoraPLD> TotalCorreo()
        {
            List<BitacoraPLD> results = new List<BitacoraPLD>();
            try
            {
                using (VerificadorPLDDataContext dc = new VerificadorPLDDataContext(Helper.ConnectionString()))
                {
                    int? res = 0;
                    var query = from item in dc.stp_CRUDBitacoraPLD(
                                       ref res, (int)CRUD.leerTotalCorreo, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null,null)
                                select new BitacoraPLD() { };
                    results.AddRange(query);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return results;
        }

        public int desbloquearUsuario(BitacoraPLD _parametros)
        {
            int? RegistroUpdate = 0;
            try
            {
                using (VerificadorPLDDataContext dc = new VerificadorPLDDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDBitacoraPLD(
                        ref RegistroUpdate, (int)CRUD.desbloquearUsuario, _parametros.intBitacoraID, null,
                        _parametros.vchUsuario, null, null, null, null, null,
                        null, null, null, null, _parametros.vchComentario, _parametros.bitAutorizaProc, null, _parametros.bitHomonimo, _parametros.bitEstatus, null,null);
                }
                ConfiguracionPLD configuracion = new ConfiguracionPLDDataAccess().ListadoBusquedaConfiguracionPLD((int)_parametros.intTipoTipificacionID, (Int16)_parametros.intSistema).First();

                if ((bool)configuracion.bitBloqueoUsuario)
                {
                    enviarCorreo(CuentaSistema, Usuario, "", Servidor, Puerto, _parametros.vchUsuario);
                    //enviarCorreo("v.pineda@hcasamex.com.mx", "accesos-si@hcasamex.com.mx", "", "mail.hcasamex.com.mx", 2525, _tipoLista(query.First().vchIdentificadorInterno), parametros, item)
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroUpdate.Value;
        }


        public int editarBitacoraPLD(BitacoraPLD _parametros)
        {
            int? RegistroUpdate = 0;
            try
            {
                using (VerificadorPLDDataContext dc = new VerificadorPLDDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDBitacoraPLD(
                        ref RegistroUpdate, (int)CRUD.desbloquearUsuario, _parametros.intBitacoraID, _parametros.vchidqeq,
                        _parametros.vchUsuario, _parametros.vchSucursal, _parametros.intSistema, _parametros.vchPersonaIncidencia,
                        _parametros.vchNombre, _parametros.vchApPaterno, _parametros.vchApMaterno, _parametros.vchNombreBusq, _parametros.vchCliente,
                        _parametros.vchRelacionCliente, _parametros.vchComentario, _parametros.bitAutorizaProc, null, _parametros.bitHomonimo, _parametros.bitEstatus, null,_parametros.vchUsuarioAudit);
                }
                ConfiguracionPLD configuracion = new ConfiguracionPLDDataAccess().ListadoBusquedaConfiguracionPLD((int)_parametros.intTipoTipificacionID, (Int16)_parametros.intSistema).First();
                if (configuracion != null)
                    if ((bool)configuracion.bitBloqueoUsuario)
                    {
                        enviarCorreo(CuentaSistema, Usuario, "", Servidor, Puerto, _parametros.vchUsuario);
                        //enviarCorreo(CuentaSistema, "accesos-si@hcasamex.com.mx", "", "mail.hcasamex.com.mx", 2525, _parametros.vchUsuario);
                        //enviarCorreo("v.pineda@hcasamex.com.mx", "accesos-si@hcasamex.com.mx", "", "mail.hcasamex.com.mx", 2525, _tipoLista(query.First().vchIdentificadorInterno), parametros, item)
                    }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroUpdate.Value;
        }

        #endregion

        #region [5] Correo
        private bool enviarCorreo(string correoUsuario, string cuentaSistema, string cuentaCopia, string servidor, int puerto, BitacoraPLD _parametros, ResultadoBusquedaPLD _item, ConfiguracionPLD _configuracion)
        {
            try
            {
                _parametros.vchUsuario = getNamebyLogin(_parametros.vchUsuario);
                clsEnvioDatos.Correo correo = new clsEnvioDatos.Correo();
                correo.strFrom = cuentaSistema;
                correo.strTo = correoUsuario;
                if (!string.IsNullOrEmpty(cuentaCopia))
                {
                    correo.strsCC = cuentaCopia;
                }
                _parametros.vchCliente = _parametros.vchCliente == null ? "" : _parametros.vchCliente;
                _parametros.vchSucursal = _parametros.vchSucursal == null ? "" : _parametros.vchSucursal;

                correo.strSubject = "SEGUIMIENTO LISTA - " + _item.vchIdentificadorInterno;
                correo.bHtml = true;
                //correo.strBody = "<table style='BACKGROUND-COLOR: tranparent;text-align:left;'><tr><td>Cliente:</td><td> <b>" + _parametros.vchCliente.ToUpper().ToString() + "</b></td></tr><tr><td>Nombre o razón social: </td><td><b>" + _item.VCHNOMCOMPLETO.ToUpper().ToString() + "</b></td></tr><tr><td>Sucursal:</td><td><b>" + _parametros.vchSucursal.ToUpper().ToString() + "</b></td></tr><tr><td>Listado: </td><td><b>" + _item.VCHTIPOLISTA.ToUpper().ToString() + "</b></td></tr></table>";
                correo.strBody = "<table style='FONT-SIZE: 11px; font-family: Tahoma, Helvetica, sans-serif; color:#000000;	padding:2px; background-color:#E8E9EE; BORDER-RIGHT:#003366 1px solid; BORDER-TOP: #003366 1px solid; BORDER-LEFT: #003366 1px solid; BORDER-BOTTOM: #003366 1px solid;cellspacing: 2;'>" +
                                    "<tr><td colspan='2' align='center' style='background-color:#FEFEFE;'>INFORMACIÓN USUARIO</td></tr>" +
                                    "<tr><td colspan='2'><hr /></td></tr>" +
                                    "<tr><td>CLIENTE: </td><td><b>" + (_parametros.vchCliente != null ? _parametros.vchCliente.ToUpper().ToString().ToUpper() : "---") + "</b></td></tr>" +
                                    "<tr><td>NOMBRE BUSQUEDA: </td><td><b>" + (_parametros.vchPersonaIncidencia != null ? _parametros.vchPersonaIncidencia.ToUpper().ToString().ToUpper() : (_parametros.vchNombre != null && _parametros.vchApPaterno != null && _parametros.vchApPaterno != null) ? _parametros.vchNombre.ToString().ToUpper() + " " + _parametros.vchApPaterno.ToString().ToUpper() + " " + _parametros.vchApMaterno.ToString().ToUpper() : "---") + "</b></td></tr>" +
                                    "<tr><td>SUCURSAL: </td><td><b>" + (_parametros.vchSucursal != null ? _parametros.vchSucursal.ToUpper().ToString().ToUpper() : "---") + "</b></td></tr>" +
                                    "<tr><td>USUARIO: </td><td><b>" + (_parametros.vchUsuario != null ? _parametros.vchUsuario.ToUpper().ToString().ToUpper() : "---") + "</b></td></tr>" +
                                    "<tr><td colspan='2'><hr /></td></tr>" +
                                    "<tr><td colspan='2' align='center' style='background-color:#FEFEFE;'>INFORMACIÓN CONFIGURACIÓN</td></tr>" +
                                    "<tr><td colspan='2'><hr /></td></tr>" +
                                    "<tr><td>IDQEQ: </td><td><b>" + (_item.VCHIDQEQ.ToUpper().ToString() != "" ? _item.VCHIDQEQ.ToUpper().ToString().ToUpper() : "---") + "</b></td></tr>" +
                                    "<tr><td>NOMBRE/RAZÓN SOCIAL[ENCONTRADO]: </td><td><b>" + (_item.VCHNOMCOMPLETO.ToUpper().ToString() != "" ? _item.VCHNOMCOMPLETO.ToUpper().ToString().ToUpper() : "---") + "</b></td></tr>" +
                                    "<tr><td>TIPO LISTA: </td><td><b>" + (_item.VCHTIPOLISTA.ToUpper().ToString() != "" ? _item.VCHTIPOLISTA.ToUpper().ToString().ToUpper() : "---") + "</b></td></tr>" +
                                    "<tr><td>TIPIFICACIÓN: </td><td><b>" + (_configuracion.vchIdentificadorInterno.ToString() != "" ? _configuracion.vchIdentificadorInterno.ToString().ToUpper() : "") + "</b></td></tr>" +
                                    "<tr><td>SISTEMA: </td><td><b>" + (_configuracion.vchNombreSistema.ToString() != "" ? _configuracion.vchNombreSistema.ToString().ToUpper() : "---") + "</b></td></tr>" +
                                    "<tr><td>BLOQUEO USUARIO: </td><td><b>" + _configuracion.vchbitBloqueoUsuario.ToString() + "</b></td></tr>" +
                                    "<tr><td>BLOQUEO PROCESO: </td><td><b>" + _configuracion.vchbitBloqueoProceso.ToString() + "</b></td></tr>" +
                                    "<tr><td colspan='2'><hr /></td></tr>" +
                                    "</table>";
                correo.strServidor = servidor;
                correo.intPuerto = puerto;
                correo.requiereCredenciales = true;
                correo.strUsuario = Usuario;
                correo.strClave = Contraseña;
                return clsEnvioDatos.EnviarCorreo(correo);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool enviarCorreo(string correoUsuario, string cuentaSistema, string cuentaCopia, string servidor, int puerto, string Usuario)
        {
            try
            {
                clsEnvioDatos.Correo correo = new clsEnvioDatos.Correo();
                correo.strFrom = cuentaSistema;
                correo.strTo = correoUsuario;
                if (!string.IsNullOrEmpty(cuentaCopia))
                {
                    correo.strsCC = cuentaCopia;
                }

                correo.strSubject = "DesBloqueo de Usuario";
                correo.bHtml = true;
                correo.strBody = "<table><tr><td>Se desbloqueo el Usuario: " + Usuario + " Satistactoriamente</td></tr></table>";

                correo.strServidor = servidor;
                correo.intPuerto = puerto;
                correo.requiereCredenciales = true;
                correo.strUsuario = Usuario;
                correo.strClave = Contraseña;
                return clsEnvioDatos.EnviarCorreo(correo);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region Propiedades conexión

        public string CuentaSistema
        {
            get
            {
                return ConfigurationManager.AppSettings["CuentaSistema"].ToString();
            }
        }

        public string Servidor
        {
            get
            {
                return ConfigurationManager.AppSettings["Servidor"].ToString();
            }
        }

        public int Puerto
        {
            get
            {
                return Convert.ToInt32(ConfigurationManager.AppSettings["Puerto"].ToString());
            }
        }

        public string Usuario
        {
            get
            {
                return ConfigurationManager.AppSettings["Usuario"].ToString();
            }
        }

        public string Contraseña
        {
            get
            {
                return ConfigurationManager.AppSettings["Contraseña"].ToString();
            }
        }
        #endregion
    }
}

namespace Seguridad.Logic.Utilidades
{
    public class clsEnvioDatos
    {

        #region Propiedades
        /// <summary>
        /// Estructura que representa un correo a enviar
        /// </summary>
        public struct Correo
        {
            public string strFrom;
            public string strTo;
            //public string[] strsCC;
            public string strsCC;
            public string[] strsBCC;
            public string strSubject;
            public string strBody;
            public bool bHtml;
            public string strServidor;
            public int intPuerto;
            public string strUsuario;
            public string strClave;
            public bool requiereCredenciales;
            public bool habilitarSSL;
        }
        #endregion

        #region Métodos

        #region POST Y GET
        /// <summary>
        /// Obtiene respuestas enviando parametros a una URL por medio de GET
        /// </summary>
        /// <param name="urlBase">URL del servicio sin parámetros</param>
        /// <param name="datos">Parámetros enviados al servicio</param>
        /// <returns>Resultado generado por el servicio</returns>
        public static string GetResponse_GET(string urlBase, Dictionary<string, string> datos)
        {
            string responseFromServer = String.Empty;
            Stream newStream = null;
            StreamReader reader = null;
            WebResponse response = null;
            try
            {
                bool FirstParam = true;
                StringBuilder Parametros = new StringBuilder();
                foreach (KeyValuePair<string, string> param in datos)
                {
                    if (!datos.Keys.First().Equals(param.Key))
                        FirstParam = false;
                    Parametros.Append(FirstParam ? "?" : "&");
                    Parametros.Append(param.Key).Append("=").Append(HttpUtility.UrlEncode(param.Value));
                }
                string UrlBaseWithParams = urlBase + Parametros.ToString();
                return UrlBaseWithParams;
                //WebRequest wr = (HttpWebRequest)WebRequest.Create(UrlBaseWithParams);
                //wr.Method = "GET";

                //wr.ContentType = "application/x-www-form-urlencoded";

                //response = wr.GetResponse();
                //newStream = response.GetResponseStream();
                //reader = new StreamReader(newStream);

                //responseFromServer = reader.ReadToEnd();

            }
            catch (Exception)
            {
                StackTrace st = new StackTrace(true);
            }
            finally
            {
                if (reader != null)
                    reader.Close();
                if (newStream != null)
                    newStream.Close();
                if (response != null)
                    response.Close();
            }
            return responseFromServer;
        }

        /// <summary>
        /// Método que obtiene una respuesta enviando parametros a la url mediante POST
        /// </summary>
        /// <param name="urlBase">URL del servicio sin parámetros</param>
        /// <param name="datos">Parametros enviados al servicio</param>
        /// <returns>Resultado enviado por el servicio</returns>
        public static string GetResponse_POST(string urlBase, Dictionary<string, string> datos)
        {
            bool FirstParam = true;
            StringBuilder Parametros = new StringBuilder();
            foreach (KeyValuePair<string, string> param in datos)
            {
                Parametros.Append(FirstParam ? "?" : "&");
                Parametros.Append(param.Key).Append("=").Append(HttpUtility.UrlEncode(param.Value));
            }

            WebRequest wr = (HttpWebRequest)WebRequest.Create(urlBase);
            wr.Method = "POST";

            ASCIIEncoding encoding = new ASCIIEncoding();
            byte[] byte1 = encoding.GetBytes(Parametros.ToString());
            wr.ContentType = "application/x-www-form-urlencoded";
            wr.ContentLength = byte1.Length;

            Stream newStream = wr.GetRequestStream();
            newStream.Write(byte1, 0, byte1.Length);
            newStream.Close();

            WebResponse response = wr.GetResponse();
            newStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(newStream);

            string responseFromServer = reader.ReadToEnd();

            reader.Close();
            newStream.Close();
            response.Close();

            return responseFromServer;
        }
        #endregion

        #region CORREO
        /// <summary>
        /// Método de la clase que envia un correo a uno o varios usuarios
        /// </summary>
        /// <param name="correo">Estructura de datos que componen el correo</param>
        /// <returns>true si se envio sin problemas el correo y false en caso contrario</returns>
        public static bool EnviarCorreo(Correo correo)
        {
            MailMessage objMail;

            try
            {
                objMail = new MailMessage();
                objMail.From = new MailAddress(correo.strFrom); //Remitente
                //objMail.To.Add(correo.strTo); //Email a enviar, se extiende funcionalidad
                if (correo.strTo != null)
                {
                    string[] correosTo = correo.strTo.Split(';');
                    foreach (string item in correosTo)
                    {
                        objMail.To.Add(item);
                    }
                }
                if (correo.strsCC != null)
                {
                    string[] correosCC = correo.strsCC.Split(';');
                    foreach (string item in correosCC)
                    {
                        objMail.CC.Add(item);
                    }
                }
                if (correo.strsBCC != null)
                {
                    foreach (string copia in correo.strsBCC)
                        objMail.Bcc.Add(copia); //Email a enviar copia oculta                
                }
                objMail.Subject = correo.strSubject;
                objMail.Body = correo.strBody;
                objMail.IsBodyHtml = correo.bHtml; //Formato Html del email

                SmtpClient SmtpMail = new SmtpClient();
                SmtpMail.Host = correo.strServidor; //el nombre del servidor de correo
                SmtpMail.Port = correo.intPuerto; //asignamos el numero de puerto

                if (correo.requiereCredenciales && !string.IsNullOrEmpty(correo.strUsuario) && !string.IsNullOrEmpty(correo.strClave))
                    SmtpMail.Credentials = new NetworkCredential(correo.strUsuario, correo.strClave);
                if (correo.habilitarSSL)
                    SmtpMail.EnableSsl = true;

                SmtpMail.Send(objMail); //Enviamos el correo
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        #endregion

        #endregion


    }
}