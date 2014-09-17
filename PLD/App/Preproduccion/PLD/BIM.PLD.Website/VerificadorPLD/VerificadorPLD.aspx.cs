using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using BIM.PLD.Website.VerificadorPLDServices;

namespace BIM.PLD.Website.VerificadorPLD
{
    public partial class VerificadorPLD : System.Web.UI.Page
    {
        VerificadorPLDServicesClient rsVerificadorService = new VerificadorPLDServicesClient();
        CatalogosServices.CatalogoServicesClient rsCatalogos = new CatalogosServices.CatalogoServicesClient();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ejecutarServicio(object sender, EventArgs e)
        {
            lbTipificacion.Text = "";
            lblBloqueoUsuario.Text = "";
            lblBloqueoProceso.Text = "";
            lblMensaje.Text = "";
            lblCreoBitacaora.Text = "";
            lblEnvioCorreo.Text = "";
            lblMensajes.Text = "";
            //System.Threading.Thread.Sleep(150);

            try
            {                               
                VerificadorPLDServices.VerificadorPLD oVerificador = new VerificadorPLDServices.VerificadorPLD();
                //datosVerificadorPDL oDatos = new datosVerificadorPDL(ddlUsuario, ddlSucursal, ddlSistema, ddlPersonaIncidencia, ddlNombre, ddlApPat, ddlApMat, ddlCliente, ddlRelacionCliente);
                datosVerificadorPDL oDatos = new datosVerificadorPDL(ddlUsuario, ddlSucursal, ddlSistema, tbPersonaIncidencia, tbNombre, tbApPat, tbApMat, ddlCliente, ddlRelacionCliente);
                BitacoraPLD _datos = oDatos.oBitacora();
                oVerificador = rsVerificadorService.ServicioVerificadorPLD(_datos);
                lbTipificacion.Text = oVerificador.Tipificacion.ToString() + " - " +rsCatalogos.ListarCatalogoTipoListaNegra().ToList().Find(s=> s.intCatalogoID==oVerificador.Tipificacion).vchDescripcion;
                lblBloqueoUsuario.Text = oVerificador.BloqueoUsuario == null ? "" : oVerificador.BloqueoUsuario.ToString();
                lblBloqueoProceso.Text = oVerificador.BloqueoProceso == null ? "" : oVerificador.BloqueoProceso.ToString();
                lblMensaje.Text = oVerificador.Mensaje == null ? "" : oVerificador.Mensaje.ToString();
                lblCreoBitacaora.Text = oVerificador.CreoBitacora == null ? "" : oVerificador.CreoBitacora.ToString();
                lblEnvioCorreo.Text = oVerificador.EnvioCorreo == null ? "" : oVerificador.EnvioCorreo.ToString();
                if (oVerificador.BloqueoProceso == null && oVerificador.BloqueoUsuario == null && oVerificador.BloqueoProceso == null &&
                    oVerificador.Mensaje == null && oVerificador.CreoBitacora == null && oVerificador.EnvioCorreo == null)
                        lblMensajes.Text = "No existe incidencia";
            }
            catch (Exception ex)
            {
                lblMensajes.Text = ex.Message;
            }
        }
    }
    class datosVerificadorPDL
    {
        private BitacoraPLD _oBitacora = new BitacoraPLD();
        //public datosVerificadorPDL(DropDownList ddlUsuario, DropDownList ddlSucursal, DropDownList ddlSistema, DropDownList ddlPersonaIncidencia,
        //    DropDownList ddlNombre, DropDownList ddlApPat, DropDownList ddlApMat, DropDownList ddlCliente, DropDownList ddlRelacionCliente)
        //{
        public datosVerificadorPDL(DropDownList ddlUsuario, DropDownList ddlSucursal, DropDownList ddlSistema, TextBox tbPersonaIncidencia,
           TextBox tbNombre, TextBox tbApPat, TextBox tbApMat, DropDownList ddlCliente, DropDownList ddlRelacionCliente)
        {
           Usuario = ddlUsuario.SelectedItem.Value != "-1" ? ddlUsuario.SelectedItem.Text : null;
           Sucursal = ddlSucursal.SelectedItem.Value != "-1" ? ddlSucursal.SelectedItem.Text : null;
           Sistema = ddlSistema.SelectedItem.Value != "-1" ? (int?) int.Parse(ddlSistema.SelectedItem.Value) : null;
           PersonaIncidencia = tbPersonaIncidencia.Text != "" ? tbPersonaIncidencia.Text : null; //ddlPersonaIncidencia.SelectedItem.Value != "-1" ? ddlPersonaIncidencia.SelectedItem.Text : "";
           Nombre = tbNombre.Text != "" ? tbNombre.Text : null; //ddlNombre.SelectedItem.Value != "-1" ? ddlNombre.SelectedItem.Text : "";
           ApPat = tbApPat.Text != "" ? tbApPat.Text : null; //ddlApPat.SelectedItem.Value != "-1" ? ddlApPat.SelectedItem.Text : "";
           ApMat = tbApMat.Text != "" ? tbApMat.Text : null; //ddlApMat.SelectedItem.Value != "-1" ? ddlApMat.SelectedItem.Text : "";
           Cliente = ddlCliente.SelectedItem.Value != "-1" ? ddlCliente.SelectedItem.Text : null;
           RelacionCliente = ddlRelacionCliente.SelectedItem.Value != "-1" ? ddlRelacionCliente.SelectedItem.Text : null;          
        }
        private string Usuario { get;  set; }
        private string Sucursal { get; set; }
        private int? Sistema { get; set; }
        private string PersonaIncidencia { get; set; }
        private string Nombre { get; set; }
        private string ApPat { get; set; }
        private string ApMat { get; set; }
        private string Cliente { get; set; }
        private string RelacionCliente { get; set; }

        public BitacoraPLD oBitacora()
        {
            _oBitacora.vchUsuario = Usuario;
            _oBitacora.vchSucursal = Sucursal;
            _oBitacora.intSistema = Sistema;
            _oBitacora.vchPersonaIncidencia = PersonaIncidencia;
            _oBitacora.vchNombre = Nombre;
            _oBitacora.vchApPaterno = ApPat;
            _oBitacora.vchApMaterno = ApMat;
            _oBitacora.vchCliente = Cliente;
            _oBitacora.vchRelacionCliente = RelacionCliente;
            return _oBitacora;
        }
    }
    
}