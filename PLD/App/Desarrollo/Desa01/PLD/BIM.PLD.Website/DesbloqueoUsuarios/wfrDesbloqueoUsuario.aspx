<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="wfrDesbloqueoUsuario.aspx.cs" Inherits="BIM.PLD.Website.DesbloqueoUsuarios.wfrDesbloqueoUsuario"
    EnableEventValidation="false" %>

<%@ Register Src="~/UserControl/Comun/Mensaje.ascx" TagName="wucMensajeSistema" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script src="../JavaScript/JQuery/jquery-1.6.2.min.js" type="text/javascript"></script>
<script src="../JavaScript/JQuery/jquery-ui.js" type="text/javascript"></script>
<script src="../JavaScript/JQuery/ui.core.js" type="text/javascript"></script>
<link href="../Styles/sliding-panel.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler() {
//            $('#txtFechaInicioMonitor').datepicker({ dateFormat: 'dd/mm/yy', showAnim: 'drop' });
//            $('#txtFechaFinMonitor').datepicker({ dateFormat: 'dd/mm/yy', showAnim: 'drop' });
        }
        $(".trigger").click(function () {
            $(".panel").toggle("fast");
            $(this).toggleClass("active");
            return false;
        });
    });    
    function OcultarPanel() {
        $(".panel").toggle("fast");
        $(".trigger").toggleClass("active");
        return true;
        }       
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <uc1:wucMensajeSistema ID="wucMensajeSistema" runat="server" />
    <center>
        <asp:Label ID="lblTitulo" runat="server" Text="Bitacora Prevención de Lavado de Dinero"
            ForeColor="#006600" Font-Size="Large"></asp:Label>
    </center>
    <br />

    <div class="panel">
    <h3>
        Motor de Busqueda- Bitacora PLD
    </h3>
    <div class="content" style="width:450px; text-align:center;">
    <center>
        <table>
            <tr>
                <td>Sistema:</td>
                <td>Usuario:</td>             
            </tr>
            <tr>
                <td>
                    <asp:DropDownList Width="100px" runat="server" ID="ddlSistema"></asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="txtUsuario" runat="server" ClientIDMode="Static" Text="" Width="90" ReadOnly="false"></asp:TextBox>
                </td>              
            </tr>
            <tr>
               <td colspan="4">
                    <asp:UpdatePanel runat="server" ID="UpdatePanel1" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Button runat="server" ID="btnBuscar" Text="Buscar" CssClass="Boton" CausesValidation="true" onclick="btnBuscar_Click" OnClientClick="return OcultarPanel();" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
               </td>
            </tr>

        </table>
    </center>                        
    </div>
</div>
<a class="trigger" href="#">Busqueda</a>
    <center>
        <asp:UpdatePanel ID="upnBitacoraPLD" runat="server">
            <ContentTemplate>
                <asp:Panel ID="pnlBitacoraPLD" runat="server" Width="100%" CssClass="popupHover" >
                    <table width="75%">
                        <tr>
                            <td>
                                <asp:GridView ID="gvrBitacoraPLD" runat="server" llowPaging="True" AutoGenerateColumns="False"
                                    EmptyDataText="No exiten datos" ForeColor="#333333" DataKeyNames="intBitacoraID"
                                    Width="100%" HorizontalAlign="Center" CssClass="gvTD" PageSize="5" AllowPaging="True"
                                    OnRowDataBound="gvrBitacoraPLD_RowDataBound" OnSelectedIndexChanged="gvrBitacoraPLD_SelectedIndexChanged"
                                    OnPageIndexChanging="gvrBitacoraPLD_PageIndexChanging">
                                    <AlternatingRowStyle CssClass="alternatingrowstyle" />
                                    <HeaderStyle CssClass="headerstyle" />
                                    <RowStyle CssClass="rowstyle" />
                                    <Columns>
                                         <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Convert.ToInt32(DataBinder.Eval(Container, "DataItemIndex")) + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>                                            
                                        <asp:TemplateField HeaderText="USUARIO">
                                            <ItemTemplate>                                                 
                                                <asp:Label ID="lblUsuario" runat="server" Text='<%# Eval("vchUsuarioNombre") %>'></asp:Label>                                                   
                                            </ItemTemplate>                                           
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SISTEMA">
                                            <ItemTemplate>                                               
                                                <asp:Label ID="lblSistema" runat="server" Text='<%# Eval("vchNombreSistema") %>'></asp:Label>                                                  
                                            </ItemTemplate>
                                        </asp:TemplateField>                                      
                                        <asp:TemplateField HeaderText="NOMBRE BÚSQUEDA">
                                            <ItemTemplate>                                                
                                                <asp:Label ID="lblPersonaIncidencia" runat="server" Text='<%# Eval("vchPersonaIncidencia") %>'></asp:Label>                                                    
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="vchTipoLista" HeaderText="TIPO LISTA" />
                                        <asp:BoundField DataField="vchIdentificadorInterno" HeaderText="IDENTIFICADOR INT" />
                                        <asp:TemplateField HeaderText="REL. CLIENTE">
                                            <ItemTemplate>                                               
                                                <asp:Label ID="lblRelCliente" runat="server" Text='<%# Eval("vchRelacionCliente") %>'></asp:Label>                                                   
                                            </ItemTemplate>
                                        </asp:TemplateField>                                        
                                        <asp:TemplateField HeaderText="FECHA" >
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("datFecha", "{0:dd/M/yyyy}") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="vchUsuarioAutoriza" HeaderText="USUARIO AUTORIZA" />
                                        <asp:TemplateField HeaderText="FECHA AUTORIZACIÓN" >
                                            <ItemTemplate><asp:Label ID="lGVFechaAutorizacion" runat="server" Text='<%# Eval("datFechaAutorizacion", "{0:dd/M/yyyy}")%>'></asp:Label></ItemTemplate>
                                        </asp:TemplateField>                                          
                                        <asp:BoundField DataField="intVigenciaDias" HeaderText="VIGENCIA EN DIAS" />
                                        <asp:TemplateField HeaderText="Accion">
                                            <ItemTemplate>                                               
                                                <asp:ImageButton ID="btnEditarBitacoraPLD" runat="server" ImageUrl="~/App_Images/edit.gif" CommandArgument='<%# Eval("intBitacoraID") + ";" + Eval("bitAutorizado") + ";" + Eval("bitProceso") + ";" + Eval("bitHomonimo") + ";" + Eval("vchComentario") + ";" + Eval("datFechaAutorizacion") + ";" + Eval("intVigenciaDias") %>'
                                                    BackColor="Transparent" CausesValidation="false" Width="16px" Height="16px" OnClick="MostrarActualizacion"
                                                    CommandName="ACTUALIZAR" ToolTip="EDITAR" />                                                       
                                            </ItemTemplate>
                                        </asp:TemplateField>                                      
                                    </Columns>
                                    <PagerTemplate>
                                        <asp:Label ID="lblFila" runat="server" Text="Muestra Filas:" />
                                        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" CausesValidation="True" OnSelectedIndexChanged="gvrBitacoraPLD_SelectedIndexChanged">
                                            <asp:ListItem Value="5" />
                                            <asp:ListItem Value="10" />
                                            <asp:ListItem Value="15" />
                                        </asp:DropDownList>
                                        &nbsp; Página
                                        <asp:TextBox ID="txtGoToPage" runat="server" AutoPostBack="true" OnTextChanged="GoToPage_TextChanged" MaxLength="8" Width="40px" CssClass="gotopage" />
                                        de
                                        <asp:Label ID="lblTotalNumberOfPages" runat="server" />
                                        <ajaxToolkit:FilteredTextBoxExtender ID="ftetxtGoToPage" FilterType="Numbers" TargetControlID="txtGoToPage" runat="server"></ajaxToolkit:FilteredTextBoxExtender>
                                        &nbsp;
                                        <asp:ImageButton ID="btnPagAnterior" runat="server" CommandName="Page" ToolTip="Página Anterior" Width="25px" CommandArgument="Prev" CssClass="previous" ImageUrl="Images/Grids/ButtonIrAAnterior.png" />
                                        <asp:ImageButton ID="btnPagSig" runat="server" CommandName="Page" ToolTip="Página Siguiente" Width="25px" CommandArgument="Next" CssClass="next" ImageUrl="Images/Grids/ButtonIrASiguiente.png" />
                                    </PagerTemplate>
                                </asp:GridView>
                                <br />
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnAccion" />
            </Triggers>
        </asp:UpdatePanel>
    </center>
    <asp:Button ID="btnShowPopUp_AccionActualizar" runat="server" Style="display: none;" />
    <ajaxToolkit:ModalPopupExtender ID="mpeAccionActualizar" runat="server" TargetControlID="btnShowPopUp_AccionActualizar"
        PopupControlID="pnlPopupAccionActualizar" 
        BackgroundCssClass="modalBackground"  Drag="false"
        DynamicServicePath="" Enabled="true">
    </ajaxToolkit:ModalPopupExtender>   
    <asp:Panel ID="pnlPopupAccionActualizar" runat="server" Width="400px" HorizontalAlign="Center" Style="display:none;">
        <asp:UpdatePanel ID="pnlAccionActualizar" UpdateMode="Conditional" runat="server" Width="100%">
        <ContentTemplate>
            <table class="Tabla" width="100%">
                <tr>
                    <td class="Titulo" colspan="2">
                        <center>
                            DESBLOQUEAR PERSONA Y/O USUARIO
                        </center>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right" width="40%">
                        <asp:Label ID="lblDesbloqUsuario" runat="server" CssClass="Label" Text="Desbloquear usuario" Width="100%"></asp:Label>
                    </td>
                    <td style="text-align: left" width="60%">
                        <table>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="upchkDesbloqUsuario" runat="server">
                                        <ContentTemplate>
                                        
                                        
                                    <asp:CheckBox ID="chkDesbloqUsuario" runat="server" CssClass="checkbox" OnCheckedChanged="mostrarPanel" AutoPostBack="true"/>

                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="upibtEditarNumeroDias" runat="server">
                                        <ContentTemplate>
                                                                                
                                    <asp:ImageButton ID="ibtEditarNumeroDias" runat="server" ImageUrl="~/App_Images/edit.gif"
                                        BackColor="Transparent" CausesValidation="false" Width="16px" Height="16px"
                                        ToolTip="EDITAR DIAS" OnClick="mostrarPanelNumeroDias"/>

                                        </ContentTemplate>
                                    </asp:UpdatePanel> 
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                 <tr>
                    <td style="text-align: right" width="40%">
                        <asp:Label ID="lblDesbloqPersona" runat="server" CssClass="Label" Text="Desbloquear proceso" Width="100%"></asp:Label>
                    </td>
                    <td style="text-align: left" width="60%">
                        <table>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkDesbloqProceso" runat="server" CssClass="checkbox" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                     <tr>
                    <td style="text-align: right" width="40%">
                        <asp:Label ID="Label1" runat="server" CssClass="Label" Text="¿Es homonimo?" Width="100%"></asp:Label>
                    </td>
                    <td style="text-align: left" width="60%">
                        <table>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkHomonimo" runat="server" CssClass="checkbox"/>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>               
                <tr>
                    <td style="text-align: right" width="40%">
                        <asp:Label ID="lblComentario" runat="server" CssClass="Label" Text="Comentario" Width="100%"></asp:Label>
                    </td>
                    <td style="text-align: left" width="60%">
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtComentario" runat="server" MaxLength="100" Width="220" TextMode="MultiLine" Height="80" CssClass="textbox"></asp:TextBox>                                
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:RequiredFieldValidator ID="rqvtxtComentario" ValidationGroup="Accion"  ControlToValidate="txtComentario" runat="server" Display="None" ErrorMessage="Debe agregar un comentario"></asp:RequiredFieldValidator>                                    
                                    <asp:ValidationSummary ID="vstxtComentario" ValidationGroup="Accion" ShowMessageBox="true" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>                
                <tr>
                    <td colspan="2">
                        <table width="400px">
                            <tr>
                                <td align="left" width="50%">
                                    <asp:Button ID="btnAccion" runat="server" CssClass="Boton" Text="Guardar" ValidationGroup="Accion" CausesValidation="true" onclick="btnAccion_Click1" />
                                </td>
                                <td align="right" width="50%">
                                    <asp:Button ID="btnCancelarAccion" runat="server" Text="Cancelar" CssClass="Boton" OnClick="btnCancelarAccion_Click"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>

    <asp:UpdatePanel ID="upAsignarNumeroDias" runat="server">
        <ContentTemplate>                     
        <asp:Button ID="btnShowPopUp_AsignacionNumeroDias" runat="server" Style="display:none; " />
        <AjaxToolkit:ModalPopupExtender ID="mpeAsignacionNumeroDias" runat="server"
            TargetControlID="btnShowPopUp_AsignacionNumeroDias"
            PopupControlID="pnlPopupAsignacionNumeroDias"
            PopupDragHandleControlID="pnlAsignacionNumeroDias"
            BackgroundCssClass="modalBackground"
          
            Drag="false"
            DynamicServicePath="" Enabled="true">
        </AjaxToolkit:ModalPopupExtender>                                                
        <asp:Panel ID="pnlPopupAsignacionNumeroDias" runat="server" Width="400px" HorizontalAlign="Center" Style="display:none;">
            <asp:Panel ID="pnlAsignacionNumeroDias" runat="server"  Width="100%">     
                <asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="UPD_NumeroDias">
                    <ContentTemplate>
                       <%-- <div id="AdjResultsDivNumeroDias" class="Tabla" style="text-align: center; vertical-align: middle; overflow: auto;">  --%>          
                            <table class="Tabla" width="100%">
                                <tr>                           
                                    <td class="Titulo" colspan="1">
                                        <center>
                                            CONFIGURACIÓN NÚMERO DE DÍAS
                                        </center>
                                    </td>
                                </tr>
                
                                <tr>                               
                                    <td style="text-align: left" width="80%">                            
                                        <table>
                                            <tr>                                   
                                                <td style="text-align: right" width="40%">
                                                    <asp:Label ID="lblTitFechaAutorizacion" runat="server" CssClass="Label" Text="Fecha de autorización" Width="100%"></asp:Label>
                                                </td>
                                                <td style="text-align: left" width="60%">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lbFechaAutorizacion" runat="server" CssClass="Label" Width="100%"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right" width="40%">
                                                    <asp:Label ID="lblNumeroDias" runat="server" CssClass="Label" Text="Número de días desbloqueo" Width="100%"></asp:Label>
                                                </td>
                                                <td style="text-align: left" width="60%">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:UpdatePanel ID="uptxtNumeroDias" runat="server">
                                                                    <ContentTemplate>
                                                                                                                                        
                                                                <asp:TextBox ID="txtNumeroDias" runat="server" CssClass="textbox" MaxLength="3" ValidationGroup="AccionNumeroDias"></asp:TextBox>
                                                                <ajaxToolkit:FilteredTextBoxExtender ID="ftbetxtNumeroDias" runat="server" TargetControlID="txtNumeroDias" FilterType="Numbers" />
                                                                <asp:RequiredFieldValidator ID="rfvtxtNumeroDias" runat="server" ControlToValidate="txtNumeroDias" Display="None" ErrorMessage="Asignar número de días" ValidationGroup="AccionNumeroDias"></asp:RequiredFieldValidator>                                                                
                                                                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="AccionNumeroDias" ShowMessageBox="true" runat="server" />

                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>                                               
                                        </table>                                                       
                                    </td>                        
                                </tr> 
                                <tr>
                                    <td style="text-align: center">
                                        <asp:Label ID="lbMensajesDesbloqueo" runat="server" CssClass="Label"></asp:Label>
                                    </td>
                                </tr>                              
                                <tr>                  
                                    <td colspan="1">
                                        <table width="100%">
                                            <tr>
                                                <td align="left" width="50%"> 

                                                    <asp:Button ID="btnAceptarCorreo" runat="server" Text="Aceptar" CssClass="Boton" CausesValidation="true" ValidationGroup="asignaNumeroDias" OnClick="mantenerPanel" />
                                                </td>                        
                                                <td align="right" width="50%">
                                                    <asp:Button ID="btnCancelarCorreo" runat="server" Text="Cancelar" CssClass="Boton" CausesValidation="false" OnClick="mantenerPanelUncheck"/>
                                                </td>   
                                            </tr>
                                        </table>
                                    </td>                             
                                </tr>
                            </table>
                       <%-- </div>--%>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
        </asp:Panel>  
            </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="chkDesbloqUsuario" />
        </Triggers>
    </asp:UpdatePanel>              

</asp:Content>
