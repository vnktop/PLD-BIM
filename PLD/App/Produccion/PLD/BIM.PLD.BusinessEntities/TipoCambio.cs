using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
namespace BIM.BusinessEntities
{
    [DataContract]
    public class TipoCambio
    {
        [DataMember]
        public int iTipoMoneda { get; set; }
        [DataMember]
        public string strTipoMoneda { get; set; }
        [DataMember]
        public int iTipoCambio { get; set; }
        [DataMember]
        public string strTipoCambio { get; set; }
        [DataMember]
        public decimal decValorCambio { get; set; }
        [DataMember]
        public DateTime datFechaCierre { get; set; }
    }
}
