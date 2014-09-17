using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;
using System.Linq;
using System.ServiceProcess;


namespace BIM.PLD.TestHost
{
    [RunInstaller(true)]
    public partial class PLDInstaller : System.Configuration.Install.Installer
    {
         private ServiceProcessInstaller process;
        private ServiceInstaller service;



        public PLDInstaller()
        {
            InitializeComponent();

            process = new ServiceProcessInstaller();
            process.Account = ServiceAccount.LocalSystem;
            service = new ServiceInstaller();
            service.ServiceName = "WCFWindowsServicePLD";
            Installers.Add(process);
            Installers.Add(service);


        }
    }
}

