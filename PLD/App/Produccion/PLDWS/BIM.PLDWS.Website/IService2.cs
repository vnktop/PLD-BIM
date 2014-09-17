using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using BIM.PLDWS.BusinessLogic;
using BIM.BusinessEntities;

namespace BIM.PLDWS.Website
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IService2" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IService2
    {
        [OperationContract]
        BIM.BusinessEntities.VerificadorPLD ServicioVerificadorPLD(BitacoraPLD _datos);
    }
}
