﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.1008
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BIM.PLD.DataAccess.Context
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="dbPLD")]
	public partial class BitacoraPLDDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Definiciones de métodos de extensibilidad
    partial void OnCreated();
    #endregion
		
		public BitacoraPLDDataContext() : 
				base(global::BIM.PLD.DataAccess.Properties.Settings.Default.dbPLDConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public BitacoraPLDDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public BitacoraPLDDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public BitacoraPLDDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public BitacoraPLDDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.stp_BusquedaRegistrosPLD")]
		public ISingleResult<stp_BusquedaRegistrosPLDResult> stp_BusquedaRegistrosPLD([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(80)")] string vchUsuario, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Int")] System.Nullable<int> intSistema)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), vchUsuario, intSistema);
			return ((ISingleResult<stp_BusquedaRegistrosPLDResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.stp_InsertarDesbloqueoPLD")]
		public ISingleResult<stp_InsertarDesbloqueoPLDResult> stp_InsertarDesbloqueoPLD([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Int")] ref System.Nullable<int> intResultado, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Int")] System.Nullable<int> intBitacoraID, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Bit")] System.Nullable<bool> bitAutorizado, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Bit")] System.Nullable<bool> bitProceso, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Bit")] System.Nullable<bool> bitHomonimo, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(50)")] string vchUsuarioAutoriza, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Date")] System.Nullable<System.DateTime> datFechaAutorizacion, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Int")] System.Nullable<int> intVigenciaDias, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(100)")] string vchComentario)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), intResultado, intBitacoraID, bitAutorizado, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion, intVigenciaDias, vchComentario);
			intResultado = ((System.Nullable<int>)(result.GetParameterValue(0)));
			return ((ISingleResult<stp_InsertarDesbloqueoPLDResult>)(result.ReturnValue));
		}
	}
	
	public partial class stp_BusquedaRegistrosPLDResult
	{
		
		private int _intBitacoraID;
		
		private System.Nullable<int> _intIdLN;
		
		private string _vchUsuario;
		
		private string _vchUsuarioNombre;
		
		private System.Nullable<int> _intSistemaID;
		
		private string _vchPersonaIncidencia;
		
		private string _vchNombre;
		
		private string _vchApPaterno;
		
		private string _vchApMaterno;
		
		private string _vchRelacionCliente;
		
		private string _vchComentario;
		
		private System.Nullable<bool> _bitAutorizado;
		
		private System.Nullable<bool> _bitProceso;
		
		private System.Nullable<System.DateTime> _datFecha;
		
		private System.Nullable<System.DateTime> _datFechaAutorizacion;
		
		private System.Nullable<bool> _bitHomonimo;
		
		private string _vchUsuarioAutoriza;
		
		private System.Nullable<bool> _bitEstatus;
		
		private string _vchNombreSistema;
		
		private string _vchTipoLista;
		
		private int _intTipoTipificacionID;
		
		private string _vchIdentificadorInterno;
		
		private System.Nullable<int> _intVigenciaDias;
		
		public stp_BusquedaRegistrosPLDResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_intBitacoraID", DbType="Int NOT NULL")]
		public int intBitacoraID
		{
			get
			{
				return this._intBitacoraID;
			}
			set
			{
				if ((this._intBitacoraID != value))
				{
					this._intBitacoraID = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_intIdLN", DbType="Int")]
		public System.Nullable<int> intIdLN
		{
			get
			{
				return this._intIdLN;
			}
			set
			{
				if ((this._intIdLN != value))
				{
					this._intIdLN = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchUsuario", DbType="VarChar(50) NOT NULL", CanBeNull=false)]
		public string vchUsuario
		{
			get
			{
				return this._vchUsuario;
			}
			set
			{
				if ((this._vchUsuario != value))
				{
					this._vchUsuario = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchUsuarioNombre", DbType="VarChar(152)")]
		public string vchUsuarioNombre
		{
			get
			{
				return this._vchUsuarioNombre;
			}
			set
			{
				if ((this._vchUsuarioNombre != value))
				{
					this._vchUsuarioNombre = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_intSistemaID", DbType="Int")]
		public System.Nullable<int> intSistemaID
		{
			get
			{
				return this._intSistemaID;
			}
			set
			{
				if ((this._intSistemaID != value))
				{
					this._intSistemaID = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchPersonaIncidencia", DbType="VarChar(500)")]
		public string vchPersonaIncidencia
		{
			get
			{
				return this._vchPersonaIncidencia;
			}
			set
			{
				if ((this._vchPersonaIncidencia != value))
				{
					this._vchPersonaIncidencia = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchNombre", DbType="VarChar(100)")]
		public string vchNombre
		{
			get
			{
				return this._vchNombre;
			}
			set
			{
				if ((this._vchNombre != value))
				{
					this._vchNombre = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchApPaterno", DbType="VarChar(100)")]
		public string vchApPaterno
		{
			get
			{
				return this._vchApPaterno;
			}
			set
			{
				if ((this._vchApPaterno != value))
				{
					this._vchApPaterno = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchApMaterno", DbType="VarChar(100)")]
		public string vchApMaterno
		{
			get
			{
				return this._vchApMaterno;
			}
			set
			{
				if ((this._vchApMaterno != value))
				{
					this._vchApMaterno = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchRelacionCliente", DbType="VarChar(100)")]
		public string vchRelacionCliente
		{
			get
			{
				return this._vchRelacionCliente;
			}
			set
			{
				if ((this._vchRelacionCliente != value))
				{
					this._vchRelacionCliente = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchComentario", DbType="VarChar(100)")]
		public string vchComentario
		{
			get
			{
				return this._vchComentario;
			}
			set
			{
				if ((this._vchComentario != value))
				{
					this._vchComentario = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_bitAutorizado", DbType="Bit")]
		public System.Nullable<bool> bitAutorizado
		{
			get
			{
				return this._bitAutorizado;
			}
			set
			{
				if ((this._bitAutorizado != value))
				{
					this._bitAutorizado = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_bitProceso", DbType="Bit")]
		public System.Nullable<bool> bitProceso
		{
			get
			{
				return this._bitProceso;
			}
			set
			{
				if ((this._bitProceso != value))
				{
					this._bitProceso = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_datFecha", DbType="Date")]
		public System.Nullable<System.DateTime> datFecha
		{
			get
			{
				return this._datFecha;
			}
			set
			{
				if ((this._datFecha != value))
				{
					this._datFecha = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_datFechaAutorizacion", DbType="DateTime")]
		public System.Nullable<System.DateTime> datFechaAutorizacion
		{
			get
			{
				return this._datFechaAutorizacion;
			}
			set
			{
				if ((this._datFechaAutorizacion != value))
				{
					this._datFechaAutorizacion = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_bitHomonimo", DbType="Bit")]
		public System.Nullable<bool> bitHomonimo
		{
			get
			{
				return this._bitHomonimo;
			}
			set
			{
				if ((this._bitHomonimo != value))
				{
					this._bitHomonimo = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchUsuarioAutoriza", DbType="VarChar(50)")]
		public string vchUsuarioAutoriza
		{
			get
			{
				return this._vchUsuarioAutoriza;
			}
			set
			{
				if ((this._vchUsuarioAutoriza != value))
				{
					this._vchUsuarioAutoriza = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_bitEstatus", DbType="Bit")]
		public System.Nullable<bool> bitEstatus
		{
			get
			{
				return this._bitEstatus;
			}
			set
			{
				if ((this._bitEstatus != value))
				{
					this._bitEstatus = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchNombreSistema", DbType="VarChar(100)")]
		public string vchNombreSistema
		{
			get
			{
				return this._vchNombreSistema;
			}
			set
			{
				if ((this._vchNombreSistema != value))
				{
					this._vchNombreSistema = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchTipoLista", DbType="NVarChar(10)")]
		public string vchTipoLista
		{
			get
			{
				return this._vchTipoLista;
			}
			set
			{
				if ((this._vchTipoLista != value))
				{
					this._vchTipoLista = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_intTipoTipificacionID", DbType="Int NOT NULL")]
		public int intTipoTipificacionID
		{
			get
			{
				return this._intTipoTipificacionID;
			}
			set
			{
				if ((this._intTipoTipificacionID != value))
				{
					this._intTipoTipificacionID = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchIdentificadorInterno", DbType="VarChar(25)")]
		public string vchIdentificadorInterno
		{
			get
			{
				return this._vchIdentificadorInterno;
			}
			set
			{
				if ((this._vchIdentificadorInterno != value))
				{
					this._vchIdentificadorInterno = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_intVigenciaDias", DbType="Int")]
		public System.Nullable<int> intVigenciaDias
		{
			get
			{
				return this._intVigenciaDias;
			}
			set
			{
				if ((this._intVigenciaDias != value))
				{
					this._intVigenciaDias = value;
				}
			}
		}
	}
	
	public partial class stp_InsertarDesbloqueoPLDResult
	{
		
		private System.Nullable<int> _Column1;
		
		public stp_InsertarDesbloqueoPLDResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Name="", Storage="_Column1", DbType="Int")]
		public System.Nullable<int> Column1
		{
			get
			{
				return this._Column1;
			}
			set
			{
				if ((this._Column1 != value))
				{
					this._Column1 = value;
				}
			}
		}
	}
}
#pragma warning restore 1591
