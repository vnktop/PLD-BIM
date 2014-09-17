using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Transactions;
using BIM.BusinessEntities;
using BIM.DataAccess;

namespace BIM.PLDWS.BusinessLogic
{
    public class ConfiguracionPLDLogic
    {
        #region Constructor de la clase

        private ConfiguracionPLDDataAccess ConfiguracionPLDDA;

        public ConfiguracionPLDLogic()
        {
            ConfiguracionPLDDA = new ConfiguracionPLDDataAccess();
        }
        #endregion

        /// <summary>
        /// Insertar registro configuración PLD
        /// </summary>
        /// <param name="oRCSBanxico">BE configuracion PLD</param>
        /// <returns></returns>
        public int InsertarConfiguracionPLD(ConfiguracionPLD oConfiguracionPLD)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroInsert = ConfiguracionPLDDA.InsertarConfiguracionPLD(oConfiguracionPLD);
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
        /// Obtiene listado de configuración PLD por tipo de lista y tipo de sistema
        /// </summary>
        /// <param name="@intTipoOperacionMDID">Id tipo de operacion</param>
        /// <param name="@VCHTIPOLISTA">tipo de lista</param>
        /// <param name="@sintSistemaID">tipo de sistema</param>
        /// <returns>Listado BE Configuración PLD</returns>
        public List<ConfiguracionPLD> ListadoBusquedaConfiguracionPLD(int? @intTipoTipificacionID, Int16? sintSistemaID)
        {
            List<ConfiguracionPLD> result = null;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    result = ConfiguracionPLDDA.ListadoBusquedaConfiguracionPLD(@intTipoTipificacionID, @sintSistemaID);
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return result;
        }

        /// <summary>
        /// Actualiza registro de configuración PLD por tipo de lista y tipo de sistema
        /// </summary>
        /// <param name="_datos">BE de configuración PLD</param>
        /// <returns></returns>
        public int editarConfiguracionPLD(ConfiguracionPLD _datos)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroInsert = ConfiguracionPLDDA.editarConfiguracionPLD(_datos);
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
        /// Eliminar registro de configuración de PLD por tipo de lista y tipo de sistema
        /// </summary>
        /// <param name="@VCHTIPOLISTA">tipo de lista</param>
        /// <param name="@sintSistemaID">tipo de sistema</param>
        /// <returns></returns>
        public int eliminarConfiguracionPLD(int? @intTipoTipificacionID, Int16? sintSistemaID)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroInsert = ConfiguracionPLDDA.eliminarConfiguracionPLD(@intTipoTipificacionID, @sintSistemaID);
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }
    }
}
