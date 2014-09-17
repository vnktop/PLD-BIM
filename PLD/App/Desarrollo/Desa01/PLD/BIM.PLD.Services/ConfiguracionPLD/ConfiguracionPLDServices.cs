using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.BusinessLogic;

namespace BIM.PLD.Services
{
    public class ConfiguracionPLDServices : IConfiguracionPLDServices
    {
        public ServiceResult InsertarConfiguracionPLD(ConfiguracionPLD oConfiguracionPLD)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new ConfiguracionPLDLogic()).InsertarConfiguracionPLD(oConfiguracionPLD);                
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
                resultado.ErrorMessage = "Error en ConfiguracionPLDServices.InsertarConfiguracionPLD: " + ex.Message;
                #if (DEBUG)
                    Console.WriteLine("Error en ConfiguracionPLDServices.InsertarConfiguracionPLD: " + ex.Message);
                #else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
                #endif
            }
            return resultado;
        }

        public List<ConfiguracionPLD> ListadoBusquedaConfiguracionPLD(int? @intTipoTipificacionID, Int16? sintSistemaID)
        {
            List<ConfiguracionPLD> result = null;
            try
            {
                result = (new ConfiguracionPLDLogic()).ListadoBusquedaConfiguracionPLD(@intTipoTipificacionID, sintSistemaID);                
            }
            catch (Exception ex)
            {
                #if (DEBUG)
                Console.WriteLine("Error en ConfiguracionPLDServices.ListadoBusquedaConfiguracionPLD: " + ex.Message);
                #else
                    //EventLogManager.LogErrorEntry(ex.Message);
                #endif
            }
            return result;
        }

        public ServiceResult editarConfiguracionPLD(ConfiguracionPLD _datos)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new ConfiguracionPLDLogic()).editarConfiguracionPLD(_datos);                
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
                resultado.ErrorMessage = "Error en ConfiguracionPLDServices.editarConfiguracionPLD: " + ex.Message;
                #if (DEBUG)
                    Console.WriteLine("Error en ConfiguracionPLDServices.editarConfiguracionPLD: " + ex.Message);
                #else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
                #endif
            }
            return resultado;
        }

        public ServiceResult eliminarConfiguracionPLD(int? @intTipoTipificacionID, Int16? sintSistemaID)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ResultValue = (new ConfiguracionPLDLogic()).eliminarConfiguracionPLD(@intTipoTipificacionID, sintSistemaID);                
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
                resultado.ErrorMessage = "Error en ConfiguracionPLDServices.eliminarConfiguracionPLD: " + ex.Message;
                #if (DEBUG)
                    Console.WriteLine("Error en ConfiguracionPLDServices.eliminarConfiguracionPLD: " + ex.Message);
                #else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
                #endif
            }
            return resultado;
        }

    }
}
