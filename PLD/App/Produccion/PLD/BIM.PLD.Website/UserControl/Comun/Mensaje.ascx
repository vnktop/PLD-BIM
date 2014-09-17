<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Mensaje.ascx.cs" Inherits="Automatizacion.ControlesComunes.Mensaje" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:HiddenField runat="server" ID="hidModal" />
<style type="text/css">
    ._ModalPopup
    {
        background-color: White;
        border-width: 3px;
        border-style: solid;
        border-color: Gray;
        padding: 3px;
        z-index: 888888 !important;
    }
    ._Mensaje
    {
        width: auto;
        height: auto;
        padding: 20px;
        margin-left: auto;
        margin-right: auto;
        margin-top: auto;
        z-index: 100050 !important;
    }
</style>
<%--<ajaxToolkit:ModalPopupExtender ID="mpeConfirmacion" runat="server" 
        Enabled="True" 
        BackgroundCssClass="modalBackground"
        TargetControlID="hidModal" 
        PopupControlID="pnlConfirmacion"
        CancelControlID="btnCerrarConfirmacion" 
        >
    </ajaxToolkit:ModalPopupExtender>--%>
<ajaxToolkit:ModalPopupExtender ID="mpeConfirmacion" runat="server" TargetControlID="hidModal"
    PopupControlID="pnlPopup_ClientesNuevos" CancelControlID="btnCerrarConfirmacion"
    BackgroundCssClass="modalBackground" DropShadow="false" Drag="false" />
<asp:Panel ID="pnlPopup_ClientesNuevos" runat="server" Style="display: none" class="_Mensaje">
    <asp:Panel ID="pnlConfirmacion" runat="server">
        <table width="60%" style="height: 80%; " class="Tabla" >
            <tr>
                <td style="text-align: center" class="Titulo">
                    Mensaje del Sistema
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr style="margin-left: 15px; margin-right: 15px;">
                <td>
                    <asp:UpdatePanel runat="server" ID="upaeMensaje">
                        <ContentTemplate>
                            <asp:Panel ID="Panel1" runat="server" GroupingText="Mensaje: ">
                                <table>
                                    <tr>
                                        <td align="center">
                                            <asp:Image runat="server" ID="imgMensaje" ImageUrl="~/App_Images/correcto.gif" Width="60%"
                                                Height="60%" />
                                        </td>
                                        <td align="left" style="vertical-align:middle;" >
                                            <div style="overflow:auto; width:100%; height:200px; vertical-align:middle; text-align:center;">
                                                <asp:Label ID="lblMensaje" Text="" runat="server" ForeColor="WindowFrame" Font-Size="Small">
                                                </asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center">
                    <%--<asp:UpdatePanel runat="server" ID="updCerrar">
                        <ContentTemplate>
                            <asp:Button ID="btnCerrarConfirmacion" runat="server" Text="Cerrar" CssClass="Boton"
                                CausesValidation="false" OnClick="btnCerrarConfirmacion_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>--%>
                    <asp:Button ID="btnCerrarConfirmacion" runat="server" Text="Cerrar" CssClass="Boton"
                                CausesValidation="false" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Panel>
