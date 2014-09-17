using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class BitacoraPLD
    {       
        [DataMember]
        public int? intBitacoraID { get; set; }
        //[DataMember]
        //public string vchidqeq { get; set; }
        //Nueva relación de BD, NRBD
        public int? intIdLN { get; set; }
        [DataMember]
        public string vchUsuario { get; set; }
        [DataMember]
        public string vchUsuarioNombre { get; set; }
        //[DataMember]
        //public string vchSucursal { get; set; }
        [DataMember]
        //public int? intSistema { get; set; }
        public int? intSistemaID { get; set; }
        [DataMember]
        public string vchPersonaIncidencia { get; set; }
        //[DataMember]
        //public string vchNombreCompleto { get; set; }
        [DataMember]
        public string vchNombre { get; set; }
        [DataMember]
        public string vchApPaterno { get; set; }
        [DataMember]
        public string vchApMaterno { get; set; }
        //[DataMember]
        //public string vchNombreBusq { get; set; }
        //[DataMember]
        //public string vchCliente { get; set; }
        [DataMember]
        public string vchRelacionCliente { get; set; }
        [DataMember]
        public string vchComentario { get; set; }
        [DataMember]
        //public bool? bitAutorizaProc { get; set; }
        public bool? bitAutorizado { get; set; }
        [DataMember]
        public bool? bitProceso { get; set; }
        [DataMember]
        public DateTime? datFecha { get; set; }
        [DataMember]
        //public DateTime? datFechaRespuesta { get; set; }
        public DateTime? datFechaAutorizacion { get; set; }
        [DataMember]
        public bool? bitHomonimo { get; set; }
        [DataMember]
        //public string vchUsuarioAudit { get; set; }
        public string vchUsuarioAutoriza { get; set; }
        [DataMember]
        public bool? bitEstatus { get; set; }
        [DataMember]
        public string vchNombreSistema { get; set; }
        [DataMember]
        public string vchTipoLista { get; set; }
        [DataMember]
        public int? intTipoTipificacionID { get; set; }
        [DataMember]
        public string vchIdentificadorInterno { get; set; }
        //NRBD
        [DataMember]
        public int? intVigenciaDias { get; set; }

        [DataMember]
        public int? TotalCorreo { get; set; }
        [DataMember]
        public string vchCorreoHCM { get; set; }
        [DataMember]
        public bool? bitHistorial { get; set; }
        
        

        
    }
}
