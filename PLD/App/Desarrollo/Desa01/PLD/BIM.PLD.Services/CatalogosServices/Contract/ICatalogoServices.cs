using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.ServiceModel;
using BIM.BusinessEntities;

namespace BIM.PLD.Services
{
    [ServiceContract]
    interface ICatalogoServices
    {
        [OperationContract]
        List<Catalogo> ListarCatalogoTipoListaNegra();
        [OperationContract]
        List<Catalogo> ListadoCatAccionesPLD();
        [OperationContract]
        List<Catalogo> ListadoCatTipoLista();
        [OperationContract]
        List<Catalogo> ListaBusquedaInteligenteTipoTipificacion(string strDatos);
    }
}
