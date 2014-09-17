using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BIM.BusinessEntities;
using BIM.PLD.BusinessLogic;

namespace BIM.PLD.Services
{
    public partial class TipoCambioServices : ITipoCambioServices
    {
        public List<TipoCambio> getListadoTipoCambio()
        {
            List<TipoCambio> result = new List<TipoCambio>();
            try
            {
                result = (new TipoCambioLogic()).getListadoTipoCambio();
            }
            catch (Exception ex)
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
                iResult = (new TipoCambioLogic()).insertaTCManual(modelo);
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
                iResult = (new TipoCambioLogic()).insertaTCAutomatico(lst);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return iResult;
        }
    }
}
