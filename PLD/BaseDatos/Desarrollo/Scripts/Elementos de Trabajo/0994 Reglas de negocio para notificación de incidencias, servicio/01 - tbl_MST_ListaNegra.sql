use dbPLD
if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_DET_Bitacora') and o.name = 'FK_TBL_DET_Bitacora_TBL_MST_ListaNegra')
alter table tbl_DET_Bitacora
   drop constraint FK_TBL_DET_Bitacora_TBL_MST_ListaNegra
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_MST_ListaNegra') and o.name = 'FK_LISTANEGRA_TIPOLISTA')
alter table tbl_MST_ListaNegra
   drop constraint FK_LISTANEGRA_TIPOLISTA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_MST_ListaNegra') and o.name = 'FK_TBL_MST_ListaNegra_TBL_CAT_Proveedores')
alter table tbl_MST_ListaNegra
   drop constraint FK_TBL_MST_ListaNegra_TBL_CAT_Proveedores
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_MST_ListaNegra')
            and   type = 'U')
   drop table tbl_MST_ListaNegra
go

/*==============================================================*/
/* Table: tbl_MST_ListaNegra                                    */
/*==============================================================*/
create table tbl_MST_ListaNegra (
   intIdLN              int                  identity(1,1),
   vchidqeq             varchar(100)         not null,
   vchTipoLista         nvarchar(10)           null,
   vchNombre            varchar(1000)        null,
   vchApPaterno         varchar(1000)        null,
   vchApMaterno         varchar(1000)        null,
   vchCURP              varchar(100)         null,
   vchRFC               varchar(100)         null,
   vchFechaNac          varchar(100)         null,
   vchEstatus           varchar(100)         null,
   vchDependencia       varchar(120)         null,
   vchPuesto            varchar(120)         null,
   intIDdispo           varchar(100)         null,
   bitCurpOK            varchar(100)         null,
   vchIDRel             varchar(120)         null,
   vchParentesco        varchar(120)         null,
   vchRazonSocial       varchar(256)         null,
   vchRFCMoral          varchar(140)         null,
   vchISSSTE            varchar(150)         null,
   vchIMSS              varchar(150)         null,
   vchIngresos          varchar(180)         null,
   vchNomCompleto       varchar(3000)        null,
   vchApellidos         varchar(200)         null,
   vchEntidad           varchar(150)         null,
   vchGenero            varchar(100)         null,
   vchAudUsuario        varchar(180)         null,
   sdatFechains         smalldatetime        null,
   vchCadenaNPM         varchar(3000)        null,
   vchCadenaNMP         varchar(3000)        null,
   iProveedorId         int                  null,
   bitEstatus           bit                  null default 1,
   constraint PK_TBL_MST_LISTANEGRA primary key (intIdLN)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('tbl_MST_ListaNegra') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'tbl_MST_ListaNegra' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Entidad para almacenar las personas pertenecientes a las Listas Negras para PLD', 
   'user', @CurrentUser, 'table', 'tbl_MST_ListaNegra'
go

alter table tbl_MST_ListaNegra
   add constraint FK_LISTANEGRA_TIPOLISTA foreign key (vchTipoLista)
      references tbl_CAT_TipoListaNegra (vchTipoLista)
go

alter table tbl_MST_ListaNegra
   add constraint FK_TBL_MST_ListaNegra_TBL_CAT_Proveedores foreign key (iProveedorId)
      references tbl_CAT_Proveedores (iProveedorId)
go
