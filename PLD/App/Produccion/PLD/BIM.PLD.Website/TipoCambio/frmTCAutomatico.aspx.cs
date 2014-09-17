using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
//using Lite.ExcelLibrary.SpreadSheet;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using BIM.PLD.Website.wsDocumentServices;
using BIM.PLD.Website.UserControl.Comun;
using BIM.PLD.Website.Utileria;

namespace BIM.PLD.Website.TipoCambio
{
    public partial class frmTipoCambio : System.Web.UI.Page
    {
        List<TipoCambioServices.TipoCambio> lst = new List<TipoCambioServices.TipoCambio>();
        public TipoCambioServices.TipoCambioServicesClient srvTipoCambio = new TipoCambioServices.TipoCambioServicesClient();
        public TipoCambioServices.TipoCambio mdl = new TipoCambioServices.TipoCambio();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnDescargar_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime fecha = DateTime.Today;
                String todayYear = fecha.Year.ToString();
                WebClient webClient = new WebClient();
                string strURL = "http://www.banxico.org.mx/SieInternet/consultasieiqy?series=SF60653&idCuadro=CF102&sector=6&tipoInformacionIQY=1&locale=es&version=2&anoInicial="+todayYear+"&anoFinal="+todayYear;                
                GetHtmlPage(strURL);
                TipoCambioServices.TipoCambio[] arraySource = srvTipoCambio.getListadoTipoCambio();
                depuraLista(arraySource.Length > 0 ? arraySource[0].datFechaCierre : new DateTime());
                fillGrid();
                Session["lstCargaAutomatica"] = lst;
                mpeConfirmaCarga.Show();
            }
            catch (Exception exc)
            {
                Message.setMensaje("Existió un error en el aplicativo, favor de consultar con el administrador", 2);
            }
        }
        protected void btnConfirmaCarga_Click(object sender, EventArgs e)
        {
            int Resultado = 0;
            try
            {
                lst = (List<TipoCambioServices.TipoCambio>)Session["lstCargaAutomatica"];
                if (lst.Count > 0)
                {
                    Resultado = srvTipoCambio.insertaTCAutomatico(lst.ToArray());
                    if (Resultado > 0)
                        Message.setMensaje("La carga automática se efectuó correctamente", 1);
                    else
                        Message.setMensaje("Hubo un error durante la carga", 2);
                }
                else
                    Message.setMensaje("No existen datos para cargar", 3);
            }
            catch (Exception ex)
            {
                Message.setMensaje("Hubo un error durante la carga, favor de contactar con el administrador", 2);
            }
        }        
        //-----------------------
        private void GetHtmlPage(string strURL)
        {            
            String strResult;
            WebResponse objResponse;
            WebRequest objRequest = HttpWebRequest.Create(strURL);
            objResponse = objRequest.GetResponse();
            using (StreamReader sr = new StreamReader(objResponse.GetResponseStream()))
            {
                try
                {
                    strResult = sr.ReadLine();
                    while ((strResult = sr.ReadLine()) != null)
                    {
                        if (strResult.Contains("<td align=\"right\" nowrap=\"nowrap\" style=\"vnd.ms-excel.numberformat:dd/mm/yyyy\"  ><b>"))
                        {
                            strResult = strResult.Replace("<td align=\"right\" nowrap=\"nowrap\" style=\"vnd.ms-excel.numberformat:dd/mm/yyyy\"  ><b>", "");
                            strResult = strResult.Replace("</b></td>", "");
                            mdl = new TipoCambioServices.TipoCambio();
                            mdl.datFechaCierre = Convert.ToDateTime(strResult.Trim().Replace("-","/"));
                        }
                        if (strResult.Contains("<td align=\"right\" style=\"vnd.ms-excel.numberformat:#,##0.0000\" >"))
                        {
                            strResult = strResult.Replace("<td align=\"right\" style=\"vnd.ms-excel.numberformat:#,##0.0000\" >", "");
                            strResult = strResult.Replace("</td>", "");
                            mdl.decValorCambio = Convert.ToDecimal(strResult.Trim());
                            mdl.strTipoMoneda = "Moneda Extranjera (Dolar EE.UU.A)";
                            mdl.strTipoCambio = "Compra/Venta";
                            lst.Add(mdl);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                 sr.Close();       
             }
        }


        
        private void depuraLista(DateTime max)
        {
            for (int i = 0; i < lst.Count; i++)
            {
                if (lst.ElementAt(i).datFechaCierre.CompareTo(max) <= 0)
                {
                    lst.RemoveAt(i);
                    i--;
                }
            }
        }
        private void fillGrid()
        {
            gdvTipoCambio.DataSource = lst;
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
                gdvTipoCambio.DataSource = (List<TipoCambioServices.TipoCambio>)Session["lstCargaAutomatica"];
                gdvTipoCambio.DataBind();
                mpeConfirmaCarga.Show();
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
                gdvTipoCambio.DataSource = (List<TipoCambioServices.TipoCambio>)Session["lstCargaAutomatica"];
                gdvTipoCambio.DataBind();
                mpeConfirmaCarga.Show();
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
                    gdvTipoCambio.DataSource = (List<TipoCambioServices.TipoCambio>)Session["lstCargaAutomatica"];
                    gdvTipoCambio.DataBind();
                    mpeConfirmaCarga.Show();
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