using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using BIM.PLD.Website.BitacoraPLDServices;
using BIM.PLD.Website.CatalogosServices;

namespace BIM.PLD.Website.DesbloqueoUsuarios
{
    public partial class wfrDesbloqueoUsuario : System.Web.UI.Page
    {
        #region Servicios

        BitacoraPLDServicesClient rsBitacoraPLDService = new BitacoraPLDServicesClient();
       // CatalogoServicesClient rsCatalogPLDService = new CatalogoServicesClient();
        ListaNegraService.IListaNegraServices rsListaNegra = new ListaNegraService.ListaNegraServicesClient();
        VerificadorPLDServices.IVerificadorPLDServices rsVerificador = new VerificadorPLDServices.VerificadorPLDServicesClient();
        ConfiguracionPLDServices.IConfiguracionPLDServices rsConfigurador = new ConfiguracionPLDServices.ConfiguracionPLDServicesClient();

        #endregion

        
        #region Propiedades
        int intBitacoraID
        {
            get
            {
                return (ViewState["intBitacoraID"] == null ? 0 : (int)ViewState["intBitacoraID"]);
            }
            set
            {
                ViewState["intBitacoraID"] = value;
            }
        }
        private List<BitacoraPLDServices.BitacoraPLD> lstBitacoraPLD
        {
            get
            {
                return ViewState["lstBitacoraPLD"] == null ? new List<BitacoraPLDServices.BitacoraPLD>() : (List<BitacoraPLDServices.BitacoraPLD>)ViewState["lstBitacoraPLD"];
            }
            set
            {
                ViewState["lstBitacoraPLD"] = value;
            }
        }
      


        #endregion

        private enum CRUD
        {
            insertar = 1,
            leerBusqueda = 2,
            leerPorID = 3,
            leerAE = 4,
            actualizar = 5,
            eliminar = 6,
            LeerBusquedaIdAE = 7,
        }

        #region Eventos

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
                LoadSistemaPLD();
                
            }
           
        }

        #endregion

        #region Metodos

        public static void _ddlAsignarValorTexto(DropDownList _dll, string _valor, string _texto)
        {
            _dll.DataValueField = _valor;
            _dll.DataTextField = _texto;
            _dll.DataBind();
        }

        private void _loadValorInicialD(DropDownList _ddl)
        {
            _ddl.Items.Insert(0, new ListItem("[Seleccione una opción...]", "0", true));
        }

        private void LoadSistemaPLD()
        {
            ddlSistema.DataSource = rsListaNegra.ListarSistemasPLD();
            _ddlAsignarValorTexto(ddlSistema, "sintSistemaID", "vchNombre");
            _loadValorInicialD(ddlSistema);
        }

        private void _MostrarBusqueda()
        {
            BitacoraPLD bitacora = new BitacoraPLD();            
            if(ddlSistema.SelectedValue!="0")
                bitacora.intSistema = (int?)Convert.ToInt32(ddlSistema.SelectedValue);
            if (txtUsuario.Text != string.Empty)
            bitacora.vchUsuario = txtUsuario.Text;
            if (txtCliente.Text != string.Empty)
            bitacora.vchCliente = txtCliente.Text;
           // bitacora.bitHistorial = chkMuestraHist.Checked;
            lstBitacoraPLD = rsBitacoraPLDService.ListadoBusquedaBitacoraPLD(bitacora).ToList();
            gvrBitacoraPLD.DataSource = lstBitacoraPLD;
                
            gvrBitacoraPLD.DataBind();
        }

        #endregion

        #region Eventos del Grid

        protected void gvrBitacoraPLD_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                GridView gridView = (GridView)sender;

                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    if (((BitacoraPLD)(e.Row.DataItem)).datFechaRespuesta != null)
                    {
                        e.Row.ForeColor = System.Drawing.Color.Red;
 
                    }
                }

               // gridView.Columns[8].Visible = !chkMuestraHist.Checked;

                if (gridView.SortExpression.Length > 0)
                {
                    int cellIndex = -1;
                    //foreach (DataControlField field in gridView.Columns)
                    //{
                    //    if (field.SortExpression == gridView.SortExpression)
                    //    {
                    //        cellIndex = gridView.Columns.IndexOf(field);
                    //        break;
                    //    }
                    //}
                    if (((BitacoraPLD)(e.Row.DataItem)).datFechaRespuesta == null)
                    {
                        if (cellIndex > -1)
                        {
                            if (e.Row.RowType == DataControlRowType.Header)
                            {
                                if (gridView.SortDirection == SortDirection.Ascending)
                                {
                                    e.Row.Cells[cellIndex].CssClass = "sortascheaderstyle";

                                }
                                else
                                {
                                    e.Row.Cells[cellIndex].CssClass = "sortdescheaderstyle";
                                }
                            }
                            else if (e.Row.RowType == DataControlRowType.DataRow)
                            {
                                if ((e.Row.RowIndex % 2) == 0)
                                {
                                    e.Row.Cells[cellIndex].CssClass = "sortalternatingrowstyle";
                                }
                                else
                                {
                                    e.Row.Cells[cellIndex].CssClass = "sortrowstyle";
                                }
                            }
                        }
                    }
                }
                if (e.Row.RowIndex != -1)
                {
                if (((BitacoraPLD)(e.Row.DataItem)).datFechaRespuesta == null)
                {
                    
                        e.Row.Attributes.Add("onmouseover", "javascript:this.style.color='#FF8000';");
                        e.Row.Attributes.Add("onmouseout", "javascript:this.style.color='#284775';");
                 }
                }

                if (e.Row.RowType == DataControlRowType.Pager)
                {
                    Label lblTotalNumberOfPages = (Label)e.Row.FindControl("lblTotalNumberOfPages");
                    lblTotalNumberOfPages.Text = gridView.PageCount.ToString();

                    TextBox txtGoToPage = (TextBox)e.Row.FindControl("txtGoToPage");
                    txtGoToPage.Text = (gridView.PageIndex + 1).ToString();

                    DropDownList ddlPageSize = (DropDownList)e.Row.FindControl("ddlPageSize");
                    ddlPageSize.SelectedValue = gridView.PageSize.ToString();
                }
            }
            catch (Exception ex)
            {
                this.wucMensajeSistema.setMensaje(ex.Message, 2);
            }
        }

        protected void gvrBitacoraPLD_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (e.NewPageIndex != -1) this.gvrBitacoraPLD.PageIndex = e.NewPageIndex;
            gvrBitacoraPLD.DataBind();
            _MostrarBusqueda();
        }

        protected void gvrBitacoraPLD_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList dropDown = (DropDownList)sender;
            this.gvrBitacoraPLD.PageSize = Int32.Parse(dropDown.SelectedValue);
            _MostrarBusqueda();
        }

        protected void gvrBitacoraPLD_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Desbloquear")
            {
            GridViewRow row = (GridViewRow)(sender as Control).Parent.Parent;
            int NoBitacora = row.RowIndex;

            Label lblClave = (Label)row.FindControl("lblClave");
            Label lblSistema = (Label)row.FindControl("lblSistema");
            Label lblSucursal = (Label)row.FindControl("lblSucursal");
            Label lblUsuario = (Label)row.FindControl("lblUsuario");
            Label lblCliente = (Label)row.FindControl("lblCliente");
            Label lblPersonaIncidencia = (Label)row.FindControl("lblPersonaIncidencia");
            Label lblRelCliente = (Label)row.FindControl("lblRelCliente");
            Label lblVCHDQEQ = (Label)row.FindControl("lblVCHDQEQ");
            Label lbltipoLista = (Label)row.FindControl("lblTipoLista");

            int Clave = Int32.Parse(lblClave.Text);
            int sistema = Convert.ToInt32(lblSistema.Text);
            string sucursal = lblSucursal.Text;
            string usuario = lblUsuario.Text;
            string cliente = lblCliente.Text;
            string perIncidencia = lblPersonaIncidencia.Text;
            string relCliente = lblRelCliente.Text;
            string VCHDQEQ = lblVCHDQEQ.Text;
            string tipoLista = lbltipoLista.Text;
            string observaciones = txtComentario.Text;
            bool bloqPersona = chkDesbloqProceso.Checked;
            bool bloqUsuario = chkDesbloqUsuario.Checked;

            ServiceResult resultBitacora = new ServiceResult();
            BIM.PLD.Website.BitacoraPLDServices.BitacoraPLD oBitacoraPLD = new BIM.PLD.Website.BitacoraPLDServices.BitacoraPLD();
            {
                oBitacoraPLD.intBitacoraID = Clave;
                oBitacoraPLD.intSistema = sistema;
                oBitacoraPLD.vchSucursal = sucursal;
                oBitacoraPLD.vchUsuario = usuario;
                oBitacoraPLD.vchCliente = cliente;
                oBitacoraPLD.vchPersonaIncidencia = perIncidencia;
                oBitacoraPLD.vchRelacionCliente = relCliente;
                oBitacoraPLD.vchidqeq = VCHDQEQ;
                oBitacoraPLD.vchComentario = observaciones;               
                oBitacoraPLD.bitAutorizaProc = bloqUsuario;

                //BitacoraID = (int)getValorResult(rsBitacoraPLDService.editarBitacoraPLD(oBitacoraPLD));
                ServiceResult result = rsBitacoraPLDService.editarBitacoraPLD(oBitacoraPLD);
                //resultado = (int)result.ResultValue > 0 ? true : false;

                this.wucMensajeSistema.setMensaje("La operación se ha realizado exitosamente.", 1);
                gvrBitacoraPLD.EditIndex = -1;
            }
            }
            //else if (btn.CommandName == "ACTUALIZAR")
            //{

            //    GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            //    int Clave = Convert.ToInt32(gvrBitacoraPLD.DataKeys[gvRow.RowIndex].Value);

            //    String _sistema = gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[1].Text;
            //    String _sucursal = Convert.ToString(gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[2].Text);
            //    String _usuario = gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[3].Text;
            //    String _cliente = gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[4].Text;


            //    CargarDatosBitacora(_sistema, _sucursal, _usuario, _cliente);
                
            //}
                
            #region codAnt

            //Button btn = (Button)sender;
            //if (btn.CommandName == "Update")
            //{
            //    GridViewRow row = (GridViewRow)(sender as Control).Parent.Parent;
            //    int NoPAC2 = Convert.ToInt32(gvrBitacoraPLD.DataKeys[row.RowIndex].Value);

            //    Label lblClave = row.FindControl("lblClave") as Label;
            //    Label lblVCHDQEQ = row.FindControl("lblVCHDQEQ") as Label;
            //    Label lblUsuario = row.FindControl("lblUsuario") as Label;
            //    Label lblSucursal = row.FindControl("lblSucursal") as Label;
            //    Label lblSistema = row.FindControl("lblSistema") as Label;
            //    Label lblPersonaIncidencia = row.FindControl("lblPersonaIncidencia") as Label;
            //    Label lblNombreCompleto = row.FindControl("lblNombreCompleto") as Label;
            //    Label lblCliente = row.FindControl("lblCliente") as Label;


            //    TextBox tbxObservaciones = row.FindControl("tbxObservaciones") as TextBox;
            //    CheckBox chkBloqueoPersona = row.FindControl("chkBloqueoPersona") as CheckBox;
            //    CheckBox chkBloqueoUsuario = row.FindControl("chkBloqueoUsuario") as CheckBox;

            //    ServiceResult result = new ServiceResult();
            //    BitacoraPLD oBitacoraPLD = new BitacoraPLD();
            //    try
            //    {
            //        oBitacoraPLD.intBitacoraID = Convert.ToInt32(lblClave.Text);
            //        oBitacoraPLD.VCHIDQEQ = lblVCHDQEQ.Text;
            //        oBitacoraPLD.vchUsuario = lblUsuario.Text;
            //        oBitacoraPLD.vchSucursal = lblSucursal.Text;
            //        oBitacoraPLD.intSistema = Convert.ToInt32(lblSistema.Text);
            //        oBitacoraPLD.vchPersonaIncidencia = lblPersonaIncidencia.Text;
            //        oBitacoraPLD.vchNombre = lblNombreCompleto.Text;
            //        oBitacoraPLD.vchCliente = lblCliente.Text;

            //        oBitacoraPLD.vchComentario = tbxObservaciones.Text;
            //        oBitacoraPLD.bitDesbloqueroPersona = chkBloqueoPersona.Checked;
            //        oBitacoraPLD.bitDesbloqueoUsuario = chkBloqueoUsuario.Checked;

            //        //Id = (int)getValorResult(rsVerificadorService.editarBitacoraPLD(null, oBitacoraPLD));
            //        result = rsVerificadorService.editarBitacoraPLD(oBitacoraPLD);

            //        this.wucMensajeSistema.setMensaje("La operación se ha realizado exitosamente.", 1);
            //        gvrBitacoraPLD.EditIndex = -1;

            //        //gvrBitacoraPLD.DataBind();
            //        //_MostrarBusqueda();
            //    }
            //    catch (Exception ex)
            //    {
            //        wucMensajeSistema.setMensaje(ex.Message, 2);
            //    }
            //}
            #endregion
        }

        protected void GoToPage_TextChanged(object sender, EventArgs e)
        {
            TextBox txtGoToPage = (TextBox)sender;
            int pageNumber = Int32.Parse(txtGoToPage.Text == string.Empty ?" 1" : txtGoToPage.Text);

            if (pageNumber > 0 && pageNumber <= this.gvrBitacoraPLD.PageCount)
            {
                this.gvrBitacoraPLD.PageIndex = pageNumber - 1;
               // this.gvrBitacoraPLD.DataSource = rsBitacoraPLDService.ListadoBusquedaBitacoraPLD();

                _MostrarBusqueda();
            }
            else
            {
                this.gvrBitacoraPLD.PageIndex = 0;
               // this.gvrBitacoraPLD.DataSource = rsBitacoraPLDService.ListadoBusquedaBitacoraPLD();
                _MostrarBusqueda();
            }
        }

        protected void gvrBitacoraPLD_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvrBitacoraPLD.EditIndex = e.NewEditIndex;
            int id = Convert.ToInt32(gvrBitacoraPLD.DataKeys[e.NewEditIndex].Value);
        }

        protected void gvrBitacoraPLD_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvrBitacoraPLD.EditIndex = -1;
            gvrBitacoraPLD.DataBind();
            _MostrarBusqueda();
        }

     

        #endregion

        protected void MostrarActualizacion(object sender, EventArgs e)
        {            
            LimpiarCtrls();
            intBitacoraID=Convert.ToInt32(((ImageButton)sender).CommandArgument);            
            BitacoraPLDServices.BitacoraPLD bitacoraPLD = lstBitacoraPLD.Find(s => s.intBitacoraID == intBitacoraID);            
            LimpiaControles(bitacoraPLD);
            pnlAccionActualizar.Update();
            mpeAccionActualizar.Show();
        }



        private object getValorResult(ServiceResult result)
        {
            object value = null;
            if (result.ServiceOk)
            {
                value = result.ResultValue;
            }
            else
            {
                throw new Exception(result.ErrorMessage);
            }
            return value;
        }

        private void _cargarRegistroPanel(BitacoraPLD _datos)
        {
            _cargaRegistro(_datos);
            mpeAccionActualizar.Show();
            btnAccion.Text = "EDITAR";
            btnAccion.CommandName = "ACTUALIZAR";
        }

        private void _cargaRegistro(BitacoraPLD _datos)
        {
            txtComentario.Text = _datos.vchComentario;
            //chkDesbloqProceso.Checked = (bool)_datos.bitDesbloqueroPersona;
            //chkDesbloqUsuario.Checked = (bool)_datos.bitDesbloqueoUsuario;
        }

        private void LimpiarCtrls()
        {
            txtComentario.Text = string.Empty;
            chkDesbloqProceso.Checked = false;
            chkDesbloqUsuario.Checked = false;
        }

        private void LimpiaControles(BitacoraPLDServices.BitacoraPLD Bitacora)
        {


            chkDesbloqUsuario.Checked = true;
            txtComentario.Text = string.Empty;
            chkDesbloqUsuario.Enabled = true;
            chkDesbloqProceso.Enabled = true;
            //chkDesbloqProceso.Checked = false;
            chkHomonimo.Enabled = true;
            //chkHomonimo.Checked = false; //estaba e
            btnAccion.Enabled = true;
            btnAccion.Visible = true;
            txtComentario.Enabled = true;

            BitacoraPLD bitacora= lstBitacoraPLD.Find(s=> s.intBitacoraID==intBitacoraID);
            
            if (bitacora != null)
            {
                //chkDesbloqUsuario.Enabled = false;
                //chkDesbloqProceso.Enabled = false;
                //chkHomonimo.Enabled = false;
                //txtComentario.Enabled = false;
                //txtComentario.Text = bitacora.vchComentario;
                //chkDesbloqProceso.Checked = (bool)(bitacora.bitHomonimo == null ? false : bitacora.bitHomonimo);
                //chkHomonimo.Checked = (bool)(bitacora.bitHomonimo == null ? false : bitacora.bitHomonimo);
                //btnAccion.Enabled = false;
                //btnAccion.Visible = false;

                chkDesbloqProceso.Checked = false;
                chkHomonimo.Checked = false;
                txtComentario.Text = string.Empty;

            }
            else
            {
                ConfiguracionPLDServices.ConfiguracionPLD configurador= rsConfigurador.ListadoBusquedaConfiguracionPLD(bitacora.intTipoTipificacionID,(short) bitacora.intSistema).First();                
                //chkDesbloqProceso.Enabled = !(bool)configurador.bitBloqueoProceso;
                //chkHomonimo.Enabled = !(bool)configurador.bitBloqueoProceso;
                //chkDesbloqUsuario.Enabled = !(bool)configurador.bitBloqueoUsuario;


                chkDesbloqProceso.Checked = bitacora.bitAutorizaProc == null ? false : (bool)bitacora.bitAutorizaProc;
                chkHomonimo.Checked = bitacora.bitHomonimo == null ? false : (bool)bitacora.bitHomonimo;
                txtComentario.Text = bitacora.vchComentario;

            }
            //chkDesbloqProceso.Checked = bitacora.bitAutorizaProc == null ? false : (bool)bitacora.bitAutorizaProc;
            //chkHomonimo.Checked = bitacora.bitHomonimo == null ? false : (bool)bitacora.bitHomonimo;
            //txtComentario.Text = bitacora.vchComentario;
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            _MostrarBusqueda();
        }

        protected void btnAccion_Click1(object sender, EventArgs e)
        {
            ServiceResult resultBitacora = new ServiceResult();
  
            BitacoraPLDServices.BitacoraPLD bitacoraPLD = lstBitacoraPLD.Find(s => s.intBitacoraID == intBitacoraID);
            BIM.PLD.Website.BitacoraPLDServices.BitacoraPLD oBitacoraPLD = new BIM.PLD.Website.BitacoraPLDServices.BitacoraPLD();
            {
                oBitacoraPLD.intBitacoraID = intBitacoraID;
                oBitacoraPLD.vchComentario = txtComentario.Text;
                oBitacoraPLD.bitAutorizaProc = chkDesbloqProceso.Checked;
                oBitacoraPLD.vchIdentificadorInterno = bitacoraPLD.vchIdentificadorInterno;
                oBitacoraPLD.intTipoTipificacionID = bitacoraPLD.intTipoTipificacionID;
                oBitacoraPLD.intSistema = bitacoraPLD.intSistema;
                oBitacoraPLD.vchUsuario = bitacoraPLD.vchUsuario;
                oBitacoraPLD.vchUsuarioAudit = Session["User"].ToString();
                if (chkDesbloqProceso.Checked)
                    oBitacoraPLD.bitEstatus = true;
                else
                    oBitacoraPLD.bitEstatus = false;

                if (chkHomonimo.Checked)
                    oBitacoraPLD.bitHomonimo = true;
                else
                    oBitacoraPLD.bitHomonimo = false;
                //oBitacoraPLD.bitDesbloqueoUsuario = bloqUsuario;

                //Clave = (int)getValorResult(rsBitacoraPLDService.editarBitacoraPLD(oBitacoraPLD));
                ServiceResult result = rsBitacoraPLDService.editarBitacoraPLD(oBitacoraPLD);
              // int  Clave = (int)result.ResultValue;
                _MostrarBusqueda();
                this.wucMensajeSistema.setMensaje("La operación se ha realizado exitosamente.", 1);
                gvrBitacoraPLD.EditIndex = -1;
                mpeAccionActualizar.Hide();

            };
        }

        protected void btnCancelarAccion_Click(object sender, EventArgs e)
        {
            mpeAccionActualizar.Hide();
        }

        //protected void btnprueba_Click(object sender, EventArgs e)
        //{
        //        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        //        int Clave = Convert.ToInt32(gvrBitacoraPLD.DataKeys[gvRow.RowIndex].Value);

        //        String _sistema = gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[3].Text;
        //        String _sucursal = Convert.ToString(gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[4].Text);
        //        String _usuario = gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[6].Text;
        //        String _cliente = gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[7].Text;


        //        CargarDatosBitacora(_sistema, _sucursal, _usuario, _cliente);
        //}


        //protected void btnprueba_Click(object sender, EventArgs e)
        //{
        //    lblMsj.Text = "No funciona -----puntos de interrupción-----";
        //}

        #region EliminarCodigo
        //private void ActualizarBitacora(int intBitacoraID)
        //{
        //    ServiceResult resultBitacora = new ServiceResult();
        //    BitacoraPLD oBitacoraPLD = new BitacoraPLD();
        //    {
        //        oBitacoraPLD.intBitacoraID = intBitacoraID;
        //        oBitacoraPLD.intSistema = Sistema;
        //        oBitacoraPLD.vchSucursal = Sucursal;
        //        oBitacoraPLD.vchUsuario = Usuario;
        //        oBitacoraPLD.vchCliente = Cliente;
        //        oBitacoraPLD.vchPersonaIncidencia = PersonaIncidencia;
        //        oBitacoraPLD.vchRelacionCliente = RelCliente;
        //        oBitacoraPLD.VCHIDQEQ = VCHDQEQ;
        //        oBitacoraPLD.vchComentario = txtComentario.Text;
        //        oBitacoraPLD.bitDesbloqueroPersona = chkDesbloqProceso.Checked;
        //        oBitacoraPLD.bitDesbloqueoUsuario = chkDesbloqUsuario.Checked;

        //        intBitacoraID = (int)getValorResult(rsBitacoraPLDService.editarBitacoraPLD(oBitacoraPLD));
        //        //ServiceResult result = rsVerificadorService.editarBitacoraPLD(oBitacoraPLD);
        //        //resultado = (int)result.ResultValue > 0 ? true : false;
        //        _DesbloquearUser();
        //        this.wucMensajeSistema.setMensaje("La operación se ha realizado exitosamente.", 1);
        //        gvrBitacoraPLD.EditIndex = -1;
        //        _MostrarBusqueda();

        //    };
        //}



        //protected void btnActualizarBitacoraPLD_Click(object sender, EventArgs e)
        //{
        ////    //Actualizar();
        //    GridViewRow row = (GridViewRow)(sender as Control).Parent.Parent;
        //    int NoBitacora = row.RowIndex;

        //    Label lblClave = (Label)row.FindControl("lblClave");
        //    Label lblVCHDQEQ = (Label)row.FindControl("lblVCHDQEQ");
        //    Label lblUsuario = (Label)row.FindControl("lblUsuario");
        //    Label lblSucursal = (Label)row.FindControl("lblSucursal");
        //    Label lblSistema = (Label)row.FindControl("lblSistema");
        //    Label lblPersonaIncidencia = (Label)row.FindControl("lblPersonaIncidencia");
        //    Label lblNombreCompleto = (Label)row.FindControl("lblNombreCompleto");
        //    Label lblApPaterno = (Label)row.FindControl("lblApPaterno");
        //    Label lblApMaterno = (Label)row.FindControl("lblApMaterno");
        //    Label lblCliente = (Label)row.FindControl("lblCliente");
        //    Label lblRelCliente = (Label)row.FindControl("lblRelCliente");
        //    TextBox tbxObservaciones = (TextBox)row.FindControl("tbxObservaciones");
        //    CheckBox chkBloqueoPersona = (CheckBox)row.FindControl("chkBloqueoPersona");
        //    CheckBox chkBloqueoUsuario = (CheckBox)row.FindControl("chkBloqueoUsuario");
        //    Label lblFecha = (Label)row.FindControl("lblFechaRespuesta");

        //    int id = Int32.Parse(lblClave.Text);
        //    string VCHDQEQ = lblVCHDQEQ.Text;
        //    string usuario = lblUsuario.Text;
        //    string sucursal = lblSucursal.Text;
        //    int sistema = Convert.ToInt32(lblSistema.Text);
        //    string perIncidencia = lblPersonaIncidencia.Text;
        //    string Nom = lblNombreCompleto.Text;
        //    string Apaterno = lblApPaterno.Text;
        //    string Amaterno = lblApMaterno.Text;
        //    string cliente = lblCliente.Text;
        //    string relCliente = lblRelCliente.Text;
        //    string observaciones = tbxObservaciones.Text;
        //    bool bloqPersona = chkBloqueoPersona.Checked;
        //    bool bloqUsuario = chkBloqueoUsuario.Checked;
        //    //DateTime Fecha =Convert.ToDateTime(lblFecha.Text);

        //    ServiceResult result = new ServiceResult();
        //    BitacoraPLD oBitacoraPLD = new BitacoraPLD();
        //    try
        //    {
        //        oBitacoraPLD.intBitacoraID = id;
        //        oBitacoraPLD.VCHIDQEQ = VCHDQEQ;
        //        oBitacoraPLD.vchUsuario = usuario;
        //        oBitacoraPLD.vchSucursal = sucursal;
        //        oBitacoraPLD.intSistema = sistema;
        //        oBitacoraPLD.vchPersonaIncidencia = perIncidencia;
        //        oBitacoraPLD.vchNombre = Nom;
        //        oBitacoraPLD.vchApPaterno = Apaterno;
        //        oBitacoraPLD.vchApMaterno = Amaterno;
        //        oBitacoraPLD.vchCliente = cliente;
        //        oBitacoraPLD.vchRelacionCliente = relCliente;
        //        oBitacoraPLD.vchComentario = observaciones;
        //        oBitacoraPLD.bitDesbloqueroPersona = bloqPersona;
        //        oBitacoraPLD.bitDesbloqueoUsuario = bloqUsuario;
        //        //oBitacoraPLD.datFechaRespuesta = Convert.ToDateTime(Fecha);

        //        id = (int)getValorResult(rsVerificadorService.editarBitacoraPLD(oBitacoraPLD));
        //        //result = rsVerificadorService.editarBitacoraPLD(oBitacoraPLD);
        //        //_DesbloquearUsuario();
        //        _DesbloquearUser();
        //        this.wucMensajeSistema.setMensaje("La operación se ha realizado exitosamente.", 1);
        //        gvrBitacoraPLD.EditIndex = -1;
        //        //_MostrarBusqueda();
        //    }
        //    catch (Exception ex)
        //    {
        //        wucMensajeSistema.setMensaje(ex.Message, 2);
        //    }
        //}
        #endregion

    }
}