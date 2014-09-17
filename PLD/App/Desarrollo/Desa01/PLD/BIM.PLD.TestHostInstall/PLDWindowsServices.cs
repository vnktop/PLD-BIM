using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.ServiceModel;
using BIM.PLD.Services;

namespace BIM.PLD.TestHost
{
    partial class PLDWindowsServices : ServiceBase
    {
        public ServiceHost serviceHost1 = null;
        public ServiceHost serviceHost2 = null;
      
        public ServiceHost serviceHost4 = null;
        
        public ServiceHost serviceHost6 = null;
        public ServiceHost serviceHost7 = null;
        public ServiceHost serviceHost8 = null;


        public PLDWindowsServices()
        {
            ServiceName = "WCFWindowsServicePLD";
        }

        public static void Main()
        {
            ServiceBase.Run(new PLDWindowsServices());
        }


        // Start the Windows service.
        protected override void OnStart(string[] args)
        {
            if (serviceHost1 != null || serviceHost2 != null || serviceHost4 != null || serviceHost6 != null || serviceHost7 != null || serviceHost8 != null)
            {
                serviceHost1.Close();
                serviceHost2.Close();
               
                serviceHost4.Close();
                
                serviceHost6.Close();
                serviceHost7.Close();
                serviceHost8.Close();

            }

            // Create a ServiceHost for the CalculatorService type and 
            // provide the base address.
            serviceHost1 = new ServiceHost(typeof(CatalogoServices));
            serviceHost2 = new ServiceHost(typeof(ListaNegraServices));
           
            serviceHost4 = new ServiceHost(typeof(ConfiguracionPLDServices));
            
            serviceHost6 = new ServiceHost(typeof(BitacoraPLDServices));
            serviceHost7 = new ServiceHost(typeof(TipoListaNegraServices));
            serviceHost8 = new ServiceHost(typeof(TipoCambioServices));


            // Open the ServiceHostBase to create listeners and start 
            // listening for messages.
            serviceHost1.Open();
            serviceHost2.Open();
         
            serviceHost4.Open();
           
            serviceHost6.Open();
            serviceHost7.Open();
            serviceHost8.Open();

        }

        protected override void OnStop()
        {
            if (serviceHost1 != null || serviceHost2 != null || serviceHost4 != null || serviceHost6 != null || serviceHost7 != null || serviceHost8 != null)
            {
                serviceHost1.Close();
                serviceHost1 = null;
                serviceHost2.Close();
                serviceHost2 = null;
               
                serviceHost4.Close();
                serviceHost4 = null;
              
                serviceHost6.Close();
                serviceHost6 = null;
                serviceHost7.Close();
                serviceHost7 = null;
                serviceHost8.Close();
                serviceHost8 = null;

            }
        }
    }
}

