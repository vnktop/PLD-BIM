using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.PLD.DataAccess.Context;

namespace BIM.DataAccess
{
    public class ConfiguracionPLDDataAccess
    {
        private enum CRUD
        {
            insertar = 1,
            leerBusqueda = 2,            
            actualizar = 3,
            eliminar = 4           
        }

        public int InsertarConfiguracionPLD(ConfiguracionPLD oConfiguracionPLD)
        {
            int? RegistroInsert = 0;
            try
            {
                using (ConfiguracionPLDDataContext dc = new ConfiguracionPLDDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDConfiguracionPLD(
                        ref RegistroInsert, (int)CRUD.insertar,
                        oConfiguracionPLD.intTipoTipificacionID, oConfiguracionPLD.sintSistemaID,
                        oConfiguracionPLD.bitBloqueoUsuario, oConfiguracionPLD.bitBloqueoProceso, oConfiguracionPLD.bitEnvioCorreo, oConfiguracionPLD.bitBitacora,
                        oConfiguracionPLD.vchMensaje, oConfiguracionPLD.vchCorreosPara,
                        oConfiguracionPLD.vchCorreosCC
                        );
                }               
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RegistroInsert.Value;
        }

        public List<ConfiguracionPLD> ListadoBusquedaConfiguracionPLD(int? @intTipoTipificacionID, Int16? sintSistemaID)
        {
            List<ConfiguracionPLD> results = new List<ConfiguracionPLD>();
            try
            {
                using (ConfiguracionPLDDataContext dc = new ConfiguracionPLDDataContext(Helper.ConnectionString()))
                {
                    int? res = 0;
                    var query = from item in dc.stp_CRUDConfiguracionPLD(
                                ref res, (int)CRUD.leerBusqueda, @intTipoTipificacionID, @sintSistemaID, null, null, null, null, null, null, null)
                                select new ConfiguracionPLD()
                                {
                                    intTipoTipificacionID = item.intTipoTipificacionID,
                                    vchIdentificadorInterno = item.vchIdentificadorInterno,
                                    sintSistemaID = item.sintSistemaID,
                                    vchNombreSistema = item.vchNombreSistema,
                                    vchbitBloqueoUsuario = item.vchbitBloqueoUsuario,
                                    bitBloqueoUsuario = item.bitBloqueoUsuario,
                                    vchbitBloqueoProceso = item.vchbitBloqueProceso,
                                    bitBloqueoProceso = item.bitBloqueoProceso,                                    
                                    vchbitEnvioCorreo = item.vchbitEnvioCorreo,
                                    bitEnvioCorreo = item.bitEnvioCorreo,
                                    bitBitacora = item.bitBitacora,
                                    vchbitBitacora = item.vchbitBitacora,
                                    vchMensaje = item.vchMensaje,
                                    vchCorreosPara = item.vchCorreosPara,
                                    vchCorreosCC = item.vchCorreosCC
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

        public int editarConfiguracionPLD(ConfiguracionPLD _datos)
        {
            int? res = 0;
            try
            {
                using (ConfiguracionPLDDataContext dc = new ConfiguracionPLDDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDConfiguracionPLD(
                        ref res, (int)CRUD.actualizar, _datos.intTipoTipificacionID, _datos.sintSistemaID,
                        _datos.bitBloqueoUsuario, _datos.bitBloqueoProceso, _datos.bitEnvioCorreo, _datos.bitBitacora, _datos.vchMensaje,
                        _datos.vchCorreosPara, _datos.vchCorreosCC
                    );
                }               
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return res.Value;
        }

        public int eliminarConfiguracionPLD(int? @intTipoTipificacionID, Int16? sintSistemaID)
        {
            int? res = 0;
            try
            {
                using (ConfiguracionPLDDataContext dc = new ConfiguracionPLDDataContext(Helper.ConnectionString()))
                {
                    dc.stp_CRUDConfiguracionPLD(
                        ref res, (int)CRUD.eliminar, @intTipoTipificacionID, @sintSistemaID, null, null, null, null, null, null, null
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
