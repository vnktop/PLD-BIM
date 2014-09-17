using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Transactions;
using BIM.BusinessEntities;
using BIM.DataAccess;

namespace BIM.PLDWS.BusinessLogic
{
    public class VerificadorPLDLogic
    {
        #region Constructor de la clase

        private VerificadorPLDDataAccess VerificadorPLDDA;

        public VerificadorPLDLogic()
        {
            VerificadorPLDDA = new VerificadorPLDDataAccess();
        }
        #endregion

        public VerificadorPLD ServicioVerificadorPLD(BitacoraPLD parametros)
        {
            VerificadorPLD result = null;
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                result = VerificadorPLDDA.ServicioVerificadorPLD(parametros);
                //    tx.Complete();
                //}
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        //public List<BitacoraPLD> ListadoBusquedaBitacoraPLD(BitacoraPLD bitacora)
        //{
        //    List<BitacoraPLD> result = null;
        //    try
        //    {
        //        //using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
        //        //{
        //        result = VerificadorPLDDA.ListadoBusquedaBitacoraPLD(bitacora);
        //        //    ts.Complete();
        //        //}
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    return result;
        //} //Opción 2   leerBusqueda = 2

        public List<BitacoraPLD> TotalCorreo(BitacoraPLD parametros)//Opción 3   leerTotalCorreo = 3
        {
            List<BitacoraPLD> result = null;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    result = VerificadorPLDDA.TotalCorreo();
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public int DesbloquearUsuario(BitacoraPLD parametros)//Opción 4   desbloquearUsuario = 4,
        {
            int? RegistroUpdate = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroUpdate = VerificadorPLDDA.desbloquearUsuario(parametros);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return RegistroUpdate.Value;
        }

        public int editarBitacoraPLD(BitacoraPLD parametros)//Opción 5   actualizar = 5
        {
            int? RegistroUpdate = 0;
            try
            {
                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required))
                {
                    RegistroUpdate = VerificadorPLDDA.editarBitacoraPLD(parametros);
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }

            return RegistroUpdate.Value;
        }





    }
}
