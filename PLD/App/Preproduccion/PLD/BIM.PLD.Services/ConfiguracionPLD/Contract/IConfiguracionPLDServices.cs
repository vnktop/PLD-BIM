using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.ServiceModel;
using BIM.BusinessEntities;

namespace BIM.PLD.Services
{
    [ServiceContract]
    interface IConfiguracionPLDServices
    {
        [OperationContract]
        ServiceResult InsertarConfiguracionPLD(ConfiguracionPLD oConfiguracionPLD);
        [OperationContract]
        List<ConfiguracionPLD> ListadoBusquedaConfiguracionPLD(int? @intTipoTipificacionID, Int16? sintSistemaID);
        [OperationContract]
        ServiceResult editarConfiguracionPLD(ConfiguracionPLD _datos);
        [OperationContract]
        ServiceResult eliminarConfiguracionPLD(int? @intTipoTipificacionID, Int16? sintSistemaID);
    }
}
