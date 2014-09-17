if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_DET_Bitacora') and o.name = 'FK_TBL_DET_Bitacora_TBL_MST_Bitacora')
alter table tbl_DET_Bitacora
   drop constraint FK_TBL_DET_Bitacora_TBL_MST_Bitacora
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_MST_Bitacora')
            and   type = 'U')
   drop table tbl_MST_Bitacora
go

/*==============================================================*/
/* Table: tbl_MST_Bitacora                                      */
/*==============================================================*/
create table tbl_MST_Bitacora (
   intBitacoraID        int                  identity,
   vchPersonaCompleto   varchar(500)         null,
   vchNombre            varchar(100)         null,
   vchApPaterno         varchar(100)         null,
   vchApMaterno         varchar(100)         null,
   vchRelacionCliente   varchar(100)         null,
   bitAutorizado        bit                  null,
   bitProceso           bit                  null,
   bitHomonimo          bit                  null,
   vchUsuarioAutoriza   varchar(50)          null,
   datFechaAutorizacion datetime             null,
   intVigenciaDias      int                  null,
   bitEstatus           bit                  null default 1,
   constraint PK_TBL_MST_BITACORA primary key (intBitacoraID)
)
go
