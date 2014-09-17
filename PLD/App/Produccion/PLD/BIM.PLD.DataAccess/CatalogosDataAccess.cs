using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.DataAccess.Context;

namespace BIM.DataAccess
{
    public class CatalogosDataAccess
    {
        public List<Catalogo> ListadoCatTipoListaNegra()
        {
            List<Catalogo> results = new List<Catalogo>();
            try
            {
                using (CatalogosDataContext dc = new CatalogosDataContext(Helper.ConnectionString()))
                {
                    var query = from item in dc.stp_ListarCatTipoListaNegra()
                                select new Catalogo()
                                {
                                    intCatalogoID = item.intTipoTipificacionID,
                                    vchDescripcion = item.vchDescripcion

                                };
                    results.AddRange(query);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return results;
        }

        public List<Catalogo> ListadoCatAccionesPLD()
        {
            List<Catalogo> results = new List<Catalogo>();
            try
            {
                using (CatalogosDataContext dc = new CatalogosDataContext(Helper.ConnectionString()))
                {
                    var query = from item in dc.stp_ListarCatAccionesPLD()
                                select new Catalogo()
                                {
                                    intCatalogoID = item.INTACCIONPLDID,
                                    vchDescripcion = item.VCHDESCRIPCION,

                                };
                    results.AddRange(query);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return results;
        }

        public List<Catalogo> ListadoCatTipoLista()
        {
            List<Catalogo> results = new List<Catalogo>();
            try
            {
                using (CatalogosDataContext dc = new CatalogosDataContext(Helper.ConnectionString()))
                {
                    var query = from item in dc.stp_ListarCatTipoLista()
                                select new Catalogo()
                                {
                                    intCatalogoID = item.intTipoListaID,
                                    vchDescripcion = item.vchTipoLista,

                                };
                    results.AddRange(query);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return results;
        }

        /// <summary>
        /// Obtiene la lista de datos según en la búsqueda inteligente para tipo de acción
        /// </summary>
        /// <param name="shrOpcion"></param>
        /// <param name="strDatos"></param>
        /// <returns></returns>
        public List<Catalogo> ListaBusquedaInteligenteTipoTipificacion(string strDatos)
        {
            List<Catalogo> result = new List<Catalogo>();
            try
            {
                using (CatalogosDataContext dc = new CatalogosDataContext(Helper.ConnectionString()))
                {
                    var query = from item in dc.stp_BusquedaInteligenteTipoTipificacion(strDatos)
                                select new Catalogo()
                                {
                                    intCatalogoID = item.intTipoTipificacionID,
                                    vchDescripcion = item.vchDescripcion
                                };
                    result.AddRange(query);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }
    }
}
