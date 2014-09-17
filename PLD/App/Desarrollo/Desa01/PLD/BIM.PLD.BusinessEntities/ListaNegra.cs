using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class ListaNegra
    {
        [DataMember]
        public int INTLISTANEGRAID { get; set; }
        [DataMember]
        public string VCHTIPOLISTA { get; set; }
        [DataMember]
        public string VCHIDQEQ { get; set; }
        [DataMember]
        public string VCHNOMBRE { get; set; }
        [DataMember]
        public string VCHAPPATERNO { get; set; }
        [DataMember]
        public string VCHAPMATERNO { get; set; }
        [DataMember]
        public string VCHCURP { get; set; }
        [DataMember]
        public string VCHRFC { get; set; }
        [DataMember]
        public string VCHFECHANAC { get; set; }
        [DataMember]
        public string VCHESTATUS { get; set; }
        [DataMember]
        public string VCHDEPENDENCIA { get; set; }
        [DataMember]
        public string VCHPUESTO { get; set; }
        [DataMember]
        public string INTIDDISPO { get; set; }
        [DataMember]
        public string BITCURPOK { get; set; }
        [DataMember]
        public string VCHIDREL { get; set; }
        [DataMember]
        public string VCHPARENTESCO { get; set; }
        [DataMember]
        public string VCHRAZONSOCIAL { get; set; }
        [DataMember]
        public string VCHRFCMORAL { get; set; }
        [DataMember]
        public string VCHISSSTE { get; set; }
        [DataMember]
        public string VCHIMSS { get; set; }
        [DataMember]
        public string VCHINGRESOS { get; set; }
        [DataMember]
        public string VCHNOMCOMPLETO { get; set; }
        [DataMember]
        public string VCHAPELLIDOS { get; set; }
        [DataMember]
        public string VCHENTIDAD { get; set; }
        [DataMember]
        public string VCHGENERO { get; set; }
        [DataMember]
        public string AUDUSUARIO { get; set; }
        //[DataMember]
        //public DateTime? SDATFECHAINS { get; set; }
        [DataMember]
        public string VCHTIPOLISTANEGRA { get; set; }
        [DataMember]
        public string vchCadenaNPM { get; set; }
        [DataMember]
        public string vchCadenaNMP { get; set; }
        [DataMember]
        public string iProveedorId { get; set; }
    }
}
