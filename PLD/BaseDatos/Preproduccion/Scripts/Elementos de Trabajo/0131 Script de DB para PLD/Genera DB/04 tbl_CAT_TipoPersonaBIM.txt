if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_CAT_TipoPersonaBIM')
            and   type = 'U')
   drop table tbl_CAT_TipoPersonaBIM
go

/*==============================================================*/
/* Table: tbl_CAT_TipoPersonaBIM                                */
/*==============================================================*/
create table tbl_CAT_TipoPersonaBIM (
   intTipoPersonaID     int                  identity,
   vchDescripcion       varchar(50)          null,
   bitEstatus           bit                  null,
   constraint PK_TBL_CAT_TIPOPERSONABIM primary key (intTipoPersonaID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('tbl_CAT_TipoPersonaBIM') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'tbl_CAT_TipoPersonaBIM' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Catálogo de tipo de personas para BIM', 
   'user', @CurrentUser, 'table', 'tbl_CAT_TipoPersonaBIM'
go
