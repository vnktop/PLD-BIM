using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class desbloqueoBitacoraPLD
    {
        [DataMember]
        public int? intBitacoraID { get; set; }
        [DataMember]
        public bool? bitAutorizado { get; set; }
        [DataMember]
        public bool? bitProceso { get; set; }
        [DataMember]
        public bool? bitHomonimo { get; set; }
        [DataMember]
        public string vchUsuarioAutoriza { get; set; }
        [DataMember]
        public DateTime? datFechaAutorizacion { get; set; }
        [DataMember]
        public int? intVigenciaDias { get; set; }
        [DataMember]
        public string vchComentario { get; set; }
    }
}
