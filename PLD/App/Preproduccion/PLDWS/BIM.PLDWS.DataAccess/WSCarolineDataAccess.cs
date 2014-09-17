using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLDWS.DataAccess.Context;

namespace BIM.DataAccess
{
    public class WSCarolineDataAccess
    {

        public List<WSCaroline> ListadoCaroline(int intTipoPersonaID, int intClienteID)
        {
            List<WSCaroline> results = new List<WSCaroline>();
            try
            {
                using (WSCarolineDataContext dc = new  WSCarolineDataContext(Helper.ConnectionString()))
                {
                    //int? res = 0;
                    var query = from item in dc.stp_ListarCaroline()
                                select new WSCaroline()
                                {
                                    //intTipoPersonaID = item.intTipoPersonaID,
                                    intClienteID = item.intClienteID,
                                  //  vchTipificacion = item.vchTipificacion,
                                    intCalificacion = item.intCalificacion};
                                   // datFecha = item.datFecha};
                                    
                    results.AddRange(query);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return results;
        }

        //***************

        public int InsertarWSCaroline (WSCaroline oWSCaroline)
        {
            int? RegistroInsert = 0;
            try
            {
                using (WSCarolineDataContext dc = new WSCarolineDataContext(Helper.ConnectionString()))
                {
                    dc.stp_InsertarCaroline(
                        ref RegistroInsert,
                                            oWSCaroline.intTipoTipificacionID,
                                            oWSCaroline.intClienteID,
                                            oWSCaroline.intPersonaID,
                                            oWSCaroline.intCalificacion);
                    
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
