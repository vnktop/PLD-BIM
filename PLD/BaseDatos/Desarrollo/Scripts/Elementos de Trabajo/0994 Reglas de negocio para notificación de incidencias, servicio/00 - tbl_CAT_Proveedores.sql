--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('tbl_MST_ListaNegra') and o.name = 'FK_TBL_MST__REFERENCE_TBL_CAT_')
--alter table tbl_MST_ListaNegra
--   drop constraint FK_TBL_MST__REFERENCE_TBL_CAT_
--go


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_MST_ListaNegra') and o.name ='FK__tbl_MST_L__iProv__4BAC3F29')
alter table tbl_MST_ListaNegra
   drop constraint FK__tbl_MST_L__iProv__4BAC3F29
go



if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_CAT_Proveedores')
            and   type = 'U')
   drop table tbl_CAT_Proveedores
go

/*==============================================================*/
/* Table: tbl_CAT_Proveedores                                   */
/*==============================================================*/
create table tbl_CAT_Proveedores (
   iProveedorId         int                  identity(1,1),
   vchDescripcion       varchar(100)         null,
   bEstatus             bit                  null,
   constraint PK_TBL_CAT_PROVEEDORES primary key (iProveedorId)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('tbl_CAT_Proveedores') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'tbl_CAT_Proveedores' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Catálogo dinámico de lista negra', 
   'user', @CurrentUser, 'table', 'tbl_CAT_Proveedores'
go

insert into  tbl_CAT_Proveedores (vchDescripcion, bEstatus) values ('Qeq', 1)
insert into  tbl_CAT_Proveedores (vchDescripcion, bEstatus) values ('PGR', 1)

alter table tbl_MST_ListaNegra 
   add constraint FK_TBL_MST_ListaNegra_TBL_CAT_Proveedores foreign key (iProveedorId)
      references tbl_CAT_Proveedores (iProveedorId)
go

