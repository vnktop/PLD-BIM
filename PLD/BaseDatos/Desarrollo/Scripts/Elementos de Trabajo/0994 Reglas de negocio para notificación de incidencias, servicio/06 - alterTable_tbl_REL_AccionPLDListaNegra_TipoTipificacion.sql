use dbPLD
if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_REL_AccionPLDListaNegra') and o.name = 'FK_AccionPLD_CATTipoTipificacion')
alter table tbl_REL_AccionPLDListaNegra
   drop constraint FK_AccionPLD_CATTipoTipificacion
go

alter table tbl_REL_AccionPLDListaNegra
   add constraint FK_AccionPLD_CATTipoTipificacion foreign key (intTipoTipificacionID)
      references tbl_CAT_TipoTipificacion (intTipoTipificacionID)
go
