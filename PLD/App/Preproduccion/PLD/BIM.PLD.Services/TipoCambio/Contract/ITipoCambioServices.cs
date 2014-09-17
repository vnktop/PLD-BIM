using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using BIM.BusinessEntities;

namespace BIM.PLD.Services
{
    [ServiceContract]
    interface ITipoCambioServices
    {
        [OperationContract]
        List<TipoCambio> getListadoTipoCambio();
        [OperationContract]
        int insertaTCManual(TipoCambio modelo);
        [OperationContract]
        int insertaTCAutomatico(List<TipoCambio> lst);
    }
}
