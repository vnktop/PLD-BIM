using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class TipoLista
    {
        [DataMember]
        public string strTipoLista { get; set; }
    }
}
