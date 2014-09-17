using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BIM.PLD.Website
{
    public partial class frmInicio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label TituloPagina = (Label)this.Master.FindControl("lblNomModulo");
                TituloPagina.Text = "Bienvenido al módulo de Prevención de Lavado de Dinero";

                Page.Title = Application["Nom_Sis"].ToString() + " - Inicio";
                Session["BANNER"] = "S";

            }
        }
    }
}