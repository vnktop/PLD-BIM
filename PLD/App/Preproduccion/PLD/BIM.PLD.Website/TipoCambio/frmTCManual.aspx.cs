using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BIM.PLD.Website.wsDocumentServices;
using BIM.PLD.Website.UserControl.Comun;
using BIM.PLD.Website.Utileria;
/*

*/

namespace BIM.PLD.Website.TipoCambio
{
    public partial class frmTCManual : System.Web.UI.Page
    {
        public TipoCambioServices.TipoCambioServicesClient srvTipoCambio = new TipoCambioServices.TipoCambioServicesClient();
        public TipoCambioServices.TipoCambio mdl = new TipoCambioServices.TipoCambio();
        private DateTime lastDate;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
                fillGrid();
        }
        protected void btnInsertar_Click(object sender, EventArgs e)
        {
            lastDate = Convert.ToDateTime(Session["lastDate"]);
            if (lastDate < Convert.ToDateTime(txtFecha.Text) && Convert.ToDateTime(txtFecha.Text) <= DateTime.Today)
            {
                try
                {
                    mdl.datFechaCierre = Convert.ToDateTime(txtFecha.Text);
                    mdl.decValorCambio = Convert.ToDecimal(txtValor.Text);
                    int value = srvTipoCambio.insertaTCManual(mdl);
                    if (value > 0)
                        Message.setMensaje("Los valores han sido ingresados correctamente", 1);
                    else
                        Message.setMensaje("Existió un error en la comunicación con la base de datos, favor de contactar con el administrador", 2);
                    fillGrid();
                }
                catch (Exception ex)
                {
                    Message.setMensaje("Existió un error en el sistema, favor de contactar con el administrador", 2);
                    throw ex;
                }
            }
            else
            {
                Message.setMensaje("La fecha debe ser mayor a la última ingresada en el sistema y menor e igual a la del día de hoy <br> Favor de ingresar una fecha válida", 3);
            }
        }
        private void fillGrid()
        {            
            TipoCambioServices.TipoCambio [] arraySource;
            arraySource = srvTipoCambio.getListadoTipoCambio();
            if(arraySource.Length > 0)
                Session["lastDate"] = arraySource[0].datFechaCierre;
            gdvTipoCambio.DataSource = arraySource;
            gdvTipoCambio.DataBind();
        }        
        #region eventos del grid
        protected void ddlBandeja_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DropDownList dropDownList = (DropDownList)sender;
                if (int.Parse(dropDownList.SelectedValue) != 0)
                {
                    this.gdvTipoCambio.AllowPaging = true;
                    this.gdvTipoCambio.PageSize = int.Parse(dropDownList.SelectedValue);
                }
                else
                    this.gdvTipoCambio.AllowPaging = false;
                this.fillGrid();
            }
            catch (Exception ex)
            {
                Message.setMensaje(ex.Message, 2);
            }
        }
        protected void txtBandeja_TextChanged(object sender, EventArgs e)
        {
            try
            {
                TextBox txtBandejaAvaluosGoToPage = (TextBox)sender;
                int numeroPagina;
                if (int.TryParse(txtBandejaAvaluosGoToPage.Text.Trim(), out numeroPagina))
                    this.gdvTipoCambio.PageIndex = numeroPagina - 1;
                else
                    this.gdvTipoCambio.PageIndex = 0;
                this.fillGrid();
            }
            catch (Exception ex)
            {
                Message.setMensaje(ex.Message, 2);
            }
        }
        protected void gdvTipoCambio_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                if (e.NewPageIndex >= 0)
                {
                    this.gdvTipoCambio.PageIndex = e.NewPageIndex;
                    this.fillGrid();
                }
            }
            catch (Exception ex)
            {
                this.Message.setMensaje(ex.Message, 2);
            }
        }
        protected void gvTipoCambio_RowDataBound(Object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.Footer)
                {

                }

                if (e.Row.RowType == DataControlRowType.DataRow)
                {

                }

                if (e.Row.RowIndex != -1)
                {
                    e.Row.Attributes.Add("onmouseover", "javascript:this.style.color='#FF8000';");
                    e.Row.Attributes.Add("onmouseout", "javascript:this.style.color='#284775';");
                }

                if (e.Row.RowType == DataControlRowType.Pager)
                {
                    Label lblTotalNumDePaginas = (Label)e.Row.FindControl("lblBandejaTotal");
                    lblTotalNumDePaginas.Text = gdvTipoCambio.PageCount.ToString();

                    TextBox txtIrAlaPagina = (TextBox)e.Row.FindControl("txtBandeja");
                    txtIrAlaPagina.Text = (gdvTipoCambio.PageIndex + 1).ToString();

                    DropDownList ddlTamPagina = (DropDownList)e.Row.FindControl("ddlBandeja");
                    ddlTamPagina.SelectedValue = gdvTipoCambio.PageSize.ToString();
                }

            }
            catch (Exception ex)
            {
                this.Message.setMensaje(ex.Message, 2);
            }
        }
        #endregion
    }
}