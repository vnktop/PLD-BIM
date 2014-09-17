using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


using System.ServiceModel;
using BIM.BusinessEntities;

namespace BIM.PLD.Services
{
    [ServiceContract]
    interface IVerificadorPLDServices
    {
        [OperationContract]
        VerificadorPLD ServicioVerificadorPLD(BitacoraPLD parametros);
    }
}
