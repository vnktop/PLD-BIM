if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_CAT_TipoListaNegra') and o.name = 'FK_TIPOLISTANEGRA_TIPOTIPI')
alter table tbl_CAT_TipoListaNegra
   drop constraint FK_TIPOLISTANEGRA_TIPOTIPI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_MST_ListaNegra') and o.name = 'FK_LISTANEGRA_TIPOLISTA')
alter table tbl_MST_ListaNegra
   drop constraint FK_LISTANEGRA_TIPOLISTA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_REL_AccionPLDListaNegra') and o.name = 'FK_ACCIONPLD_TIPOLISTA')
alter table tbl_REL_AccionPLDListaNegra
   drop constraint FK_ACCIONPLD_TIPOLISTA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_CAT_TipoListaNegra')
            and   type = 'U')
   drop table tbl_CAT_TipoListaNegra
go

/*==============================================================*/
/* Table: tbl_CAT_TipoListaNegra                                */
/*==============================================================*/
create table tbl_CAT_TipoListaNegra (
   intTipoListaID       int                  identity,
   vchTipoLista         varchar(5)           not null,
   intTipoTipificacionID int                  null,
   VCDDESCRIPCION       varchar(256)         null,
   vchPais              varchar(50)          null,
   BITESTATUS           bit                  null default 1,
   constraint PK_TBL_CAT_TIPOLISTANEGRA primary key (vchTipoLista)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('tbl_CAT_TipoListaNegra') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'tbl_CAT_TipoListaNegra' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Entidad para enlistar los tipos de listas negras que existen', 
   'user', @CurrentUser, 'table', 'tbl_CAT_TipoListaNegra'
go

alter table tbl_CAT_TipoListaNegra
   add constraint FK_TIPOLISTANEGRA_TIPOTIPI foreign key (intTipoTipificacionID)
      references tbl_CAT_TipoTipificacion (intTipoTipificacionID)
go
