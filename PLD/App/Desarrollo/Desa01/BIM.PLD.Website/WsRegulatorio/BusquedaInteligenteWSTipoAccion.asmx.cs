using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using BIM.PLD.Website.CatalogosServices;


namespace BIM.PLD.Website.WsRegulatorio
{
    /// <summary>
    /// Descripción breve de BusquedaInteligenteWSTipoAccion
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    //[System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio Web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    [System.Web.Script.Services.ScriptService]
    public class BusquedaInteligenteWSTipoAccion : System.Web.Services.WebService
    {

        [WebMethod]
        public string[] GetCompletionListTA(string prefixText, int count, string contextKey)
        {
            try
            {
                if (count == 0)
                {
                    count = 10;
                }
                prefixText = prefixText.Replace(" ", "%") + "%";

                CatalogoServicesClient tlncService = new CatalogoServicesClient();

                var linqSP = tlncService.ListaBusquedaInteligenteTipoTipificacion(prefixText);
                List<string> items = new List<string>(count);
                foreach (var dr in linqSP)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(dr.vchDescripcion, dr.intCatalogoID.ToString()));
                }
                return items.ToArray();
            }
            catch (Exception ex) { throw new System.Exception(ex.Message); }
        }
    }
}
