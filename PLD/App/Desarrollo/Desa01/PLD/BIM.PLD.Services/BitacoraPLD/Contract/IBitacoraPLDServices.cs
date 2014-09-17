using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.ServiceModel;
using BIM.BusinessEntities;

namespace BIM.PLD.Services
{
    [ServiceContract]
    interface IBitacoraPLDServices
    {
        [OperationContract]        
        List<BitacoraPLD> ListadoBusquedaBitacoraPLD(string vchUsuario, int? intSistema);

        [OperationContract]
        ServiceResult desbloquearUsuario(desbloqueoBitacoraPLD parametros);

        //[OperationContract]
        //ServiceResult editarBitacoraPLD(BitacoraPLD parametros);


    }
}
