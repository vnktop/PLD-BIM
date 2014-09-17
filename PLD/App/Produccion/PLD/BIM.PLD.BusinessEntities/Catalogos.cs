using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class Catalogo
    {
        [DataMember]
        public int intCatalogoID { get; set; }

        [DataMember]
        public string vchClaveCNBV { get; set; }

        [DataMember]
        public string vchDescripcion { get; set; }

        [DataMember]
        public bool blPadre { get; set; }
    }
   
}
