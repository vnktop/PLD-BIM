<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" 
         CodeBehind="frmTCAutomatico.aspx.cs" Inherits="BIM.PLD.Website.TipoCambio.frmTipoCambio" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxToolkit" %>
<%@ Register Src="~/UserControl/Comun/Mensaje.ascx" TagName="wucMensajeSistema" TagPrefix="uc1" %>
<asp:Content ID="Content1"  ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
<style type="text/css">
     .modalBackgroundCaptura
{
    z-index: 20000 !important;
	background-color:Gray;
	filter:alpha(opacity=70);
	opacity:0.7;
}

     .modalBackgroundArchivos
{
    z-index: 30000 !important;
	background-color:Gray;
	filter:alpha(opacity=70);
	opacity:0.7;
}

 .modalBackgroundComentarios
{
    z-index: 30000 !important;
	background-color:Gray;
	filter:alpha(opacity=70);
	opacity:0.7;
}
</style>
    <uc1:wucMensajeSistema ID="Message" runat="server" />
    <asp:Panel ID="pnlTipoCambioAutomatico" runat="server" HorizontalAlign="Center">
        <asp:UpdatePanel ID="upnTipoCambioAutomatico" runat="server">
            <ContentTemplate>
                <table class="Tabla" width="35%">
                    <tr>
                        <td colspan ="4" class="Titulo" align ="center">
                            Motor de carga automática "Actualización Banxico"
                        </td>
                    </tr>
                    <tr>
                        <td class="TD" align="right">
                            <asp:Label ID="lblDescarga" runat="server" Class="Label" Text ="Descargue el archivo:" />                            
                        </td>
                        <td>
                            <asp:Button ID="btnDescargar" runat="server" class ="Boton" Text ="Descargar" OnClick="btnDescargar_Click" />
                        </td>
                    </tr>
                </table>
                <asp:Button ID="btnShowPopUp_ConfirmaCarga" runat="server" Style="display:none;" />
                <AjaxToolkit:ModalPopupExtender ID="mpeConfirmaCarga" runat="server"
                                                TargetControlID="btnShowPopUp_ConfirmaCarga"
                                                PopupControlID="pnlPopupConfirmaCarga"
                                                PopupDragHandleControlID="pnlConfirmaCarga"
                                                BackgroundCssClass="modalBackgroundCaptura"
                                                CancelControlID="btnCancelarCarga"
                                                Drag="false"
                                                DynamicServicePath="" Enabled="true">
                </AjaxToolkit:ModalPopupExtender>
                <asp:Panel ID="pnlPopupConfirmaCarga" runat="server" HorizontalAlign="Center" style="display:inline;">
                    <table class="Tabla" width="60%" style="height: 80%; ">
                        <tr>
                            <td class="Titulo" >
                                <center>
                                    Confirmación de carga automática
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblMensajeConfirmacion" runat ="server" class="TitBot" Text="¿Desea cargar los siguientes datos de <em>Tipo de Cambio</em> ?" />
                                
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <br />
                                <asp:Panel ID="pnlConsultaTipoCambio" runat="server" HorizontalAlign="Center" ScrollBars="Auto" Width="100%">
                                    <asp:UpdatePanel ID="udpConsultaTipoCambio" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gdvTipoCambio" runat="server" AllowSorting="false"
                                                          OnRowDataBound="gvTipoCambio_RowDataBound"
                                                          AutoGenerateColumns="false" PageSize="5" AllowPaging="true"
                                                          OnPageIndexChanging="gdvTipoCambio_OnPageIndexChanging"                                    
                                                          EmptyDataText="No existen datos nuevos para subir...">
                                                <Columns>
                                                    <asp:BoundField HeaderText="Tipo Moneda" DataField="strTipoMoneda" />
                                                    <asp:BoundField HeaderText="Tipo Cambio" DataField="strTipoCambio" />
                                                    <asp:BoundField HeaderText="Valor de Cambio" DataField="decValorCambio"/>
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
                                                    <asp:TextBox ID="txtBandeja" runat="server"  OnTextChanged="txtBandeja_TextChanged"
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
                        </tr>
                        <tr>
                            
                            <td align="center">
                            <br />
                                <asp:Button ID="btnCancelarCarga" runat="server" class="Boton" text="Cancelar" Width="109px"/>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnConfirmaCarga" runat="server" class="Boton" text="Confirmar" Width="109px" OnClick="btnConfirmaCarga_Click"/>
                            </td>
                            
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
</asp:Content>