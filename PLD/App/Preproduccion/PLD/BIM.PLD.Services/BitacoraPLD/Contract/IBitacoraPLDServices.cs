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
        List<BitacoraPLD> ListadoBusquedaBitacoraPLD(BitacoraPLD bitacora);

        [OperationContract]
        ServiceResult desbloquearUsuario(BitacoraPLD parametros);

        [OperationContract]
        ServiceResult editarBitacoraPLD(BitacoraPLD parametros);


    }
}
