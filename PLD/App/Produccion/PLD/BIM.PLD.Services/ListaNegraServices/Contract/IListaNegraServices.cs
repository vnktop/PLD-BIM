using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.ServiceModel;
using BIM.BusinessEntities;

namespace BIM.PLD.Services
{
    [ServiceContract]
    interface IListaNegraServices
    {
        [OperationContract]
        ServiceResult InsertarListaNegra(ListaNegra oListaNegra);

        //[OperationContract]
        //List<ListaNegra> BusquedaListaNegra(int iTipoListaNegra);
        [OperationContract]
        ServiceResult CargaListasNegras(int iProveedorId);
      
        [OperationContract]
        List<SistemasPLD> ListarSistemasPLD();

        [OperationContract]
        ServiceResult almacenarArchivo(string fuente, string destino, string archivo);

        [OperationContract]
        List<Proveedor> ListarProveedores();

        [OperationContract]
        ServiceResult insertarProveedor(string proveedor);
    }
}
