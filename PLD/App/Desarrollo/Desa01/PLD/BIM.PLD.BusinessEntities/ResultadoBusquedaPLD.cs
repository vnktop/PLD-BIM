using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class ResultadoBusquedaPLD
    {
        [DataMember]
        public string VCHIDQEQ { get; set; }
        [DataMember]
        public string VCHTIPOLISTA { get; set; }
        [DataMember]
        public int? intTipoTipificacionID { get; set; }
        [DataMember]
        public string vchIdentificadorInterno { get; set; }
        [DataMember]
        public string VCHNOMCOMPLETO { get; set; }
    }
}
