using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Seguridad.Logic.Utilidades;
using Seguridad.DataAccessIntegration;
using Seguridad.Logic.Autenticacion;
using Seguridad.DataAccessIntegration.Autenticacion;
using Seguridad.DataAccessIntegration.Autorizacion;
using Seguridad.Logic.Autorizacion;

namespace BIM.PLD.Website
{
    public partial class frmLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region Codigo para autenticar el token
            string url = ConfigurationManager.AppSettings["LoginURL"];
            if (Request.QueryString["data1"] != null)
            {
                string token = Request.QueryString["data1"].ToString();
                string usuarioId = Request.QueryString["data2"].ToString();
                string sistemaId = Request.QueryString["data3"].ToString();
                string ip = Request.QueryString["data4"].ToString();

                token = clsEncriptacion.DecryptString(token);
                usuarioId = clsEncriptacion.DecryptString(usuarioId);
                sistemaId = clsEncriptacion.DecryptString(sistemaId);
                ip = clsEncriptacion.DecryptString(ip); 

                Seguridad.DataAccess.Linq.Autenticacion.tbl_BIT_Sesiones sesion = new Seguridad.DataAccess.Linq.Autenticacion.tbl_BIT_Sesiones();
                sesion.guidToken = Guid.Parse(token.ToUpper());
                sesion.sintSistemaID = short.Parse(sistemaId);
                sesion.intUsuarioID = int.Parse(usuarioId);
                sesion.vchSesionID = Session.SessionID;
                sesion.bitEstatusSesion = true; 
                sesion.bitEstatusToken = true;

                clsDatosOperaciones datos = new clsDatosOperaciones(Convert.ToInt32(usuarioId), ip);

                sesion = new clsManejoSesion().ConsumirToken(sesion.guidToken, sesion.intUsuarioID.Value, sesion.sintSistemaID, ip);
                if (sesion != null)
                {
                    // Obtenemos los datos del usuario
                    DatosUsuario usuario = new clsManejoUsuario().GetDatosUsuario(sesion.intUsuarioID.Value, sesion.sintSistemaID);
                    List<MenuSistema> permisos = new clsManejoPermisos().GetPermisos(usuario.Perfil_Id);

                    Session["PerfilID"] = usuario.Perfil_Id;
                    Session["User"] = usuario.User_Desc;
                    Session["Perfil"] = usuario.SDescripPerfil;
                    Session["UserName"] = usuario.SNameUser;
                    Session["Puesto"] = usuario.StrPuesto;
                    Session["DatosSesion"] = sesion;
                    Session["DatosInformativos"] = datos;

                    Session["sintSistemaID"] = sistemaId;
                    // Almacenamos el token
                    Session["token"] = token;
                    Session["UserId"] = usuario.UserId;

                    // Redireccionamos a la pagina principal
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Inicio", "javascript:Abre();", true);
                }
                else
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Cerrar",
                        "javascript:Redirecciona('" + url + "');", true);
            }
            else
                // Ejecuta Script
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Cerrar",
                        "javascript:Redirecciona('" + url + "');", true);
            #endregion
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Cerrar", "javascript:Abre()", true);
        }
    }
}