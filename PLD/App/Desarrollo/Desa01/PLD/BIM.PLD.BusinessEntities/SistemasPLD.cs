using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class SistemasPLD
    {
        [DataMember]
        public Int16? sintSistemaID { get; set; }
        [DataMember]
        public string vchNombre { get; set; }
        [DataMember]
        public string vchDescripcion { get; set; }
        [DataMember]
        public int conf { get; set; }

    }
}
