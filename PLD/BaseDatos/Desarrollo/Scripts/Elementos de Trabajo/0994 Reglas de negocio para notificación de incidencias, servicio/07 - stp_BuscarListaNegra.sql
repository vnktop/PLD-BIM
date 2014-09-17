USE [dbPLD]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_BuscarListaNegra'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_BuscarListaNegra
GO
/*=================================================================
             AUTOR:              Victor Pineda Velázquez
             DESCRIPCION: Listar los registros de la tabla Lista Negra
                                        tbl_MST_ListaNegra
             MODIFICACION: RICARDO MARTÍNEZ   FECHA MODIF: 05-AGOSTO-2013 ORDER BY TM.vchTipoLista
             FECHA DE CREACIÓN: 20-MARZO-2013  
=================================================================*/
-- exec stp_BuscarListaNegra null, null, null, 'enrique peña nieto'
CREATE PROCEDURE [dbo].[stp_BuscarListaNegra]
         @vchPersonaIncidenciaNombre varchar(100) = '',
         @vchPersonaIncidenciaApPat varchar(100) = '',
         @vchPersonaIncidenciaApMat varchar(100) = '',
         @vchNombreCompleto varchar(300) = ''
AS
BEGIN  
       DECLARE @NOMBRE            AS VARCHAR(100)
       DECLARE @APPAT             AS VARCHAR(100)
       DECLARE @APMAT             AS VARCHAR(100)
       DECLARE @NOMBREC              AS VARCHAR(300)
       DECLARE @APPS                 AS VARCHAR(200)
       DECLARE @NPM                  AS VARCHAR(300)
       DECLARE @cadena               AS VARCHAR(300)
       DECLARE @Pos                  AS INT 
       DECLARE @Contador             AS INT
       
       SET @vchPersonaIncidenciaNombre = ISNULL(@vchPersonaIncidenciaNombre, '')
       SET @vchPersonaIncidenciaApPat =  ISNULL(@vchPersonaIncidenciaApPat, '')
       SET @vchPersonaIncidenciaApMat =  ISNULL(@vchPersonaIncidenciaApMat, '')
       SET @vchNombreCompleto =          ISNULL(@vchNombreCompleto, '')
       
       -- Existe solo nombre para razón social, no aplica función formatoNombreAp, ya que no esta dividida la razón en campor NPM ó NMP       
       IF (       @vchPersonaIncidenciaNombre <> '' 
                  AND @vchPersonaIncidenciaApPat = '' AND @vchPersonaIncidenciaApMat = '' AND @vchNombreCompleto = '') 
             BEGIN
             print 'opción 1'                 
                    SELECT  TM.intIdLN,                                  TM.VCHTIPOLISTA,       TT.intTipoTipificacionID,
                                  TT.vchDescripcion AS vchIdentificadorInterno,         
                                  CASE WHEN ISNULL(TM.vchNomCompleto,'') = '' THEN 
                                                           ISNULL(TM.vchNombre,'') + ' ' + ISNULL(TM.vchApPaterno,'') + ' ' + ISNULL(TM.vchApMaterno,'') 
                                                     ELSE ISNULL(TM.vchNomCompleto,'') END VCHNOMCOMPLETO
                    FROM    tbl_MST_ListaNegra TM INNER JOIN 
                                  tbl_CAT_TipoListaNegra TC ON TM.VCHTIPOLISTA = TC.VCHTIPOLISTA INNER JOIN
                                  tbl_CAT_TipoTipificacion TT on TC.intTipoTipificacionID = TT.intTipoTipificacionID
                    WHERE -- Nombre                         
                                  (TM.vchRazonSocial         LIKE @vchPersonaIncidenciaNombre) OR                         
                                  (TM.VCHNOMCOMPLETO         LIKE @vchPersonaIncidenciaNombre)                           
                    ORDER BY TT.vchDescripcion asc, TM.vchTipoLista,TM.intIdLN desc
             print @NOMBRE 
             END   
             
       --     Existe solo los parámetros de nombre y apellidos 
       IF (       @vchPersonaIncidenciaNombre <> '' AND @vchPersonaIncidenciaApPat <> '' AND @vchPersonaIncidenciaApMat <> ''
                  AND @vchNombreCompleto = '')      
             BEGIN
             
             print 'opción 2'
             IF LEN(@vchPersonaIncidenciaNombre) = 1
                        SET @NOMBRE = ''
                  ELSE
                        SET @NOMBRE = dbo.FormatoNombreAp(@vchPersonaIncidenciaNombre)
             IF LEN(@vchPersonaIncidenciaApPat) = 1
                        SET @APPAT = ''
                  ELSE
                        SET @APPAT = dbo.FormatoNombreAp(@vchPersonaIncidenciaApPat)
             
             IF LEN(@vchPersonaIncidenciaApMat) = 1
                        SET @APMAT = ''
                  ELSE
                        SET @APMAT = dbo.FormatoNombreAp(@vchPersonaIncidenciaApMat)             
             SET @NPM =          '%' + @NOMBRE + '%' + @APPAT + '%' + @APMAT + '%'            
                    SELECT  TM.intIdLN,                                  TM.VCHTIPOLISTA,       TT.intTipoTipificacionID,
                                  TT.vchDescripcion AS vchIdentificadorInterno,         
                                    CASE WHEN ISNULL(TM.vchRazonSocial,'') = '' THEN 
                                                           ISNULL(TM.vchNombre,'') + ' ' + ISNULL(TM.vchApPaterno,'') + ' ' + ISNULL(TM.vchApMaterno,'') 
                                                     ELSE ISNULL(TM.vchRazonSocial,'') END VCHNOMCOMPLETO
                    FROM    tbl_MST_ListaNegra TM INNER JOIN 
                                  tbl_CAT_TipoListaNegra TC ON TM.VCHTIPOLISTA = TC.VCHTIPOLISTA INNER JOIN
                                  tbl_CAT_TipoTipificacion TT on TC.intTipoTipificacionID = TT.intTipoTipificacionID
                    WHERE -- Nombre + ApPat + ApMat, busca nombre - paterno - materno                           
                                  (TM.vchCadenaNPM  LIKE @NPM           )      OR
                                  (TM.vchCadenaNMP           LIKE @NPM           )                                       
                    ORDER BY TT.vchDescripcion asc, TM.vchTipoLista,TM.intIdLN desc
             print @NPM   
             END    
       -- Existe solo nombre completo           
       IF (       @vchPersonaIncidenciaNombre = '' AND @vchPersonaIncidenciaApPat = '' AND @vchPersonaIncidenciaApMat = '' 
                  AND @vchNombreCompleto <> '')
             BEGIN
                             print 'opción 4'           
                             DECLARE @sDATOS VARCHAR(8000), @EXT VARCHAR(100), @NUEVO VARCHAR(8000)
                             SET @sDATOS = @vchNombreCompleto
                             SET @NUEVO = ''

                             EXECUTE sp_PopFirstWord @sDATOS OUTPUT, @EXT OUTPUT 
                             SET @NUEVO = CASE WHEN LEN(@EXT) = 1 THEN '' ELSE @EXT END
                             WHILE (@sDATOS <> '')
                                   BEGIN
                                         EXECUTE sp_PopFirstWord @sDATOS OUTPUT, @EXT OUTPUT 
                                         --SELECT @EXT
                                         SET @NUEVO = @NUEVO + ' ' + CASE WHEN LEN(@EXT) = 1 THEN '' ELSE @EXT END
                                   END
                                   
                             SET @vchNombreCompleto = @NUEVO
                             
                             
                    SET   @vchNombreCompleto = RTRIM(LTRIM(REPLACE(REPLACE(@vchNombreCompleto, '   ', ' '), '  ', ' ')))
                    PRINT @vchNombreCompleto
                    SET @Pos = charindex(' ', @vchNombreCompleto)  
                    SET @cadena = @vchNombreCompleto  
                    SET @Contador = 0          
                    WHILE (@Pos <> 0 ) 
                           BEGIN
                                  SET @Pos = charindex(' ', @cadena)
                                  if (@Pos <> 0)
                                        begin
                                               SET @cadena = SUBSTRING(@cadena, @Pos + 1,LEN(@cadena)) 
                                        end
                                  SET @Contador = @Contador + 1
                                  print @cadena
                                  --print @Contador
                           END                               
                    print @Contador   
                    IF (@Contador > 1) -- Existe nombre y apellidos, al menos por espacios
                           BEGIN
                           
                           PRINT 'CONTADOR > 1'
                           
                                  SET @Pos = charindex(' ', @vchNombreCompleto)
                                  SET @cadena = '%' + SUBSTRING(@vchNombreCompleto, 1, @Pos -1) + '%' 
                                  SET @APPS = SUBSTRING(@vchNombreCompleto, @Pos + 1,LEN(@vchNombreCompleto))                            
                                  SET @vchNombreCompleto = @cadena + @APPS + '%'                                 
                                  -- FORMATO PRIMER NOMBRE % + APELLIDOS
                                  SET @NOMBREC = dbo.FormatoNombreAp(@vchNombreCompleto)             
                                  print  @NOMBREC    
                                  PRINT @vchNombreCompleto
                                          
                                  SELECT  TM.intIdLN,                                  TM.VCHTIPOLISTA,       TT.intTipoTipificacionID,
                                               TT.vchDescripcion AS vchIdentificadorInterno,         
                                               CASE WHEN ISNULL(TM.vchNomCompleto,'') = '' THEN 
                                                                             ISNULL(TM.vchNombre,'') + ' ' + ISNULL(TM.vchApPaterno,'') + ' ' + ISNULL(TM.vchApMaterno,'') 
                                                                       ELSE ISNULL(TM.vchNomCompleto,'') END VCHNOMCOMPLETO
                                  FROM    tbl_MST_ListaNegra TM INNER JOIN 
                                               tbl_CAT_TipoListaNegra TC ON TM.VCHTIPOLISTA = TC.VCHTIPOLISTA     INNER JOIN
                                               tbl_CAT_TipoTipificacion TT on TC.intTipoTipificacionID = TT.intTipoTipificacionID
                                  WHERE -- NombreCompleto                              
                                               (TM.vchCadenaNMP           LIKE @NOMBREC       )      OR
                                               (TM.vchCadenaNPM           LIKE @NOMBREC       )      OR
                                               -- Razón social
                                               (ISNULL(TM.vchNombre,'') + ' ' + ISNULL(TM.vchApPaterno,'') + ' ' + ISNULL(TM.vchApMaterno,'')         LIKE @vchNombreCompleto)
                                  ORDER BY TT.vchDescripcion asc, TM.vchTipoLista,TM.intIdLN desc                                                      
                                                              
                           END
                    
             END
END


go

--stp_BuscarListaNegra
--         @vchPersonaIncidenciaNombre = 'ANGELICA',
--         @vchPersonaIncidenciaApPat  = 'RIVERA',
--         @vchPersonaIncidenciaApMat  = 'HURTADO',
--         @vchNombreCompleto  = ''