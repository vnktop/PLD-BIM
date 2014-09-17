using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.BusinessLogic;

namespace BIM.PLD.Services
{
    public class VerificadorPLDServices : IVerificadorPLDServices
    {
        public VerificadorPLD ServicioVerificadorPLD(BitacoraPLD parametros)
        {
            VerificadorPLD result = null;
            try
            {
                result = (new VerificadorPLDLogic()).ServicioVerificadorPLD(parametros);
            }
            catch (Exception ex)
            {
                #if(DEBUG)
                Console.WriteLine("Error en VerificadorPLDServices.ServicioVerificadorPLD: " + ex.Message);
                #else
                    EventLogManager.LogErrorEntry("Error en VerificadorPLDServices.ServicioVerificadorPLD: " + ex.Message);
                    //TODO: Codificar envío de notificación de error al EventLog
                #endif
            }
            return result;
        }
    }
}
