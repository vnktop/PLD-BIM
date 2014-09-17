using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BIM.PLD.Website.UserControl.Comun
{
    public partial class wucBusquedaInteligente : System.Web.UI.UserControl
    {
        public delegate void getRegistroEventHandler(int idRegistro);
        public event getRegistroEventHandler getRegistroEvent;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                hdnValue.ClientIDMode = System.Web.UI.ClientIDMode.Static;
                //hdnValue.ClientIDMode = System.Web.UI.ClientIDMode. "ctl00_ContentPlaceHolderContenido_tabAsignacion_tabDatoSol_wucBusquedaIntelig_hdnValue";
            }
            catch (Exception ex)
            {
                //wucMensajeSistema.setMensaje(ex.Message, 2);
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// Metodo que selecciona que busqueda ejecutara el control
        /// </summary>
        /// <param name="bnNoConsulta"></param>
        public void tipoDeConsulta(byte bnNoConsulta)
        {
            try
            {
                myTextBox.Width = 480;
                autoComplete1.MinimumPrefixLength = 3;
                autoComplete1.ContextKey = Convert.ToString(bnNoConsulta);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        /// <summary>
        /// Metodo que controla en evento del hiddenfield y recibe el Id Seleccionado
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void hdnValue_ValueChanged(object sender, EventArgs e)
        {
            try
            {
                string selectedWidgetID = ((HiddenField)sender).Value;
                if (getRegistroEvent != null)
                    getRegistroEvent.Invoke(Convert.ToInt32(selectedWidgetID));
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// Limpia el control de la busqueda
        /// </summary>
        public void limpiaBusqueda()
        {
            try
            {
                this.myTextBox.Text = string.Empty;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Label lblBusq { get { return lblBusqueda; } set { lblBusqueda = value; } }

        public TextBox txtBusqueda { get { return myTextBox; } set { myTextBox = value; } }
    }
}