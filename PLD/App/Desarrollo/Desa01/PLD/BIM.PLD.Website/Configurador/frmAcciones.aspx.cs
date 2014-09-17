using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BIM.PLD.Website.Utileria;
using BIM.PLD.Website.ConfiguracionPLDServices;


namespace BIM.PLD.Website.Configurador
{

    public partial class frmAcciones : System.Web.UI.Page
    {
        #region Valores proyecto

        ListaNegraService.ListaNegraServicesClient rsListaNegra = new ListaNegraService.ListaNegraServicesClient();
        CatalogosServices.CatalogoServicesClient rsCatalogos = new CatalogosServices.CatalogoServicesClient();
        ConfiguracionPLDServices.ConfiguracionPLDServicesClient rsConfigurador = new ConfiguracionPLDServices.ConfiguracionPLDServicesClient();

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

        public enum tipoCorreo
        {
            PARA = 1,
            CC = 2
        }

        #endregion

        #region Inicio de controles

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                _configurarControlesIniciales();
            }            
        }

        private void _configurarControlesIniciales()
        {
            ddlTipoSistema.DataSource = rsListaNegra.ListarSistemasPLD();           
            //Utileria.Utileria._ddlAsignarValorTexto(ddlTipoSistema, "sintSistemaID", "vchNombre");
            Utileria.Utileria._ddlAsignarValorTexto(ddlTipoSistema, "sintSistemaID", "vchNombre");
            Utileria.Utileria._ddlAgregarValorInicial(ddlTipoSistema, "[Seleccione una opción…]");  
            //var listas =     (from item in rsCatalogos.ListarCatalogoTipoListaNegra()
            //                  select item.vchIdentificadorInterno).Distinct();
            //ddlTipoLista.DataSource = listas;                
            ddlTipoLista.DataSource = rsCatalogos.ListarCatalogoTipoListaNegra();
            Utileria.Utileria._ddlAsignarValorTexto(ddlTipoLista, "intCatalogoID", "vchDescripcion");
            //ddlTipoLista.DataBind();
            Utileria.Utileria._ddlAgregarValorInicial(ddlTipoLista, "[Seleccione una opción…]");         
           _mostrarBusquedaGV(null, null);
    

           tbMensaje.Attributes.Add("onkeydown", "CountCharactersControlTxtMe(this)");
           tbMensaje.Attributes.Add("onkeyup", "CountCharactersControlTxtMe(this)");
          

        }

        private void _mostrarBusquedaGV(int? _intTipoTipificacionID, Int16? _intTipoSistema)
        {
            List<ConfiguracionPLD> _sistemas = new List<ConfiguracionPLD>();
            ConfiguracionPLD _sistema;
            var _s = rsConfigurador.ListadoBusquedaConfiguracionPLD(_intTipoTipificacionID, _intTipoSistema).Select(s => s.vchNombreSistema).Distinct();
            foreach (var item in _s)
            {
                if (item != null)
                {
                    _sistema = new ConfiguracionPLD();
                    _sistema.vchNombreSistema = item;
                    _sistemas.Add(_sistema);
                }                
            }                       
            gvResultadoMotorBusqueda.DataSource = _sistemas;// rsConfigurador.ListadoBusquedaConfiguracionPLD(_strTipoLista, _intTipoSistema).Select(s => s.vchNombreSistema).Distinct();
            gvResultadoMotorBusqueda.DataBind();
        }

        #endregion

        #region Opciones de menú

        protected void menu(object sender, EventArgs e)
        {
            Button bt = (Button)sender;
            switch (bt.CommandName)
            {
                case "BUSCAR":
                    _buscarRegistro();
                    break;

                case "INSERTAR":
                    _insertarRegistro();
                    break;

                case "ACTUALIZAR":
                    _acturalizarRegistro();
                    break;

                case "ELIMINAR":
                    _eliminarRegistro(bt.CommandArgument);
                    break;

                default:

                    break;
            }
        }

        #endregion

        #region Buscar registro

        private void _buscarRegistro()
        {
            parametrosBusqueda _parametrosBusqueda = new parametrosBusqueda(ddlTipoLista, ddlTipoSistema);
            ConfiguracionPLDServices.ConfiguracionPLD _datos = _existeREgistro(_parametrosBusqueda.intTipoLista, _parametrosBusqueda.intTipoSistema);
            if (_datos !=  null)
            {
                _cargarRegistroPanel(_datos); //Existen datos
            }
            else
            {
                _limpiarPanel();
                lbTipoListaPanelValor.Text = ddlTipoLista.SelectedItem.Text;
                lbTipoSistemaPanelValor.Text = ddlTipoSistema.SelectedItem.Text;
                mpeAccionRegistro.Show();
                btnAccion.Text = "ASIGNAR";
                btnAccion.CommandName = "INSERTAR";
                lbMensajesCorreo.Text = "";
            }          
        }

        private ConfiguracionPLDServices.ConfiguracionPLD _existeREgistro(int? _intTipoTipificacionID, Int16? _tipoSistema)
        {
            ConfiguracionPLDServices.ConfiguracionPLD[] _datos;
            ConfiguracionPLDServices.ConfiguracionPLD _dato = new ConfiguracionPLDServices.ConfiguracionPLD();
            try
            {
                _datos = rsConfigurador.ListadoBusquedaConfiguracionPLD(_intTipoTipificacionID, _tipoSistema);
                _dato = _datos.Count() > 0 ? _datos.First() : null;
            }
            catch (Exception ex)
            {
                throw ex;
               
            }
            return _dato;
        }

        private void _cargarRegistroPanel(ConfiguracionPLDServices.ConfiguracionPLD _datos)
        {
            _cargaRegistro(_datos);
            mpeAccionRegistro.Show();
            btnAccion.Text = "ACTUALIZAR";
            btnAccion.CommandName = "ACTUALIZAR";
            lbMensajesCorreo.Text = "";
        }

        private void _cargaRegistro(ConfiguracionPLDServices.ConfiguracionPLD _datos)
        {
            lbTipoListaPanelValor.Text = _datos.vchIdentificadorInterno;
            lbTipoSistemaPanelValor.Text = _datos.vchNombreSistema;
            ddlTipoLista.SelectedIndex = Utileria.Utileria._ddlAsignarIdPorTexto(ddlTipoLista, _datos.vchIdentificadorInterno.ToString());
            ddlTipoSistema.SelectedIndex = Utileria.Utileria._ddlAsignarIdPorTexto(ddlTipoSistema, _datos.vchNombreSistema.ToString());
            cbBloqueousuario.Checked = (bool)_datos.bitBloqueoUsuario;
            cbBloqueoProceso.Checked = (bool)_datos.bitBloqueoProceso;            
            cbBloqueoCorreo.Checked = (bool)_datos.bitEnvioCorreo;
            cbCrearBitacora.Checked = (bool)_datos.bitBitacora; 
            if (_datos.vchCorreosPara != null)
            {
                List<CorreoTo> correos = new List<CorreoTo>();
                correos = cargarGVCorreoTo(_datos.vchCorreosPara, tipoCorreo.PARA);
                if(_datos.vchCorreosCC != null)
                   correos.AddRange(cargarGVCorreoTo(_datos.vchCorreosCC, tipoCorreo.CC));
                creaListaCorreosPara(correos);
                grdContact.DataSource = correos;
                grdContact.DataBind();
            }
            else
            {
                cargarRegistro();
            }         
            tbMensaje.Text = _datos.vchMensaje;
            ibtEditarCorreos.Visible = cbBloqueoCorreo.Checked == true ? true : false;
        }

        private List<CorreoTo> cargarGVCorreoTo(string _datos, tipoCorreo _tipoCorreo)
        {                       
            List<CorreoTo> correos = new List<CorreoTo>();
            string[] correosstr;
            char splitchar = ';';
            correosstr = _datos.Split(splitchar);
            foreach (string item in correosstr)
            {
                CorreoTo correo = new CorreoTo();
                correo.strCorreo = item;                
                correo.strTipoCorreo = _tipoCorreo == tipoCorreo.PARA ? "PARA": "CC";
                correos.Add(correo);
            }            
            return correos;
        }

        private void _limpiarPanel()
        {
            cbBloqueousuario.Checked = false;
            cbBloqueoCorreo.Checked = false;
            cbCrearBitacora.Checked = false;
            limpiarCorreosGV();        
            tbMensaje.Text = "";
            ibtEditarCorreos.Visible = false;
        }

        private void limpiarCorreosGV()
        {
            cargarRegistro();
        }

        #endregion

        #region Insertar registro

        private void _insertarRegistro()
        {
            try
            {
                if (_insertarRegistroConfiguracionPLD())
                    cMensajes.setMensaje("REGISTRO DE CONFIGURACIÓN INGRESADO CORRECTAMENTE", 1);
                _mostrarBusquedaGV(null, null);
            }
            catch (Exception ex)
            {
                cMensajes.setMensaje(ex.Message, 2);
            }
        }       

        private bool _insertarRegistroConfiguracionPLD()
        {
            bool res;
            try
            {
               
                parametrosConfiguracionPLD oParametros = new parametrosConfiguracionPLD(ddlTipoLista, ddlTipoSistema, cbBloqueousuario, cbBloqueoProceso, cbBloqueoCorreo, cbCrearBitacora, tbMensaje, obtenerListaCorreos());                
                ConfiguracionPLDServices.ServiceResult result = rsConfigurador.InsertarConfiguracionPLD(oParametros.oParametrosConfiguaracionPLD());
                res = (int)result.ResultValue > 0 ? true : false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return res;
        }

        #endregion

        #region Actualizar registro

        private void _acturalizarRegistro()
        {
            try
            {
                if (_actualizarRegistroConfiguracionPLD())
                    cMensajes.setMensaje("REGISTRO DE CONFIGURACIÓN ACTUALIZADO CORRECTAMENTE", 1);
                _mostrarBusquedaGV(null, null);
            }
            catch (Exception ex)
            {
                cMensajes.setMensaje(ex.Message, 2);
            }
        }

        private bool _actualizarRegistroConfiguracionPLD()
        {
            bool res;
            try
            {
                //parametrosConfiguracionPLD oParametros = new parametrosConfiguracionPLD(ddlTipoLista, ddlTipoSistema, cbBloqueousuario, cbBloqueoCorreo, tbMensaje, obtenerListaCorreos(), tbCorreoCC);
                parametrosConfiguracionPLD oParametros = new parametrosConfiguracionPLD(ddlTipoLista, ddlTipoSistema, cbBloqueousuario, cbBloqueoProceso, cbBloqueoCorreo, cbCrearBitacora, tbMensaje, obtenerListaCorreos());
                ConfiguracionPLDServices.ServiceResult result = rsConfigurador.editarConfiguracionPLD(oParametros.oParametrosConfiguaracionPLD());
                res = (int)result.ResultValue > 0 ? true : false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return res;
        }

        #endregion

        #region Eliminar registro

        private void _eliminarRegistro(string _commandArgumment)
        {
            ConfiguracionPLDServices.ServiceResult resultado = new ConfiguracionPLDServices.ServiceResult();
            resultado = _eliminarRegistroPLD(_commandArgumment);
            switch (resultado.ServiceOk)
            {
                case true:
                    cMensajes.setMensaje("REGISTRO ELIMINADO SATISFACTORIAMENTE.", 1);
                    _mostrarBusquedaGV(null, null);
                    break;
                case false:
                    cMensajes.setMensaje("EXISTE UN PROBLEMA EN LA ELIMINACIÓN DEL REGISTRO. FAVOR DE CONSULTAR CON EL ÁREA DE SISTEMAS", 3);
                    break;
                default:
                    cMensajes.setMensaje("EXISTE UN ERROR EN LA ELIMINACIÓN DEL REGISTRO. COMUNICARSE CON EL ÁREA DE SISTEMAS" + resultado.ErrorMessage, 2);
                    break;
            }
        }

        private ConfiguracionPLDServices.ServiceResult _eliminarRegistroPLD(string _commandArgument)
        {
            string[] arg = new string[2];
            arg = _commandArgument.ToString().Split(',');
            ConfiguracionPLDServices.ServiceResult resultado = new ConfiguracionPLDServices.ServiceResult();
            resultado = rsConfigurador.eliminarConfiguracionPLD((int?)Convert.ToInt32(arg[0].ToString()), (Int16?)Convert.ToInt16(arg[1].ToString()));
            return resultado;
        }

        #endregion

        #region Lógica panel captura/edición

        protected void mostrarPanel(object sender, EventArgs e)
        {
            CheckBox _cb = (CheckBox)sender;
            if (_cb.Checked == true)
            {
                List<CorreoTo> _listaCorreos = new List<CorreoTo>();
                _listaCorreos = obtenerListaCorreos();
                if (_listaCorreos != null)
                {
                    if (_listaCorreos.Count() == 0)
                    {
                        cargarRegistro();
                        mpeAsignacionCorreo.Show();
                    }
                    else
                    {
                        grdContact.EditIndex = -1;
                        MuestraActualiaPanelCargaGVCorreosPara();
                    }
                    ibtEditarCorreos.Visible = true;
                    lbMensajesCorreo.Text = "";
                }
                else
                {
                    cargarRegistro();
                    mpeAsignacionCorreo.Show();
                }
            }
            else
            {
                mpeAccionRegistro.Show();               
                ibtEditarCorreos.Visible = false;
            }
        }
      
        protected void mantenerPanel(object sender, EventArgs e)
        {
            mpeAccionRegistro.Show();
            if (numeroCorreosTo() == 0)
            {
                //cargarRegistro();
                mpeAsignacionCorreo.Show();
                //rfvtbCorreoPara.Visible = true;
                lbMensajesCorreo.Text = "En la asignación de correos debe existir correo PARA ";
            }            
        }

        private int numeroCorreosTo()
        {          
            List<CorreoTo> correos = new List<CorreoTo>();
            if (Session["correos"] == null)
                return 0;
            correos = obtenerListaCorreos();
            int _cuantosCorreosTO = correos.Count(t => t.strTipoCorreo == "PARA");
            return _cuantosCorreosTO;
        }

        protected void mantenerPanelUncheck(object sender, EventArgs e)
        {         
            cbBloqueoCorreo.Checked = false;
            ibtEditarCorreos.Visible = false;         
            mpeAccionRegistro.Show();
        }


        protected void mostrarPanelCorreosEdicion(object sender, ImageClickEventArgs e)
        {
           
            grdContact.EditIndex = -1;
            MuestraActualiaPanelCargaGVCorreosPara();

        }

        #endregion       
               
        #region Eventos GV

        /// <summary>
        /// Construccion de GridView de Busqueda
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>            
        protected void gvResultadoMotorBusqueda_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.Footer)
                {

                }

                if (e.Row.RowType == DataControlRowType.DataRow)
                {                   

                    Label _sistemaGV = (Label)e.Row.FindControl("lblgvTipoSistema");

                    List<ConfiguracionPLD> _sistemas = new List<ConfiguracionPLD>();
                    ConfiguracionPLD _sistema;
                 
                    var _s =    from s in rsConfigurador.ListadoBusquedaConfiguracionPLD(null, null)
                                    orderby s.vchNombreSistema descending
                                    select s;
                    foreach (var item in _s)
                    {
                        if (item.vchNombreSistema == _sistemaGV.Text)
                        {
                            _sistema = new ConfiguracionPLD();
                            _sistema.bitBitacora = item.bitBitacora;
                            _sistema.bitBloqueoUsuario = item.bitBloqueoUsuario;
                            _sistema.bitBloqueoProceso = item.bitBloqueoProceso;
                            _sistema.bitEnvioCorreo = item.bitEnvioCorreo;
                            _sistema.sintSistemaID = item.sintSistemaID;
                            _sistema.vchbitBitacora = item.vchbitBitacora;
                            _sistema.vchbitBloqueoUsuario = item.vchbitBloqueoUsuario;
                            _sistema.vchbitBloqueoProceso = item.vchbitBloqueoProceso;
                            _sistema.vchbitEnvioCorreo = item.vchbitEnvioCorreo;
                            _sistema.vchCorreosCC = item.vchCorreosCC;
                            _sistema.vchCorreosPara = item.vchCorreosPara;
                            _sistema.intTipoTipificacionID = item.intTipoTipificacionID;
                            _sistema.vchIdentificadorInterno = item.vchIdentificadorInterno;
                            _sistema.vchMensaje = item.vchMensaje;
                            _sistema.vchNombreSistema = item.vchNombreSistema;                            

                            _sistemas.Add(_sistema);
                        }                           
                    }
                    GridView gvBusquedaSistema = e.Row.FindControl("gvBusquedaSistema") as GridView;
                    gvBusquedaSistema.DataSource = _sistemas;// rsConfigurador.ListadoBusquedaConfiguracionPLD(_strTipoLista, _intTipoSistema);
                    gvBusquedaSistema.DataBind();                   
                }

                if (e.Row.RowIndex != -1)
                {
                    e.Row.Attributes.Add("onmouseover", "javascript:this.style.color='#FF8000';");
                    e.Row.Attributes.Add("onmouseout", "javascript:this.style.color='#284775';");
                }

                if (e.Row.RowType == DataControlRowType.Pager)
                {
                    Label lblTotalNumDePaginas = (Label)e.Row.FindControl("lbBandejaTotal");
                    lblTotalNumDePaginas.Text = gvResultadoMotorBusqueda.PageCount.ToString();

                    TextBox txtIrAlaPagina = (TextBox)e.Row.FindControl("txtBandeja");
                    txtIrAlaPagina.Text = (gvResultadoMotorBusqueda.PageIndex + 1).ToString();

                    DropDownList ddlTamPagina = (DropDownList)e.Row.FindControl("dlBandeja");
                    ddlTamPagina.SelectedValue = gvResultadoMotorBusqueda.PageSize.ToString();
                   
                }

            }
            catch (Exception ex)
            {
                this.cMensajes.setMensaje(ex.Message, 2);
            }
        }

        private void _presentacionEtiquetasGV(Label _lblFuente, Label _lblPresentacion)
        {
            if (_lblFuente.Text.Length > 30)
            {
                _lblPresentacion.Text = "[...]";
                _lblPresentacion.ToolTip = _lblFuente.Text;
                _lblFuente.Text = _lblFuente.Text.Substring(0, 26);
            }
        }

        /// <summary>
        /// Evento que monitorea los eventos de comandos existentes en el GridView
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvBusquedaSistema_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow row;
                row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                switch (e.CommandName)
                {
                    case "ACTUALIZAR": //leer por id            
                        GridView gv = (GridView)sender;
                        Int16 _listaSistema = Convert.ToInt16(gv.DataKeys[Convert.ToInt32(row.RowIndex)].Values[1].ToString());                      
                        int _listaTipo = Convert.ToInt32(gv.DataKeys[Convert.ToInt32(row.RowIndex)].Values[0].ToString());                        
                        ConfiguracionPLDServices.ConfiguracionPLD _datos = _existeREgistro(_listaTipo, _listaSistema);
                        _cargarRegistroPanel(_datos);
                        break;
                    case "ELIMINAR": //Eliminar por id
                        ImageButton _ibd = (ImageButton)row.FindControl("ibtEliminar");
                        btnAceptarEliminar.CommandArgument = _ibd.CommandArgument;                        
                        lblMensajeEliminarRegsitro.Text = "¿CONFIRMAR SI DESEA LA ELIMINACIÓN DEL REGISTRO?"; ;
                        mpeEliminarRegistro.Show();
                        break;
                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                this.cMensajes.setMensaje(ex.Message, 2);
            }
        }

        protected void gvBusquedaSistema_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                e.Row.Attributes.Add("onmouseover", "javascript:this.style.color='#FF8000';");
                e.Row.Attributes.Add("onmouseout", "javascript:this.style.color='#284775';");
            }

        }       

        #endregion

        #region Eventos paginación GV
        /// <summary>
        /// Evento que realiza el cambio del tamaño del numero de columnas
        /// que seran mostradas en pantalla
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlBandeja_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DropDownList dropDownList = (DropDownList)sender;
                if (int.Parse(dropDownList.SelectedValue) != 0)
                {
                    gvResultadoMotorBusqueda.AllowPaging = true;
                    gvResultadoMotorBusqueda.PageSize = int.Parse(dropDownList.SelectedValue);
                }
                else
                    gvResultadoMotorBusqueda.AllowPaging = false;
                _mostrarBusquedaGV(null, null);

            }
            catch (Exception ex)
            {
                cMensajes.setMensaje(ex.Message, 2);
            }
        }

        /// <summary>
        /// Evento que registra el cambio del numero de acceso a la pagina a consultar
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void txtBandeja_TextChanged(object sender, EventArgs e)
        {
            try
            {
                TextBox txtBandejaInversionPÄGoToPage = (TextBox)sender;
                int numeroPagina;
                if (int.TryParse(txtBandejaInversionPÄGoToPage.Text.Trim(), out numeroPagina))
                    this.gvResultadoMotorBusqueda.PageIndex = numeroPagina - 1;
                else
                    this.gvResultadoMotorBusqueda.PageIndex = 0;
                _mostrarBusquedaGV(null, null);
            }
            catch (Exception ex)
            {
                cMensajes.setMensaje(ex.Message, 2);
            }
        }

        /// <summary>
        /// Evento que manipula el paginado del gridview
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvResultadoMotorBusqueda_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                GridView _gv = (GridView)sender;
                if ((e.NewPageIndex >= 0) && (e.NewPageIndex < _gv.PageCount))
                {
                    gvResultadoMotorBusqueda.PageIndex = e.NewPageIndex;
                   _mostrarBusquedaGV(null, null);
                }
            }
            catch (Exception ex)
            {
                this.cMensajes.setMensaje(ex.Message, 2);
            }
        }
        #endregion        

        #region GridView Correo

        protected void grdContact_RowDataBound(object sender, GridViewRowEventArgs e)
        {             
            if (e.Row.RowType == DataControlRowType.DataRow)
            {                
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
            }           
            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {              
                HiddenField _labelTipoCorreo = (HiddenField)e.Row.FindControl("hdTipo");
                
                if (_labelTipoCorreo.Value != "")
                {
                    if (_labelTipoCorreo.Value == "PARA")
                    {
                        RadioButton _rb = (RadioButton)e.Row.FindControl("cbTOEdit");
                        _rb.Checked = true;
                    }
                    else
                    {
                        RadioButton _rb = (RadioButton)e.Row.FindControl("cbCCEdit");
                        _rb.Checked = true;
                    }
                }           
            }
        }

        protected void grdContact_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

            grdContact.EditIndex = -1;
            lbMensajesCorreo.Text = "";
            MuestraActualiaPanelCargaGVCorreosPara();            
        }

        protected void grdContact_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            TextBox txtName = (TextBox)grdContact.Rows[e.RowIndex].FindControl("txtCorreo");
            HiddenField lblCorreo = (HiddenField)grdContact.Rows[e.RowIndex].FindControl("hdnID");
            HiddenField lblTipoCorreo = (HiddenField)grdContact.Rows[e.RowIndex].FindControl("hdTipo");
            RadioButton _rbTO = (RadioButton)grdContact.Rows[e.RowIndex].FindControl("cbTOEdit");
            RadioButton _rbCC = (RadioButton)grdContact.Rows[e.RowIndex].FindControl("cbCCEdit");
            List<CorreoTo> correos = new List<CorreoTo>();
            correos = devuelveListaCorreosPara();

            if (txtName.Text == lblCorreo.Value)//mismo correo  con cambio de tipo correo
            {
                string _tipoCorreo = _rbCC.Checked == true ? _rbCC.Text : _rbTO.Text;
                if ((from correoSelect in correos
                     where correoSelect.strCorreo == txtName.Text
                     select correoSelect).First().strTipoCorreo == _tipoCorreo)
                {//es lo mismo, no realizar asignación
                    //_existeCorrreo();
                    return;
                    
                }
                else
                {
                   
                    (from correo in correos
                     where correo.strCorreo == lblCorreo.Value.ToString()
                     select correo).First().strTipoCorreo = _tipoCorreo;

                }
            }
            else //diferente correo, validar si existe el mismo en la lista
            {
                if ((from correoSelect in correos
                     where correoSelect.strCorreo == txtName.Text
                     select correoSelect).Count() > 0)
                {

                    _existeCorrreo();
                    return;

                }
                else
                {
                    string _tipoCorreo = _rbCC.Checked == true ? _rbCC.Text : _rbTO.Text;
                    (from correo in correos
                     where correo.strCorreo == lblCorreo.Value.ToString()
                     select correo).First().strTipoCorreo = _tipoCorreo;

                    (from correo in correos
                     where correo.strCorreo == lblCorreo.Value.ToString()
                     select correo).First().strCorreo = txtName.Text;

                }
            }


            grdContact.EditIndex = -1;
            lbMensajesCorreo.Text = "";


            creaListaCorreosPara(correos);
            MuestraActualiaPanelCargaGVCorreosPara();
            
        }

        protected void grdContact_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            List<CorreoTo> correos = new List<CorreoTo>();
            correos = devuelveListaCorreosPara();            
            correos.RemoveAt(e.RowIndex);

            creaListaCorreosPara(correos);                     

            MuestraActualiaPanelCargaGVCorreosPara();

            if (grdContact.Rows.Count == 0)
            {
                cargarRegistro();
                mpeAsignacionCorreo.Show();
            }
        }

        protected void grdContact_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Insert"))
            {
                lbMensajesCorreo.Text = "";
                CorreoTo corrreo = new CorreoTo();
                TextBox txtNewCorreo = (TextBox)grdContact.HeaderRow.FindControl("txtNewCorreo");                                
                RadioButton rb = (RadioButton)grdContact.HeaderRow.FindControl("cbTO");
                corrreo.strCorreo = txtNewCorreo.Text;
                corrreo.strTipoCorreo = rb.Checked ? "PARA" : "CC";

                List<CorreoTo> correos = new List<CorreoTo>();                
                foreach (GridViewRow item in grdContact.Rows)
                {
                    Label lblCorreo = (Label)item.FindControl("lblCorreo");
                    Label _lblTipo = (Label)item.FindControl("lbTipoCorreo");
                    if (lblCorreo.Text != "")
                    {
                        CorreoTo correo = new CorreoTo();
                        correo.strCorreo = lblCorreo.Text;
                        correo.strTipoCorreo = _lblTipo.Text;
                        correos.Add(correo);
                    }
                }

                if ((from correoSelect in correos
                     where correoSelect.strCorreo == corrreo.strCorreo
                     select correoSelect).Count() > 0)                
                {
                    _existeCorrreo();
                    return;
                }
                else
                {
                    correos.Add(corrreo);
                    creaListaCorreosPara(correos);
                    MuestraActualiaPanelCargaGVCorreosPara();
                }               
            }
        }        

        protected void grdContact_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdContact.EditIndex = e.NewEditIndex;

            lbMensajesCorreo.Text = "";
            MuestraActualiaPanelCargaGVCorreosPara();
            //grdContact.Rows[e.NewEditIndex].FindControl("txtCorreo").Focus();            
        }

        private List<CorreoTo> obtenerListaCorreos()
        {
            List<CorreoTo> _datos = new List<CorreoTo>();
            _datos = Session["correos"] != null ? (List<CorreoTo>)Session["correos"] : null;
            return _datos;
        }

        private void _existeCorrreo()
        {
            lbMensajesCorreo.Text = "Existe correo";
            mpeAsignacionCorreo.Show();
        }

        private void cargarRegistro()
        {
            listaVacia();
            grdContact.DataSource = null;
            grdContact.DataBind();
            CorreoTo correoVacio = new CorreoTo();
            correoVacio.strCorreo = "";
            List<CorreoTo> inicioCorreo = new List<CorreoTo>();
            inicioCorreo.Add(correoVacio);
            grdContact.DataSource = inicioCorreo;
            grdContact.DataBind();
            grdContact.Rows[0].Cells.Clear();
            grdContact.Rows[0].Cells.Add(new TableCell());
            grdContact.Rows[0].Cells[0].Text = "Sin Correos";
        }

        private void listaVacia()
        {
            Session["correos"] = null;
        }

        private void creaListaCorreosPara(List<CorreoTo> _lista)
        {
            Session["correos"] = null;
            Session["correos"] = _lista;
        }

        private List<CorreoTo> devuelveListaCorreosPara()
        {
            List<CorreoTo> _creaLista = new List<CorreoTo>();
            _creaLista = (List<CorreoTo>)Session["correos"];
          
            return _creaLista;
        }

        private void MuestraActualiaPanelCargaGVCorreosPara()
        {
            
            List<CorreoTo> correos = new List<CorreoTo>();
            correos = devuelveListaCorreosPara();
            grdContact.DataSource = correos;
            grdContact.DataBind();

            UPD_Correo.Update();
            mpeAsignacionCorreo.Show();
        }
       
        #endregion            
                      
    }

    #region Clase parámetros de búsqueda

    public class parametrosBusqueda
    {
        public parametrosBusqueda(
            DropDownList intTipoLista,
            DropDownList intTipoSistema        
            )
        {
            this.intTipoLista =     ((int?)int.Parse(intTipoLista.SelectedItem.Value) != 0 ? (int?)int.Parse(intTipoLista.SelectedItem.Value) : null);
            this.intTipoSistema = ((Int16?)Int16.Parse(intTipoSistema.SelectedItem.Value) > 0 ? (Int16?)Int16.Parse(intTipoSistema.SelectedItem.Value) : null);           

        }
        public int? intTipoLista { get; private set; }
        public Int16? intTipoSistema { get; private set; }       
    }

    #endregion

    #region Clase parámetros configuración PLD

    public class parametrosConfiguracionPLD
    {
        public enum tipoCorreo
        {
            PARA = 1,
            CC = 2
        }
        private ConfiguracionPLDServices.ConfiguracionPLD oConfiguracionPLD = new ConfiguracionPLDServices.ConfiguracionPLD();
        public parametrosConfiguracionPLD(
            DropDownList intTipoLista,
            DropDownList intTipoSistema,
            CheckBox bitBloqueoUsuario,
            CheckBox bitBloqueoProceso,
            CheckBox bitEnvioCorreo,
            CheckBox bitBitacora,
            TextBox vchMensaje,         
            List<CorreoTo> _datos        
            )
        {
            oConfiguracionPLD.intTipoTipificacionID = (int?)int.Parse(intTipoLista.SelectedItem.Value) != 0 ? (int?)int.Parse(intTipoLista.SelectedItem.Value) : null;
            oConfiguracionPLD.sintSistemaID = ((Int16?)Int16.Parse(intTipoSistema.SelectedItem.Value) > 0 ? (Int16?)Int16.Parse(intTipoSistema.SelectedItem.Value) : null);
            oConfiguracionPLD.bitBloqueoUsuario = bitBloqueoUsuario.Checked;
            oConfiguracionPLD.bitBloqueoProceso = bitBloqueoProceso.Checked;
            oConfiguracionPLD.bitEnvioCorreo = bitEnvioCorreo.Checked;
            oConfiguracionPLD.bitBitacora = bitBitacora.Checked;
            oConfiguracionPLD.vchMensaje = vchMensaje.Text;
            //Se envia null para no mostrar correos CC como resultado de la busqueda
            oConfiguracionPLD.vchCorreosPara = bitEnvioCorreo.Checked == true ? 
                cadenaCorreosPara(_datos, tipoCorreo.PARA) != "" ? cadenaCorreosPara(_datos, tipoCorreo.PARA) : null 
                    : null;
            oConfiguracionPLD.vchCorreosCC = bitEnvioCorreo.Checked == true ? 
                cadenaCorreosPara(_datos, tipoCorreo.CC) != "" ? cadenaCorreosPara(_datos, tipoCorreo.CC) : null  
                    : null; 
        }       
        public ConfiguracionPLDServices.ConfiguracionPLD oParametrosConfiguaracionPLD()
        {
            return oConfiguracionPLD;
        }
        private string cadenaCorreosPara(List<CorreoTo> _datos, tipoCorreo _tipoCorreo)
        {
            List<CorreoTo> _correos = new List<CorreoTo>();
            if (_tipoCorreo == tipoCorreo.PARA)
            {
                foreach (CorreoTo item in _datos)
                {
                    if (item.strTipoCorreo == "PARA")
                        _correos.Add(item);
                }
            }
            else
            {
                foreach (CorreoTo item in _datos)
                {
                    if (item.strTipoCorreo == "CC")
                        _correos.Add(item);
                }
            }

            int contador = 1;
            string _datosstr = "";
            foreach (CorreoTo item in _correos)
            {
                _datosstr += (contador != _correos.Count ? item.strCorreo.ToString() + ";" : item.strCorreo.ToString());
                contador += 1;
            }
            return _datosstr;
        }
    }

    #endregion

    public class CorreoTo
    {
        public string strTipoCorreo { get; set; }//DOS VALORES: PARA; CC
        public string strCorreo { get; set; }
    }
        
}