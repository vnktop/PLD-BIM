using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Diagnostics;
using BIM.PLDWS.BusinessLogic;
//using BIM.BusinessEntities;

namespace BIM.PLDWS.Website
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "Service2" en el código, en svc y en el archivo de configuración a la vez.
    public class Service2 : IService2
    {


        public BIM.BusinessEntities.VerificadorPLD ServicioVerificadorPLD(BIM.BusinessEntities.BitacoraPLD parametros)
        {
            BIM.BusinessEntities.VerificadorPLD result = null;
            try
            {
                result = (new VerificadorPLDLogic()).ServicioVerificadorPLD(parametros);
            }
            catch (Exception ex)
            {
#if(DEBUG)


                const string fic = @"C:\inetpub\wwwroot\PLD\Prueba.txt";
                string texto = ex.Message;

                System.IO.StreamWriter sw = new System.IO.StreamWriter(fic);
                sw.WriteLine(texto);
                sw.Close();

                
                //Console.WriteLine("Error en VerificadorPLDServices.ServicioVerificadorPLD: " + ex.Message);

                //if (!EventLog.SourceExists(cs))
                //    EventLog.CreateEventSource(cs, "Application");

                //EventLog.WriteEntry(cs, ex.Message, EventLogEntryType.Error);
#else
                    EventLogManager.LogErrorEntry("Error en VerificadorPLDServices.ServicioVerificadorPLD: " + ex.Message);
                    //TODO: Codificar envío de notificación de error al EventLog
#endif
            }
            return result;
        }

       

        public string cs { get; set; }
    }
}

