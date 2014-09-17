using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Unival.UserControl.Comun
{
    public partial class wucNotificacionMsj : System.Web.UI.UserControl
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            String[] aNivel; Int32 nivel; String rutaFinal = "";



            // Recupera direccion actual de la Pagina
            String rootPath = Server.HtmlEncode(Request.Path);

            // Recupera nivel de la ruta
            aNivel = rootPath.Split('/');
            nivel = aNivel.Length;

            // Recorre dependiendo el numero de niveles
            for (var i = 1; i <= nivel - 3; i++)
            {
                rutaFinal = rutaFinal + "../";
            }

            // Arma la ruta Final
            //  rutaFinal = rutaFinal;
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "jsLib1", "<script type='text/javascript' src='" + rutaFinal + "JavaScript/JQuery/jquery-1.6.2.min.js'></script>", false);

            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "jsLib2", "<script type='text/javascript' src='" + rutaFinal + "JavaScript/JQuery/jquery-ui.js'></script>", false);

            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "jsLib3", "<script type='text/javascript' src='" + rutaFinal + "JavaScript/JQuery/ui.core.js'></script>", false);
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "jsLib4", "<script type='text/javascript' src='" + rutaFinal + "JavaScript/JQuery/ui.notificationmsg.js'></script>", false);
//              ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "jsLib5", "<script type='text/javascript' src='" + rutaFinal + "JavaScript/JQuery/ui.notificationmsg.js'></script>", false);

         //   ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "jsTemas", "<script type='text/javascript' src='" + rutaFinal + "App_Themes/HCMTheme/JQuery/sliding-panel.css></script>", false);

             




            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "Msj", "<script type='text/javascript'> " +

                       " function MuestraMsj() {" +

                      " var animStyle = 'slide'; " +
                     " $.ajax({ " +
                       " type: 'POST', " +
                       " url: '" + rutaFinal + "WsUnival/MensajeAlertaWS.asmx/GetMessages', " +
                       " data: '{}'," +
                       " contentType: 'application/json; charset=utf-8'," +
                       " dataType: 'json'," +
                       " success: function (msg) {" +
                        " $.each(msg.d, function(i, l) { " +

                        " $('body').append('<embed id=sound src=" + rutaFinal + "App_Images/beep.mp3 autostart=true hidden=true></embed>');" +


                        " dv = document.createElement('div');" +
                        " dv.setAttribute('id', 'lyr1' + i); " +
                        " dv.style.position = 'fixed'; " +
                        " dv.style.border = ' solid 1px black'; " +
                        " dv.style.pixelWidth = 150; " +
                        " dv.style.pixelHeight = 100; " +
                        " dv.style.backgroundColor = 'white'; " +
                        " var pos = i * 110; " +
                        " if (i == 0) " +
                          "  dv.style.bottom = '0px'; " +
                        " else " +
                          "  dv.style.bottom = pos + 'px'; " +
                        " dv.style.right = '0px'; " +
                        " dv.style.display = 'none'; " +
                        " dv.style.margin = '0px 0px 0px'+ pos + 'px'; " +
                        " dv.innerHTML = '<div style=\"width:142px;background-color:Transparent;background-image:url(" + rutaFinal + "App_Images/bg.gif);background-repeat:repeat-x;padding:6px;color:#ffffff;text-align:right;\" > " +
                        " <div style=\"padding: 4px;  font-size: 12px; font-weight: bold; color: #ffffff; float:left;\"> My Inbox</div> " +
                        " <span id=\"closebutton\'+i+\'\"  style=cursor:hand> " +
                        " <img alt=Cerrar  src= " + rutaFinal + "App_Images/close_vista.gif border=0 /> </span> " +
                        " <div style=\"padding: 20px; text-align: left; color : red;\"><strong> <span id=modalbody> \'+ l +\'  </span></strong>&nbsp; " +
                        " </div>'; " +
                        " document.forms[0].appendChild(dv);" +

                       
                        " var per = pos * 5000;" +
                         " $('#lyr1' + i).notificationmsg({ period: per });" +
                         " $('#lyr1' + i).notificationmsg({ animation: animStyle });" +
                        " $('#closebutton' + i).click(function() { $('#lyr1' + i).notificationmsg('hide'); });" +

                        " setTimeout(function() { $('#lyr1' + i).notificationmsg('show'); }, 1000); " +

                            " }); " +
                         " }," +
                       " error: function (xhr,msg,e) {" +
                        " alert(msj);" +
                         " }" +
                     " });" +
                       " }" +
                       " </script>", false);
            //   ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "UrlImg", "urlImg('" + rutaFinal + "')", true);


        }

        protected void Page_Load(object sender, EventArgs e)
        {



        }

        protected void btnPrueb_Onclick(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "JsMensaje", "javascript:MuestraMsj();", true);

        }

    }
}