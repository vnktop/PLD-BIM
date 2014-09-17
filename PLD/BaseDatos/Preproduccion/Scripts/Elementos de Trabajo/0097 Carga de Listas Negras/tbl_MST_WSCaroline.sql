if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('tbl_MST_WSCaroline') and o.name = 'FK_TBL_MST__REFERENCE_TBL_CAT_')
alter table tbl_MST_WSCaroline
   drop constraint FK_TBL_MST__REFERENCE_TBL_CAT_
go

if exists (select 1
            from  sysobjects
           where  id = object_id('tbl_MST_WSCaroline')
            and   type = 'U')
   drop table tbl_MST_WSCaroline
go

/*==============================================================*/
/* Table: tbl_MST_WSCaroline                                    */
/*==============================================================*/
create table tbl_MST_WSCaroline (
   intWSCarolineID      int                  identity,
   intTipoTipificacionID int                  null,
   intClienteID         int                  null,
   intPersonaID         int                  null,
   intCalificacion      int                  null,
   datFecha             date                 null,
   constraint PK_TBL_MST_WSCAROLINE primary key (intWSCarolineID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('tbl_MST_WSCaroline') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'tbl_MST_WSCaroline' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Entidad para almacenar la información emitida por Caroline con respecto a la calificación de las personas de PLD', 
   'user', @CurrentUser, 'table', 'tbl_MST_WSCaroline'
go

alter table tbl_MST_WSCaroline
   add constraint FK_TBL_MST__REFERENCE_TBL_CAT_ foreign key (intTipoTipificacionID)
      references tbl_CAT_TipoTipificacion (intTipoTipificacionID)
go
