use dbPLD
if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_DET_Bitacora') and o.name = 'FK_TBL_DET_Bitacora_TBL_MST_Bitacora')
alter table tbl_DET_Bitacora
   drop constraint FK_TBL_DET_Bitacora_TBL_MST_Bitacora
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_DET_Bitacora') and o.name = 'FK_TBL_DET_Bitacora_TBL_MST_ListaNegra')
alter table tbl_DET_Bitacora
   drop constraint FK_TBL_DET_Bitacora_TBL_MST_ListaNegra
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_DET_Bitacora') and o.name = 'FK_TBL_DET_Bitacora_TBL_CAT_TipoTipificacion')
alter table tbl_DET_Bitacora
   drop constraint FK_TBL_DET_Bitacora_TBL_CAT_TipoTipificacion
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_DET_Bitacora')
            and   type = 'U')
   drop table tbl_DET_Bitacora
go

/*==============================================================*/
/* Table: tbl_DET_Bitacora                                      */
/*==============================================================*/
create table tbl_DET_Bitacora (
   intDetBitacoraID     int                  identity,
   intBitacoraID        int                  null,
   intTipoTipificacionID int                  null,
   intIdLN              int                  null,
   datFecha             date                 null,
   vchUsuario           varchar(50)          null,
   intSistemaID         int                  null,
   vchComentario        varchar(100)         null,
   constraint PK_TBL_DET_BITACORA primary key (intDetBitacoraID)
)
go

alter table tbl_DET_Bitacora
   add constraint FK_TBL_DET_Bitacora_TBL_MST_Bitacora foreign key (intBitacoraID)
      references tbl_MST_Bitacora (intBitacoraID)
go

alter table tbl_DET_Bitacora
   add constraint FK_TBL_DET_Bitacora_TBL_MST_ListaNegra foreign key (intIdLN)
      references tbl_MST_ListaNegra (intIdLN)
go

alter table tbl_DET_Bitacora
   add constraint FK_TBL_DET_Bitacora_TBL_CAT_TipoTipificacion foreign key (intTipoTipificacionID)
      references tbl_CAT_TipoTipificacion (intTipoTipificacionID)
go
