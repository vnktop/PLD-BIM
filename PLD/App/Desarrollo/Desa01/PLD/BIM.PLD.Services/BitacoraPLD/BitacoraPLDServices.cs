using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.BusinessLogic;

namespace BIM.PLD.Services
{
    public class BitacoraPLDServices : IBitacoraPLDServices
    {
        public List<BitacoraPLD> ListadoBusquedaBitacoraPLD(string vchUsuario, int? intSistema)
        {
            List<BitacoraPLD> result = null;
            try
            {
                result = (new BitacoraLogic()).ListadoBusquedaBitacoraPLD(vchUsuario, intSistema);
            }
            catch (Exception ex)
            {
#if(DEBUG)
                Console.WriteLine("Error en BitacoraPLDServices.ListadoBusquedaBitacoraPLD: " + ex.Message);
#else
            EventLogManager.LogErrorEntry("Error en BitacoraPLDServices.ListadoBusquedaBitacoraPLD: " + ex.Message);
            //TODO: Codificar envío de notificación de error al EventLog
#endif
            }
            return result;
        }

        public ServiceResult desbloquearUsuario(desbloqueoBitacoraPLD parametros)
        {
            ServiceResult resultado = new ServiceResult();
            try
            {
                resultado.ServiceOk = (new BitacoraLogic()).desbloquearUsuario(parametros);                
            }
            catch (Exception ex)
            {
                resultado.ErrorMessage = "Error en BitacoraPLDServices.desbloquearUsuario: " + ex.Message;
#if (DEBUG)
                Console.WriteLine("Error en BitacoraPLDServices.desbloquearUsuario: " + ex.Message);
#else
                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
#endif
            }
            return resultado;
        }

//        public ServiceResult editarBitacoraPLD(BitacoraPLD parametros)
//        {
//            ServiceResult resultado = new ServiceResult();
//            try
//            {
//                resultado.ResultValue = (new VerificadorPLDLogic()).editarBitacoraPLD(parametros);
//                if ((int)resultado.ResultValue > 0)
//                {
//                    resultado.ServiceOk = true;
//                }
//                else
//                {
//                    resultado.ServiceOk = false;
//                }
//            }
//            catch (Exception ex)
//            {
//                resultado.ErrorMessage = "Error en ConfiguracionPLDServices.editarConfiguracionPLD: " + ex.Message;
//#if (DEBUG)
//                Console.WriteLine("Error en ConfiguracionPLDServices.editarConfiguracionPLD: " + ex.Message);
//#else
//                    //EventLogManager.LogErrorEntry(result.ErrorMessage);
//#endif
//            }
//            return resultado;
//        }

        

    }
}
