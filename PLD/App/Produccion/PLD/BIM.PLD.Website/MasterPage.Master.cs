using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;

//using Seguridad.Menu;
//using Seguridad.Session;

using Seguridad.Logic.Menu;
using Seguridad.Logic.Autenticacion;

namespace Unival
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        BIM.PLD.Website.VerificadorPLDServices.VerificadorPLDServicesClient rsVerificadorServicio = new BIM.PLD.Website.VerificadorPLDServices.VerificadorPLDServicesClient();

        clsMenu objMenu = new clsMenu();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //_TotalCorreo();

                
                clsManejoSesion controlador = new clsManejoSesion();

                if (Session["User"] == null || Session["User"] == "" )
                {
                    Session["bitCierraVentana"] = "0";
                    Response.Redirect("~/frmLogin.aspx");
                }

                // Si la session esta activa
                if (Session["User"] != "" && Session["User"] != null)
                {
                    this.lblPerfil.Text = Convert.ToString(Session["Puesto"]);
                    this.lblDescUsuario.Text = Convert.ToString(Session["UserName"]);

                    Session.Add("vsMasterPageContent", this.ContentPlaceHolderContenido.ClientID.ToString() + "_");
                    MetCrearMenuAJAX();
                }
                else
                    Session["bitCierraVentana"] = "0";
            }
        }
        /// <summary>
        /// Cierra la sesión actual del usuario
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkSalirSistema_Click(object sender, EventArgs e)
        {
            string rutaFinal = string.Empty;

            Session["bitCierraVentana"] = "0";
            // Abandona Session
            Session.Abandon();

            // Arma la ruta Final
            rutaFinal = ConfigurationManager.AppSettings["LoginURL"];

            // Ejecuta Script
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Cerrar", "javascript:Salir('" + rutaFinal + "');", true);

        }
        /// <summary>
        /// Evento que envia al sistema a la pagina de inicio.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ibtnInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("../frmInicio.aspx", false);
            
        }
        /// <summary>
        /// Metodo que nos permite construir el menu
        /// </summary>
        private void MetCrearMenuAJAX()
        {
            // Si la session esta activa
            if (Session["User"] != "" && Session["User"] != null)
            {
                objMenu.MetGeneraMenu(ref menuSistema, Convert.ToInt32(Session["PerfilID"]));
            }

        }

        //protected void lnkBitacora_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("../DesbloqueoUsuarios/wfrDesbloqueoUsuario.aspx", false);
        //}


        //void ActualizarContador(object sender, EventArgs e)
        //{
        //    string total = "";
        //    System.Threading.Timer tie = new System.Threading.Timer(new System.Threading.TimerCallback(_TotalCorreo), total, 0, 1000);
        //}

        //private void _TotalCorreo()
        //{
        //    BIM.PLD.Website.VerificadorPLDServices.BitacoraPLD[] _dato = rsVerificadorServicio.ListadoBusquedaBitacoraPLD();
        //    lblTotalMensajes.Text = _dato.Count().ToString();
        //}
    }
}
