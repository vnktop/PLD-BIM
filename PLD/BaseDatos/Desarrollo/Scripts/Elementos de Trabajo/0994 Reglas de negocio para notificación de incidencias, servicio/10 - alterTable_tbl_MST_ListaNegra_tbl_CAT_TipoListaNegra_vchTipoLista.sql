USE dbPLD

insert into tbl_CAT_TipoListaNegra (vchTipoLista,intTipoTipificacionID, BITESTATUS) values ('ONUAQ', 4, 1)
insert into tbl_CAT_TipoListaNegra (vchTipoLista,intTipoTipificacionID, BITESTATUS) values ('UKMW', 4, 1)

ALTER TABLE dbo.tbl_MST_ListaNegra
   DROP CONSTRAINT FK_LISTANEGRA_TIPOLISTA
GO


ALTER TABLE tbl_CAT_TipoListaNegra
	DROP CONSTRAINT PK_TBL_CAT_TIPOLISTANEGRA
GO


ALTER TABLE tbl_CAT_TipoListaNegra 
ALTER COLUMN vchTipoLista NVARCHAR(10) not null

ALTER TABLE tbl_MST_ListaNegra 
ALTER COLUMN vchTipoLista NVARCHAR(10) not null

ALTER TABLE tbl_CAT_TipoListaNegra
   ADD CONSTRAINT PK_TBL_CAT_TIPOLISTANEGRA PRIMARY KEY (vchTipoLista)
GO

ALTER TABLE tbl_MST_ListaNegra
   ADD CONSTRAINT FK_LISTANEGRA_TIPOLISTA FOREIGN KEY (vchTipoLista)
      REFERENCES tbl_CAT_TipoListaNegra (vchTipoLista)
GO
--alter table tbl_CAT_TipoListaNegra
--   add constraint FK_TIPOLISTANEGRA_TIPOTIPI foreign key (intTipoTipificacionID)
--      references tbl_CAT_TipoTipificacion (intTipoTipificacionID)
--go