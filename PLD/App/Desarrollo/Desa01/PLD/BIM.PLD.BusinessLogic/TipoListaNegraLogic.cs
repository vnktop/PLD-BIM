using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Transactions;
using BIM.BusinessEntities;
using BIM.DataAccess;

namespace BIM.PLD.BusinessLogic
{
    public class TipoListaNegraLogic
    {
        #region Constructor de la clase

        private TipoListaNegraDataAccess TipoListaNegraDA;

        public TipoListaNegraLogic()
        {
            TipoListaNegraDA = new TipoListaNegraDataAccess();
        }
        #endregion

        /// <summary>
        /// Insertar registro Tipo lista negra
        /// </summary>
        /// <param name="oRCSBanxico">BE tipo lista negra</param>
        /// <returns></returns>
        public int InsertarTipoListaNegra(CatTipoListaNegra oCatTipoListaNegra)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroInsert = TipoListaNegraDA.InsertarTipoListaNegra(oCatTipoListaNegra);                  
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }

        /// <summary>
        /// Obtiene listado de tipo lista negra por tipo de lista y tipo de tipificaión
        /// </summary>
        /// <param name="@intTipoTipificacionID">Id tipo de tipificación</param>
        /// <param name="@vchTipoLista">tipo de lista</param>     
        /// <returns>Listado BE tipo de lista negra</returns>
        public List<CatTipoListaNegra> ListadoBusquedaTipoListaNegra(int? @intTipoTipificacionID, string @vchTipoLista)
        {
            List<CatTipoListaNegra> result = null;
            try
            {
                result = TipoListaNegraDA.ListadoBusquedaTipoListaNegra(@intTipoTipificacionID, @vchTipoLista);                                                        
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return result;
        }

        /// <summary>
        /// Actualiza registro de tipo lista negra por tipo de lista y tipo de tipificación
        /// </summary>
        /// <param name="_datos">BE de tipo de lista negra</param>
        /// <returns></returns>
        public int editarTipoListaNegra(CatTipoListaNegra _datos)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroInsert = TipoListaNegraDA.editarTipoListaNegra(_datos);
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }

        /// <summary>
        /// Eliminar registro de tipo de lista negra por tipo de lista y tipo de tipificación
        /// </summary>
        /// <param name="@intTipoTipificacionID">Id tipo de tipificación</param>
        /// <param name="@vchTipoLista">tipo de lista</param>  
        /// <returns>entero valor del resultado</returns>
        public int eliminarTipoListaNegra(int? intTipoListaID)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroInsert = TipoListaNegraDA.eliminarTipoListaNegra(intTipoListaID);                    
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }

        /// <summary>
        /// Leer existencia de registro de tipo de lista negra por tipo de lista y tipo de tipificación
        /// </summary>
        /// <param name="@intTipoTipificacionID">Id tipo de tipificación</param>
        /// <param name="@vchTipoLista">tipo de lista</param>  
        /// <returns>entero valor del resultado</returns>
        public int LeerExisteciaRegistroTipoListaNegra(int? @intTipoTipificacionID, string @vchTipoLista)
        {
            int? RegistroInsert = 0;
            try
            {
                RegistroInsert = TipoListaNegraDA.LeerExisteciaRegistroTipoListaNegra(@intTipoTipificacionID, @vchTipoLista);                             
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }

        public int InsertarTipoTipificacion(CatTipoListaNegra oCatTipoListaNegra)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroInsert = TipoListaNegraDA.InsertarTipoTipificacion(oCatTipoListaNegra);
                    ts.Complete();
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
            int? RegistroInsert = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroInsert = TipoListaNegraDA.editarTipoTipificacion(_datos);
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }

        public int LeerExisteciaRegistroTipoTipificacion(string @VCDDESCRIPCION)
        {
            int? RegistroInsert = 0;
            try
            {
                RegistroInsert = TipoListaNegraDA.LeerExisteciaRegistroTipoTipificacion(@VCDDESCRIPCION);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }
    }
}
