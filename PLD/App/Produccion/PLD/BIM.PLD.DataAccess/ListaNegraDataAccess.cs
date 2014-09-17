using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.DataAccess.Context;

using System.Configuration;

using System.Diagnostics;
using System.Runtime.InteropServices;
using System.IO;

namespace BIM.DataAccess
{
    public class ListaNegraDataAccess
    {
        public int InsertarListaNegra(ListaNegra oListaNegra)
        {
            int? ListaNegraID = 0;
            try
            {
                using (ListaNegraDataContext dc = new ListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.stp_InsertaListaNegra(oListaNegra.VCHIDQEQ
                                                                    , oListaNegra.VCHTIPOLISTA
                                                                    , oListaNegra.VCHNOMBRE
                                                                    , oListaNegra.VCHAPPATERNO
                                                                    , oListaNegra.VCHAPMATERNO
                                                                    , oListaNegra.VCHCURP
                                                                    , oListaNegra.VCHRFC
                                                                    , oListaNegra.VCHFECHANAC
                                                                    , oListaNegra.VCHESTATUS
                                                                    , oListaNegra.VCHDEPENDENCIA
                                                                    , oListaNegra.VCHPUESTO
                                                                    , oListaNegra.INTIDDISPO
                                                                    , oListaNegra.BITCURPOK
                                                                    , oListaNegra.VCHIDREL
                                                                    , oListaNegra.VCHPARENTESCO
                                                                    , oListaNegra.VCHRAZONSOCIAL
                                                                    , oListaNegra.VCHRFCMORAL
                                                                    , oListaNegra.VCHISSSTE
                                                                    , oListaNegra.VCHIMSS
                                                                    , oListaNegra.VCHINGRESOS
                                                                    , oListaNegra.VCHNOMCOMPLETO
                                                                    , oListaNegra.VCHAPELLIDOS
                                                                    , oListaNegra.VCHENTIDAD
                                                                    , oListaNegra.VCHGENERO
                                                                    , oListaNegra.AUDUSUARIO
                                                                    , DateTime.Now
                                                                    , oListaNegra.vchCadenaNPM
                                                                    , oListaNegra.vchCadenaNMP);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ListaNegraID.Value;
        }

        public int InsertaProveedor(string proveedor)
        {
            int resultado = 0;
            try
            {
                using (ListaNegraDataContext dc = new ListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.stp_InsertaProveedor(proveedor);
                }
                resultado = 1;
            }
            catch (Exception ex)
            {
                resultado = 0;
                throw ex;

            }
            return resultado;
        }

        //public List<ListaNegra> BusquedaListaNegra(int iTipoListaNegra)
        //{
        //    List<ListaNegra> results = new List<ListaNegra>();
        //    try
        //    {
        //        using (ListaNegraDataContext dc = new ListaNegraDataContext(Helper.ConnectionString()))
        //        {
        //            var query = from item in dc.stp_BuscarListaNegra(iTipoListaNegra)
        //                        select new ListaNegra
        //                        {

        //                            VCHTIPOLISTA = item.VCHTIPOLISTA,
        //                            VCHIDQEQ = item.VCHIDQEQ,
        //                            VCHNOMBRE = item.VCHNOMBRE,
        //                            VCHAPPATERNO = item.VCHAPPATERNO,
        //                            VCHAPMATERNO = item.VCHAPMATERNO,
        //                            VCHCURP = item.VCHCURP,
        //                            VCHRFC = item.VCHRFC,
        //                            VCHFECHANAC = item.VCHFECHANAC,
        //                            VCHESTATUS = item.VCHESTATUS,
        //                            VCHDEPENDENCIA = item.VCHDEPENDENCIA,
        //                            VCHPUESTO = item.VCHPUESTO,
        //                            INTIDDISPO = item.INTIDDISPO,
        //                            BITCURPOK = item.BITCURPOK,
        //                            VCHIDREL = item.VCHIDREL,
        //                            VCHPARENTESCO = item.VCHPARENTESCO,
        //                            VCHRAZONSOCIAL = item.VCHRAZONSOCIAL,
        //                            VCHRFCMORAL = item.VCHRFCMORAL,
        //                            VCHISSSTE = item.VCHISSSTE,
        //                            VCHIMSS = item.VCHIMSS,
        //                            VCHINGRESOS = item.VCHINGRESOS,
        //                            VCHNOMCOMPLETO = item.VCHNOMCOMPLETO,
        //                            VCHAPELLIDOS = item.VCHAPELLIDOS,
        //                            VCHENTIDAD = item.VCHENTIDAD,
        //                            VCHGENERO = item.VCHGENERO,
        //                            AUDUSUARIO = item.AUDUSUARIO,
        //                            VCHTIPOLISTANEGRA = item.VCHTIPOLISTANEGRA};
        //            results.AddRange(query);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    return results;
        //}
        public string CargaListasNegras(int iProveedor)
        {
            string resultado = null;
            try
            {
                using (ListaNegraDataContext dc = new ListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.CommandTimeout = 0;
                    dc.stp_CargaListasNegras(ref resultado, iProveedor);
                }
            }
            catch (Exception ex)
            {                
                throw ex;
            }

            return resultado == null ? "" : resultado;
        }

        public List<Proveedor> ListarProveedores()
        {
            List<Proveedor> results = new List<Proveedor>();
            try
            {
                using (ListaNegraDataContext dc = new ListaNegraDataContext(Helper.ConnectionString()))
                {
                    var query = from item in dc.stp_ListarProveedores()
                                select new Proveedor
                                {
                                    iProveedorId = item.iProveedorId,
                                    strNombre = item.vchDescripcion
                                };
                    results.AddRange(query);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return results;
        }

        

        public List<SistemasPLD> ListarSistemasPLD()
        {
            List<SistemasPLD> results = new List<SistemasPLD>();
            try
            {
                using (ListaNegraDataContext dc = new ListaNegraDataContext(Helper.ConnectionString()))
                {
                    var query = from item in dc.stp_ListarSistemasPLD()
                                select new SistemasPLD
                                {

                                    sintSistemaID = item.sintSistemaID,
                                    vchNombre = item.vchNombre,
                                    vchDescripcion = item.vchDescripcion,
                                    conf = item.conf


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

        public bool almacenarArchivo(string fuente, string destino, string archivo)
        {
            bool _res;
            try
            {                                
                ExternalResourceConnection.PinvokeWindowsNetworking.ConnectToRemote(destino, Usuario, Clave);
                File.Copy(fuente + archivo, destino + archivo, true);
                ExternalResourceConnection.PinvokeWindowsNetworking.DisconnectRemote(Repositorio);
                _res = true;
            }
            catch (Exception ex)
            {
                _res = false;
                throw ex;
            }
            return _res;
        }

        #region Variables de conexión

        public string Repositorio
        {
            get
            {
                return ConfigurationManager.AppSettings["RepositorioLN"];
            }
        }

        public string Usuario
        {
            get
            {
                return ConfigurationManager.AppSettings["UsuarioLN"];
            }
        }

        public string Clave
        {
            get
            {
                return ConfigurationManager.AppSettings["ClaveLN"];
            }
        }


        #endregion

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
}