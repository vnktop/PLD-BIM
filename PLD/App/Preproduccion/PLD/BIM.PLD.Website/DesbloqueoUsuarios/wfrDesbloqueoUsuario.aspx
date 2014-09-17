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
    function VerificaChk(chk) {
        if (!document.getElementById('<%= chkDesbloqProceso.ClientID %>').checked) {
            chk.checked = false;
        }
    }
    function VerificaChkPersona(chk) {
        if (!this.checked) {
            document.getElementById('<%= chkHomonimo.ClientID %>').checked = false;
        }
    }
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
                <td>Cliente:</td>
             <%--   <td>Historial</td>--%>
            </tr>
            <tr>
                <td>
                    <asp:DropDownList Width="100px" runat="server" ID="ddlSistema"> 
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="txtUsuario" runat="server" ClientIDMode="Static" Text=""
                        Width="90" ReadOnly="false"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="txtCliente" runat="server" ClientIDMode="Static" Text="" Width="100"
                        ReadOnly="false"></asp:TextBox>
                </td>

                <%--<td>
                 <asp:CheckBox ID="chkMuestraHist" CssClass="checkbox" runat="server" />
                </td>--%>
            </tr>
            <tr>
                         <td colspan="4">
                    <asp:UpdatePanel runat="server" ID="UpdatePanel1" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Button runat="server" ID="btnBuscar" Text="Buscar" CssClass="Boton" 
                                CausesValidation="true" onclick="btnBuscar_Click" OnClientClick="return OcultarPanel();" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>

        </table>
    </center>
            
        
         <%--   <asp:UpdatePanel runat="server" ID="upaeVistaPrevia">
                <ContentTemplate>
                    <br />
                    <asp:GridView ID="grvMonitorFacturacion" runat="server" CellPadding="4" ForeColor="#333333"
                        Width="70%" AutoGenerateColumns="False"
                        GridLines="None" HorizontalAlign="Center">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField HeaderText="vchNombreSistema" DataField="Sistema" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="vchUsuario" DataField="Usuario" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="vchPersonaIncidencia" DataField="Perosna incidente" ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                        <EditRowStyle BackColor="#999999" HorizontalAlign="Center" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>--%>
        
    </div>
</div>
<a class="trigger" href="#">Busqueda</a>








    <center>
        <asp:UpdatePanel ID="upnBitacoraPLD" runat="server">
            <ContentTemplate>
                <asp:Panel ID="pnlBitacoraPLD" runat="server" Width="100%" CssClass="popupHover">
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
                                        <asp:TemplateField HeaderText="Clave">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblClave" runat="server" Text='<%# Eval("intBitacoraID") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblClave" runat="server" Text='<%# Eval("intBitacoraID") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sistema">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblSistema" runat="server" Text='<%# Eval("vchNombreSistema") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Usuario">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblUsuario" runat="server" Text='<%# Eval("vchUsuarioNombre") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblUsuario" runat="server" Text='<%# Eval("vchUsuarioNombre") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sucursal">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblSucursal" runat="server" Text='<%# Eval("vchSucursal") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblSucursal" runat="server" Text='<%# Eval("vchSucursal") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cliente">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblCliente" runat="server" Text='<%# Eval("vchCliente") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="id Lista Negra">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblidqeq" runat="server" Text='<%# Eval("vchidqeq") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Nombre Búsqueda">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblPersonaIncidencia" runat="server" Text='<%# Eval("vchPersonaIncidencia") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Nombre Coincidencia">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblPersonaCoincidencia" runat="server" Text='<%# Eval("vchNombreCompleto") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="vchIdentificadorInterno" 
                                            HeaderText="Identificador" />
                                            <asp:BoundField DataField="vchTipoLista" 
                                            HeaderText="Tipo Lista" />
                                      <%--  <asp:TemplateField HeaderText="Rel. Cliente">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblRelCliente" runat="server" Text='<%# Eval("vchRelacionCliente") %>'></asp:Label>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        
                                         <asp:TemplateField HeaderText="Fecha" SortExpression="fecha"><ItemTemplate><asp:Label ID="Label2" runat="server" Text='<%# Bind("datFecha") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                                          <asp:BoundField DataField="vchUsuarioAudit" 
                                            HeaderText="Usuario Autoriza" />
                                           <asp:BoundField DataField="datFechaRespuesta" 
                                            HeaderText="Fecha Respuesta" />

                                        <asp:TemplateField HeaderText="Accion">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:ImageButton ID="btnEditarBitacoraPLD" runat="server" ImageUrl="~/App_Images/edit.gif" CommandArgument='<%# Eval("intBitacoraID") %>'
                                                                BackColor="Transparent" CausesValidation="false" Width="16px" Height="16px" OnClick="MostrarActualizacion"
                                                                CommandName="ACTUALIZAR" ToolTip="EDITAR" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                      
                                    </Columns>
                                    <PagerTemplate>
                                        <asp:Label ID="lblFila" runat="server" Text="Muestra Filas:" />
                                        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" CausesValidation="True"
                                            OnSelectedIndexChanged="gvrBitacoraPLD_SelectedIndexChanged">
                                            <asp:ListItem Value="5" />
                                            <asp:ListItem Value="10" />
                                            <asp:ListItem Value="15" />
                                        </asp:DropDownList>
                                        &nbsp; Página
                                        <asp:TextBox ID="txtGoToPage" runat="server" AutoPostBack="true" OnTextChanged="GoToPage_TextChanged" MaxLength="8"
                                            Width="40px" CssClass="gotopage" />
                                        de
                                        <asp:Label ID="lblTotalNumberOfPages" runat="server" /><ajaxToolkit:FilteredTextBoxExtender
                                            ID="ftetxtGoToPage" FilterType="Numbers" TargetControlID="txtGoToPage" runat="server">
                                        </ajaxToolkit:FilteredTextBoxExtender>
                                        &nbsp;
                                        <asp:ImageButton ID="btnPagAnterior" runat="server" CommandName="Page" ToolTip="Página Anterior"
                                            Width="25px" CommandArgument="Prev" CssClass="previous" ImageUrl="Images/Grids/ButtonIrAAnterior.png" />
                                        <asp:ImageButton ID="btnPagSig" runat="server" CommandName="Page" ToolTip="Página Siguiente"
                                            Width="25px" CommandArgument="Next" CssClass="next" ImageUrl="Images/Grids/ButtonIrASiguiente.png" />
                                    </PagerTemplate>
                                </asp:GridView>
                                <br />
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnAccion" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </center>
    <asp:Button ID="btnShowPopUp_AccionActualizar" runat="server" Style="display: none;" />
    <ajaxToolkit:ModalPopupExtender ID="mpeAccionActualizar" runat="server" TargetControlID="btnShowPopUp_AccionActualizar"
        PopupControlID="pnlPopupAccionActualizar" PopupDragHandleControlID="pnlAccionActualizar"
        BackgroundCssClass="modalBackground" CancelControlID="brnCancelarPopUp" Drag="false"
        DynamicServicePath="" Enabled="true">
    </ajaxToolkit:ModalPopupExtender>
    <asp:Button ID="brnCancelarPopUp" runat="server" style="visibility:hidden" />
    <asp:Panel ID="pnlPopupAccionActualizar" runat="server" Width="400px" HorizontalAlign="Center">
        <asp:UpdatePanel ID="pnlAccionActualizar" UpdateMode="Conditional" runat="server" BackColor="White" Width="100%">
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
                        <asp:Label ID="lblDesbloqUsuario" runat="server" CssClass="Label" Text="Desbloquear usuario"
                            Width="100%"></asp:Label>
                    </td>
                    <td style="text-align: left" width="60%">
                        <table>
                            <tr>
                                <td>
                                    <asp:CheckBox onkeydown="return false"  Checked="true" ID="chkDesbloqUsuario" runat="server" CssClass="checkbox"/>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                 <tr>
                    <td style="text-align: right" width="40%">
                        <asp:Label ID="lblDesbloqPersona" runat="server" CssClass="Label" Text="Desbloquear proceso"
                            Width="100%"></asp:Label>
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
                        <asp:Label ID="Label1" runat="server" CssClass="Label" Text="¿Es homonimo?"
                            Width="100%"></asp:Label>
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
                                    <asp:TextBox ID="txtComentario" runat="server" MaxLength="100" Width="220" TextMode="MultiLine"
                                        Height="80" CssClass="textbox"></asp:TextBox>
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
                                    <asp:Button ID="btnAccion" runat="server" CssClass="Boton" Text="Guardar" ValidationGroup="Accion"
                                        CausesValidation="true" onclick="btnAccion_Click1" />
                                </td>
                                <td align="right" width="50%">
                                    <asp:Button ID="btnCancelarAccion" runat="server" Text="Cancelar" CssClass="Boton"
                                        CausesValidation="false" onclick="btnCancelarAccion_Click"  />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>

<%--    <asp:Button ID="btnprueba" runat="server" Text="..." CommandName="Prueba" 
        />

    <asp:Label ID="lblMsj" runat="server"></asp:Label>--%>


    </asp:Content>
