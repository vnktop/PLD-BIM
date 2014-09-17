using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.BusinessLogic;

namespace BIM.PLD.Services
{
    public class TipoListaNegraServices : ITipoListaNegra
    {
        public ServiceResult InsertarTipoListaNegra(CatTipoListaNegra oCatTipoListaNegra)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new TipoListaNegraLogic()).InsertarTipoListaNegra(oCatTipoListaNegra);
                if ((int)resultado.ResultValue > 0)
                {
                    resultado.ServiceOk = true;
                }
                else
                {
                    resultado.ServiceOk = false;
                }
            }
            catch (Exception ex)
            {
                resultado.ErrorMessage = "Error en TipoListaNegraServices.InsertarTipoListaNegra: " + ex.Message;
#if (DEBUG)
                Console.WriteLine("Error en TipoListaNegraServices.InsertarTipoListaNegra: " + ex.Message);
#else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
#endif
            }
            return resultado;
        }

        public List<CatTipoListaNegra> ListadoBusquedaTipoListaNegra(int? @intTipoTipificacionID, string @vchTipoLista)
        {
            List<CatTipoListaNegra> result = null;
            try
            {
                result = (new TipoListaNegraLogic()).ListadoBusquedaTipoListaNegra(@intTipoTipificacionID, @vchTipoLista);
            }
            catch (Exception ex)
            {
#if (DEBUG)
                Console.WriteLine("Error en TipoListaNegraServices.ListadoBusquedaTipoListaNegra: " + ex.Message);
#else
                    //EventLogManager.LogErrorEntry(ex.Message);
#endif
            }
            return result;
        }

        public ServiceResult editarTipoListaNegra(CatTipoListaNegra _datos)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new TipoListaNegraLogic()).editarTipoListaNegra(_datos);
                if ((int)resultado.ResultValue > 0)
                {
                    resultado.ServiceOk = true;
                }
                else
                {
                    resultado.ServiceOk = false;
                }
            }
            catch (Exception ex)
            {
                resultado.ErrorMessage = "Error en TipoListaNegraServices.editarTipoListaNegra: " + ex.Message;
#if (DEBUG)
                Console.WriteLine("Error en TipoListaNegraServices.editarTipoListaNegra: " + ex.Message);
#else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
#endif
            }
            return resultado;
        }

        public ServiceResult eliminarTipoListaNegra(int? intTipoListaID)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new TipoListaNegraLogic()).eliminarTipoListaNegra(intTipoListaID);
                if ((int)resultado.ResultValue > 0)
                {
                    resultado.ServiceOk = true;
                }
                else
                {
                    resultado.ServiceOk = false;
                }
            }
            catch (Exception ex)
            {
                resultado.ErrorMessage = "Error en TipoListaNegraServices.eliminarTipoListaNegra: " + ex.Message;
#if (DEBUG)
                Console.WriteLine("Error en TipoListaNegraServices.eliminarTipoListaNegra: " + ex.Message);
#else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
#endif
            }
            return resultado;
        }

        public ServiceResult LeerExisteciaRegistroTipoListaNegra(int? @intTipoTipificacionID, string @vchTipoLista)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new TipoListaNegraLogic()).LeerExisteciaRegistroTipoListaNegra(@intTipoTipificacionID, @vchTipoLista);
                if ((int)resultado.ResultValue > 0)
                {
                    resultado.ServiceOk = true;
                }
                else
                {
                    resultado.ServiceOk = false;
                }
            }
            catch (Exception ex)
            {
                resultado.ErrorMessage = "Error en TipoListaNegraServices.LeerExisteciaRegistroTipoListaNegra: " + ex.Message;
#if (DEBUG)
                Console.WriteLine("Error en TipoListaNegraServices.LeerExisteciaRegistroTipoListaNegra: " + ex.Message);
#else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
#endif
            }
            return resultado;
        }

        public ServiceResult InsertarTipoTipificacion(CatTipoListaNegra oCatTipoListaNegra)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new TipoListaNegraLogic()).InsertarTipoTipificacion(oCatTipoListaNegra);
                if ((int)resultado.ResultValue > 0)
                {
                    resultado.ServiceOk = true;
                }
                else
                {
                    resultado.ServiceOk = false;
                }
            }
            catch (Exception ex)
            {
                resultado.ErrorMessage = "Error en TipoListaNegraServices.InsertarTipoTipificacion: " + ex.Message;
#if (DEBUG)
                Console.WriteLine("Error en TipoListaNegraServices.InsertarTipoTipificacion: " + ex.Message);
#else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
#endif
            }
            return resultado;
        }

        public ServiceResult editarTipoTipificacion(CatTipoListaNegra _datos)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new TipoListaNegraLogic()).editarTipoTipificacion(_datos);
                if ((int)resultado.ResultValue > 0)
                {
                    resultado.ServiceOk = true;
                }
                else
                {
                    resultado.ServiceOk = false;
                }
            }
            catch (Exception ex)
            {
                resultado.ErrorMessage = "Error en TipoListaNegraServices.editarTipoTipificacion: " + ex.Message;
#if (DEBUG)
                Console.WriteLine("Error en TipoListaNegraServices.editarTipoTipificacion: " + ex.Message);
#else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
#endif
            }
            return resultado;
        }

        public ServiceResult LeerExisteciaRegistroTipoTipificacion(string @VCDDESCRIPCION)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new TipoListaNegraLogic()).LeerExisteciaRegistroTipoTipificacion(@VCDDESCRIPCION);
                if ((int)resultado.ResultValue > 0)
                {
                    resultado.ServiceOk = true;
                }
                else
                {
                    resultado.ServiceOk = false;
                }
            }
            catch (Exception ex)
            {
                resultado.ErrorMessage = "Error en TipoListaNegraServices.LeerExisteciaRegistroTipoTipificacion: " + ex.Message;
#if (DEBUG)
                Console.WriteLine("Error en TipoListaNegraServices.LeerExisteciaRegistroTipoTipificacion: " + ex.Message);
#else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
#endif
            }
            return resultado;
        }
    }
}
