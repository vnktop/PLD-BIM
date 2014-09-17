using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace BIM.BusinessEntities
{
    [DataContract]
    public class ServiceResult
    {
        public ServiceResult()
        {
            ServiceOk = false;
            ResultValue = null;
            ErrorMessage = string.Empty;
        }

        [DataMember]
        public bool ServiceOk { get; set; }
        [DataMember]
        public object ResultValue { get; set; }
        [DataMember]
        public string ErrorMessage { get; set; }
    }
}

