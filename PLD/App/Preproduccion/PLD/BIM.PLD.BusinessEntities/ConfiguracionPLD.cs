using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class ConfiguracionPLD
    {
        [DataMember]
        public int? intTipoTipificacionID { get; set; }
        [DataMember]
        public string vchIdentificadorInterno { get; set; }        
        [DataMember]
        public Int16? sintSistemaID { get; set; }
        [DataMember]
        public string vchNombreSistema { get; set; }
        [DataMember]
        public string vchbitBloqueoUsuario { get; set; }
        [DataMember]
        public bool? bitBloqueoUsuario { get; set; }
        [DataMember]
        public string vchbitBloqueoProceso { get; set; }
        [DataMember]
        public bool? bitBloqueoProceso { get; set; }
        [DataMember]
        public string vchbitEnvioCorreo { get; set; }
        [DataMember]
        public bool? bitEnvioCorreo { get; set; }
        [DataMember]
        public string vchbitBitacora { get; set; }
        [DataMember]
        public bool? bitBitacora { get; set; }
        [DataMember]
        public string vchMensaje { get; set; }
        [DataMember]
        public string vchCorreosPara { get; set; }
        [DataMember]
        public string vchCorreosCC { get; set; }
    }
}
