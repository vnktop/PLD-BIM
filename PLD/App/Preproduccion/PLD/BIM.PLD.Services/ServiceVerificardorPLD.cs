using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using BIM.BusinessEntities;
using BIM.PLD.BusinessLogic;

namespace BIM.PLD.Services
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "ServiceVerificardorPLD" en el código y en el archivo de configuración a la vez.
    public class ServiceVerificardorPLD : IServiceVerificardorPLD
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
