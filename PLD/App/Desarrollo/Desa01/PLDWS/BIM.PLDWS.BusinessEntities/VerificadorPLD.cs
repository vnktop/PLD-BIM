using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class VerificadorPLD
    {
        [DataMember]
        public int? Tipificacion { get; set; }
        [DataMember]
        public bool? BloqueoUsuario { get; set; }
        [DataMember]
        public bool? BloqueoProceso { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public bool? CreoBitacora { get; set; }
        [DataMember]
        public bool? EnvioCorreo { get; set; }
    }
}
