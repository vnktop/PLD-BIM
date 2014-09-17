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
//using Seguridad.Autenticacion;
using System.Diagnostics;


namespace Automatizacion.ControlesComunes
{
    public partial class Mensaje : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          

        }
        /// <summary>
        /// Metodo que selecciona el tipo de mensaje a mostrar al usuario, ademas
        /// de que se inicializa el mensaje a mostrar
        /// </summary>
        /// <param name="mensaje">Establece el mensaje</param>
        /// <param name="sintTipo">1-Correcto,2-Error,3-Alerta,Default-Alerta</param>
        public void setMensaje(string mensaje, Int16 sintTipo /*1-Correcto,2-Error,3-Alerta*/)
        {
          
                this.lblMensaje.Text = mensaje;
                switch (sintTipo)
                {
                    case 1:
                        imgMensaje.ImageUrl = "~/App_Images/Correcto.png";
                        break;
                    case 2:
                        imgMensaje.ImageUrl = "~/App_Images/Error.png";
                        break;
                    case 3:
                        imgMensaje.ImageUrl = "~/App_Images/Alerta.png";
                        break;
                    default:
                        imgMensaje.ImageUrl = "~/App_Images/Alerta.png";
                        break;
                }
                mpeConfirmacion.Show();
            
        }

        //protected void btnCerrarConfirmacion_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        mpeConfirmacion.Hide();
        //    }
        //    catch (Exception ex)
        //    {
        //        StackTrace st = new StackTrace(true);
        //        clsLogging.registrarError(ex.Message, st, Session["User"].ToString());
        //        //wucMensajeSisLog.setMensaje(ex.Message, 2);
        //    }
        //}
    }
}