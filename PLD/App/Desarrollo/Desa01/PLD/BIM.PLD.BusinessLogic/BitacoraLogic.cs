using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BIM.BusinessEntities;
using BIM.DataAccess;

namespace BIM.PLD.BusinessLogic
{
    public class BitacoraLogic
    {
         #region Constructor de la clase

        private BitacoraPLDDataAccess BitacoraDA;

        public BitacoraLogic()
        {
            BitacoraDA = new BitacoraPLDDataAccess();
        }
        #endregion

        public List<BitacoraPLD> ListadoBusquedaBitacoraPLD(string vchUsuario, int? intSistema)
        {
            List<BitacoraPLD> _resultado = new List<BitacoraPLD>();
            try
            {
                _resultado = BitacoraDA.ListadoBusquedaBitacoraPLD(vchUsuario, intSistema);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
            return _resultado;
        }

        public bool desbloquearUsuario(desbloqueoBitacoraPLD parametros)
        {
            bool _res = false;
            try
            {
                _res = BitacoraDA.desbloquearUsuario(parametros);
            }
            catch (Exception ex)
            {                
                throw ex;
            }
            return _res;
        }
    }
}
