using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.DataAccess.Context;

namespace BIM.DataAccess
{
    public class BitacoraPLDDataAccess
    {
        public List<BitacoraPLD> ListadoBusquedaBitacoraPLD(string vchUsuario, int? intSistema)
        {
            List<BitacoraPLD> results = new List<BitacoraPLD>();
            try
            {
                using (BitacoraPLDDataContext dc = new BitacoraPLDDataContext(Helper.ConnectionString()))
                {
                    var query = from item in dc.stp_BusquedaRegistrosPLD(vchUsuario, intSistema)
                                select new BitacoraPLD
                                {
                                    intBitacoraID           = item.intBitacoraID,
                                    intIdLN                 = item.intIdLN,
                                    vchUsuario              = item.vchUsuario,
                                    vchUsuarioNombre        = item.vchUsuarioNombre,
                                    intSistemaID            = item.intSistemaID,
                                    vchPersonaIncidencia    = item.vchPersonaIncidencia,
                                    vchNombre               = item.vchNombre,
                                    vchApPaterno            = item.vchApPaterno,
                                    vchApMaterno            = item.vchApMaterno,
                                    vchRelacionCliente      = item.vchRelacionCliente,
                                    vchComentario           = item.vchComentario,
                                    bitAutorizado           = item.bitAutorizado,
                                    bitProceso              = item.bitProceso,
                                    datFecha                = item.datFecha,
                                    datFechaAutorizacion    = item.datFechaAutorizacion,
                                    bitHomonimo             = item.bitHomonimo,
                                    vchUsuarioAutoriza      = item.vchUsuarioAutoriza,
                                    bitEstatus              = item.bitEstatus,
                                    vchNombreSistema        = item.vchNombreSistema,
                                    vchTipoLista            = item.vchTipoLista,
                                    intTipoTipificacionID   = item.intTipoTipificacionID,
                                    vchIdentificadorInterno = item.vchIdentificadorInterno,
                                    intVigenciaDias         = item.intVigenciaDias,                                        
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

        public bool desbloquearUsuario(desbloqueoBitacoraPLD parametros)
        {
            int? _res = 0;           
            try
            {
                using (BitacoraPLDDataContext dc = new BitacoraPLDDataContext(Helper.ConnectionString()))
                {
                    dc.stp_InsertarDesbloqueoPLD(ref _res, parametros.intBitacoraID, parametros.bitAutorizado, parametros.bitProceso, parametros.bitHomonimo, parametros.vchUsuarioAutoriza, parametros.datFechaAutorizacion, parametros.intVigenciaDias, parametros.vchComentario);                                
                    if(_res > 0)
                    {
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;           
            }
            return false;
        }
    }
}
