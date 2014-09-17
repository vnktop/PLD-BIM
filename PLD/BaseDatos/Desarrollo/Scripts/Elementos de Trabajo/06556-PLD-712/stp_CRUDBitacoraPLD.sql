USE [dbPLD]
GO

/****** Object:  StoredProcedure [dbo].[stp_CRUDBitacoraPLD]    Script Date: 04/22/2013 10:08:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_CRUDBitacoraPLD'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_CRUDBitacoraPLD
GO

/*
		Variable de control
		@intAccion = 1, ingresar; @intAccion = 2, leer; @intAccion = 3, total correos enviados;  @intAccion = 4, desbloquear usuario [forma];  @intAccion = 5, desbloquear usuario [Servicio]
*/


/*
		Variable de control
		@intAccion = 1, ingresar; @intAccion = 2, leer; @intAccion = 3, total correos enviados;  @intAccion = 4, desbloquear usuario [forma];  @intAccion = 5, desbloquear usuario [Servicio]
*/

CREATE PROCEDURE [dbo].[stp_CRUDBitacoraPLD]	
	@intResultado					AS INT OUTPUT,
	@intAccion            int,
	@intBitacoraID        int,
    @vchidqeq             varchar(100),
    @vchUsuario           varchar(80),
    @vchSucursal          varchar(50),
    @intSistema           int,
    @vchPersonaIncidencia varchar(256),
    @vchNombre            varchar(100),
    @vchApPaterno         varchar(100),
    @vchApMaterno         varchar(100),
    @vchNombreBusq        varchar(300),
    @vchCliente           varchar(256),
    @vchRelacionCliente   varchar(100),
    @vchComentario        varchar(256),
    @bitAutorizaProc      bit,
    @datFecha             datetime,
    @bitHomonimo        bit,
    @bitEstatus           bit,
    @bitHistorial         bit=null,
    @vchUsuarioAudit      varchar(80)=null
    
AS
BEGIN
	IF @intAccion = 1                                    /*[c] - SQL Ingresar*/
            BEGIN
                  BEGIN TRANSACTION  ingresar_Bitacora
                  BEGIN TRY  
                  DECLARE @TableOutput TABLE(intResultado int);
                        MERGE tbl_MST_BitacoraPLD
AS target
    USING (SELECT  
                  @VCHIDQEQ,
                  @vchUsuario,
                  --case when @intSistema=4 then (select USU.vchUsuario from dbSIE..tbl_CAT_Usuarios USU where USU.intUsuarioID=case when isnumeric(@vchUsuario)=1 then  cast(@vchUsuario as int) else 0 end) else @vchUsuario end,
                  @vchSucursal,
                  @intSistema,
                  @vchPersonaIncidencia,
                  @vchNombre,
                  @vchApPaterno,
                  @vchApMaterno,
                  @vchNombreBusq,
                  @vchCliente,
                  @vchRelacionCliente,
				  GETDATE()) AS source 
                  (VCHIDQEQ,
                  vchUsuario,
                  vchSucursal,
                  intSistema,
                  vchPersonaIncidencia,
                  vchNombre,
                  vchApPaterno,
                  vchApMaterno,
                  vchNombreBusq,
                  vchCliente,
                  vchRelacionCliente,
                  datFecha)
    ON (isnull(target.VCHIDQEQ,'')=isnull(source.VCHIDQEQ,'') and isnull(target.vchUsuario,'')=isnull(source.vchUsuario,'') and isnull(target.vchSucursal,'')=isnull(source.vchSucursal,'') and target.intSistema=source.intSistema and isnull(convert(varchar,target.datFecha,112),'')=isnull(convert(varchar, source.datFecha,112),'') )
      WHEN NOT MATCHED THEN  
     
         INSERT
           (vchidqeq,vchUsuario,vchSucursal,intSistema,vchPersonaIncidencia,vchNombre, vchApPaterno, vchApMaterno, vchNombreBusq,
                  vchCliente,vchRelacionCliente,datFecha)
           
     VALUES
           (source.vchidqeq,source.vchUsuario,source.vchSucursal,source.intSistema,source.vchPersonaIncidencia,      source.vchNombre,source.vchApPaterno,source.vchApMaterno,  source.vchNombreBusq,
                  source.vchCliente,source.vchRelacionCliente,getdate())
                  OUTPUT Inserted.intBitacoraID INTO @TableOutput;                        
                        select  @intResultado= intResultado from @TableOutput
                      
                        COMMIT TRANSACTION  ingresar_Bitacora                   
                  END TRY
                  BEGIN CATCH
                        ROLLBACK TRANSACTION     ingresar_Bitacora
                        SET               @intResultado = -1                 
                  END CATCH         
            END

		IF @intAccion = 2				/*SQL Leer busqueda por sistema, usuario y cliente*/ 
		BEGIN	
				SELECT TM_BT.intBitacoraID
					  ,TM_BT.vchidqeq
					  ,isnull(TM_BT.vchUsuario,'') vchUsuario --select vchNombre+' '+ vchApPaterno +' '+vchApMaterno  from dbSIE..tbl_CAT_Usuarios CAT_USR
					  ,
								case when intSistema=4 or intSistema=5 
								then (select  CAT_USR.vchNombre+' '+ CAT_USR.vchApPaterno +' '+CAT_USR.vchApMaterno   from dbSIE..tbl_CAT_Usuarios CAT_USR where TM_BT.vchUsuario = CAT_USR.vchUsuario)
																else 
																(select Usu_Nombre   collate Modern_Spanish_CI_AI from LSPLDSIBAMEX.dbBIM.dbo.SOUSUARI where TM_BT.vchUsuario     =Usu_Clave collate Modern_Spanish_CI_AI )
																end  vchUsuarioNombre
					  , CASE ISNULL(TM_BT.vchSucursal,'')
						WHEN '001' THEN 'INSURGENTES'
						WHEN '851' THEN 'CORPORATIVO'
						WHEN '' THEN ''
						ELSE
							TM_BT.vchSucursal
					  END vchSucursal
					  ,TM_BT.intSistema
					  ,upper( CASE WHEN isnull(TM_BT.vchPersonaIncidencia,'') = '' THEN isnull(TM_BT.vchNombre,'') + ' ' + isnull(TM_BT.vchApPaterno,'') +' '+ isnull(TM_BT.vchApMaterno,'') else TM_BT.vchPersonaIncidencia end) vchPersonaIncidencia
					  ,TM_BT.vchNombre
					  ,TM_BT.vchApPaterno
					  ,TM_BT.vchApMaterno
					  ,TM_BT.vchNombreBusq
					  ,TM_BT.vchCliente
					  ,TM_BT.vchRelacionCliente
					  ,TM_BT.vchComentario
					  ,TM_BT.bitAutorizaProc
					  ,TM_BT.datFecha
					  ,TM_BT.datFechaRespuesta
					  ,TM_BT.bitHomonimo
					  ,TM_BT.vchUsuarioAudit
					  ,TM_BT.bitEstatus
					  ,CAT_SIST.vchNombre AS vchNombreSistema
					  ,TM_LN.VCHTIPOLISTA AS vchTipoLista
					  ,CAT_TT.intTipoTipificacionID
					  ,CAT_TT.vchDescripcion AS vchIdentificadorInterno
					  , case when @vchUsuario is null then '' else case when intSistema=4 then  (select CAT_USR.vchCorreoHCM  from dbSIE..tbl_CAT_Usuarios CAT_USR where  case  when isnumeric(TM_BT.vchUsuario)=1 then cast(TM_BT.vchUsuario as int) end = CAT_USR.intUsuarioID)
					    when intSistema=5 then (select CAT_USR.vchCorreoHCM  from dbSIE..tbl_CAT_Usuarios CAT_USR where TM_BT.vchUsuario = CAT_USR.vchUsuario)
																else (select Usu_EMail   collate Modern_Spanish_CI_AI from LSPLDSIBAMEX.dbBIM.dbo.SOUSUARI where TM_BT.vchUsuario     =Usu_Clave collate Modern_Spanish_CI_AI )
																end end vchCorreoHCM
				FROM   tbl_MST_BitacoraPLD AS TM_BT	
				       left JOIN dbSIE..tbl_CAT_Sistemas AS CAT_SIST	ON TM_BT.intSistema=CAT_SIST.sintSistemaID
					   left JOIN tbl_MST_ListaNegra		AS TM_LN ON TM_BT.VCHIDQEQ=TM_LN.VCHIDQEQ
					   left JOIN tbl_CAT_TipoListaNegra CAT_TL ON CAT_TL.VCHTIPOLISTA = TM_LN.VCHTIPOLISTA
					   inner join tbl_CAT_TipoTipificacion CAT_TT ON CAT_TT.intTipoTipificacionID = CAT_TL.intTipoTipificacionID
					   left JOIN dbSIE..tbl_CAT_Usuarios CAT_USR ON TM_BT.vchUsuario = CAT_USR.vchUsuario --and CAT_USR.bitEstatus=1
					 -- 
				WHERE   1= case
							--when @bitHistorial=1 then 1
							--else TM_BT.bitEstatus
							--end	AND 1 = case 
													when @intSistema is null
													then 1
													when  @intSistema is not null
													and @intSistema= TM_BT.intSistema
													then 1
													else 0
													end
											AND 1 = case 
													when @vchCliente is null
													then 1
													when  @vchCliente is not null
													and @vchCliente= TM_BT.vchCliente
													then 1
													else 0
													end
													AND 1 = case 
													when @vchUsuario is null
													then 1
													when  @vchUsuario is not null
													and @vchUsuario= TM_BT.vchUsuario
													then 1
													else 0
													end
												 order by TM_BT.intBitacoraID desc	
								--COLLATE Latin1_General_CS_AS_KS_WS

				
			
				
		END
	
	IF @intAccion = 3				/*SQL Total correo enviados*/
		BEGIN
			SELECT COUNT(TM_BT.intBitacoraID)AS Total
			FROM   dbo.tbl_MST_BitacoraPLD AS TM_BT 
			WHERE TM_BT.bitEstatus=1 
		END
	IF @intAccion = 4				/*SQL Desbloquear Usuario. forma*/
		begin
			--BEGIN TRANSACTION desbloquear_Usuario
			--BEGIN TRY							
				UPDATE tbl_MST_BitacoraPLD
				SET						
						vchComentario=			@vchComentario,
						bitAutorizaProc=	@bitAutorizaProc,
						bitEstatus=	@bitEstatus,
						bitHomonimo=@bitHomonimo,
						datFechaRespuesta=		getdate(),
						vchUsuarioAudit=@vchUsuarioAudit
				WHERE	intBitacoraID=			@intBitacoraID
				SET		@intResultado =			@@ROWCOUNT;
				
			--	COMMIT TRANSACTION desbloquear_Usuario
			--END TRY 
			--BEGIN CATCH
			--	ROLLBACK TRANSACTION desbloquear_Usuario
			--	SET			@intResultado = -1	
			--END CATCH
			--BEGIN TRANSACTION desbloquear
			--BEGIN TRY							
				
				DECLARE @IdSistema int;
				
				select @IdSistema=intSistema from tbl_MST_BitacoraPLD  WHERE	intBitacoraID=@intBitacoraID;
				
				
				if @IdSistema=5 OR @IdSistema=4
				begin
				  UPDATE dbSIE..tbl_CAT_Usuarios
				  set bitBloqueado=0
				  where vchUsuario=@vchUsuario;
				end
			--	COMMIT TRANSACTION desbloquear
			--END TRY 
			--BEGIN CATCH
			--	ROLLBACK TRANSACTION desbloquear
			--	SET			@intResultado = -1	
			--END CATCH
				begin 
				if (@IdSistema=14 or @IdSistema=15) 
				begin
                   UPDATE LSPLDSIBAMEX.dbBIM.dbo.SOUSUARI  
				SET Usu_Activo = 'S' 
				WHERE Usu_Clave =@vchUsuario; 
				end 
				end 
		end
		
	IF @intAccion = 5				/*SQL Desbloquear Usuario, BE - BA en TRUE y vchidqeq, como llave para asignar BE en false, servicio*/
		BEGIN
			--BEGIN TRANSACTION			desbloquear_UsuarioBE_BA
			--BEGIN TRY	
													
			--	UPDATE  tbl_MST_BitacoraPLD
			--	SET		bitEstatus =			0
			--	WHERE	vchidqeq =			isnull(@vchidqeq, '')	AND
			--			bitAutorizaProc =	1		AND
			--			intSistema = @intSistema	AND
			--			vchUsuario = @vchUsuario	AND	
			--			CONVERT(VARCHAR, datFecha, 112) = CONVERT(VARCHAR, getdate(), 112)		AND
			--			vchidqeq = @vchidqeq	
						
			--	SET		@intResultado =			@@ROWCOUNT
			--	COMMIT TRANSACTION		desbloquear_UsuarioBE_BA
			--END TRY 
			--BEGIN CATCH
			--	ROLLBACK TRANSACTION	desbloquear_UsuarioBE_BA
			--	SET			@intResultado = -1	
			--END CATCH
						
			IF EXISTS(	SELECT 1 FROM tbl_MST_BitacoraPLD WHERE	ISNULL(vchidqeq,'') = isnull(@vchidqeq, '')	AND
																ISNULL(bitAutorizaProc,0) =	1		AND
																ISNULL(intSistema,0) = @intSistema	AND
																ISNULL(vchUsuario,'') = @vchUsuario	AND	
																CONVERT(VARCHAR, datFecha, 112) = CONVERT(VARCHAR, getdate(), 112)
					  )
				BEGIN
					SET		@intResultado =	1
				END
			ELSE
				BEGIN
					SET		@intResultado =	0
				END			
			
		END
	SELECT @intResultado
	--RETURN @intResultado
END	
GO


--[stp_CRUDBitacoraPLD]	
--	@intResultado			= 0,
--	@intAccion				= 5,
--	@intBitacoraID          = NULL,
--    @vchidqeq               = 'QEQ168124',
--    @vchUsuario             = 'RICARDO.MARTINEZ',
--    @vchSucursal            = '4',
--    @intSistema             = 4,
--    @vchPersonaIncidencia   = '',
--    @vchNombre              = 'ANGELICA',
--    @vchApPaterno           = 'RIVERA',
--    @vchApMaterno           = 'HURTADO',
--    @vchNombreBusq          = NULL,
--    @vchCliente             = NULL,
--    @vchRelacionCliente     = NULL,
--    @vchComentario          = NULL,
--    @bitAutorizaProc        = NULL,
--    @datFecha               = NULL,
--    @bitHomonimo            = NULL,
--    @bitEstatus             = NULL,
--    @bitHistorial           = 0,
--    @vchUsuarioAudit        = NULL



