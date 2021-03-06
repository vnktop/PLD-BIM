IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('stp_CRUDBitacoraPLD') )
BEGIN 
 DROP PROCEDURE stp_CRUDBitacoraPLD
END 
GO
/*
		Variable de control
		@intAccion = 1, ingresar; @intAccion = 2, leer; @intAccion = 3, total correos enviados;  @intAccion = 4, desbloquear usuario [forma];  @intAccion = 5, desbloquear usuario [Servicio]
*/

CREATE PROCEDURE stp_CRUDBitacoraPLD
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
    @datFecha             date,
    @bitHomonimo        bit,
   @bitEstatus           bit,
    @bitHistorial         bit = NULL
    
AS

BEGIN
	IF @intAccion = 1							/*[c] - SQL Ingresar*/
		BEGIN
			BEGIN TRANSACTION					ingresar_Bitacora
			BEGIN TRY			
				--INSERT INTO tbl_MST_BitacoraPLD
				--(
				--	vchidqeq,				vchUsuario,				vchSucursal,		intSistema,
				--	vchPersonaIncidencia,	vchNombre,				vchApPaterno,		vchApMaterno,	vchNombreBusq,
				--	vchCliente,				vchRelacionCliente,		datFecha
				--)
				--VALUES
				--(
				--	@VCHIDQEQ,				@vchUsuario,			@vchSucursal,		@intSistema,
				--	@vchPersonaIncidencia,	@vchNombre,				@vchApPaterno,		@vchApMaterno,	@vchNombreBusq,
				--	@vchCliente,			@vchRelacionCliente,	getdate()
				--)
				 MERGE tbl_MST_BitacoraPLD
 AS target
    USING (SELECT  
			@VCHIDQEQ,
			@vchUsuario,
			@vchSucursal,
			@intSistema,
			@vchPersonaIncidencia,
			@vchNombre,
			@vchApPaterno,
			@vchApMaterno,
			@vchNombreBusq,
			@vchCliente,
			@vchRelacionCliente,
			@datFecha) AS source 
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
    ON (target.VCHIDQEQ=source.VCHIDQEQ and target.vchUsuario=source.vchUsuario and target.vchSucursal=source.vchSucursal and target.intSistema=source.intSistema and target.datFecha=source.datFecha )
	WHEN NOT MATCHED THEN	
	   INSERT
           (vchidqeq,vchUsuario,vchSucursal,intSistema,vchPersonaIncidencia,vchNombre,				vchApPaterno,		vchApMaterno,	vchNombreBusq,
			vchCliente,vchRelacionCliente,datFecha)
           
     VALUES
           (source.vchidqeq,source.vchUsuario,source.vchSucursal,source.intSistema,source.vchPersonaIncidencia,	source.vchNombre,source.vchApPaterno,source.vchApMaterno,	source.vchNombreBusq,
			source.vchCliente,source.vchRelacionCliente,getdate());				  
				SET			@intResultado = IDENT_CURRENT('tbl_MST_BitacoraPLD')
				COMMIT TRANSACTION				ingresar_Bitacora				
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION			ingresar_Bitacora
				SET			@intResultado = -1			
			END CATCH		
		END
		IF @intAccion = 2				/*SQL Leer busqueda por sistema, usuario y cliente*/ 
		BEGIN	
				SELECT TM_BT.intBitacoraID
					  ,TM_BT.vchidqeq
					  ,TM_BT.vchUsuario
					  ,case when isnumeric(TM_BT.vchSucursal)=1 
					  then 
					 (select vchDescripcion from dbSIE..tbl_CAT_SucursalBancaria where sintSucursalBanID=cast(TM_BT.vchSucursal as smallint))
					    when isnumeric(TM_BT.vchSucursal)=0  then 
					   TM_BT.vchSucursal end vchSucursal
					  ,TM_BT.intSistema
					  ,upper(case when ISNULL(TM_BT.vchPersonaIncidencia,'')='' then isnull(TM_BT.vchNombre,'')+' '+isnull(TM_BT.vchApPaterno,'')+' '+isnull(TM_BT.vchApMaterno,'') else TM_BT.vchPersonaIncidencia end ) vchPersonaIncidencia
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
					  ,TM_BT.bitEstatus
					  ,CAT_SIST.vchNombre AS vchNombreSistema
					  ,TM_LN.VCHTIPOLISTA AS vchTipoLista
					  ,CAT_TT.intTipoTipificacionID
					  ,CAT_TT.vchDescripcion AS vchIdentificadorInterno
					  ,CAT_USR.vchCorreoHCM				   				   
				FROM   tbl_MST_BitacoraPLD AS TM_BT	
				       left JOIN dbSIE..tbl_CAT_Sistemas AS CAT_SIST	ON TM_BT.intSistema=CAT_SIST.sintSistemaID
					   left JOIN tbl_MST_ListaNegra		AS TM_LN ON TM_BT.VCHIDQEQ=TM_LN.VCHIDQEQ
					   left JOIN tbl_CAT_TipoListaNegra CAT_TL ON CAT_TL.VCHTIPOLISTA = TM_LN.VCHTIPOLISTA
					   inner join tbl_CAT_TipoTipificacion CAT_TT ON CAT_TT.intTipoTipificacionID = CAT_TL.intTipoTipificacionID
					   left JOIN dbSIE..tbl_CAT_Usuarios CAT_USR ON TM_BT.vchUsuario = CAT_USR.vchUsuario and CAT_USR.bitEstatus=1
					   --order by TM_BT.intBitacoraID desc
					 -- 
				WHERE   1= case
							when @bitHistorial=1 then 1
							else TM_BT.bitEstatus
							end	AND 1 = case 
													when @intSistema is null
													then 1
													when  @intSistema is not null
													and @intSistema= TM_BT.intSistema
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
											AND 1 = case 
													when @intSistema is null
													then 1
													when  @intSistema is not null
													and @intSistema= TM_BT.intSistema
													then 1
													else 0
													end
													order by intBitacoraID desc;
													
								--COLLATE Latin1_General_CS_AS_KS_WS

				
			
				
		END
	
	IF @intAccion = 3				/*SQL Total correo enviados*/
		BEGIN
			SELECT COUNT(TM_BT.intBitacoraID)AS Total
			FROM   dbo.tbl_MST_BitacoraPLD AS TM_BT 
			WHERE TM_BT.bitEstatus=1 
		END
	IF @intAccion = 4				/*SQL Desbloquear Usuario. forma*/
		BEGIN
			BEGIN TRANSACTION desbloquear_Usuario
			BEGIN TRY							
				UPDATE tbl_MST_BitacoraPLD
				SET						
						vchComentario=			@vchComentario,
						bitAutorizaProc=	@bitAutorizaProc,
						bitEstatus=	@bitEstatus,
						bitHomonimo=@bitHomonimo,
						datFechaRespuesta=		getdate()
				WHERE	intBitacoraID=			@intBitacoraID
				SET		@intResultado =			@@ROWCOUNT;
				
				DECLARE @IdSistema int;
				
				select @IdSistema=intSistema from tbl_MST_BitacoraPLD  WHERE	intBitacoraID=@intBitacoraID;
				
				if (@IdSistema=14 or @IdSistema=15) 
				begin
					UPDATE [lsPLDSibamex]..SOUSUARI  
				SET Usu_Activo = 'S' 
				WHERE Usu_Clave =@vchUsuario 
				end 
				if @IdSistema=4
				begin
				  UPDATE dbSIE..tbl_CAT_Usuarios
				  set bitBloqueado=0
				  where intUsuarioID=cast(@vchUsuario as int);
				end
				if @IdSistema=5
				begin
				  UPDATE dbSIE..tbl_CAT_Usuarios
				  set bitBloqueado=0
				  where vchUsuario=@vchUsuario;
				end
				
				
				
				
				COMMIT TRANSACTION		desbloquear_Usuario
			END TRY 
			BEGIN CATCH
				ROLLBACK TRANSACTION	desbloquear_Usuario
				SET			@intResultado = -1	
			END CATCH
		END
	IF @intAccion = 5				/*SQL Desbloquear Usuario, BE - BA en TRUE y vchidqeq, como llave para asignar BE en false, servicio*/
		BEGIN
			BEGIN TRANSACTION			desbloquear_UsuarioBE_BA
			BEGIN TRY											
				UPDATE tbl_MST_BitacoraPLD
				SET		bitEstatus =			0
				WHERE	vchidqeq =			isnull(@vchidqeq, '')	AND
						bitAutorizaProc =	1			AND
						bitEstatus	=		1
				SET		@intResultado =			@@ROWCOUNT
				COMMIT TRANSACTION		desbloquear_UsuarioBE_BA
			END TRY 
			BEGIN CATCH
				ROLLBACK TRANSACTION	desbloquear_UsuarioBE_BA
				SET			@intResultado = -1	
			END CATCH
		END
	SELECT @intResultado
	RETURN @intResultado
END	
