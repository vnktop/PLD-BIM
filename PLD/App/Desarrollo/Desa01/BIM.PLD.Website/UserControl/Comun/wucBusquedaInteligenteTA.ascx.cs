using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BIM.PLD.Website.TipoListaNegraService;
using BIM.PLD.Website.CatalogosServices;

namespace BIM.PLD.Website.UserControl.Comun
{
    public partial class wucBusquedaInteligenteTA : System.Web.UI.UserControl
    {

        #region Tipos para agregar/edición de TipoAccion

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


        #endregion       
        public delegate void getRegistroEventHandler(int idRegistro);
        public event getRegistroEventHandler getRegistroEvent;        
        public CatalogoServicesClient rsCatAcciones = new CatalogoServicesClient();
        public TipoListaNegraClient rsTipoListaNegra = new TipoListaNegraClient();

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
            if (!IsPostBack)
            {
                _cargarDLL();
            }
        }

        private void _cargarDLL()
        {
            ddlCatTipoListaNegra.DataSource = rsCatAcciones.ListarCatalogoTipoListaNegra();
            Utileria.Utileria._ddlAsignarValorTexto(ddlCatTipoListaNegra, "intCatalogoID", "vchDescripcion");
            Utileria.Utileria._ddlAgregarValorInicial(ddlCatTipoListaNegra, "[Seleccione una opción…]");           
        }

        /// <summary>
        /// Metodo que selecciona que busqueda ejecutara el control
        /// </summary>
        /// <param name="bnNoConsulta"></param>
        //public void tipoDeConsulta(byte bnNoConsulta)
        //{
        //    try
        //    {
        //        myTextBox.Width = 480;
        //        autoComplete1.MinimumPrefixLength = 3;
        //        autoComplete1.ContextKey = Convert.ToString(bnNoConsulta);
        //        Session["RegistroValido"] = myTextBox.Text != "" ? true : false;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(ex.Message);
        //    }

        //}

        /// <summary>
        /// Metodo que controla en evento del hiddenfield y recibe el Id Seleccionado
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void hdnValue_ValueChanged(object sender, EventArgs e)
        {
            try
            {
                string selectedWidgetID = ((HiddenField)sender).Value.Split('|').ElementAt(0);
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
        //public void limpiaBusqueda()
        //{
        //    try
        //    {
        //        this.myTextBox.Text = string.Empty;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(ex.Message);
        //    }
        //}

        

        public Label lblBusq { get { return lblBusqueda; } set { lblBusqueda = value; } }

        //public TextBox txtBusqueda { get { return myTextBox; } set { myTextBox = value; } }

        public string strDatosRegistro { get {return hdnValue.Value; } }

        //public bool registroValido { get { return (bool)Session["RegistroValido"]; } }

        public DropDownList ddlBusqueda { get { return ddlCatTipoListaNegra; } set { ddlCatTipoListaNegra = value; } }

        #region Agregar/Editar catálogo Tipo de acción

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
                            int idRegistroTipoAccion = Convert.ToInt32(this.strDatosRegistro.Split('|').ElementAt(0));
                            //_editarRetistro(Convert.ToInt32(idRegistroTipoAccion[0]));
                            _editarRetistro(idRegistroTipoAccion);
                            break;

                        default:
                            break;
                    }
                    break;
                case respuestaExisteRegistro.ExisteTipo:
                    //ddlBusquedaTipoAccion.SelectedIndex = _existeRegistro.Valores.id;
                    wucMensajeSistema.setMensaje("EXISTE REGISTRO CON EL MISMO TIPO DE ACCIÓN", 2);
                    mpeEditarAgregarRegistro.Show();
                    break;
                case respuestaExisteRegistro.ExisteCNBV:
                    //ddlBusquedaTipoAccion.SelectedIndex = _existeRegistro.Valores.id;
                    wucMensajeSistema.setMensaje("EXISTE REGISTRO CON LA MISMA CLAVE CNBV", 2);
                    mpeEditarAgregarRegistro.Show();
                    break;
                case respuestaExisteRegistro.ExisteTipoYCNBV:
                    //ddlBusquedaTipoAccion.SelectedIndex = _existeRegistro.Valores.id;
                    wucMensajeSistema.setMensaje("EXISTE REGISTRO CON LA MISMA CLAVE CNBV Y TIPO DE ACCIÓN", 2);
                    mpeEditarAgregarRegistro.Show();
                    break;
                default:
                    break;
            }
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
                    wucMensajeSistema.setMensaje("Registro ingresado correctamente", 1);                   
                }
                else
                {
                    wucMensajeSistema.setMensaje("Error al ingresar el registro", 2);
                }
            }
            catch (Exception ex)
            {
                wucMensajeSistema.setMensaje("Error en inserción: " + ex.Message, 2);
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
                    wucMensajeSistema.setMensaje("Registro actualizado correctamente", 1);                   
                }
                else
                {
                    wucMensajeSistema.setMensaje("Error al actualizar el registro", 2);
                }
            }
            catch (Exception ex)
            {
                wucMensajeSistema.setMensaje("Error en actualización: " + ex.Message, 2);
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
            //if (this.registroValido == true)
            //{
                btnAceptarAccion.CommandName = "2";
                lbIdTipoTipificacionValor.Text = this.ddlCatTipoListaNegra.SelectedItem.Value;
                tbTipoTipificacionValor.Text = this.ddlCatTipoListaNegra.SelectedItem.Text;                
                btnAceptarAccion.Text = "EDITAR";                
                mpeEditarAgregarRegistro.Show();
                //return;
            //}
            //this.wucMensajeSistema.setMensaje("INGRESAR REGISTRO VALIDO", 2);
            
        }

        protected void ibAgregar_Click(object sender, ImageClickEventArgs e)
        {
            btnAceptarAccion.CommandName = "1";
            tbTipoTipificacionValor.Text = "";
            lbIdTipoTipificacionValor.Text = "";            
            btnAceptarAccion.Text = "AGREGAR";
            mpeEditarAgregarRegistro.Show();
        }

        private TipoAccion datosRegistroDDLTipoAccion(DropDownList _ddlTipoAccion)
        {
            TipoAccion _res;
            _res.id = _ddlTipoAccion.SelectedIndex > 0 ? Convert.ToInt32(_ddlTipoAccion.SelectedItem.Value.Split('|')[0]) : 0;
            _res.CNBV = _ddlTipoAccion.SelectedIndex > 0 ? _ddlTipoAccion.SelectedItem.Value.Split('|')[1] : "";
            return _res;
        }

        private TipoAccion datosRegistroWUCTipoAccion(wucBusquedaInteligenteTA _control)
        {
            TipoAccion _res;
            _res.id = _control.strDatosRegistro != "" ? Convert.ToInt32(_control.strDatosRegistro.Split('|').ElementAt(0)) : 0;
            _res.CNBV = _control.strDatosRegistro != "" ? _control.strDatosRegistro.Split('|').ElementAt(1) : "";
            return _res;
        }

        #endregion
    }
}