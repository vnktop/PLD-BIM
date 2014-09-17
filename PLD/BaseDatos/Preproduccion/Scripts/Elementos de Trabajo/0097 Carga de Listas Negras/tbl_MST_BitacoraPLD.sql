if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_MST_BitacoraPLD')
            and   type = 'U')
   drop table tbl_MST_BitacoraPLD
go

/*==============================================================*/
/* Table: tbl_MST_BitacoraPLD                                   */
/*==============================================================*/
create table tbl_MST_BitacoraPLD (
   intBitacoraID        int                  identity,
   vchidqeq             varchar(100)         null,
   vchUsuario           varchar(80)          null,
   vchSucursal          varchar(50)          null,
   intSistema           int                  null,
   vchPersonaIncidencia varchar(256)         null,
   vchNombre            varchar(100)         null,
   vchApPaterno         varchar(100)         null,
   vchApMaterno         varchar(100)         null,
   vchNombreBusq        varchar(300)         null,
   vchCliente           varchar(256)         null,
   vchRelacionCliente   varchar(100)         null,
   vchComentario        varchar(256)         null,
   bitAutorizaProc      bit                  null default 0,
   datFecha             date                 null,
   datFechaRespuesta    date                 null,
   bitHomonimo          bit                  null default 0,
   bitEstatus           bit                  null default 1,
   constraint PK_TBL_MST_BITACORAPLD primary key (intBitacoraID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('tbl_MST_BitacoraPLD') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'tbl_MST_BitacoraPLD' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Entidad para almacenar los movimientos de alta de personas en los sistemas de Sibamex, Fiduciario, SIHCEI Individual y SIHCEI Empresarial', 
   'user', @CurrentUser, 'table', 'tbl_MST_BitacoraPLD'
go
