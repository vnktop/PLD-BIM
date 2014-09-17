<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="VerificadorPLD.aspx.cs" Inherits="BIM.PLD.Website.VerificadorPLD.VerificadorPLD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  
<style type="text/css">
.tablaiz
{
    width: 150px;
    text-align: right;
}
.tabalder
{
     width: 250px;
     text-align: left;
}
</style> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
<center>
    <asp:UpdatePanel ID="upMain" runat="server">
        <ContentTemplate>               
            <table class="Tabla">
                <tr>
                    <td colspan="2">SIMULADOR SERVICIO PLD</td>
                </tr>
                <tr>
                    <td class="tablaiz">
                        USUARIO:</td>
                    <td class="tabalder">
                        <asp:DropDownList ID="ddlUsuario" runat="server" AppendDataBoundItems="true" CssClass="textbox">
                            <asp:ListItem Selected="True" Value="-1">-- SELECCIONE --</asp:ListItem>
                            <asp:ListItem>CARLOS MINOR</asp:ListItem>
                            <asp:ListItem>RICARDO MARTINEZ</asp:ListItem>
                            <asp:ListItem>WILBHER GOMEZ</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">
                        SUCURSAL:</td>
                    <td class="tabalder">
                        <asp:DropDownList ID="ddlSucursal" runat="server" AppendDataBoundItems="true" CssClass="textbox">
                            <asp:ListItem Selected="True" Value="-1">-- SELECCIONE --</asp:ListItem>
                            <asp:ListItem>SUCURSAL 1</asp:ListItem>
                            <asp:ListItem>SUCURSAL 2</asp:ListItem>
                            <asp:ListItem>SUCURSAL 3</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                 <tr>
                    <td class="tablaiz">
                        SISTEMA:</td>
                    <td class="tabalder">
                        <asp:DropDownList ID="ddlSistema" runat="server" AppendDataBoundItems="true" CssClass="textbox">
                            <asp:ListItem Selected="True" Value="-1">-- SELECCIONE --</asp:ListItem>
                            <asp:ListItem Value="4">Crédito Individual</asp:ListItem>
                            <asp:ListItem Value="5">Crédito Empresarial</asp:ListItem>
                            <asp:ListItem Value="14">Sibamex</asp:ListItem>
                            <asp:ListItem Value="15">Fiduciario</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvSIstema" runat="server" ControlToValidate="ddlSistema" InitialValue="-1" Text="*" ToolTip="seleccione sistema"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">
                        PERSONA INCIDENCIA:</td>
                    <td class="tabalder">
                        <asp:TextBox ID="tbPersonaIncidencia" runat="server" MaxLength="190" Width="250"></asp:TextBox>
                        <%--<asp:DropDownList ID="ddlPersonaIncidencia" runat="server" AppendDataBoundItems="true" CssClass="textbox">
                            <asp:ListItem Selected="True" Value="-1">-- SELECCIONE --</asp:ListItem>
                            <asp:ListItem Value="1">joaquín guzmán loera</asp:ListItem>
                            <asp:ListItem Value="2">chapo guzmán loera</asp:ListItem>
                            <asp:ListItem Value="3"> j ó a q u í n   g ú z m á n   l o e r a</asp:ListItem>
                            <asp:ListItem Value="4">otro</asp:ListItem>
                        </asp:DropDownList>--%>
                        <%--<asp:RequiredFieldValidator ID="rfvddlPersonaIncidencia" runat="server" ControlToValidate="ddlPersonaIncidencia" InitialValue="-1" Text="*" ToolTip="seleccione persona"></asp:RequiredFieldValidator>--%>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">
                        NOMBRE:</td>
                    <td class="tabalder">
                        <asp:TextBox ID="tbNombre" runat="server" MaxLength="90"  Width="150"></asp:TextBox>
                        <%--<asp:DropDownList ID="ddlNombre" runat="server" AppendDataBoundItems="true" CssClass="textbox">
                            <asp:ListItem Selected="True" Value="-1">-- SELECCIONE --</asp:ListItem>
                            <asp:ListItem Value="1">joaquín</asp:ListItem>
                            <asp:ListItem Value="2">chapo</asp:ListItem>
                            <asp:ListItem Value="3"> j ó a q u í n </asp:ListItem>
                            <asp:ListItem Value="4">otro</asp:ListItem>
                        </asp:DropDownList>--%>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">
                        AP PATERNO:</td>
                    <td class="tabalder">
                        <asp:TextBox ID="tbApPat" runat="server" MaxLength="90"  Width="150"></asp:TextBox>
                        <%--<asp:DropDownList ID="ddlApPat" runat="server" AppendDataBoundItems="true" CssClass="textbox">
                            <asp:ListItem Selected="True" Value="-1">-- SELECCIONE --</asp:ListItem>
                            <asp:ListItem Value="1">guzmán</asp:ListItem>
                            <asp:ListItem Value="2">loera</asp:ListItem>
                            <asp:ListItem Value="3"> g ú z m á n </asp:ListItem>
                            <asp:ListItem Value="4">otro</asp:ListItem>
                        </asp:DropDownList>--%>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">
                        AP MATERNO:</td>
                    <td class="tabalder">
                        <asp:TextBox ID="tbApMat" runat="server" MaxLength="90"  Width="150"></asp:TextBox>
                       <%-- <asp:DropDownList ID="ddlApMat" runat="server" AppendDataBoundItems="true" CssClass="textbox">
                            <asp:ListItem Selected="True" Value="-1">-- SELECCIONE --</asp:ListItem>
                            <asp:ListItem Value="1">loera</asp:ListItem>
                            <asp:ListItem Value="2">guzmán</asp:ListItem>
                            <asp:ListItem Value="3"> l o e r a</asp:ListItem>
                            <asp:ListItem Value="4">otro</asp:ListItem>
                        </asp:DropDownList>--%>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">
                        CLIENTE:</td>
                    <td class="tabalder">
                        <asp:DropDownList ID="ddlCliente" runat="server" AppendDataBoundItems="true" CssClass="textbox">
                            <asp:ListItem Selected="True" Value="-1">-- SELECCIONE --</asp:ListItem>
                            <asp:ListItem Value="1">CLIENTE 1</asp:ListItem>
                            <asp:ListItem Value="2">CLIENTE 2</asp:ListItem>
                            <asp:ListItem Value="3">CLIENTE 3</asp:ListItem>
                            <asp:ListItem Value="4">CLIENTE 4</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">
                        RELACIÓN CLIENTE</td>
                    <td class="tabalder">
                        <asp:DropDownList ID="ddlRelacionCliente" runat="server" AppendDataBoundItems="true" CssClass="textbox">
                            <asp:ListItem Selected="True" Value="-1">-- SELECCIONE --</asp:ListItem>
                            <asp:ListItem Value="1">ACREDITADO</asp:ListItem>
                            <asp:ListItem Value="2">COACREDITADO</asp:ListItem>
                            <asp:ListItem Value="3">ACCIONISTA</asp:ListItem>
                            <asp:ListItem Value="4">AVAL</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>       
                <tr>
                    <td>
                        &nbsp;</td>
                    <td class="tablaiz">
                        <asp:Button ID="btAccrion" runat="server" Text="EJECUTAR" CssClass="Boton" OnClick="ejecutarServicio" /></td>
                </tr>
                <tr>
                    <td colspan="2">RESULTADOS:
                    </td>           
                </tr>
                <tr>
                    <td class="tablaiz">TIPIFICACIÓN
                    </td>
                    <td class="tabalder">
                        <asp:Label ID="lbTipificacion" runat="server" CssClass="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">BLOQUEO USUARIO:
                    </td>
                    <td class="tabalder">
                        <asp:Label ID="lblBloqueoUsuario" runat="server" CssClass="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">BLOQUEO PROCESO:
                    </td>
                    <td class="tabalder">
                        <asp:Label ID="lblBloqueoProceso" runat="server" CssClass="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">MENSAJE:
                    </td>
                    <td class="tabalder">
                        <asp:Label ID="lblMensaje" runat="server" CssClass="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">CREO BITACORA:
                    </td>
                    <td class="tabalder">
                        <asp:Label ID="lblCreoBitacaora" runat="server" CssClass="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tablaiz">ENVÍO CORREO
                    </td>
                    <td class="tabalder">
                         <asp:Label ID="lblEnvioCorreo" runat="server" CssClass="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblMensajes" runat="server" CssClass="Label"></asp:Label>
                    </td>
                </tr>
            </table>
    
        </ContentTemplate>
    </asp:UpdatePanel>
</center>
</asp:Content>
