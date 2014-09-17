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
        ListaNegraService.IListaNegraServices rsListaNegra = new ListaNegraService.ListaNegraServicesClient();        
        ConfiguracionPLDServices.IConfiguracionPLDServices rsConfigurador = new ConfiguracionPLDServices.ConfiguracionPLDServicesClient();
        

        #endregion

        
        #region Propiedades

        private bool? bitAutorizado
        {
            get
            {
                bool? _bitAutorizado = (bool?)ViewState["bitAutorizado"];
                if (_bitAutorizado != null)
                    return _bitAutorizado;
                else
                    return null;
            }
            set
            {
                ViewState["bitAutorizado"] = value;
            }
        }

        private bool? bitProceso
        {
            get
            {
                bool? _bitProceso = (bool?)ViewState["bitProceso"];
                if (_bitProceso != null)
                    return _bitProceso;
                else
                    return null;
            }
            set
            {
                ViewState["bitProceso"] = value;
            }
        }

        private bool? bitHomonimo
        {
            get
            {
                bool? _bitHomonimo = (bool?)ViewState["bitHomonimo"];
                if (_bitHomonimo != null)
                    return _bitHomonimo;
                else
                    return null;
            }
            set
            {
                ViewState["bitHomonimo"] = value;
            }
        }

        private string vchComentario
        {
            get
            {
                string _vchComentario = (string)ViewState["vchComentario"];
                if (_vchComentario != null)
                    return _vchComentario;
                else
                    return null;
            }
            set
            {
                ViewState["vchComentario"] = value;
            }
        }

        private DateTime? datFechaAutorizacion
        {
            get
            {
                DateTime? _datFechaAutorizacion = (DateTime?)ViewState["datFechaAutorizacion"];
                if (_datFechaAutorizacion != null)
                    return _datFechaAutorizacion;
                else
                    return null;
            }
            set
            {
                ViewState["datFechaAutorizacion"] = value;
            }
        }

        private int? intVigenciaDias
        {
            get
            {
                int? _intVigenciaDias = (int?)ViewState["intVigenciaDias"];
                if (_intVigenciaDias != null)
                    return _intVigenciaDias;
                else
                    return null;
            }
            set
            {
                ViewState["intVigenciaDias"] = value;
            }
        }

        private int? intBitacoraID
        {
            get
            {
                int? _intBitacoraID = (int?)ViewState["intBitacoraID"];
                if (_intBitacoraID != null)
                    return _intBitacoraID;
                else
                    return null;
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
            int? _intSistemaID = 0;
            string _vchUsuario = "";
            if(ddlSistema.SelectedValue!="0")
                _intSistemaID = (int?)Convert.ToInt32(ddlSistema.SelectedValue);
            if (txtUsuario.Text != string.Empty)
                _vchUsuario = txtUsuario.Text;
        
            lstBitacoraPLD = rsBitacoraPLDService.ListadoBusquedaBitacoraPLD(_vchUsuario == "" ? null : _vchUsuario, _intSistemaID == 0 ? null : _intSistemaID).ToList();

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
                    if (((BitacoraPLD)(e.Row.DataItem)).datFechaAutorizacion != null)
                    {
                        e.Row.ForeColor = System.Drawing.Color.Red;
 
                    }
                }             

                if (gridView.SortExpression.Length > 0)
                {
                    int cellIndex = -1;                    
                    if (((BitacoraPLD)(e.Row.DataItem)).datFechaAutorizacion == null)
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
                if (((BitacoraPLD)(e.Row.DataItem)).datFechaAutorizacion == null)
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

        //protected void gvrBitacoraPLD_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "Desbloquear")
        //    {
        //    GridViewRow row = (GridViewRow)(sender as Control).Parent.Parent;
        //    int NoBitacora = row.RowIndex;
            
        //    Label lblSistema = (Label)row.FindControl("lblSistema");
        //    Label lblUsuario = (Label)row.FindControl("lblUsuario");          
        //    Label lblPersonaIncidencia = (Label)row.FindControl("lblPersonaIncidencia");
        //    Label lblRelCliente = (Label)row.FindControl("lblRelCliente");            
        //    //Label lbltipoLista = (Label)row.FindControl("lblTipoLista");

        //    //int Clave = Int32.Parse(lblClave.Text);
        //    int sistema = Convert.ToInt32(lblSistema.Text);
        //    //string sucursal = lblSucursal.Text;
        //    string usuario = lblUsuario.Text;
        //    //string cliente = lblCliente.Text;
        //    string perIncidencia = lblPersonaIncidencia.Text;
        //    string relCliente = lblRelCliente.Text;
        //    //string VCHDQEQ = lblVCHDQEQ.Text;
        //    //string tipoLista = lbltipoLista.Text;
        //    string observaciones = txtComentario.Text;
        //    bool bloqPersona = chkDesbloqProceso.Checked;
        //    bool bloqUsuario = chkDesbloqUsuario.Checked;

        //    //ServiceResult resultBitacora = new ServiceResult();
        //    //BIM.PLD.Website.BitacoraPLDServices.BitacoraPLD oBitacoraPLD = new BIM.PLD.Website.BitacoraPLDServices.BitacoraPLD();
        //    //{
        //    //    oBitacoraPLD.intBitacoraID = Clave;
        //    //    oBitacoraPLD.intSistema = sistema;
        //    //    oBitacoraPLD.vchSucursal = sucursal;
        //    //    oBitacoraPLD.vchUsuario = usuario;
        //    //    oBitacoraPLD.vchCliente = cliente;
        //    //    oBitacoraPLD.vchPersonaIncidencia = perIncidencia;
        //    //    oBitacoraPLD.vchRelacionCliente = relCliente;
        //    //    oBitacoraPLD.vchidqeq = VCHDQEQ;
        //    //    oBitacoraPLD.vchComentario = observaciones;               
        //    //    oBitacoraPLD.bitAutorizaProc = bloqUsuario;

        //    //    //BitacoraID = (int)getValorResult(rsBitacoraPLDService.editarBitacoraPLD(oBitacoraPLD));
        //    //    ServiceResult result = rsBitacoraPLDService.editarBitacoraPLD(oBitacoraPLD);
        //    //    //resultado = (int)result.ResultValue > 0 ? true : false;

        //    //    this.wucMensajeSistema.setMensaje("La operación se ha realizado exitosamente.", 1);
        //    //    gvrBitacoraPLD.EditIndex = -1;
        //    //}
        //    }

        //    //else if (btn.CommandName == "ACTUALIZAR")
        //    //{

        //    //    GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        //    //    int Clave = Convert.ToInt32(gvrBitacoraPLD.DataKeys[gvRow.RowIndex].Value);

        //    //    String _sistema = gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[1].Text;
        //    //    String _sucursal = Convert.ToString(gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[2].Text);
        //    //    String _usuario = gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[3].Text;
        //    //    String _cliente = gvrBitacoraPLD.Rows[gvRow.RowIndex].Cells[4].Text;


        //    //    CargarDatosBitacora(_sistema, _sucursal, _usuario, _cliente);
                
        //    //}
                
        //    #region codAnt

        //    //Button btn = (Button)sender;
        //    //if (btn.CommandName == "Update")
        //    //{
        //    //    GridViewRow row = (GridViewRow)(sender as Control).Parent.Parent;
        //    //    int NoPAC2 = Convert.ToInt32(gvrBitacoraPLD.DataKeys[row.RowIndex].Value);

        //    //    Label lblClave = row.FindControl("lblClave") as Label;
        //    //    Label lblVCHDQEQ = row.FindControl("lblVCHDQEQ") as Label;
        //    //    Label lblUsuario = row.FindControl("lblUsuario") as Label;
        //    //    Label lblSucursal = row.FindControl("lblSucursal") as Label;
        //    //    Label lblSistema = row.FindControl("lblSistema") as Label;
        //    //    Label lblPersonaIncidencia = row.FindControl("lblPersonaIncidencia") as Label;
        //    //    Label lblNombreCompleto = row.FindControl("lblNombreCompleto") as Label;
        //    //    Label lblCliente = row.FindControl("lblCliente") as Label;


        //    //    TextBox tbxObservaciones = row.FindControl("tbxObservaciones") as TextBox;
        //    //    CheckBox chkBloqueoPersona = row.FindControl("chkBloqueoPersona") as CheckBox;
        //    //    CheckBox chkBloqueoUsuario = row.FindControl("chkBloqueoUsuario") as CheckBox;

        //    //    ServiceResult result = new ServiceResult();
        //    //    BitacoraPLD oBitacoraPLD = new BitacoraPLD();
        //    //    try
        //    //    {
        //    //        oBitacoraPLD.intBitacoraID = Convert.ToInt32(lblClave.Text);
        //    //        oBitacoraPLD.VCHIDQEQ = lblVCHDQEQ.Text;
        //    //        oBitacoraPLD.vchUsuario = lblUsuario.Text;
        //    //        oBitacoraPLD.vchSucursal = lblSucursal.Text;
        //    //        oBitacoraPLD.intSistema = Convert.ToInt32(lblSistema.Text);
        //    //        oBitacoraPLD.vchPersonaIncidencia = lblPersonaIncidencia.Text;
        //    //        oBitacoraPLD.vchNombre = lblNombreCompleto.Text;
        //    //        oBitacoraPLD.vchCliente = lblCliente.Text;

        //    //        oBitacoraPLD.vchComentario = tbxObservaciones.Text;
        //    //        oBitacoraPLD.bitDesbloqueroPersona = chkBloqueoPersona.Checked;
        //    //        oBitacoraPLD.bitDesbloqueoUsuario = chkBloqueoUsuario.Checked;

        //    //        //Id = (int)getValorResult(rsVerificadorService.editarBitacoraPLD(null, oBitacoraPLD));
        //    //        result = rsVerificadorService.editarBitacoraPLD(oBitacoraPLD);

        //    //        this.wucMensajeSistema.setMensaje("La operación se ha realizado exitosamente.", 1);
        //    //        gvrBitacoraPLD.EditIndex = -1;

        //    //        //gvrBitacoraPLD.DataBind();
        //    //        //_MostrarBusqueda();
        //    //    }
        //    //    catch (Exception ex)
        //    //    {
        //    //        wucMensajeSistema.setMensaje(ex.Message, 2);
        //    //    }
        //    //}
        //    #endregion
        //}

        protected void GoToPage_TextChanged(object sender, EventArgs e)
        {
            TextBox txtGoToPage = (TextBox)sender;
            int pageNumber = Int32.Parse(txtGoToPage.Text == string.Empty ?" 1" : txtGoToPage.Text);

            if (pageNumber > 0 && pageNumber <= this.gvrBitacoraPLD.PageCount)
            {
                this.gvrBitacoraPLD.PageIndex = pageNumber - 1;              
                _MostrarBusqueda();
            }
            else
            {
                this.gvrBitacoraPLD.PageIndex = 0;       
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
            //LimpiarCtrls();

            string[] arg = new string[7];
            arg = ((ImageButton)sender).CommandArgument.ToString().Split(';');
            //[0] es Id
            intBitacoraID           = arg[0] == "" ? 0      : Convert.ToInt32(arg[0]);
            bitAutorizado           = arg[1] == "" ? null   : (bool?)Convert.ToBoolean(arg[1]);
            bitProceso              = arg[2] == "" ? null   : (bool?)Convert.ToBoolean(arg[2]);
            bitHomonimo             = arg[3] == "" ? null   : (bool?)Convert.ToBoolean(arg[3]);
            vchComentario           = arg[4] == "" ? ""     : arg[4].ToString();
            datFechaAutorizacion    = arg[5] == "" ? null   : (DateTime?) Convert.ToDateTime(arg[5]);
            intVigenciaDias         = arg[6] == "" ? null   : (int?)Convert.ToInt32(arg[6]);

           
            chkDesbloqUsuario.Checked   = bitAutorizado == null ? false :(bool)bitAutorizado;
            chkDesbloqProceso.Checked   = bitProceso == null ? false : (bool)bitProceso;
            chkHomonimo.Checked         = bitHomonimo == null ? false : (bool)bitHomonimo;
            txtComentario.Text          = vchComentario;

            ibtEditarNumeroDias.Visible = bitAutorizado == null ? false : (bool)bitAutorizado;
                       
            pnlAccionActualizar.Update();
            mpeAccionActualizar.Show();
        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            _MostrarBusqueda();
        }

        private bool _validarFechaAutorizacionNumeroDias()
        {
            if (txtNumeroDias.Text == "" && chkDesbloqUsuario.Checked == true)            
            {
                lbMensajesDesbloqueo.Text = "INDICAR NÚMERO DE DIAS";
                txtNumeroDias.Focus();
                return true;
            }
            lbMensajesDesbloqueo.Text = "";
            return false;
        }

        protected void btnAccion_Click1(object sender, EventArgs e)
        {                                        
            if (_datosModificados() == true)
            {
                ServiceResult _result = new ServiceResult();            
                try
                {                
                    desbloqueoBitacoraPLD _datos = _obtenerDatosDesbloqueo();
                    _result = rsBitacoraPLDService.desbloquearUsuario(_datos);
                    Int16 _flag = _result.ServiceOk == true ? Convert.ToInt16(1) : Convert.ToInt16(2);
                    string _message = _result.ServiceOk == true ? "ASIGNACIÓN DE DESBLOQUEO CORRECTA" : "ERROR EN LA ASIGNACIÓN DE DESBLOQUEO, :" + _result.ErrorMessage;
                    wucMensajeSistema.setMensaje(_message, _flag);
                    if (_result.ServiceOk == true)
                        _MostrarBusqueda();
                    pnlAccionActualizar.Update();
                }
                catch (Exception ex)
                {

                    wucMensajeSistema.setMensaje("ERROR EN EL DESBLOQUEO: " + ex.Message, 2);
                }
            }
            mpeAccionActualizar.Hide();           
        }

        private bool _datosModificados()
        {
            if (chkDesbloqUsuario.Checked != bitAutorizado)
                return true;
            if (chkDesbloqProceso.Checked != bitProceso)
                return true;
            if (chkHomonimo.Checked != bitHomonimo)
                return true;
            if (txtComentario.Text != vchComentario)
                return true;
            txtNumeroDias.Text = txtNumeroDias.Text == "" ? intVigenciaDias.ToString() : txtNumeroDias.Text;
            if (Convert.ToInt32(txtNumeroDias.Text) != intVigenciaDias)
                return true;
            
            return false;
        }

        private desbloqueoBitacoraPLD _obtenerDatosDesbloqueo()
        {
            desbloqueoBitacoraPLD _datos    = new desbloqueoBitacoraPLD();
            _datos.bitAutorizado            = chkDesbloqUsuario.Checked;
            _datos.bitProceso               = chkDesbloqProceso.Checked;
            _datos.bitHomonimo              = chkHomonimo.Checked;
            _datos.vchUsuarioAutoriza       = Session["UserName"].ToString().ToUpper();// Session["User"].ToString();
            _datos.datFechaAutorizacion     = chkDesbloqUsuario.Checked == true ? lbFechaAutorizacion.Text != "" ? (DateTime?)Convert.ToDateTime(lbFechaAutorizacion.Text) : datFechaAutorizacion : null;
            _datos.intBitacoraID            = intBitacoraID;
            _datos.intVigenciaDias          = chkDesbloqUsuario.Checked == true ? txtNumeroDias.Text != "" ? (int?)Convert.ToInt32(txtNumeroDias.Text) : intVigenciaDias : null;
            _datos.vchComentario            = txtComentario.Text;
            return _datos;
        }

        protected void btnCancelarAccion_Click(object sender, EventArgs e)
        {
            mpeAccionActualizar.Hide();
        }     

        protected void mostrarPanelNumeroDias(object sender, ImageClickEventArgs e)
        {           
            MuestraActualizaPanelCargaNumeroDias();

        }

        protected void mostrarPanel(object sender, EventArgs e)
        {
            CheckBox _cb = (CheckBox)sender;
            if (_cb.Checked == true)
            {
                MuestraActualizaPanelCargaNumeroDias();
                ibtEditarNumeroDias.Visible = true;
            }
            else
            {
                mpeAccionActualizar.Show();
                ibtEditarNumeroDias.Visible = false;
            }
        }

        private void MuestraActualizaPanelCargaNumeroDias()
        {

            lbFechaAutorizacion.Text    = datFechaAutorizacion == null ? DateTime.Now.ToShortDateString() : ((DateTime)datFechaAutorizacion).ToShortDateString();
            txtNumeroDias.Text          = intVigenciaDias == null ? "" : intVigenciaDias.ToString();

            if (lbMensajesDesbloqueo.Text != "")
                lbMensajesDesbloqueo.Text = "";

            UPD_NumeroDias.Update();
            mpeAsignacionNumeroDias.Show();
        }

        protected void mantenerPanel(object sender, EventArgs e)
        {            
            if (_validarFechaAutorizacionNumeroDias() == true)
            {
                mpeAsignacionNumeroDias.Show();
            }
            else
            {
                //intVigenciaDias = Convert.ToInt32(txtNumeroDias.Text);
                mpeAccionActualizar.Show();
            }
            
        }

        protected void mantenerPanelUncheck(object sender, EventArgs e)
        {
            chkDesbloqUsuario.Checked = false;
            ibtEditarNumeroDias.Visible = false;
            mpeAccionActualizar.Show();
        }

    }

}