using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BIM.PLD.Website.Utileria;
using BIM.PLD.Website.TipoListaNegraService;
using BIM.PLD.Website.UserControl.Comun;
using BIM.PLD.Website.Utileria;

namespace BIM.PLD.Website.Mantenimiento
{
    public partial class frmMntoTipoListaNegra : System.Web.UI.Page
    {
        #region valores proyecto

        CatalogosServices.CatalogoServicesClient rsCatalogos = new CatalogosServices.CatalogoServicesClient();
        TipoListaNegraClient rsTipoListaNegra = new TipoListaNegraClient();

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
            ddlTipoLista.DataSource = rsCatalogos.ListadoCatTipoLista();
            Utileria.Utileria._ddlAsignarValorTexto(ddlTipoLista, "intCatalogoID", "vchDescripcion");
            Utileria.Utileria._ddlAgregarValorInicial(ddlTipoLista, "[Seleccione una opción…]");
            ddlTipoTipificacion.DataSource = rsCatalogos.ListarCatalogoTipoListaNegra();
            Utileria.Utileria._ddlAsignarValorTexto(ddlTipoTipificacion, "intCatalogoID", "vchDescripcion");
            Utileria.Utileria._ddlAgregarValorInicial(ddlTipoTipificacion, "[Seleccione una opción…]");

            ddlCatTipoListaNegra.DataSource = rsCatalogos.ListarCatalogoTipoListaNegra();
            Utileria.Utileria._ddlAsignarValorTexto(ddlCatTipoListaNegra, "intCatalogoID", "vchDescripcion");
            Utileria.Utileria._ddlAgregarValorInicial(ddlCatTipoListaNegra, "[Seleccione una opción…]");           

            //this.cuBI.getRegistroEvent += new UserControl.Comun.wucBusquedaInteligenteTA.getRegistroEventHandler(TraeDatosEvent);
            //this.cuBI.tipoDeConsulta(1);             //Para buscar por nombre
            //this.cuBI.lblBusq.Text = "TIPO TIPIFICACIÓN";

            _mostrarBusquedaGV(null, null);
        }

        private void TraeDatosEvent(int idTblNav)
        {
            //try
            //{
            //    this.intOperacionID = idTblNav;
            //}
            //catch (Exception ex)
            //{
            //    throw new Exception(ex.Message);
            //}
        }

        private void _mostrarBusquedaGV(int? _intTipoTipificacionID, string _strTipoLista)
        {
            List<CatTipoListaNegra> _sistemas = new List<CatTipoListaNegra>();
            CatTipoListaNegra _sistema;
            var _s = rsTipoListaNegra.ListadoBusquedaTipoListaNegra(_intTipoTipificacionID, _strTipoLista).Select(s => s.vchTipoTipificacion).Distinct();
            foreach (var item in _s)
            {
                if (item != null)
                {
                    _sistema = new CatTipoListaNegra();
                    _sistema.vchTipoTipificacion = item;
                    _sistemas.Add(_sistema);
                }
            }
            gvResultadoMotorBusqueda.DataSource = _sistemas;
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
                    _acturalizarRegistro(Convert.ToInt32(bt.CommandArgument));
                    break;

                case "ELIMINAR":
                    _eliminarRegistro(bt.CommandArgument);
                    break;
                case "NUEVO":
                    _nuevoRegistro();
                    break;

                default:

                    break;
            }
        }

        #endregion

        #region nuevo registro

        private void _nuevoRegistro()
        {
            btnAccion.CommandName = "INSERTAR";
            btnAccion.Text = "INGRESAR";
            _limpiarPanel();
            mpeAccionRegistro.Show();            
        }

        #endregion

        #region Buscar registro

        private void _buscarRegistro()
        {
            parametrosBusqueda _parametrosBusqueda = new parametrosBusqueda(ddlTipoLista, ddlTipoTipificacion);
            CatTipoListaNegra _datos = _existeREgistro(_parametrosBusqueda.intTipoTipificacion, _parametrosBusqueda.strTipoLista);
            if (_datos != null)
            {
                _cargarRegistroPanel(_datos); //Existen datos
            }
            else
            {
                _limpiarPanel();
                mpeAccionRegistro.Show();
                btnAccion.Text = "ASIGNAR";
                btnAccion.CommandName = "INSERTAR";
            }
        }

        private CatTipoListaNegra _existeREgistro(int? _intTipoTipificacionID, string _tipoLista)
        {
            CatTipoListaNegra[] _datos;
            CatTipoListaNegra _dato = new CatTipoListaNegra();
            try
            {
                _datos = rsTipoListaNegra.ListadoBusquedaTipoListaNegra(_intTipoTipificacionID, _tipoLista);
                _dato = _datos.Count() > 0 ? _datos.First() : null;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return _dato;
        }

        private void _cargarRegistroPanel(CatTipoListaNegra _datos)
        {
            _cargaRegistro(_datos);
            mpeAccionRegistro.Show();
            btnAccion.Text = "ACTUALIZAR";
            btnAccion.CommandName = "ACTUALIZAR";
        }

        private void _cargaRegistro(CatTipoListaNegra _datos)
        {
            ddlCatTipoListaNegra.SelectedIndex =  Utileria.Utileria._ddlAsignarIdPorTexto(ddlCatTipoListaNegra,  _datos.vchTipoTipificacion);
            tbTipoListaValor.Text = _datos.vchTipoLista;
            tbDescripcionValor.Text = _datos.VCDDESCRIPCION;
            tbPaisValor.Text = _datos.vchPais;
        }

        private void _limpiarPanel()
        {
            //cuBI.txtBusqueda.Text = "";
            ddlCatTipoListaNegra.SelectedIndex = 0;
            tbTipoListaValor.Text = "";
            tbDescripcionValor.Text = "";
            tbPaisValor.Text = "";
        }


        #endregion

        #region Insertar registro

        private void _insertarRegistro()
        {
            try
            {
                if (_insertarRegistroTipoListaNegra())
                    cMensajes.setMensaje("REGISTRO DE CONFIGURACIÓN INGRESADO CORRECTAMENTE", 1);
                _mostrarBusquedaGV(null, null);
            }
            catch (Exception ex)
            {
                cMensajes.setMensaje(ex.Message, 2);
            }
        }

        private bool _insertarRegistroTipoListaNegra()
        {
            bool res;
            try
            {
                parametrosTipoListaNegra oParametros = new parametrosTipoListaNegra(null, tbTipoListaValor, Convert.ToInt32(ddlCatTipoListaNegra.SelectedItem.Value), tbDescripcionValor, tbPaisValor);               
                ServiceResult result = rsTipoListaNegra.InsertarTipoListaNegra(oParametros.oParametrosTipoListaNegra());
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

        private void _acturalizarRegistro(int @intTipoListaID)
        {
            try
            {
                if (_actualizarRegistroConfiguracionPLD(@intTipoListaID))
                    cMensajes.setMensaje("REGISTRO DE CONFIGURACIÓN ACTUALIZADO CORRECTAMENTE", 1);
                _mostrarBusquedaGV(null, null);
            }
            catch (Exception ex)
            {
                cMensajes.setMensaje(ex.Message, 2);
            }
        }

        private bool _actualizarRegistroConfiguracionPLD(int @intTipoListaID)
        {
            bool res;
            try
            {
                parametrosTipoListaNegra oParametros = new parametrosTipoListaNegra(@intTipoListaID, tbTipoListaValor, Convert.ToInt32(ddlCatTipoListaNegra.SelectedItem.Value), tbDescripcionValor, tbPaisValor);
                ServiceResult result = rsTipoListaNegra.editarTipoListaNegra(oParametros.oParametrosTipoListaNegra());
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
            ServiceResult resultado = new ServiceResult();
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

        private ServiceResult _eliminarRegistroPLD(string _commandArgument)
        {
            string[] arg = new string[2];
            arg = _commandArgument.ToString().Split(',');
            ServiceResult resultado = new ServiceResult();
            resultado = rsTipoListaNegra.eliminarTipoListaNegra((int?)Convert.ToInt32(_commandArgument.ToString()));
            return resultado;
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

                    List<CatTipoListaNegra> _sistemas = new List<CatTipoListaNegra>();
                    CatTipoListaNegra _sistema;

                    var _s = from s in rsTipoListaNegra.ListadoBusquedaTipoListaNegra(null, null)
                             orderby s.vchTipoTipificacion descending
                             select s;
                    foreach (var item in _s)
                    {
                        if (item.vchTipoTipificacion == _sistemaGV.Text)
                        {
                            _sistema = new CatTipoListaNegra();
                            _sistema.intTipoListaID = item.intTipoListaID;
                            _sistema.vchTipoLista = item.vchTipoLista;
                            _sistema.intTipoTipificacionID = item.intTipoTipificacionID;
                            _sistema.VCDDESCRIPCION = item.VCDDESCRIPCION;
                            _sistema.vchPais = item.vchPais;                            
                            _sistemas.Add(_sistema);
                        }
                    }
                    GridView gvBusquedaSistema = e.Row.FindControl("gvBusquedaSistema") as GridView;
                    gvBusquedaSistema.DataSource = _sistemas;
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
                        ImageButton _ibe = (ImageButton)row.FindControl("ibtEditar");
                        int _TipoTipificacion = Convert.ToInt32(_ibe.CommandArgument.Split(',').ElementAt(0));
                        string _TipoLista = _ibe.CommandArgument.Split(',').ElementAt(1);
                        CatTipoListaNegra _datos = _existeREgistro(_TipoTipificacion, _TipoLista);
                        btnAccion.CommandArgument = _ibe.CommandArgument.Split(',').ElementAt(2);
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

        #region Agregar/Editar catálogo Tipo de acción

        enum AccionAgregarEditar
        {
            Agregar = 1,
            Editar = 2
        }

        struct RespuestaTipoAccion
        {
            public respuestaExisteRegistro TipoRegistro;
            public TipoAccion Valores;
        }

        enum respuestaExisteRegistro
        {
            NoExiste = 0,
            ExisteTipo = 1,
            ExisteCNBV = 2,
            ExisteTipoYCNBV = 3
        }
        struct TipoAccion
        {
            public int id;
            public string CNBV;
        };

        protected void accion(object sender, EventArgs e)
        {
            Button _boton = (Button)sender;
            RespuestaTipoAccion _existeRegistro = ExisteRegistro();
            switch (_existeRegistro.TipoRegistro)
            {
                case respuestaExisteRegistro.NoExiste:
                    switch (Convert.ToInt32(_boton.CommandName))
                    {
                        case (int)AccionAgregarEditar.Agregar:
                            _agregarRegistro();
                            break;
                        case (int)AccionAgregarEditar.Editar:
                            //string[] idRegistroTipoAccion = ddlBusquedaTipoAccion.SelectedItem.Value.Split('|');
                            int idRegistroTipoAccion = Convert.ToInt32(ddlCatTipoListaNegra.SelectedItem.Value);
                            //_editarRetistro(Convert.ToInt32(idRegistroTipoAccion[0]));
                            _editarRetistro(idRegistroTipoAccion);
                            break;

                        default:
                            break;
                    }
                    break;
                case respuestaExisteRegistro.ExisteTipo:
                    //ddlBusquedaTipoAccion.SelectedIndex = _existeRegistro.Valores.id;
                    cMensajes.setMensaje("EXISTE REGISTRO CON LA MISMA DEFINICIÓN", 2);
                    mpeEditarAgregarRegistro.Show();
                    break;
                case respuestaExisteRegistro.ExisteCNBV:
                    //ddlBusquedaTipoAccion.SelectedIndex = _existeRegistro.Valores.id;
                    cMensajes.setMensaje("EXISTE REGISTRO CON LA MISMA DEFINICIÓN", 2);
                    mpeEditarAgregarRegistro.Show();
                    break;
                case respuestaExisteRegistro.ExisteTipoYCNBV:
                    //ddlBusquedaTipoAccion.SelectedIndex = _existeRegistro.Valores.id;
                    cMensajes.setMensaje("EXISTE REGISTRO CON LA MISMA DEFINICIÓN", 2);
                    mpeEditarAgregarRegistro.Show();
                    break;
                default:
                    break;
            }
        }

        private void recargaValoresPanelTipoTipificacion()
        {
            ddlCatTipoListaNegra.DataSource = rsCatalogos.ListarCatalogoTipoListaNegra();
            Utileria.Utileria._ddlAsignarValorTexto(ddlCatTipoListaNegra, "intCatalogoID", "vchDescripcion");
            Utileria.Utileria._ddlAgregarValorInicial(ddlCatTipoListaNegra, "[Seleccione una opción…]");
            mpeAccionRegistro.Show();
        }

        private void _agregarRegistro()
        {
            //definir variables
            CatTipoListaNegra oCatTipoAccion = new CatTipoListaNegra();

            //asignar valores            
            oCatTipoAccion.VCDDESCRIPCION = tbTipoTipificacionValor.Text;

            //llamar servicio
            try
            {
                ServiceResult _respuesta = rsTipoListaNegra.InsertarTipoTipificacion(oCatTipoAccion);
                if (_respuesta.ServiceOk == true)
                {
                    
                    cMensajes.setMensaje("Registro ingresado correctamente", 1);
                    recargaValoresPanelTipoTipificacion();
                }
                else
                {
                    cMensajes.setMensaje("Error al ingresar el registro", 2);
                }
            }
            catch (Exception ex)
            {
                cMensajes.setMensaje("Error en inserción: " + ex.Message, 2);
                throw ex;
            }

            //manejar respueta
        }

        private void _editarRetistro(int _id)
        {
            //definir variables
            CatTipoListaNegra oCatTipoAccion = new CatTipoListaNegra();

            //asignar valores           
            oCatTipoAccion.VCDDESCRIPCION = tbTipoTipificacionValor.Text;
            oCatTipoAccion.intTipoTipificacionID = Convert.ToInt32(lbIdTipoTipificacionValor.Text);

            //llamar servicio
            try
            {
                ServiceResult _respuesta = rsTipoListaNegra.editarTipoTipificacion(oCatTipoAccion);
                if (_respuesta.ServiceOk == true)
                {
                    cMensajes.setMensaje("Registro actualizado correctamente", 1);
                    recargaValoresPanelTipoTipificacion();
                }
                else
                {
                    cMensajes.setMensaje("Error al actualizar el registro", 2);
                }
            }
            catch (Exception ex)
            {
                cMensajes.setMensaje("Error en actualización: " + ex.Message, 2);
                throw ex;
            }
        }

        private RespuestaTipoAccion ExisteRegistro()
        {
            RespuestaTipoAccion _res;
            _res.TipoRegistro = respuestaExisteRegistro.NoExiste;
            _res.Valores.id = 0;
            _res.Valores.CNBV = "";
            string _VCDDESCRIPCION = tbTipoTipificacionValor.Text;
            ServiceResult _resC = rsTipoListaNegra.LeerExisteciaRegistroTipoTipificacion(_VCDDESCRIPCION);

            _res.TipoRegistro = (int)_resC.ResultValue == 1 ? respuestaExisteRegistro.ExisteCNBV :
                (int)_resC.ResultValue == 10 ? respuestaExisteRegistro.ExisteTipo :
                (int)_resC.ResultValue >= 11 ? respuestaExisteRegistro.ExisteTipoYCNBV :
                respuestaExisteRegistro.NoExiste;
            return _res;
        }

        //foreach (ListItem item in ddlBusquedaTipoAccion.Items)
        //{
        //    if (item.Value != "-1")
        //    {
        //        string[] claveRegistroTipoAccionCNBV = item.Value.Split('|');
        //        _res.TipoRegistro = claveRegistroTipoAccionCNBV[1].ToUpper().Replace(" ", "") == tbIDCNBV.Text.ToUpper().Replace(" ", "") ? respuestaExisteRegistro.ExisteCNBV :
        //            item.Text.ToUpper().Replace(" ", "") == tbRegistroTipoAccion.Text.ToUpper().Replace(" ", "") ? respuestaExisteRegistro.ExisteTipo : respuestaExisteRegistro.NoExiste;
        //        if (_res.TipoRegistro != respuestaExisteRegistro.NoExiste)
        //        {
        //            _res.Valores.id = contador;// Convert.ToInt32(claveRegistroTipoAccionCNBV[0]);
        //            _res.Valores.CNBV = claveRegistroTipoAccionCNBV[1];
        //            return _res;
        //        }
        //    }
        //    contador += 1;
        //}


        protected void ibtEditar_Click(object sender, ImageClickEventArgs e)
        {
            if (ddlCatTipoListaNegra.SelectedItem.Value != "0")
            {
            btnAceptarAccion.CommandName = "2";          
            lbIdTipoTipificacionValor.Text = this.ddlCatTipoListaNegra.SelectedItem.Value;
            tbTipoTipificacionValor.Text = this.ddlCatTipoListaNegra.SelectedItem.Text;
            btnAceptarAccion.Text = "EDITAR";           
            lbIdTipoTipificacionValor.Visible = true;
            lbTitIdTipoTipificación.Visible = true;
            mpeEditarAgregarRegistro.Show();
            return;
            }
            this.cMensajes.setMensaje("SELECCIONAR TIPO TIPIFICACIÓN", 2);                      
            mpeAccionRegistro.Show();
            ddlCatTipoListaNegra.Focus();
        }

        protected void ibAgregar_Click(object sender, ImageClickEventArgs e)
        {
            btnAceptarAccion.CommandName = "1";           
            tbTipoTipificacionValor.Text = "";
            lbIdTipoTipificacionValor.Text = "";
            btnAceptarAccion.Text = "AGREGAR";            
            lbIdTipoTipificacionValor.Visible = false;
            lbTitIdTipoTipificación.Visible = false;
            mpeEditarAgregarRegistro.Show();
        }

        private TipoAccion datosRegistroDDLTipoAccion(DropDownList _ddlTipoAccion)
        {
            TipoAccion _res;
            _res.id = _ddlTipoAccion.SelectedIndex > 0 ? Convert.ToInt32(_ddlTipoAccion.SelectedItem.Value.Split('|')[0]) : 0;
            _res.CNBV = _ddlTipoAccion.SelectedIndex > 0 ? _ddlTipoAccion.SelectedItem.Value.Split('|')[1] : "";
            return _res;
        }

        //private TipoAccion datosRegistroWUCTipoAccion(wucBusquedaInteligenteTA _control)
        //{
        //    TipoAccion _res;
        //    _res.id = _control.strDatosRegistro != "" ? Convert.ToInt32(_control.strDatosRegistro.Split('|').ElementAt(0)) : 0;
        //    _res.CNBV = _control.strDatosRegistro != "" ? _control.strDatosRegistro.Split('|').ElementAt(1) : "";
        //    return _res;
        //}

        protected void mantenerPanelCaptura(object sender, EventArgs e)        
        {            
            mpeAccionRegistro.Show();
        }

        #endregion
        
    }

    #region Clase parámetros de búsqueda

    public class parametrosBusqueda
    {
        public parametrosBusqueda(
            DropDownList strTipoLista,
            DropDownList intTipoTipificacion
            )
        {
            this.strTipoLista = strTipoLista.SelectedItem.Value != "0" ? strTipoLista.SelectedItem.Text.ToString() : null;
            this.intTipoTipificacion = ((Int16?)Int16.Parse(intTipoTipificacion.SelectedItem.Value) > 0 ? (Int16?)Int16.Parse(intTipoTipificacion.SelectedItem.Value) : null);

        }
        public string strTipoLista { get; private set; }
        public int? intTipoTipificacion { get; private set; }
    }

    #endregion

    #region Clase parámetros configuración PLD

    public class parametrosTipoListaNegra
    {
        private CatTipoListaNegra oTipoListaNegra = new CatTipoListaNegra();
        public parametrosTipoListaNegra(
            int? intTipoListaID,
            TextBox strTipoLista,
            int? intTipoTipificacion,
            TextBox Descripcion,
            TextBox Pais
            )
        {
            oTipoListaNegra.intTipoListaID = intTipoListaID;
            oTipoListaNegra.vchTipoLista = strTipoLista.Text;
            oTipoListaNegra.intTipoTipificacionID = intTipoTipificacion;
            oTipoListaNegra.VCDDESCRIPCION = Descripcion.Text;
            oTipoListaNegra.vchPais = Pais.Text;
        }
        public CatTipoListaNegra oParametrosTipoListaNegra()
        {
            return oTipoListaNegra;
        }
    }

    #endregion

}