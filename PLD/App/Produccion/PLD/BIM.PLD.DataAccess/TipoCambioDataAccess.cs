using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BIM.PLD.DataAccess.Context;
using System.Configuration;
using System.Runtime.InteropServices;
using System.IO;
using BIM.BusinessEntities;
namespace BIM.DataAccess
{
    public class TipoCambioDataAccess
    {
        public List<TipoCambio> getListadoTipoCambio()
        {
            List<TipoCambio> lst = new List<TipoCambio>();
            try
            {
                using (TipoCambioDataContext dc = new TipoCambioDataContext(Helper.ConnectionString()))
                {
                    var query = from item in dc.stp_getTipoCambio()
                                select new TipoCambio()
                                {
                                    strTipoMoneda = item.vchDescripcionCMO,
                                    strTipoCambio = item.vchDescripcionCGE,
                                    decValorCambio = item.decValorCTC,
                                    datFechaCierre = item.datFchDeCierreCTC
                                };
                    lst.AddRange(query);
                }
            }
            catch(Exception e)
            {
                throw e;
            }
            return lst;
        }

        public int insertaTCManual(TipoCambio entity)
        {
            int Result = 0;
            try
            {
                using (TipoCambioDataContext dc = new TipoCambioDataContext(Helper.ConnectionString()))
                {
                    dc.stp_InsertaTipoCambioManual(entity.datFechaCierre,entity.decValorCambio);
                }
                Result = 1;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return Result;
        }
    }
}
