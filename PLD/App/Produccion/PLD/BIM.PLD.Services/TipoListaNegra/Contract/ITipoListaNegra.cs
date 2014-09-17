using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.ServiceModel;
using BIM.BusinessEntities;

namespace BIM.PLD.Services
{
    [ServiceContract]
    interface ITipoListaNegra
    {
        [OperationContract]
        ServiceResult InsertarTipoListaNegra(CatTipoListaNegra oCatTipoListaNegra);
        [OperationContract]
        List<CatTipoListaNegra> ListadoBusquedaTipoListaNegra(int? @intTipoTipificacionID, string @vchTipoLista);
        [OperationContract]
        ServiceResult editarTipoListaNegra(CatTipoListaNegra _datos);
        [OperationContract]
        ServiceResult eliminarTipoListaNegra(int? intTipoListaID);
        [OperationContract]
        ServiceResult LeerExisteciaRegistroTipoListaNegra(int? @intTipoTipificacionID, string @vchTipoLista);
        [OperationContract]
        ServiceResult InsertarTipoTipificacion(CatTipoListaNegra oCatTipoListaNegra);
        [OperationContract]
        ServiceResult editarTipoTipificacion(CatTipoListaNegra _datos);
        [OperationContract]
        ServiceResult LeerExisteciaRegistroTipoTipificacion(string @VCDDESCRIPCION);
    }
}
