using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Diagnostics;
using BIM.PLDWS.BusinessLogic;
//using BIM.BusinessEntities;

using System.Configuration;
using System.IO;

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

                if (Directory.Exists(RepositorioTmpLocal))
                    Directory.CreateDirectory(RepositorioTmpLocal);

                string msg = DateTime.Today.ToShortDateString() + " - " + DateTime.Today.ToShortTimeString() + " Mensaje error: " + ex.Message;

                File.AppendAllText(RepositorioTmpLocal + ArchivoError, msg);                
              
#else
                    EventLogManager.LogErrorEntry("Error en VerificadorPLDServices.ServicioVerificadorPLD: " + ex.Message);
                    //TODO: Codificar envío de notificación de error al EventLog
#endif
            }
            return result;
        }

        public string RepositorioTmpLocal
        {
            get
            {
                return ConfigurationManager.AppSettings["RepositorioTmpLocal"].ToString();
            }
        }

        public string ArchivoError
        {
            get
            {
                return ConfigurationManager.AppSettings["ArchivoError"].ToString();
            }
        }

       

        public string cs { get; set; }
    }
}

