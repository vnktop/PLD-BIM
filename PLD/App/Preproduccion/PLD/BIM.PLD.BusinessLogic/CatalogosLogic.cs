using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.DataAccess;

namespace BIM.PLD.BusinessLogic
{
    public class CatalogosLogic
    {
        #region Constructor

        private CatalogosDataAccess CatalogosDA;

        public CatalogosLogic()
        {
            CatalogosDA = new CatalogosDataAccess();
        }

        #endregion

        #region Obtiene los datos  ListadoCatalogoTipoListaNegra
        public List<Catalogo> ListadoCatalogoTipoListaNegra()
        {
            List<Catalogo> results = null;
            try
            {
                results = CatalogosDA.ListadoCatTipoListaNegra();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return results;
        }
        #endregion 

        #region Obtiene los datos  ListadoCatalogoAccionePLD
        public List<Catalogo> ListadoCatAccionesPLD()
        {
            List<Catalogo> results = null;
            try
            {
                results = CatalogosDA.ListadoCatAccionesPLD();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return results;
        }
        #endregion 

        public List<Catalogo> ListadoCatTipoLista()
        {
            List<Catalogo> results = null;
            try
            {
                results = CatalogosDA.ListadoCatTipoLista();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return results;
        }

        /// <summary>
        /// Obtiene la lista de datos según la busqueda deseada
        /// </summary>
        /// <param name="shrOpcion"></param>
        /// <param name="strDatos"></param>
        /// <returns></returns>
        public List<Catalogo> ListaBusquedaInteligenteTipoTipificacion(string strDatos)
        {
            List<Catalogo> result = null;
            try
            {
                result = CatalogosDA.ListaBusquedaInteligenteTipoTipificacion(strDatos);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }
    }
}
