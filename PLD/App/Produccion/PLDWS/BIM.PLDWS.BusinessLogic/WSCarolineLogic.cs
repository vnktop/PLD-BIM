using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Transactions;
using BIM.BusinessEntities;
using BIM.DataAccess;

namespace BIM.PLDWS.BusinessLogic
{
    public class WSCarolineLogic
    {
       #region Constructor de la clase

        private WSCarolineDataAccess WSCarolineDA;

        public WSCarolineLogic()
        {
            WSCarolineDA = new WSCarolineDataAccess();
        }
        #endregion

        /// <summary>
        /// Muestra los registros
        /// </summary>
        /// <param name="intTipoPersonaID"></param>
        /// <returns></returns>

        public List<WSCaroline> ListadoWSCaroline(int intTipoPersonaID, int intClienteID)
        {
            List<WSCaroline> result = null;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    result = WSCarolineDA.ListadoCaroline(intTipoPersonaID, intClienteID);
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
        /// Inserta un registro
        /// </summary>
        /// <param name="oWSCaroline"></param>
        /// <returns></returns>
        public int InsertarWSCaroline(WSCaroline oWSCaroline)
        {
            int? RegistroInsert = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroInsert = WSCarolineDA.InsertarWSCaroline(oWSCaroline);
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
