if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_CAT_TipoListaNegra') and o.name = 'FK_TIPOLISTANEGRA_TIPOTIPI')
alter table tbl_CAT_TipoListaNegra
   drop constraint FK_TIPOLISTANEGRA_TIPOTIPI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_MST_WSCaroline') and o.name = 'FK_TBL_MST__REFERENCE_TBL_CAT_')
alter table tbl_MST_WSCaroline
   drop constraint FK_TBL_MST__REFERENCE_TBL_CAT_
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_REL_AccionPLDListaNegra') and o.name = 'FK_AccionPLD_CATTipoTipificacion')
alter table tbl_REL_AccionPLDListaNegra
   drop constraint FK_AccionPLD_CATTipoTipificacion
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_CAT_TipoTipificacion')
            and   type = 'U')
   drop table tbl_CAT_TipoTipificacion
go

/*==============================================================*/
/* Table: tbl_CAT_TipoTipificacion                              */
/*==============================================================*/
create table tbl_CAT_TipoTipificacion (
   intTipoTipificacionID int                  identity,
   vchDescripcion       varchar(25)          null,
   constraint PK_TBL_CAT_TIPOTIPIFICACION primary key (intTipoTipificacionID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('tbl_CAT_TipoTipificacion') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'tbl_CAT_TipoTipificacion' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Catálogo para enlistar los tipos de Tipificación
   
   1.-Normal
   2.-Pep
   3.-Venc
   4.-Negra
   5.-Indefinido', 
   'user', @CurrentUser, 'table', 'tbl_CAT_TipoTipificacion'
go
