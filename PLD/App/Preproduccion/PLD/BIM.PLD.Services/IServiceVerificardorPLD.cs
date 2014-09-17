using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using BIM.BusinessEntities;

namespace BIM.PLD.Services
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IServiceVerificardorPLD" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IServiceVerificardorPLD
    {
        [OperationContract]
        VerificadorPLD ServicioVerificadorPLD(BitacoraPLD parametros);

    }
}
