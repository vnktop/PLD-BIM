using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class WSCaroline
    {
        
       
        [DataMember]
        public int? intTipoTipificacionID { get; set; }
        [DataMember]
        public int? intClienteID { get; set; }
        [DataMember]
        public int intPersonaID { get; set; }
        [DataMember]
        public int? intCalificacion { get; set; }

        
    }
}
