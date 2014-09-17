using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.BusinessLogic;

namespace BIM.PLD.Services
{
    public partial class ListaNegraServices : IListaNegraServices
    {
        public ServiceResult InsertarListaNegra(ListaNegra oListaNegra)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new ListaNegraLogic()).InsertarListaNegra(oListaNegra);
                resultado.ServiceOk = true;
            }
            catch (Exception ex) 
            {
                resultado.ErrorMessage = "Error en ListaNegraServices.InsertarListaNegra:" + ex.Message;
                #if (DEBUG)
                                Console.WriteLine(resultado.ErrorMessage);
                #else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
                #endif
            }
            return resultado;
        }


        //public List<ListaNegra> BusquedaListaNegra(int iTipoListaNegra)
        //{
        //    List<ListaNegra> result = null;
        //    try
        //    {
        //        result = (new ListaNegraLogic()).BusquedaListaNegra(iTipoListaNegra);
        //    }
        //    catch (Exception ex)
        //    {
        //        #if(DEBUG)
        //        Console.WriteLine("Error en ListaNegraServices.BusquedaListaNegra: " + ex.Message);
        //        #else
        //            EventLogManager.LogErrorEntry("Error en BitacoraInterfacesService.ListarBitacoraInterfaces: " + ex.Message);
        //            //TODO: Codificar envío de notificación de error al EventLog
        //        #endif
        //    }
        //    return result;
        //}
        public ServiceResult CargaListasNegras(int iProveedorId)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new ListaNegraLogic()).CargaListasNegras(iProveedorId);
                resultado.ServiceOk = true;
            }
            catch (Exception ex)
            {
                resultado.ErrorMessage = "Error en ListaNegraServices.CargaListasNegras:" + ex.Message;
#if (DEBUG)
                Console.WriteLine(resultado.ErrorMessage);
#else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
#endif
            }
            return resultado;
        }


        public List<Proveedor> ListarProveedores()
        {
            List<Proveedor> Result = new List<Proveedor>();
            try
            {
                Result = (new ListaNegraLogic()).ListarProveedores();
            }
            catch (Exception exc)
            {
                throw exc;
            }
            return Result;
        }

        public ServiceResult insertarProveedor(string proveedor)
        {
            ServiceResult result = new ServiceResult();               
            result.ResultValue = (new ListaNegraLogic()).insertaProveedor(proveedor);
            return result;
        }

        public List<SistemasPLD> ListarSistemasPLD()
        {
            List<SistemasPLD> result = null;
            try
            {
                result = (new ListaNegraLogic()).ListarSistemasPLD();
            }
            catch (Exception ex)
            {
#if(DEBUG)
                Console.WriteLine("Error en ListaNegraServices.ListarSistemasPLD: " + ex.Message);
#else
                    EventLogManager.LogErrorEntry("Error en BitacoraInterfacesService.ListaRelCatTipoListNegAccion: " + ex.Message);
                    //TODO: Codificar envío de notificación de error al EventLog
#endif
            }
            return result;

        }

        public ServiceResult almacenarArchivo(string fuente, string destino, string archivo)
        {
            ServiceResult result = new ServiceResult();
            try
            {
                result.ServiceOk = (new ListaNegraLogic()).almacenarArchivo(fuente, destino, archivo);
            }
            catch (Exception ex)
            {
#if (DEBUG)
                Console.WriteLine("Error en Interfaces. almacenarArchivo: " + ex.Message);
                result.ErrorMessage = "Error al escribir el archivo en repositorio: " + ex.Message;
                
#endif
                result.ResultValue = ex.Message;
            }
            return result;
        }
    }
}
