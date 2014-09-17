using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class Proveedor
    {
        [DataMember]
        public int iProveedorId { get; set; }
        [DataMember]
        public string strNombre { get; set; }
        [DataMember]
        public int iEstatus { get; set; }
    }
}
