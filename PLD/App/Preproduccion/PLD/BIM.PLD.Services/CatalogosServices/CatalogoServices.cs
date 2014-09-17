using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.BusinessLogic;

namespace BIM.PLD.Services
{
    public partial class CatalogoServices : ICatalogoServices
    {
        public List<Catalogo> ListarCatalogoTipoListaNegra()
        {
            List<Catalogo> result = null;
            try
            {
                result = (new CatalogosLogic()).ListadoCatalogoTipoListaNegra();
            }
            catch (Exception ex)
            {
#if (DEBUG)
                Console.WriteLine("Error en CatalogoServices.ListarCatalogoTipoListaNegra: " + ex.Message);
#else
               EventLogManager.LogErrorEntry("Error en CatalogoServices.ListarCatalogoTipoListaNegra: " + ex.Message);
               //TODO: Codificar envío de notificación de error al EventLog
#endif
            }
            return result;
        }
        public List<Catalogo> ListadoCatAccionesPLD()
        {
            List<Catalogo> result = null;
            try
            {
                result = (new CatalogosLogic()).ListadoCatAccionesPLD();
            }
            catch (Exception ex)
            {
#if (DEBUG)
                Console.WriteLine("Error en CatalogoServices.ListadoCatAccionesPLD: " + ex.Message);
#else
               EventLogManager.LogErrorEntry("Error en CatalogoServices.ListadoCatAccionesPLD: " + ex.Message);
               //TODO: Codificar envío de notificación de error al EventLog
#endif
            }
            return result;
        }

        public List<Catalogo> ListadoCatTipoLista()
        {
            List<Catalogo> result = null;
            try
            {
                result = (new CatalogosLogic()).ListadoCatTipoLista();
            }
            catch (Exception ex)
            {
#if (DEBUG)
                Console.WriteLine("Error en CatalogoServices.ListadoCatTipoLista: " + ex.Message);
#else
               EventLogManager.LogErrorEntry("Error en CatalogoServices.ListadoCatTipoLista: " + ex.Message);
               //TODO: Codificar envío de notificación de error al EventLog
#endif
            }
            return result;
        }

        public List<Catalogo> ListaBusquedaInteligenteTipoTipificacion(string strDatos)
        {
            List<Catalogo> result = null;
            try
            {
                result = (new CatalogosLogic()).ListaBusquedaInteligenteTipoTipificacion(strDatos);

            }
            catch (Exception ex)
            {
#if(DEBUG)
                Console.WriteLine("Error en CatalogoServices.ListaBusquedaInteligenteTipoTipificacion: " + ex.Message);
#else
                                               EventLogManager.LogErrorEntry("Error en CatalogoServices.ListaBusquedaInteligenteTipoTipificacion: " + ex.Message);
                                               //TODO: Codificar envío de notificación de error al EventLog
#endif
            }
            return result;
        }
    }
}
