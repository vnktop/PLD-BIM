using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.OleDb;
using System.IO;
using System.Data;
using System.Text;
using System.Runtime.InteropServices;

using System.Configuration;
using BIM.PLD.Website.wsDocumentServices;
using BIM.PLD.Website.UserControl.Comun;
using BIM.PLD.Website.Utileria;


using System.Diagnostics;



namespace BIM.PLD.Website.ListasNegra
{
    public partial class frmListaNegra : System.Web.UI.Page
    {
        #region Servicios
        public CatalogosServices.CatalogoServicesClient rsCatListaNegra = new CatalogosServices.CatalogoServicesClient();
        public ListaNegraService.ListaNegraServicesClient rsListaNegra = new ListaNegraService.ListaNegraServicesClient();
        #endregion

        #region Atributos
        //private int _ClaveTipoListaNegra;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {            
            if (!IsPostBack)
            {
                List<ListaNegraService.Proveedor> lst = new List<ListaNegraService.Proveedor>();
                ListaNegraService.Proveedor[] array = rsListaNegra.ListarProveedores();
                for (int i = 0; i < array.Length; i++)
                {
                    lst.Add(array[i]);
                }
                this.ddlProveedores.DataSource = lst;
                this.ddlProveedores.DataValueField = "iProveedorId";
                this.ddlProveedores.DataTextField = "strNombre";
                this.ddlProveedores.DataBind();
                ddlProveedores.Items.Insert(0, new ListItem("[Seleccione el Proveedor...]", "0", true));
            }
            ddlProveedores.SelectedIndexChanged += new EventHandler(ddlProveedores_SelectedIndexChanged);
        }

        void ddlProveedores_SelectedIndexChanged(object sender, EventArgs e)
        {
            Error.Style.Value = "display:none;";
        }

        #region Metodos

        private void _asignarDescripcionesDDL(DropDownList _dll, string _id, string _descripcipon)
        {
            _dll.DataValueField = _id;
            _dll.DataTextField = _descripcipon;
            _dll.DataBind();
        }

        private void _loadValorInicialDDL(DropDownList _ddl)
        {
            _ddl.Items.Insert(0, new ListItem("[Seleccione una opción...]", "-1", true));
        }

        #endregion

        #region Eventos

        protected void iBtnAddProveedor_Click(object sender, EventArgs e)
        {
            mpeAgregarProveedor.Show();
        }

        protected void btnAceptarAgregar_Click(object sender, EventArgs e)
        {
            string strProveedor = txtProveedor.Text;
            try
            {
                rsListaNegra.insertarProveedor(strProveedor);
                List<ListaNegraService.Proveedor> lst = new List<ListaNegraService.Proveedor>();
                ListaNegraService.Proveedor[] array = rsListaNegra.ListarProveedores();
                for (int i = 0; i < array.Length; i++)
                {
                    lst.Add(array[i]);
                }
                this.ddlProveedores.DataSource = lst;
                this.ddlProveedores.DataValueField = "iProveedorId";
                this.ddlProveedores.DataTextField = "strNombre";
                this.ddlProveedores.DataBind();
                ddlProveedores.Items.Insert(0, new ListItem("[Seleccione el Proveedor...]", "0", true));
                wucMensajeSistema.setMensaje("Proveedor Insertado correctamente", 1);
            }
            catch(Exception exc)
            {
                wucMensajeSistema.setMensaje("Error al Insertar proveedor",2);
                escribeLog(exc.Message);
            }
        }

        protected void btnCargarArchivo_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlProveedores.SelectedIndex > 0)
                {
                    if (fupArchivo.HasFile)
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Muestra", "MuestraCargando();", true);
                        string strFileName = fupArchivo.PostedFile.FileName;
                        if (LeeArchivo(strFileName) == 0)
                            this.wucMensajeSistema.setMensaje("La estructura del archivo es incorrecta <br/>" + strErrorMessage,3);
                    }
                    else
                    {
                        wucMensajeSistema.setMensaje("Debe seleccionar un archivo", 2);
                    }
                }
                else
                {
                    wucMensajeSistema.setMensaje("Debe seleccionar el proveedor", 2);
                    Error.Style.Value = "display:inline;";
                }
            }
            catch (Exception ex)
            {
                escribirBitacoraIncidencias(ex.Message);
                this.wucMensajeSistema.setMensaje("Ocurrio un error en la aplicación actual, contacte al administrador del sistema. [La estructura del archivo es incorrecta]",2);                
            } 
            finally
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Oculta", "OcultaCargando();", true);
            }
        }

        private int[] entity = new int[25];
        
        private int identificaColumnas(string line)
        {
            int result = 0;
            for (int i = 0; i < entity.Length; i++)
                entity[i] = -1;
            string[] tokens;
            tokens = line.Split(new char[] { '\t' });
            for (int i = 0; i < tokens.Length; i++)
            {
                switch (tokens[i].ToLower())
                {
                    #region tabla
                    case "idqeq":
                        entity[0] = i;
                        break;
                    case "nombre":
                        entity[1] = i;
                        break;
                    case "paterno":
                        entity[2] = i;
                        break;
                    case "materno":
                        entity[3] = i;
                        break;
                    case "curp":
                        entity[4] = i;
                        break;
                    case "rfc":
                        entity[5] = i;
                        break;
                    case "fecnac":
                        entity[6] = i;
                        break;
                    case "lista":
                        entity[7] = i;
                        break;
                    case "estatus":
                        entity[8] = i;
                        break;
                    case "dependencia":
                        entity[9] = i;
                        break;
                    case "puesto":
                        entity[10] = i;
                        break;
                    case "iddispo":
                        entity[11] = i;
                        break;
                    case "curpok":
                        entity[12] = i;
                        break;
                    case "idrel":
                        entity[13] = i;
                        break;
                    case "parentesco":
                        entity[14] = i;
                        break;
                    case "razonsoc":
                        entity[15] = i;
                        break;
                    case "rfcmoral":
                        entity[16] = i;
                        break;
                    case "issste":
                        entity[17] = i;
                        break;
                    case "imss":
                        entity[18] = i;
                        break;
                    case "ingresos":
                        entity[19] = i;
                        break;
                    case "nomcomp":
                        entity[20] = i;
                        break;
                    case "apellidos":
                        entity[21] = i;
                        break;
                    case "entidad":
                        entity[22] = i;
                        break;
                    case "genero":
                        entity[23] = i;
                        break;
                    case "proveedor":
                        entity[24] = i;
                        break;
                    default:
                        //Aquí se asignan las columnas no presentes
                        break;
                    #endregion
                }
            }
            if (entity[7] == -1 || entity[0] == -1 || entity[20] == -1)
                result = 0;
            else
                result = 1;
            //for (int i = 0; i < 4; i++)
            //    if (entity[i] == -1)
            //    {
            //        result = 0;
            //        break;
            //    }
            if (result == 0)
            {
                strErrorMessage = "No se encontraron las siguientes columnas: ";
                if (entity[0] == -1)
                    strErrorMessage += "<br/> -idqeq ";
                
                if (entity[20] == -1)
                    strErrorMessage += "<br/> -nombre completo ";
                
                if (entity[7] == -1)
                    strErrorMessage += "<br/> -lista ";
            }
            return result;
        }

        string strErrorMessage;

        private int LeeArchivo(string Archivo)
        {
            int result = 0;
            try
            {
                StreamReader objReader = new StreamReader(fupArchivo.FileContent, System.Text.Encoding.GetEncoding(1252), false);
                string [] strEntities;
                string sLine = "";
                StringBuilder sbtxt = new StringBuilder();
                List<ListaNegraService.ListaNegra> lstListaNegra = new List<ListaNegraService.ListaNegra>();
                int count = 0;

                sLine = objReader.ReadLine();

                if (identificaColumnas(sLine) == 1)
                {
                    while (sLine != null)
                    {
                        if (sLine != null)
                        {

                            if (count != 0)
                            {
                                sLine = sLine.Replace("|", "");
                                ListaNegraService.ListaNegra listaNegra = new ListaNegraService.ListaNegra();
                                strEntities = sLine.Split(new char[] { '\t' });
                                if (strEntities[entity[0]] != "" &&
                                    strEntities[entity[20]] != "" &&
                                    strEntities[entity[7]] != "")
                                {
                                    listaNegra.VCHTIPOLISTA = strEntities[entity[0]];
                                    listaNegra.VCHIDQEQ = strEntities[entity[0]] + '|';

                                    listaNegra.VCHNOMBRE = entity[1] != -1 ? QuitarCaracteresEspeciales(strEntities[entity[1]]).ToUpper() + '|' : "" + '|';
                                    listaNegra.VCHAPPATERNO = entity[2] != -1 ? QuitarCaracteresEspeciales(strEntities[entity[2]]).ToUpper() + '|' : "" + '|';
                                    listaNegra.VCHAPMATERNO = entity[3] != -1 ? QuitarCaracteresEspeciales(strEntities[entity[3]]).ToUpper() + '|' : "" + '|';
                                    listaNegra.iProveedorId = ddlProveedores.SelectedValue;

                                    if (entity[4] != -1)
                                        listaNegra.VCHCURP = strEntities[entity[4]] + '|';
                                    else
                                        listaNegra.VCHCURP = "" + '|';

                                    if (entity[5] != -1)
                                        listaNegra.VCHRFC = strEntities[entity[5]] + '|';
                                    else
                                        listaNegra.VCHRFC = "" + '|';

                                    if (entity[6] != -1)
                                        listaNegra.VCHFECHANAC = strEntities[entity[6]] + '|';
                                    else
                                        listaNegra.VCHFECHANAC = "" + '|';

                                    if (entity[7] != -1)
                                        listaNegra.VCHTIPOLISTA = strEntities[entity[7]] + '|';
                                    else
                                        listaNegra.VCHTIPOLISTA = "" + '|';

                                    if (entity[8] != -1)
                                        listaNegra.VCHESTATUS = strEntities[entity[8]] + '|';
                                    else
                                        listaNegra.VCHESTATUS = "" + '|';

                                    if (entity[9] != -1)
                                        listaNegra.VCHDEPENDENCIA = strEntities[entity[9]] + '|';
                                    else
                                        listaNegra.VCHDEPENDENCIA = "" + '|';

                                    if (entity[10] != -1)
                                        listaNegra.VCHPUESTO = strEntities[entity[10]] + '|';
                                    else
                                        listaNegra.VCHPUESTO = "" + '|';

                                    if (entity[11] != -1)
                                        listaNegra.INTIDDISPO = strEntities[entity[11]] + '|';
                                    else
                                        listaNegra.INTIDDISPO = "" + '|';

                                    if (entity[12] != -1)
                                        listaNegra.BITCURPOK = strEntities[entity[12]] + '|';
                                    else
                                        listaNegra.BITCURPOK = "" + '|';

                                    if (entity[13] != -1)
                                        listaNegra.VCHIDREL = strEntities[entity[13]] + '|';
                                    else
                                        listaNegra.VCHIDREL = "" + '|';

                                    if (entity[14] != -1)
                                        listaNegra.VCHPARENTESCO = strEntities[entity[14]] + '|';
                                    else
                                        listaNegra.VCHPARENTESCO = "" + '|';

                                    if (entity[15] != -1)
                                        listaNegra.VCHRAZONSOCIAL = strEntities[entity[15]] + '|';
                                    else
                                        listaNegra.VCHRAZONSOCIAL = "" + '|';

                                    if (entity[16] != -1)
                                        listaNegra.VCHRFCMORAL = strEntities[entity[16]] + '|';
                                    else
                                        listaNegra.VCHRFCMORAL = "" + '|';

                                    if (entity[17] != -1)
                                        listaNegra.VCHISSSTE = strEntities[entity[17]] + '|';
                                    else
                                        listaNegra.VCHISSSTE = "" + '|';

                                    if (entity[18] != -1)
                                        listaNegra.VCHIMSS = strEntities[entity[18]] + '|';
                                    else
                                        listaNegra.VCHIMSS = "" + '|';

                                    if (entity[19] != -1)
                                        listaNegra.VCHINGRESOS = strEntities[entity[19]] + '|';
                                    else
                                        listaNegra.VCHINGRESOS = "" + '|';

                                    if (entity[20] != -1)
                                        listaNegra.VCHNOMCOMPLETO = QuitarCaracteresEspeciales(strEntities[entity[20]]).ToUpper() + '|';
                                    else
                                        listaNegra.VCHNOMCOMPLETO = "" + '|';

                                    if (entity[21] != -1)
                                        listaNegra.VCHAPELLIDOS = QuitarCaracteresEspeciales(strEntities[entity[21]]).ToUpper() + '|';
                                    else
                                        listaNegra.VCHAPELLIDOS = "" + '|';

                                    if (listaNegra.VCHNOMBRE.Replace("|", "") != string.Empty && listaNegra.VCHAPPATERNO.Replace("|", "") != string.Empty && listaNegra.VCHAPMATERNO.Replace("|", "") != string.Empty)
                                    {
                                        listaNegra.vchCadenaNPM = listaNegra.VCHNOMBRE.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "") + listaNegra.VCHAPPATERNO.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "") + listaNegra.VCHAPMATERNO.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "");
                                        listaNegra.vchCadenaNMP = listaNegra.VCHNOMBRE.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "") + listaNegra.VCHAPMATERNO.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "") + listaNegra.VCHAPPATERNO.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "");
                                    }
                                    if (listaNegra.VCHNOMBRE.Replace("|", "") != string.Empty && listaNegra.VCHAPPATERNO.Replace("|", "") == string.Empty || listaNegra.VCHAPMATERNO.Replace("|", "") == string.Empty && (listaNegra.VCHAPPATERNO.Replace("|", "") != string.Empty || listaNegra.VCHAPMATERNO.Replace("|", "") != string.Empty))
                                    {
                                        listaNegra.vchCadenaNPM = listaNegra.VCHNOMBRE.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "") + listaNegra.VCHAPPATERNO.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "") + listaNegra.VCHAPMATERNO.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "");

                                    }
                                    if (listaNegra.VCHNOMBRE.Replace("|", "") == string.Empty && listaNegra.VCHAPPATERNO.Replace("|", "") == string.Empty && listaNegra.VCHAPMATERNO.Replace("|", "") == string.Empty)
                                    {
                                        if (listaNegra.VCHNOMCOMPLETO.Replace("|", "") == listaNegra.VCHRAZONSOCIAL.Replace("|", ""))
                                            listaNegra.vchCadenaNPM = listaNegra.VCHNOMCOMPLETO.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "");

                                    }
                                    if (listaNegra.VCHNOMBRE.Replace("|", "") == string.Empty && listaNegra.VCHAPPATERNO.Replace("|", "") == string.Empty && listaNegra.VCHAPMATERNO.Replace("|", "") == string.Empty)
                                    {
                                        if (listaNegra.VCHNOMCOMPLETO.Replace("|", "") != listaNegra.VCHRAZONSOCIAL.Replace("|", ""))
                                        {
                                            listaNegra.vchCadenaNPM = listaNegra.VCHRAZONSOCIAL.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "");
                                            listaNegra.vchCadenaNMP = listaNegra.VCHNOMCOMPLETO.Replace("|", "").Replace(".", "").Replace(" ", "").Replace(",", "").Replace(";", "").Replace("'", "").Replace("\"", "").Replace("/", "").Replace("\\", "");
                                        }

                                    }
                                    try
                                    {
                                        if (entity[22] != -1)
                                            listaNegra.VCHENTIDAD = strEntities[entity[22]] + '|';
                                        else
                                            listaNegra.VCHENTIDAD = "" + '|';

                                        if (entity[23] != -1)
                                            listaNegra.VCHGENERO = strEntities[entity[23]] + '|';
                                        else
                                            listaNegra.VCHGENERO = "" + '|';

                                    }
                                    catch
                                    {
                                        listaNegra.VCHENTIDAD = "|";
                                        listaNegra.VCHGENERO = "|";
                                    }

                                    lstListaNegra.Add(listaNegra);
                                    sbtxt.AppendLine(listaNegra.VCHIDQEQ + listaNegra.VCHTIPOLISTA + listaNegra.VCHNOMBRE + listaNegra.VCHAPPATERNO + listaNegra.VCHAPMATERNO + listaNegra.VCHCURP + listaNegra.VCHRFC + listaNegra.VCHFECHANAC + listaNegra.VCHESTATUS + listaNegra.VCHDEPENDENCIA + listaNegra.VCHPUESTO + listaNegra.INTIDDISPO + listaNegra.BITCURPOK + listaNegra.VCHIDREL + listaNegra.VCHPARENTESCO + listaNegra.VCHRAZONSOCIAL + listaNegra.VCHRFCMORAL + listaNegra.VCHISSSTE + listaNegra.VCHIMSS + listaNegra.VCHINGRESOS + listaNegra.VCHNOMCOMPLETO + listaNegra.VCHAPELLIDOS + listaNegra.VCHENTIDAD + listaNegra.VCHGENERO + Session["User"] + "|" + DateTime.Now.ToString("yyyy/MM/dd") + "|" + listaNegra.vchCadenaNPM + "|" + listaNegra.vchCadenaNMP + "|" + listaNegra.iProveedorId);
                                }
                            }
                            count++;
                            sLine = objReader.ReadLine();
                        }
                    }
                    objReader.Close();
                    EscribeServidor(sbtxt);
                    result = 1;
                }
                //else
                //{
                    
                //}
            }
            catch (Exception ex)
            {
                escribeLog(ex.Message);
                throw ex;
            }
            return result;
        }

        private void EscribeServidor2(StringBuilder registros)
        {
            
            string strFileName = "ListaNegra.txt";
            string _tipoArchivoDir = "";
            _tipoArchivoDir = "PLD";
            string strType = "txt";
            string directorio = Repositorio + _tipoArchivoDir + @"\";

            System.Text.UTF8Encoding  encoding=new System.Text.UTF8Encoding();
            

            byte[] hfc =(byte[]) encoding.GetBytes(registros.ToString());
            IwsDocumentHandlingClient proxy = new IwsDocumentHandlingClient();
            RemoteFileInfoRequest request = new RemoteFileInfoRequest();
            UploadFileResponse response = new UploadFileResponse();

            long length = (long)hfc.Length;
            byte[] buffer2 = hfc;
            request.data = buffer2;
            request.FileName = strFileName;
            request.Length = length;
            request.strServerPath = directorio;
            response = proxy.UploadFile(request);
        }

        private void EscribeServidor(StringBuilder registros)
        {
            
            try
            {
                string _tipoArchivoDir = "";

                if (registros.Length > 0)
                {
                    _tipoArchivoDir = "PLD";  
                }
                System.Text.UTF8Encoding  encoding=new System.Text.UTF8Encoding();
                string dirOrigen=Server.MapPath("~")+"/Repositorio/";
                File.WriteAllText(dirOrigen + "ListaNegra.txt", registros.ToString(), System.Text.Encoding.GetEncoding(1252));
                string nf = "ListaNegra.txt";
                string directorioDest = Repositorio + _tipoArchivoDir + @"\";
                ListaNegraService.ServiceResult result= rsListaNegra.almacenarArchivo(dirOrigen, directorioDest, nf);
                int iProveedorId = Convert.ToInt32(ddlProveedores.SelectedValue);
                if (result.ServiceOk)
                {
                    ListaNegraService.ServiceResult cargaArchivo = rsListaNegra.CargaListasNegras(iProveedorId);
                    if (!(((string)cargaArchivo.ResultValue).ToUpper()).Contains("ERROR"))
                    {
                        if (cargaArchivo.ServiceOk)
                        {
                            wucMensajeSistema.setMensaje("Se cargaron correctamente las listas negras", 1);
                        }
                        else
                        {
                            escribirBitacoraIncidencias(cargaArchivo.ErrorMessage);
                            wucMensajeSistema.setMensaje("Ocurrio un error y no se cargaron las listas, contacte al administrador", 2);
                        }
                    }
                    else
                    {
                        escribirBitacoraIncidencias(((string)cargaArchivo.ResultValue));
                        wucMensajeSistema.setMensaje("Ocurrio un error y no se cargaron las listas, contacte al administrador", 2);
                    }
                }
                else
                {
                    escribirBitacoraIncidencias(result.ErrorMessage);
                    wucMensajeSistema.setMensaje("Ocurrio un error en el copiado de archivos Conatcte con el administrador",2);
                }
            }
            
            catch (Exception ex)
            {

                escribeLog(ex.Message);
                throw ex;
            }
        }

        private void escribirBitacoraIncidencias(string msg)
        {
            string location = Server.MapPath("~") + "/Repositorio/";
            if (!Directory.Exists(location))
                Directory.CreateDirectory(location);

            File.AppendAllText(location + "Log.txt",
                DateTime.Now.ToShortDateString() + ' ' +
                DateTime.Now.ToLongTimeString() +
                ". Mensaje de error: " + msg +
                "\r\n");
        }


        private string strRutaAplicacionIncidencias
        {
            get
            {
                return ConfigurationManager.AppSettings["strRutaAplicacionIncidencias"].ToString();
            }

        }


        void escribeLog(string error)
        {
            try
            {
                System.Text.UTF8Encoding encoding = new System.Text.UTF8Encoding();
                byte[] hfc = (byte[])encoding.GetBytes(error.ToString());
                string location = Server.MapPath("~") + "/Repositorio/Log.txt";
                File.WriteAllBytes(location, hfc);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string QuitarCaracteresEspeciales(string texto)
        {
            try
            {
                string consignos = "áàäéèëíìïóòöúùüÁÀÄÉÈËÍÌÏÓÒÖÚÙÜçÇ";
                string sinsignos = "aaaeeeiiiooouuuAAAEEEIIIOOOUUUcC";
                for (int v = 0; v < sinsignos.Length; v++)
                {
                    string i = consignos.Substring(v, 1);
                    string j = sinsignos.Substring(v, 1);
                    texto = texto.Replace(i, j);
                }
            }
            catch (Exception ex)
            {
                escribeLog(ex.Message);
                throw ex;
            }
            return texto;
        }

        #endregion

        #region Propiedades conexión

        public string Repositorio
        {
            get
            {
                return ConfigurationManager.AppSettings["Repositorio"].ToString();
            }
        }

        public string Usuario
        {
            get
            {
                return ConfigurationManager.AppSettings["Usuario"].ToString();
            }
        }

        public string Clave
        {
            get
            {
                return ConfigurationManager.AppSettings["Clave"].ToString();
            }
        }

        
        #endregion
        
    }
}
#region Clase que escribe a recurso externo

namespace ExternalResourceConnection
{
    /// <summary>
    /// Mostly from http://lookfwd.doitforme.gr/blog/media/PinvokeWindowsNetworking.cs as found on http://stackoverflow.com/questions/659013/accessing-a-shared-file-unc-from-a-remote-non-trusted-domain-with-credentials
    /// This isn't consumed externally; rather, it's meant to be used in conjunction with File.cs
    /// </summary>
    internal class PinvokeWindowsNetworking
    {
        #region Consts
        const int RESOURCE_CONNECTED = 0x00000001;
        const int RESOURCE_GLOBALNET = 0x00000002;
        const int RESOURCE_REMEMBERED = 0x00000003;

        const int RESOURCETYPE_ANY = 0x00000000;
        const int RESOURCETYPE_DISK = 0x00000001;
        const int RESOURCETYPE_PRINT = 0x00000002;

        const int RESOURCEDISPLAYTYPE_GENERIC = 0x00000000;
        const int RESOURCEDISPLAYTYPE_DOMAIN = 0x00000001;
        const int RESOURCEDISPLAYTYPE_SERVER = 0x00000002;
        const int RESOURCEDISPLAYTYPE_SHARE = 0x00000003;
        const int RESOURCEDISPLAYTYPE_FILE = 0x00000004;
        const int RESOURCEDISPLAYTYPE_GROUP = 0x00000005;

        const int RESOURCEUSAGE_CONNECTABLE = 0x00000001;
        const int RESOURCEUSAGE_CONTAINER = 0x00000002;


        const int CONNECT_INTERACTIVE = 0x00000008;
        const int CONNECT_PROMPT = 0x00000010;
        const int CONNECT_REDIRECT = 0x00000080;
        const int CONNECT_UPDATE_PROFILE = 0x00000001;
        const int CONNECT_COMMANDLINE = 0x00000800;
        const int CONNECT_CMD_SAVECRED = 0x00001000;

        const int CONNECT_LOCALDRIVE = 0x00000100;
        #endregion

        #region Errors
        const int NO_ERROR = 0;

        const int ERROR_ACCESS_DENIED = 5;
        const int ERROR_ALREADY_ASSIGNED = 85;
        const int ERROR_BAD_DEVICE = 1200;
        const int ERROR_BAD_NET_NAME = 67;
        const int ERROR_BAD_PROVIDER = 1204;
        const int ERROR_CANCELLED = 1223;
        const int ERROR_EXTENDED_ERROR = 1208;
        const int ERROR_INVALID_ADDRESS = 487;
        const int ERROR_INVALID_PARAMETER = 87;
        const int ERROR_INVALID_PASSWORD = 1216;
        const int ERROR_MORE_DATA = 234;
        const int ERROR_NO_MORE_ITEMS = 259;
        const int ERROR_NO_NET_OR_BAD_PATH = 1203;
        const int ERROR_NO_NETWORK = 1222;

        const int ERROR_BAD_PROFILE = 1206;
        const int ERROR_CANNOT_OPEN_PROFILE = 1205;
        const int ERROR_DEVICE_IN_USE = 2404;
        const int ERROR_NOT_CONNECTED = 2250;
        const int ERROR_OPEN_FILES = 2401;
        const int ERROR_DIRECTORY = 267;
        const int ERROR_USER_GROUP_NAME = 2202;
        const int ERROR_MULTIPLE_CREDENTIALS = 1219;

        private struct ErrorClass
        {
            public int num;
            public string message;
            public ErrorClass(int num, string message)
            {
                this.num = num;
                this.message = message;
            }
        }


        // Created with excel formula:
        // ="new ErrorClass("&A1&", """&PROPER(SUBSTITUTE(MID(A1,7,LEN(A1)-6), "_", " "))&"""), "
        private static ErrorClass[] ERROR_LIST = new ErrorClass[] {
			new ErrorClass(ERROR_ACCESS_DENIED, "Error: Access Denied"), 
			new ErrorClass(ERROR_ALREADY_ASSIGNED, "Error: Already Assigned"), 
			new ErrorClass(ERROR_BAD_DEVICE, "Error: Bad Device"), 
			new ErrorClass(ERROR_BAD_NET_NAME, "Error: Bad Net Name"), 
			new ErrorClass(ERROR_BAD_PROVIDER, "Error: Bad Provider"), 
			new ErrorClass(ERROR_CANCELLED, "Error: Cancelled"), 
			new ErrorClass(ERROR_EXTENDED_ERROR, "Error: Extended Error"), 
			new ErrorClass(ERROR_INVALID_ADDRESS, "Error: Invalid Address"), 
			new ErrorClass(ERROR_INVALID_PARAMETER, "Error: Invalid Parameter"), 
			new ErrorClass(ERROR_INVALID_PASSWORD, "Error: Invalid Password"), 
			new ErrorClass(ERROR_MORE_DATA, "Error: More Data"), 
			new ErrorClass(ERROR_NO_MORE_ITEMS, "Error: No More Items"), 
			new ErrorClass(ERROR_NO_NET_OR_BAD_PATH, "Error: No Net Or Bad Path"), 
			new ErrorClass(ERROR_NO_NETWORK, "Error: No Network"), 
			new ErrorClass(ERROR_BAD_PROFILE, "Error: Bad Profile"), 
			new ErrorClass(ERROR_CANNOT_OPEN_PROFILE, "Error: Cannot Open Profile"), 
			new ErrorClass(ERROR_DEVICE_IN_USE, "Error: Device In Use"), 
			new ErrorClass(ERROR_EXTENDED_ERROR, "Error: Extended Error"), 
			new ErrorClass(ERROR_NOT_CONNECTED, "Error: Not Connected"), 
			new ErrorClass(ERROR_OPEN_FILES, "Error: Open Files"), 
            new ErrorClass(ERROR_DIRECTORY, "Error: Invalid Directory"),
            new ErrorClass(ERROR_USER_GROUP_NAME, "Error: The user name or group name parameter is invalid"),
            new ErrorClass(ERROR_MULTIPLE_CREDENTIALS, "Error: Multiple Credentials in a Single Windows Session")
		};

        private static string GetErrorForNumber(int errNum)
        {
            foreach (ErrorClass er in ERROR_LIST)
            {
                if (er.num == errNum) return er.message;
            }
            return "Error: Unknown, " + errNum;
        }
        #endregion

        [DllImport("Mpr.dll")]
        private static extern int WNetUseConnection(
            IntPtr hwndOwner,
            NETRESOURCE lpNetResource,
            string lpPassword,
            string lpUserID,
            int dwFlags,
            string lpAccessName,
            string lpBufferSize,
            string lpResult
            );

        [DllImport("Mpr.dll")]
        private static extern int WNetCancelConnection2(
            string lpName,
            int dwFlags,
            bool fForce
            );

        [StructLayout(LayoutKind.Sequential)]
        private class NETRESOURCE
        {
            public int dwScope = 0;
            public int dwType = 0;
            public int dwDisplayType = 0;
            public int dwUsage = 0;
            public string lpLocalName = "";
            public string lpRemoteName = "";
            public string lpComment = "";
            public string lpProvider = "";
        }


        public static void ConnectToRemote(string remoteUNC, string username, string password)
        {
            ConnectToRemote(remoteUNC, username, password, false);
        }

        public static void ConnectToRemote(string remoteUNC, string username, string password, bool promptUser)
        {
            ConnectToRemote(remoteUNC, username, password, promptUser, false);
        }

        private static void ConnectToRemote(string remoteUNC, string username, string password, bool promptUser, bool multipleCredentialsInProgress)
        {
            NETRESOURCE nr = new NETRESOURCE();
            nr.dwType = RESOURCETYPE_DISK;
            nr.lpRemoteName = Clean(remoteUNC);
            
            //			nr.lpLocalName = "F:";

            int ret;
            if (promptUser)
                ret = WNetUseConnection(IntPtr.Zero, nr, "", "", CONNECT_INTERACTIVE | CONNECT_PROMPT, null, null, null);
            else
                ret = WNetUseConnection(IntPtr.Zero, nr, password, username, 0, null, null, null);

            if (ret == NO_ERROR) return;
            if (ret == ERROR_MULTIPLE_CREDENTIALS && !multipleCredentialsInProgress)
            {
                DisconnectRemote(remoteUNC);
                ConnectToRemote(remoteUNC, username, password, promptUser, true);
                return;
            }
            throw new InvalidOperationException(GetErrorForNumber(ret));
        }

        public static void DisconnectRemote(string remoteUNC)
        {
            int ret = WNetCancelConnection2(Clean(remoteUNC), CONNECT_UPDATE_PROFILE, false);
            if (ret == NO_ERROR) return;
            throw new InvalidOperationException(GetErrorForNumber(ret));
        }

        private static string Clean(string remoteUNC)
        {
            if (string.IsNullOrEmpty(remoteUNC))
                throw new ArgumentNullException("remoteUNC");

            if (!System.IO.Path.IsPathRooted(remoteUNC))
                throw new ArgumentOutOfRangeException("remoteUNC", @"path must be of the form \\server...");

            if (!remoteUNC.StartsWith(System.IO.Path.DirectorySeparatorChar.ToString() + System.IO.Path.DirectorySeparatorChar.ToString())
                && !remoteUNC.StartsWith(System.IO.Path.AltDirectorySeparatorChar.ToString() + System.IO.Path.AltDirectorySeparatorChar.ToString()))
                throw new ArgumentOutOfRangeException("remoteUNC", @"path must be of the form \\server...");

            // we're working with something at least workable now.  We'll strip off the first two chars, split the rest on separators, and return back just the server portion (index 0)
            return @"\\" + System.IO.Path.GetPathRoot(remoteUNC).Substring(2).Split(System.IO.Path.DirectorySeparatorChar, System.IO.Path.AltDirectorySeparatorChar)[0];

        }
    }
}

#endregion