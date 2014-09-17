using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Transactions;
using BIM.DataAccess;
using BIM.BusinessEntities;

namespace BIM.PLD.BusinessLogic
{
    public class TipoCambioLogic
    {
        private TipoCambioDataAccess tcDA;
        public TipoCambioLogic()
        {
            tcDA = new TipoCambioDataAccess();
        }
        public List<TipoCambio> getListadoTipoCambio()
        {
            List<TipoCambio> result = new List<TipoCambio>();
            try
            {
                result = tcDA.getListadoTipoCambio();
            }
            catch(Exception ex)
            {
                throw ex;
            }
            return result;
        }
        public int insertaTCManual(TipoCambio modelo)
        {
            int iResult = 0;
            try
            {
                iResult = tcDA.insertaTCManual(modelo);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return iResult;
        }
        public int insertaTCAutomatico(List<TipoCambio> lst)
        {
            int iResult = 0;
            try
            {
                for(int i = 0; i <lst.Count; i++)
                    tcDA.insertaTCManual(lst.ElementAt(i));
                iResult = 1;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return iResult;
        }
    }
}
