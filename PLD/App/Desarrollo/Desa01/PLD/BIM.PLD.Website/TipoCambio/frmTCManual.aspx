<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" 
         CodeBehind="frmTCManual.aspx.cs" Inherits="BIM.PLD.Website.TipoCambio.frmTCManual" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/UserControl/Comun/Mensaje.ascx" TagName="wucMensajeSistema" TagPrefix="uc1" %>

<asp:Content ID="Content1"  ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <uc1:wucMensajeSistema ID="Message" runat="server" />
    <asp:Panel ID="pnlTipoCambioManual" runat="server" HorizontalAlign="Center">
        <asp:UpdatePanel ID="upnTipoCambioManual" runat="server">
            <ContentTemplate>
                <table class="Tabla" width="35%">
                    <tr>
                        <td colspan ="5" class="Titulo" align ="center">
                            Motor de carga manual
                        </td>
                    </tr>
                    <tr>
                        <td class="TD" align="right">
                            <asp:Label ID="lblFecha" runat="server" Class="Label" Text ="Ingrese la fecha:" />                            
                        </td>
                        <td>
                            <asp:TextBox ID="txtFecha"  contentEditable="true" runat="server" Width="86px"></asp:TextBox>
                            <asp:ImageButton ID="imgCalFecha" ImageUrl="~/Images/Calendar.png" 
                                             runat="server" Height="21px" Width="23px" />
                            <asp:CalendarExtender ID="caltxtFechaConFin" TargetControlID="txtFecha" PopupButtonID="imgCalFecha"
                                                  Format="dd/MM/yyyy" runat="server">
                            </asp:CalendarExtender>
                            <asp:RequiredFieldValidator ID="rfvTxtFecha" runat="server" 
                                                        Text="*" 
                                                        ForeColor="Red" 
                                                        ControlToValidate="txtFecha" 
                                                        InitialValue=""
                                                        ErrorMessage="- Selecciona la fecha."
                                                        Display="Dynamic"
                                                        ValidationGroup="vdgCargaManual"/>
                        </td>
                        <td>
                            <asp:Button ID="btnInsertar" runat="server" class ="Boton" Text ="Insertar" 
                                        OnClick="btnInsertar_Click" CausesValidation="true" 
                                        ValidationGroup="vdgCargaManual" Width="90px"/>
                        </td>
                    </tr>
                    <tr>                        
                        <td align = "right">
                            <asp:Label ID="lblValor" runat="server" Class="Label" Text ="Ingrese el Valor:" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtValor" contentEditable="true" runat="server" Width="90px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTxtValor" runat="server" 
                                                        Text="*" 
                                                        ForeColor="Red" 
                                                        ControlToValidate="txtValor" 
                                                        InitialValue=""
                                                        ErrorMessage="- Selecciona el valor."
                                                        Display="Dynamic"
                                                        ValidationGroup="vdgCargaManual"/>
                            <asp:RegularExpressionValidator ID="rfvTxtValorDecimal" 
                                                        runat="server"                                                                              
                                                        ValidationExpression="^-?(([1-9]\d*)|0)(.0*[1-9](0*[0-9])*)?$"
                                                        ControlToValidate="txtValor"
                                                        Display="Dynamic"
                                                        ErrorMessage="El valor debe ser numérico" 
                                                        Text="*"                                                                    
                                                        ValidationGroup="vdgCargaManual"/>                                    
                        </td>
                    </tr>
                </table>
                <asp:ValidationSummary ID="vsCargaManual" runat="server" ShowMessageBox="true" ShowSummary="false"
                     ValidationGroup="vdgCargaManual" HeaderText="Campos Faltantes" DisplayMode="List" />
                
                <!-- /*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*-   Tabla Grid View   -*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\ -->
                <table width="100%">
                <tr>
                    <td colspan="7">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="7" align="center">
                        <asp:Panel ID="pnlConsultaTipoCambio" runat="server" HorizontalAlign="Center" ScrollBars="Auto" Width="100%" Height="480px">
                            <asp:UpdatePanel ID="udpConsultaTipoCambio" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:GridView ID="gdvTipoCambio" runat="server" AllowSorting="false"
                                    OnRowDataBound="gvTipoCambio_RowDataBound"
                                    AutoGenerateColumns="false" PageSize="5" AllowPaging="true"
                                    OnPageIndexChanging="gdvTipoCambio_OnPageIndexChanging"                                    
                                    EmptyDataText="No se encontraron datos bajo el criterio de búsqueda">
                                    <Columns>
                                        <asp:BoundField HeaderText="Tipo Moneda" DataField="strTipoMoneda" />
                                        <asp:BoundField HeaderText="Tipo Cambio" DataField="strTipoCambio" />
                                        <asp:BoundField HeaderText="Valor de Cambio" DataField="decValorCambio" />
                                        <asp:BoundField HeaderText="Fecha Cierre" DataField="datFechaCierre" DataFormatString="{0:dd/MM/yyyy}"/>                                        
                                    </Columns>
                                    <AlternatingRowStyle CssClass="alternatingrowstyle" />
                                    <HeaderStyle CssClass="headerstyle" />
                                    <RowStyle CssClass="rowstyle" />
                                    <PagerTemplate>
                                        <asp:Label ID="lbTemplate" runat="server" Text="Muestra Filas: " CssClass="Label"/>                                        
                                        <asp:DropDownList ID="ddlBandeja" runat="server" AutoPostBack="true" CausesValidation="false"
                                                          Enabled="true" OnSelectedIndexChanged="ddlBandeja_SelectedIndexChanged">
                                            <asp:ListItem Value="5" />
                                            <asp:ListItem Value="10" />
                                            <asp:ListItem Value="15" />
                                            <asp:ListItem Value="20" />
                                            <asp:ListItem Value="25" />
                                        </asp:DropDownList>
                                            &nbsp; Página
                                        <asp:TextBox ID="txtBandeja" runat="server" AutoPostBack="true" OnTextChanged="txtBandeja_TextChanged"
                                                     Width="40" MaxLength="10"/>                                        
                                                   de
                                        <asp:Label ID="lblBandejaTotal" runat="server"/>
                                            &nbsp;
                                        <asp:Button ID="btnBandeja_I" runat="server" CommandName="Page" CausesValidation="false"
                                                    ToolTip="Pagina Anterior" CommandArgument="Prev" CssClass="previous" />
                                        <asp:Button ID="btnBandeja_II" runat="server" CommandName="Page" CausesValidation="false"
                                                    ToolTip="Pagina Siguiente" CommandArgument="Next" CssClass="next" />
                                    </PagerTemplate>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </td>
                </table>
                <!-- /*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*-   ---------------   -*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\ -->
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
</asp:Content>