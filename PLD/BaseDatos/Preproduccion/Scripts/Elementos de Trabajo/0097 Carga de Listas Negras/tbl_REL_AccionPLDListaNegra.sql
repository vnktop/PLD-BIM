if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_REL_AccionPLDListaNegra') and o.name = 'FK_ACCIONPLD_TIPOLISTA')
alter table tbl_REL_AccionPLDListaNegra
   drop constraint FK_ACCIONPLD_TIPOLISTA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_REL_AccionPLDListaNegra') and o.name = 'FK_AccionPLD_CATTipoTipificacion')
alter table tbl_REL_AccionPLDListaNegra
   drop constraint FK_AccionPLD_CATTipoTipificacion
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_REL_AccionPLDListaNegra')
            and   type = 'U')
   drop table tbl_REL_AccionPLDListaNegra
go

/*==============================================================*/
/* Table: tbl_REL_AccionPLDListaNegra                           */
/*==============================================================*/
create table tbl_REL_AccionPLDListaNegra (
   intTipoTipificacionID int                  not null,
   sintSistemaID        smallint             not null,
   bitBloqueoUsuario    bit                  null,
   bitBloqueoProceso    bit                  null,
   bitEnvioCorreo       bit                  null,
   bitBitacora          bit                  null,
   vchMensaje           varchar(100)         null,
   vchCorreosPara       varchar(256)         null,
   vchCorreosCC         varchar(256)         null,
   BITESTATUS           bit                  null default 1,
   constraint PK_TBL_REL_ACCIONPLDLISTANEGRA primary key (intTipoTipificacionID, sintSistemaID)
)
go

alter table tbl_REL_AccionPLDListaNegra
   add constraint FK_ACCIONPLD_TIPOLISTA foreign key ()
      references tbl_CAT_TipoListaNegra
go

alter table tbl_REL_AccionPLDListaNegra
   add constraint FK_AccionPLD_CATTipoTipificacion foreign key (intTipoTipificacionID)
      references tbl_CAT_TipoTipificacion (intTipoTipificacionID)
go