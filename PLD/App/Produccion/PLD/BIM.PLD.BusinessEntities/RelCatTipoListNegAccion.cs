using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class RelCatTipoListNegAccion
    {
       
        [DataMember]
        public string VCHTIPOLISTA { get; set; }
        [DataMember]
        public int? INTACCIONPLDID { get; set; }
        [DataMember]
        public Int16? sintSistemaID { get; set; }
        [DataMember]
        public bool? BITESTATUS { get; set; }
    }
}
