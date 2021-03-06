﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.296
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
	public partial class TipoListaNegraDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Definiciones de métodos de extensibilidad
    partial void OnCreated();
    #endregion
		
		public TipoListaNegraDataContext() :
        base(global::BIM.PLD.DataAccess.Properties.Settings.Default.dbPLDConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public TipoListaNegraDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public TipoListaNegraDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public TipoListaNegraDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public TipoListaNegraDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.stp_CRUDTipoListaNegra")]
		public ISingleResult<stp_CRUDTipoListaNegraResult> stp_CRUDTipoListaNegra([global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Int")] ref System.Nullable<int> intResultado, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Int")] System.Nullable<int> intAccion, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Int")] System.Nullable<int> intTipoListaID, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(5)")] string vchTipoLista, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="Int")] System.Nullable<int> intTipoTipificacionID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="VCDDESCRIPCION", DbType="VarChar(256)")] string vCDDESCRIPCION, [global::System.Data.Linq.Mapping.ParameterAttribute(DbType="VarChar(50)")] string vchPais)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), intResultado, intAccion, intTipoListaID, vchTipoLista, intTipoTipificacionID, vCDDESCRIPCION, vchPais);
			intResultado = ((System.Nullable<int>)(result.GetParameterValue(0)));
			return ((ISingleResult<stp_CRUDTipoListaNegraResult>)(result.ReturnValue));
		}
	}
	
	public partial class stp_CRUDTipoListaNegraResult
	{
		
		private int _intTipoListaID;
		
		private string _vchTipoLista;
		
		private System.Nullable<int> _intTipoTipificacionID;
		
		private string _vchTipoTipificacion;
		
		private string _VCDDESCRIPCION;
		
		private string _vchPais;
		
		public stp_CRUDTipoListaNegraResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_intTipoListaID", DbType="Int NOT NULL")]
		public int intTipoListaID
		{
			get
			{
				return this._intTipoListaID;
			}
			set
			{
				if ((this._intTipoListaID != value))
				{
					this._intTipoListaID = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchTipoLista", DbType="VarChar(5) NOT NULL", CanBeNull=false)]
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_intTipoTipificacionID", DbType="Int")]
		public System.Nullable<int> intTipoTipificacionID
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchTipoTipificacion", DbType="VarChar(25)")]
		public string vchTipoTipificacion
		{
			get
			{
				return this._vchTipoTipificacion;
			}
			set
			{
				if ((this._vchTipoTipificacion != value))
				{
					this._vchTipoTipificacion = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_VCDDESCRIPCION", DbType="VarChar(256)")]
		public string VCDDESCRIPCION
		{
			get
			{
				return this._VCDDESCRIPCION;
			}
			set
			{
				if ((this._VCDDESCRIPCION != value))
				{
					this._VCDDESCRIPCION = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_vchPais", DbType="VarChar(50)")]
		public string vchPais
		{
			get
			{
				return this._vchPais;
			}
			set
			{
				if ((this._vchPais != value))
				{
					this._vchPais = value;
				}
			}
		}
	}
}
#pragma warning restore 1591
