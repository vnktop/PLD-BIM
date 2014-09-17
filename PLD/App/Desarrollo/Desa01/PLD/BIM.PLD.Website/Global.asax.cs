﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using Seguridad.DataAccess.Linq.Autenticacion;
using Seguridad.DataAccessIntegration;
using Seguridad.Logic.Autenticacion;
using Seguridad.DataAccessIntegration.Autenticacion;
using System.Net;

namespace BIM.PLD.Website
{
    public class Global : System.Web.HttpApplication
    {

        void Application_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta al iniciarse la aplicación
            Application.Add("Nom_Sis", "Módulo de Reportes Regulatorios");   // Nombre del Sistema
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Código que se ejecuta cuando se cierra la aplicación

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Código que se ejecuta al producirse un error no controlado

        }

        void Session_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta cuando se inicia una nueva sesión
            // Variables de sistema
            Session.Timeout = 10;             //*** TIEMPO DE LA SESION
            Session.LCID = 2058;

            // Variables de usuario
            this.Session.Add("User", "");   //*** LOGION DEL USUARIO
            this.Session.Add("UserName", "");   //*** NOMBRE DEL USUARIO
            this.Session.Add("PerfilID", "");
            this.Session.Add("Perfil", "");
            this.Session.Add("BANNER", "");   //*** BANNER
            //this.Session.Add("IP", System.Net.Dns.GetHostByName(System.Net.Dns.GetHostName()).AddressList[0].ToString());
            this.Session.Add("IP", Dns.GetHostEntry(Dns.GetHostName()).AddressList[0].ToString());

            this.Session.Add("bitCierraVentana", "0");

            // Variables de catálogos generales
            Session.Add("AdmCat", "");
            Session.Add("Pag_Act", "frmInicio.aspx");
        }

        void Session_End(object sender, EventArgs e)
        {
            // Código que se ejecuta cuando finaliza una sesión.
            // Nota: el evento Session_End se desencadena sólo cuando el modo sessionstate
            // se establece como InProc en el archivo Web.config. Si el modo de sesión se establece como StateServer 
            // o SQLServer, el evento no se genera.
            tbl_BIT_Sesiones sesion = (tbl_BIT_Sesiones)Session["DatosSesion"];
            clsDatosOperaciones datos = (clsDatosOperaciones)Session["DatosInformativos"];

            this.Session.Add("bitCierraVentana", "0");

            if (sesion != null)
            {
                if (sesion.sintSistemaID == Convert.ToInt16(Session["sintSistemaID"]))
                {
                    sesion.bitEstatusSesion = false;
                    clsManejoSesion controlador = new clsManejoSesion();
                    controlador.ManejarSesionSistema(clsSesionesDA.OperacionSesiones.ACTUALIZAR_SESION_ESTATUS, sesion, datos);
                }
            }

            // Variables de sistema
            Session.Timeout = 1;                //*** TIEMPO DE LA SESION
            Session.LCID = 2058;

            // Variables de usuario
            this.Session.Add("User", "");       //*** LOGION DEL USUARIO
            this.Session.Add("UserName", "");   //*** NOMBRE DEL USUARIO
            this.Session.Add("PerfilID", "");
            this.Session.Add("Perfil", "");
            this.Session.Add("NuevoIngreso", "");
            this.Session.Add("IP", "");
            this.Session.Add("BANNER", "");

            // Variables de catálogos generales
            Session.Add("AdmCat", "");
            Session.Add("Pag_Act", "frmInicio.aspx");
        }

    }
}
