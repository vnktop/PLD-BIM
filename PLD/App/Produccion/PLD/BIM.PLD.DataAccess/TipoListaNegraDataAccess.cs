using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.DataAccess.Context;

using System.Configuration;
using System.Runtime.InteropServices;
using System.IO;

namespace BIM.DataAccess
{
    public class TipoListaNegraDataAccess
    {
        private enum CRUD
        {
            insertar = 1,
            leerBusqueda = 2,
            actualizar = 3,
            eliminar = 4,
            leerExisteRegistroTipoListaNegra = 5,
            ingresarTipoTipificacion = 6,
            editarTipoTipificacion = 7,
            leerExisteRegistroTipoTipificacion = 8

        }

        public int InsertarTipoListaNegra(CatTipoListaNegra oCatTipoListaNegra)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TipoListaNegraDataContext dc = new TipoListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDTipoListaNegra(
                        ref RegistroInsert,
                        (int)CRUD.insertar,
                        null,
                        oCatTipoListaNegra.vchTipoLista,
                        oCatTipoListaNegra.intTipoTipificacionID,
                        oCatTipoListaNegra.VCDDESCRIPCION,
                        oCatTipoListaNegra.vchPais
                        );
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }

        public List<CatTipoListaNegra> ListadoBusquedaTipoListaNegra(int? @intTipoTipificacionID, string @vchTipoLista)
        {
            List<CatTipoListaNegra> results = new List<CatTipoListaNegra>();
            try
            {
                using (TipoListaNegraDataContext dc = new TipoListaNegraDataContext(Helper.ConnectionString()))
                {
                    int? res = 0;
                    var query = from item in dc.stp_CRUDTipoListaNegra(
                                ref res, (int)CRUD.leerBusqueda, null, @vchTipoLista, @intTipoTipificacionID, null, null)
                                select new CatTipoListaNegra()
                                {
                                    intTipoListaID = item.intTipoListaID,
                                    vchTipoLista = item.vchTipoLista,
                                    intTipoTipificacionID = item.intTipoTipificacionID,
                                    vchTipoTipificacion = item.vchTipoTipificacion,
                                    VCDDESCRIPCION = item.VCDDESCRIPCION,
                                    vchPais = item.vchPais
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

        public int editarTipoListaNegra(CatTipoListaNegra _datos)
        {
            int? res = 0;
            try
            {
                using (TipoListaNegraDataContext dc = new TipoListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDTipoListaNegra(
                        ref res, (int)CRUD.actualizar, _datos.intTipoListaID, _datos.vchTipoLista, _datos.intTipoTipificacionID, _datos.VCDDESCRIPCION, _datos.vchPais
                    );
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return res.Value;
        }

        public int eliminarTipoListaNegra(int? @intTipoListaID)
        {
            int? res = 0;
            try
            {
                using (TipoListaNegraDataContext dc = new TipoListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDTipoListaNegra(
                        ref res, (int)CRUD.eliminar, @intTipoListaID, null, null, null, null
                        );
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return res.Value;
        }

        public int LeerExisteciaRegistroTipoListaNegra(int? @intTipoTipificacionID, string @vchTipoLista)
        {
            int? res = 0;
            try
            {
                using (TipoListaNegraDataContext dc = new TipoListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDTipoListaNegra(
                        ref res, (int)CRUD.leerExisteRegistroTipoListaNegra, null, @vchTipoLista, @intTipoTipificacionID, null, null
                        );
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return res.Value;
        }

        public int InsertarTipoTipificacion(CatTipoListaNegra oCatTipoListaNegra)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TipoListaNegraDataContext dc = new TipoListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDTipoListaNegra(
                        ref RegistroInsert,
                        (int)CRUD.ingresarTipoTipificacion,
                        null,
                        null,
                        null,
                        oCatTipoListaNegra.VCDDESCRIPCION,
                        null
                        );
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }

        public int editarTipoTipificacion(CatTipoListaNegra _datos)
        {
            int? res = 0;
            try
            {
                using (TipoListaNegraDataContext dc = new TipoListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDTipoListaNegra(
                        ref res, (int)CRUD.editarTipoTipificacion, null, null, _datos.intTipoTipificacionID, _datos.VCDDESCRIPCION, null
                    );
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return res.Value;
        }

        public int LeerExisteciaRegistroTipoTipificacion(string @VCDDESCRIPCION)
        {
            int? res = 0;
            try
            {
                using (TipoListaNegraDataContext dc = new TipoListaNegraDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDTipoListaNegra(
                        ref res, (int)CRUD.leerExisteRegistroTipoTipificacion, null, null, null, @VCDDESCRIPCION, null
                        );
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return res.Value;
        }
    }
}
       
