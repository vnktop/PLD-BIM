using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class CatTipoListaNegra
    {        
        [DataMember]
        public int? intTipoListaID { get; set; }
        [DataMember]
        public string vchTipoLista { get; set; }
        [DataMember]       
        public int? intTipoTipificacionID { get; set; }
        [DataMember]
        public string vchTipoTipificacion { get; set; }       
        [DataMember]
        public string VCDDESCRIPCION { get; set; }
        [DataMember]
        public string vchPais { get; set; }
    }
}
