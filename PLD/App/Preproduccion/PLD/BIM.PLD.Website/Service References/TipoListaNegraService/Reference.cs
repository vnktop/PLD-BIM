﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.586
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BIM.PLD.Website.TipoListaNegraService {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="CatTipoListaNegra", Namespace="http://schemas.datacontract.org/2004/07/BIM.BusinessEntities")]
    [System.SerializableAttribute()]
    public partial class CatTipoListaNegra : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string VCDDESCRIPCIONField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> intTipoListaIDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> intTipoTipificacionIDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string vchPaisField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string vchTipoListaField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string vchTipoTipificacionField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string VCDDESCRIPCION {
            get {
                return this.VCDDESCRIPCIONField;
            }
            set {
                if ((object.ReferenceEquals(this.VCDDESCRIPCIONField, value) != true)) {
                    this.VCDDESCRIPCIONField = value;
                    this.RaisePropertyChanged("VCDDESCRIPCION");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> intTipoListaID {
            get {
                return this.intTipoListaIDField;
            }
            set {
                if ((this.intTipoListaIDField.Equals(value) != true)) {
                    this.intTipoListaIDField = value;
                    this.RaisePropertyChanged("intTipoListaID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> intTipoTipificacionID {
            get {
                return this.intTipoTipificacionIDField;
            }
            set {
                if ((this.intTipoTipificacionIDField.Equals(value) != true)) {
                    this.intTipoTipificacionIDField = value;
                    this.RaisePropertyChanged("intTipoTipificacionID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string vchPais {
            get {
                return this.vchPaisField;
            }
            set {
                if ((object.ReferenceEquals(this.vchPaisField, value) != true)) {
                    this.vchPaisField = value;
                    this.RaisePropertyChanged("vchPais");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string vchTipoLista {
            get {
                return this.vchTipoListaField;
            }
            set {
                if ((object.ReferenceEquals(this.vchTipoListaField, value) != true)) {
                    this.vchTipoListaField = value;
                    this.RaisePropertyChanged("vchTipoLista");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string vchTipoTipificacion {
            get {
                return this.vchTipoTipificacionField;
            }
            set {
                if ((object.ReferenceEquals(this.vchTipoTipificacionField, value) != true)) {
                    this.vchTipoTipificacionField = value;
                    this.RaisePropertyChanged("vchTipoTipificacion");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="ServiceResult", Namespace="http://schemas.datacontract.org/2004/07/BIM.BusinessEntities")]
    [System.SerializableAttribute()]
    [System.Runtime.Serialization.KnownTypeAttribute(typeof(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra))]
    [System.Runtime.Serialization.KnownTypeAttribute(typeof(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra[]))]
    public partial class ServiceResult : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ErrorMessageField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private object ResultValueField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private bool ServiceOkField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ErrorMessage {
            get {
                return this.ErrorMessageField;
            }
            set {
                if ((object.ReferenceEquals(this.ErrorMessageField, value) != true)) {
                    this.ErrorMessageField = value;
                    this.RaisePropertyChanged("ErrorMessage");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public object ResultValue {
            get {
                return this.ResultValueField;
            }
            set {
                if ((object.ReferenceEquals(this.ResultValueField, value) != true)) {
                    this.ResultValueField = value;
                    this.RaisePropertyChanged("ResultValue");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool ServiceOk {
            get {
                return this.ServiceOkField;
            }
            set {
                if ((this.ServiceOkField.Equals(value) != true)) {
                    this.ServiceOkField = value;
                    this.RaisePropertyChanged("ServiceOk");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="TipoListaNegraService.ITipoListaNegra")]
    public interface ITipoListaNegra {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITipoListaNegra/InsertarTipoListaNegra", ReplyAction="http://tempuri.org/ITipoListaNegra/InsertarTipoListaNegraResponse")]
        BIM.PLD.Website.TipoListaNegraService.ServiceResult InsertarTipoListaNegra(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra oCatTipoListaNegra);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITipoListaNegra/ListadoBusquedaTipoListaNegra", ReplyAction="http://tempuri.org/ITipoListaNegra/ListadoBusquedaTipoListaNegraResponse")]
        BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra[] ListadoBusquedaTipoListaNegra(System.Nullable<int> intTipoTipificacionID, string vchTipoLista);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITipoListaNegra/editarTipoListaNegra", ReplyAction="http://tempuri.org/ITipoListaNegra/editarTipoListaNegraResponse")]
        BIM.PLD.Website.TipoListaNegraService.ServiceResult editarTipoListaNegra(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra _datos);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITipoListaNegra/eliminarTipoListaNegra", ReplyAction="http://tempuri.org/ITipoListaNegra/eliminarTipoListaNegraResponse")]
        BIM.PLD.Website.TipoListaNegraService.ServiceResult eliminarTipoListaNegra(System.Nullable<int> intTipoListaID);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITipoListaNegra/LeerExisteciaRegistroTipoListaNegra", ReplyAction="http://tempuri.org/ITipoListaNegra/LeerExisteciaRegistroTipoListaNegraResponse")]
        BIM.PLD.Website.TipoListaNegraService.ServiceResult LeerExisteciaRegistroTipoListaNegra(System.Nullable<int> intTipoTipificacionID, string vchTipoLista);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITipoListaNegra/InsertarTipoTipificacion", ReplyAction="http://tempuri.org/ITipoListaNegra/InsertarTipoTipificacionResponse")]
        BIM.PLD.Website.TipoListaNegraService.ServiceResult InsertarTipoTipificacion(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra oCatTipoListaNegra);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITipoListaNegra/editarTipoTipificacion", ReplyAction="http://tempuri.org/ITipoListaNegra/editarTipoTipificacionResponse")]
        BIM.PLD.Website.TipoListaNegraService.ServiceResult editarTipoTipificacion(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra _datos);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITipoListaNegra/LeerExisteciaRegistroTipoTipificacion", ReplyAction="http://tempuri.org/ITipoListaNegra/LeerExisteciaRegistroTipoTipificacionResponse")]
        BIM.PLD.Website.TipoListaNegraService.ServiceResult LeerExisteciaRegistroTipoTipificacion(string VCDDESCRIPCION);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface ITipoListaNegraChannel : BIM.PLD.Website.TipoListaNegraService.ITipoListaNegra, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class TipoListaNegraClient : System.ServiceModel.ClientBase<BIM.PLD.Website.TipoListaNegraService.ITipoListaNegra>, BIM.PLD.Website.TipoListaNegraService.ITipoListaNegra {
        
        public TipoListaNegraClient() {
        }
        
        public TipoListaNegraClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public TipoListaNegraClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public TipoListaNegraClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public TipoListaNegraClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public BIM.PLD.Website.TipoListaNegraService.ServiceResult InsertarTipoListaNegra(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra oCatTipoListaNegra) {
            return base.Channel.InsertarTipoListaNegra(oCatTipoListaNegra);
        }
        
        public BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra[] ListadoBusquedaTipoListaNegra(System.Nullable<int> intTipoTipificacionID, string vchTipoLista) {
            return base.Channel.ListadoBusquedaTipoListaNegra(intTipoTipificacionID, vchTipoLista);
        }
        
        public BIM.PLD.Website.TipoListaNegraService.ServiceResult editarTipoListaNegra(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra _datos) {
            return base.Channel.editarTipoListaNegra(_datos);
        }
        
        public BIM.PLD.Website.TipoListaNegraService.ServiceResult eliminarTipoListaNegra(System.Nullable<int> intTipoListaID) {
            return base.Channel.eliminarTipoListaNegra(intTipoListaID);
        }
        
        public BIM.PLD.Website.TipoListaNegraService.ServiceResult LeerExisteciaRegistroTipoListaNegra(System.Nullable<int> intTipoTipificacionID, string vchTipoLista) {
            return base.Channel.LeerExisteciaRegistroTipoListaNegra(intTipoTipificacionID, vchTipoLista);
        }
        
        public BIM.PLD.Website.TipoListaNegraService.ServiceResult InsertarTipoTipificacion(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra oCatTipoListaNegra) {
            return base.Channel.InsertarTipoTipificacion(oCatTipoListaNegra);
        }
        
        public BIM.PLD.Website.TipoListaNegraService.ServiceResult editarTipoTipificacion(BIM.PLD.Website.TipoListaNegraService.CatTipoListaNegra _datos) {
            return base.Channel.editarTipoTipificacion(_datos);
        }
        
        public BIM.PLD.Website.TipoListaNegraService.ServiceResult LeerExisteciaRegistroTipoTipificacion(string VCDDESCRIPCION) {
            return base.Channel.LeerExisteciaRegistroTipoTipificacion(VCDDESCRIPCION);
        }
    }
}
