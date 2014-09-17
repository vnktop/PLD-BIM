use dbPLD
if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_CAT_RelacionCliente')
            and   type = 'U')
   drop table tbl_CAT_RelacionCliente
go

/*==============================================================*/
/* Table: tbl_CAT_RelacionCliente                               */
/*==============================================================*/
create table tbl_CAT_RelacionCliente (
   intRelacionClienteID int                  identity,
   vchDescripcion       varchar(50)          null,
   bitEstatus           bit                  null,
   constraint PK_TBL_CAT_RELACIONCLIENTE primary key (intRelacionClienteID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('tbl_CAT_RelacionCliente') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'tbl_CAT_RelacionCliente' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Catálogo de tipo de personas para BIM', 
   'user', @CurrentUser, 'table', 'tbl_CAT_RelacionCliente'
go
