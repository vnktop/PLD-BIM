using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using BIM.BusinessEntities;
using BIM.PLDWS.BusinessLogic;

using Microsoft.Web.Administration;
using System.Diagnostics;
using System.Transactions;



namespace BIM.PLDWS.Website
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "ServiceCaroline" en el código, en svc y en el archivo de configuración a la vez.
    public class ServiceCaroline : IServiceCaroline
    {
        public int InsertarCaroline(WSCaroline oWSCaroline)
        {

                       
            WSCarolineLogic rsCaroline = new WSCarolineLogic();
            int Respuesta = 0;

            try
            {
                Respuesta = rsCaroline.InsertarWSCaroline(oWSCaroline);
            }
            catch (Exception ex)
            {
                //Console.WriteLine("Error en ServiceCaroline: " + ex.Message);
                string sSource;
                string sLog;
                string sEvent;

                sSource = "dotNET Sample App";
                sLog = "Application";
                sEvent = "Error en ServiceCaroline: " + ex.Message;

                if (!EventLog.SourceExists(sSource))
                    EventLog.CreateEventSource(sSource, sLog);

                EventLog.WriteEntry(sSource, sEvent);
                EventLog.WriteEntry(sSource, sEvent, EventLogEntryType.Warning, 234);



            }
                   
            return Respuesta;

        }

        public int InsertarListaCaroline(List<WSCaroline> lstWSCaroline)
        {


            
            int Respuesta = 0;

            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {   

                    foreach (WSCaroline wsCaroline in lstWSCaroline)
                    {
                        InsertarCaroline(wsCaroline);
                        Respuesta++;
                    }
                    //Respuesta = rsCaroline.InsertarWSCaroline(oWSCaroline);
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                //Console.WriteLine("Error en ServiceCaroline: " + ex.Message);
                string sSource;
                string sLog;
                string sEvent;

                sSource = "dotNET Sample App";
                sLog = "Application";
                sEvent = "Error en ServiceCaroline: " + ex.Message;

                if (!EventLog.SourceExists(sSource))
                    EventLog.CreateEventSource(sSource, sLog);

                EventLog.WriteEntry(sSource, sEvent);
                EventLog.WriteEntry(sSource, sEvent, EventLogEntryType.Warning, 234);



            }

            return Respuesta;

        }
    }
}
