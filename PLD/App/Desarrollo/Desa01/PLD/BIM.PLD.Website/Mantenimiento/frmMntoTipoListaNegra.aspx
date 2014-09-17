<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="frmMntoTipoListaNegra.aspx.cs" Inherits="BIM.PLD.Website.Mantenimiento.frmMntoTipoListaNegra" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="hcm" TagName="cMensajes" Src="~/UserControl/Comun/Mensaje.ascx" %>
<%--<%@ Register Src="~/UserControl/Comun/wucBusquedaInteligenteTA.ascx" TagName="wucBusquedaInteligente" TagPrefix="uc1" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
.select  
{    
border:         1px solid #ccc;
padding:        6px 4px;
outline:        none;       
margin:         0;   
display:        block;
background:     #fff;  
font-family:    Tahoma, Helvetica, sans-serif;
font-size:      11px;
font-style:     normal;
font-weight:    bold;
color:          #006847;
}  
</style> 
<style type="text/css">
    div#AdjResultsDiv
    {
        width: expression((screen.width-30));
        height: expression((screen.height/2.55));
        overflow: scroll;
        position: relative;
    }
        
    div#AdjResultsDiv th
    {
        top: expression(document.getElementById("AdjResultsDiv").scrollTop-2);
        left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft);
        position: relative;
        z-index: 999999;
    }
        
        
    div#div-datagrid
    {
        width: 420px;
        height: 200px;
        overflow: auto;
        scrollbar-base-color: #ffeaff;
    }
        
    /* Locks the left column */
        
    td.locked
    {
        font-size: 7pt;
        text-align: left;
        background-color: inherit;
        color: Black;
        position: relative;
        cursor: default;
        left: expression(document.getElementById("AdjResultsDiv").scrollLeft-2); /*IE5+ only*/
    }
        
        
        
    /* Keeps the header as the top most item. Important for top left item*/
        
    th.locked
    {
        z-index: 99;
    }
        
        
    /* DataGrid Item and AlternatingItem Style*/
        
    .GridRow
    {
        font-size: 7pt;
        color: black;
        font-family: Verdana;
        background-color: #ffffff;
        height: 15px;
    }
        
    .GridAltRow
    {
        font-size: 7pt;
        color: black;
        font-family: Verdana;
        background-color: #eeeeee;
        height: 15px;
    }
</style>   
 <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        .Grid td
        {
            background-color: #A1DCF2;
            color: black;
            font-size: 10pt;
            line-height:200%
        }
        .Grid th
        {
            background-color: #3AC0F2;
            color: White;
            font-size: 10pt;
            line-height:200%
        }
        .ChildGrid td
        {
            background-color: #eee !important;
            color: black;
            font-size: 10pt;
            line-height:200%
        }
        .ChildGrid th
        {
            background-color: #6C6C6C !important;
            color: White;
            font-size: 10pt;
            line-height:200%
        }
    </style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>  
<script type="text/javascript">
    $("[src*=plus]").live("click", function () {
        $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
        $(this).attr("src", "../App_Images/minus.png");
    });
    $("[src*=minus]").live("click", function () {
        $(this).attr("src", "../App_Images/plus.png");
        $(this).closest("tr").next().remove();
    });
    </script>     
<script src="../JavaScript/JQuery/jquery-1.6.2.min.js" type="text/javascript"></script>
<script src="../JavaScript/JQuery/jquery-ui.js" type="text/javascript"></script>
<script src="../JavaScript/JQuery/ui.core.js" type="text/javascript"></script>
<link href="../Styles/sliding-panel.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler() {
        }
        $(".trigger").click(function () {
            $(".panel").toggle("fast");
            $(this).toggleClass("active");
            return false;
        });
    });
    function OcultarPanel() {
        if ($("#ddlTipoLista option:selected").text() == 0 || $("#ddlTipoTipificacion option:selected").text() == 0) {
            return false;
        }
    }        
</script>
<style type="text/css">
    .style1
    {
        width: 5%;
    }
    .style2
    {
        width: 20%;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <asp:UpdatePanel ID="upJquery" runat="server">
    <ContentTemplate>
    <center>
        <asp:Label ID="lblTitulo" runat="server" Text=" MANTENIMIENTO TIPO LISTA NEGRA"
            ForeColor="#006600" Font-Size="Large"></asp:Label>
    </center>        
    <div class="panel">
        <h3>
            <center>
                MANTENIMIENTO TIPO LISTA NEGRA
            </center>
        </h3>
        <div class="content" style="width:425px; text-align:center;">
        <center>
            <table>
                <tr>
                    <td colspan="3" style="text-align: center" width="49%px">
                        <asp:Label ID="lblTitTipoLista" runat="server" CssClass="Label" Text="TIPO DE LISTA" 
                            Width="100%"></asp:Label>
                    </td>
                    <td width="2%">
                        &nbsp;</td>
                    <td colspan="3" style="text-align: center" width="49%">
                        <asp:Label ID="lblTitTipTipificación" runat="server" CssClass="Label" 
                            Text="TIPO DE TIPIFICACIÓN  " Width="100%"></asp:Label>                            
                    </td>
                </tr>
                <tr>
                    <td width="47%">
                        <asp:DropDownList ID="ddlTipoLista" runat="server" CssClass="select" Width="100%" ValidationGroup="buscar">
                        </asp:DropDownList>
                    </td>
                    <td width="1%">
                        <asp:RequiredFieldValidator ID="rfvddlTipoLista" runat="server" 
                            ControlToValidate="ddlTipoLista" Display="Dynamic" 
                            ErrorMessage="Seleccionar tipo de lista" InitialValue="0" 
                            SetFocusOnError="True" Text="*" ToolTip="Seleccionar tipo de lista" ValidationGroup="buscar"></asp:RequiredFieldValidator>
                    </td>
                    <td width="1%">
                        &nbsp;</td>
                    <td width="2%">
                        &nbsp;</td>
                    <td width="47%">
                        <asp:DropDownList ID="ddlTipoTipificacion" runat="server" CssClass="select" Width="100%" ValidationGroup="buscar">                                
                        </asp:DropDownList>
                    </td>
                    <td width="1%">
                        <asp:RequiredFieldValidator ID="rfvddlTipoTipificacion" runat="server" 
                            ControlToValidate="ddlTipoTipificacion" Display="Dynamic" 
                            ErrorMessage="Seleccionar tipo de tipificación" InitialValue="0" SetFocusOnError="True" 
                            Text="*" ToolTip="Seleccionar tipo de tipificación" ValidationGroup="buscar"></asp:RequiredFieldValidator>
                    </td>
                    <td width="1%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="7" width="100%">                
                        <table width="100%">
                            <tr>
                                <td width="50%" style="text-align: left">
                                    <asp:Button ID="btnBuscarMB" runat="server" CssClass="Boton" Text="BUSCAR" CommandName="BUSCAR" OnClick="menu" ValidationGroup="buscar" />
                                </td>
                                <td width="50%" style="text-align: right">
                                    <asp:Button ID="btnAccionMB" runat="server"  CssClass="Boton" Text="NUEVO" CommandName="NUEVO" OnClick="menu" OnClientClick="OcultarPanel();" CausesValidation="false"/>
                                </td>
                            </tr>
                        </table>                
                    </td>                   
                </tr>
            </table>
        </center>                          
        </div>
    </div>
</ContentTemplate>
</asp:UpdatePanel>
<a class="trigger" href="#">BUSQUEDA</a>
<asp:UpdatePanel ID="upMain" runat="server">
    <ContentTemplate>
        <div>
            <hcm:cMensajes ID="cMensajes" runat="server" />
        </div>
               
        <asp:Panel ID="pResultadoMotorBusqueda" runat="server" >
            <div style="margin-bottom: 10px;">  
                <div style="border: dashed 1px #222222;">        
                    <div id="up_container" > 
                        <asp:UpdatePanel ID="upResultadoMotorBusqueda" runat="server">
                            <ContentTemplate>                            
                                <center>
                                    <asp:GridView ID="gvResultadoMotorBusqueda" runat="server" AutoGenerateColumns="false"
                                        AllowSorting="false" PageSize="5" AllowPaging="true"  
                                        OnRowDataBound="gvResultadoMotorBusqueda_OnRowDataBound"   
                                        OnPageIndexChanging="gvResultadoMotorBusqueda_OnPageIndexChanging"          
                                        EmptyDataText="NO EXISTEN REGISTROS">
                                        <Columns>     
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <img alt = "" style="cursor: pointer" src="../App_Images/plus.png" />
                                                    <asp:Panel ID="pnlDetalles" runat="server" Style="display: none">                                       
                                                        <asp:GridView ID="gvBusquedaSistema" runat="server" AutoGenerateColumns="false" OnRowDataBound="gvBusquedaSistema_OnRowDataBound"                                          
                                                            OnRowCommand="gvBusquedaSistema_OnRowCommand" >                                        
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <%# Convert.ToInt32(DataBinder.Eval(Container, "DataItemIndex")) + 1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>                                                              
                                                                <asp:TemplateField HeaderText="TIPO DE LISTA">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvTipoLista" runat="server" Text='<%# Bind("vchTipoLista") %>'></asp:Label>                                                    
                                                                    </ItemTemplate>                   
                                                                </asp:TemplateField>                    
                                                                <asp:TemplateField HeaderText="DESCRIPCIÓN">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvDescripcion" runat="server" Text='<%# Bind("VCDDESCRIPCION") %>'></asp:Label>   
                                                                    </ItemTemplate>                   
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="PAIS">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvPais" runat="server" Text='<%# Bind("vchPais") %>'></asp:Label>   
                                                                    </ItemTemplate>                   
                                                                </asp:TemplateField>                                                      
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="ibtEditar" runat="server" ImageUrl="~/App_Images/edit.gif" 
                                                                            BackColor="Transparent" CausesValidation="false" Width="16px" Height="16px"
                                                                            CommandName="ACTUALIZAR" CommandArgument='<%# Eval("intTipoTipificacionID")  + "," + Eval("vchTipoLista") + "," + Eval("intTipoListaID")%>' ToolTip="EDITAR"/>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="ibtEliminar" runat="server" ImageUrl="../Images/delete.png"
                                                                            BackColor="Transparent" CausesValidation="false" Width="16px" Height="16px"
                                                                            CommandName="ELIMINAR" CommandArgument='<%# Eval("intTipoListaID") %>' ToolTip="ELIMINAR"/>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>                    
                                                            </Columns>
                                                            <AlternatingRowStyle CssClass="alternatingrowstyle" />
                                                            <HeaderStyle CssClass="headerstyle" />
                                                            <RowStyle CssClass="rowstyle" />                                                                                                           
                                                        </asp:GridView>                                                                                                                                            
                                                    </asp:Panel>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="TIPO DE TIPIFICACIÓN">
                                            <ItemTemplate>
                                                <asp:Label ID="lblgvTipoSistema" runat="server" Text='<%# Bind("vchTipoTipificacion") %>'></asp:Label>   
                                            </ItemTemplate>                   
                                        </asp:TemplateField>  
                                        </Columns>
                                        <PagerTemplate>
                                            <asp:Label ID="lbTemplate" runat="server" Text="Muestra Filas: " CssClass="Label">
                                            </asp:Label>
                                            <asp:DropDownList ID="dlBandeja" runat="server" AutoPostBack="true" CausesValidation="false"
                                                Enabled="true" OnSelectedIndexChanged="ddlBandeja_SelectedIndexChanged">
                                                <asp:ListItem Value="5" />
                                                <asp:ListItem Value="10" />
                                                <asp:ListItem Value="15" />
                                                <asp:ListItem Value="20" />
                                                <asp:ListItem Value="25" />
                                            </asp:DropDownList>
                                            &nbsp; Página
                                            <asp:TextBox ID="txtBandeja" runat="server" AutoPostBack="true" OnTextChanged="txtBandeja_TextChanged"
                                                Width="40" MaxLength="10">
                                            </asp:TextBox>
                                            de
                                            <asp:Label ID="lbBandejaTotal" runat="server" />
                                            &nbsp;
                                            <asp:Button ID="btnBandeja_I" runat="server" CommandName="Page" CausesValidation="false"
                                                ToolTip="Pagina Anterior" CommandArgument="Prev" CssClass="previous" />
                                            <asp:Button ID="btnBandeja_II" runat="server" CommandName="Page" CausesValidation="false"
                                                ToolTip="Pagina Siguiente" CommandArgument="Next" CssClass="next" />
                                        </PagerTemplate> 
                                        <AlternatingRowStyle CssClass="alternatingrowstyle" />
                                        <HeaderStyle CssClass="headerstyle" />
                                        <RowStyle CssClass="rowstyle" />
                                    </asp:GridView>
                                </center>          
                            </ContentTemplate>          
                        </asp:UpdatePanel>                 
                    </div>
                </div>
            </div>               
        </asp:Panel>     
        <asp:Button ID="btnShowPopUp_AccionRegistro" runat="server" Style="display:none; " />
        <AjaxToolkit:ModalPopupExtender ID="mpeAccionRegistro" runat="server"
            TargetControlID="btnShowPopUp_AccionRegistro"
            PopupControlID="pnlPopupAccionRegistro"
            PopupDragHandleControlID="pnlAccionRegistro"
            BackgroundCssClass="modalBackground"
            CancelControlID="btnCancelarAccion"
            Drag="false"
            DynamicServicePath="" Enabled="true">
        </AjaxToolkit:ModalPopupExtender>       
                    
        <asp:Panel ID="pnlPopupAccionRegistro" runat="server" Width="300px" HorizontalAlign="Center" Style="display:none;">
            <asp:Panel ID="pnlAccionRegistro" runat="server" BackColor="White" Width="100%">               
                <table class="Tabla" width="100%">
                    <tr>                           
                        <td class="Titulo" colspan="2">
                            <center>
                                TIPO LISTA NEGRA
                            </center>
                        </td>
                    </tr>
                    <tr>                       
                        <%--<td style="text-align: right" width="40%">
                            <asp:Label ID="lbTitTipoTipificacion" runat="server" CssClass="Label" Text="TIPO TIPIFICACIÓN"></asp:Label>
                        </td>--%>
                        <td colspan="3" style="text-align: left" width="100%">                                                                                    
                            <%--<uc1:wucBusquedaInteligente ID="cuBI" runat="server" />--%>
                            <table width="100%">
                                <tr>
                                    <td class="style1">
                                    </td>
                                    <td align="right" class="style2">
                                        <asp:Label ID="lblBusqueda" runat="server" Text="Busqueda:" BackColor="" CssClass="Label"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <%--<asp:HiddenField ID="hdnValue" OnValueChanged="hdnValue_ValueChanged" runat="server" />--%>
                                        <asp:DropDownList ID="ddlCatTipoListaNegra" runat="server" CssClass="select"></asp:DropDownList>
                                    </td>
                                    <td align="left">
                                        <asp:RequiredFieldValidator ID="rfvddlCatTipoListaNegra" runat="server" ControlToValidate="ddlCatTipoListaNegra" ErrorMessage="seleccionar valor de tipo tipificación" InitialValue="0" Text="*"></asp:RequiredFieldValidator>                                                               
                                    </td>
                                   <td align="left">
                                        <asp:UpdatePanel ID="upEdicioAgregar" runat="server">
                                            <ContentTemplate>
                                                <table>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:ImageButton ID="ibtEditar" runat="server" ImageUrl="~/App_Images/edit.gif" 
                                                                BackColor="Transparent" Width="16px" Height="16px" ToolTip="EDITAR" CausesValidation="false"
                                                                onclick="ibtEditar_Click"/>
                                                        </td>                            
                                                        <td align="left">
                                                            <asp:ImageButton ID="ibAgregar" runat="server" 
                                                                ImageUrl="~/App_Images/AddRecord.png" BackColor="Transparent" 
                                                                Width="16px" Height="16px" ToolTip="AGREGAR" CausesValidation="false" 
                                                                onclick="ibAgregar_Click"/>
                                                        </td>
                                                       <%-- <td>
                                                            <asp:RequiredFieldValidator ID="rfvddlBusquedaTipoAccion" runat="server" ControlToValidate="ddlBusquedaTipoAccion" Display="Dynamic" ErrorMessage="SELECCIONAR ITEM PARA EDICIÓN" InitialValue="-1" ValidationGroup="EscenarioEdicion" TEXT="SELECCIONAR ITEM PARA EDICIÓN"></asp:RequiredFieldValidator>
                                                        </td>--%>
                                                        </tr>
                                                </table>                                             
                                            </ContentTemplate>  
                                            <%--<Triggers>                                                    
                                                <asp:PostBackTrigger ControlID="btnCancelar" />
                                            </Triggers>   --%>                               
                                        </asp:UpdatePanel> 
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>
                                        <asp:Label ID="lbMensajesTitTipoListaNegra" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>--%>
                            </table>
                        </td>     
                    </tr>
                    <tr>                                
                        <td style="text-align: right" width="40%">
                            <asp:Label ID="lbTitTipoLista" runat="server" CssClass="Label" Text="TIPO LISTA"></asp:Label>
                        </td>
                        <td style="text-align: left" width="60%">                            
                            <asp:TextBox ID="tbTipoListaValor" runat="server" CssClass="textbox" Width="100%" MaxLength="4"></asp:TextBox>
                            <ajaxToolkit:TextBoxWatermarkExtender ID="tbmetbTipoListaValor" runat="server" TargetControlID="tbTipoListaValor" WatermarkText="<4 CARACTERERS>">
                            </ajaxToolkit:TextBoxWatermarkExtender>
                        </td>        
                        <td align="left">
                            <asp:RequiredFieldValidator ID="rfvtbTipoListaValor" runat="server" ControlToValidate="tbTipoListaValor" ErrorMessage="Ingresar valor de tipo de lista" Text="*"></asp:RequiredFieldValidator>                  
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" width="40%">
                            <asp:Label ID="lblTitDescripcipon" runat="server" CssClass="Label" 
                                Text="DESCRIPCIÓN" Width="100%"></asp:Label>
                        </td>                        
                        <td style="text-align: left" width="60%">
                           <asp:TextBox ID="tbDescripcionValor" runat="server" CssClass="textbox" Width="100%"></asp:TextBox>                    
                        </td>            
                        <td align="left">
                            <asp:RequiredFieldValidator ID="rfvtbDescripcionValor" runat="server" ControlToValidate="tbDescripcionValor" ErrorMessage="Ingresar descripción de la lista" Text="*"></asp:RequiredFieldValidator>                  
                        </td>            
                    </tr>
                    <tr>
                        <td style="text-align: right" width="40%">
                            <asp:Label ID="lblTitPais" runat="server" CssClass="Label" 
                                Text="PAIS" Width="100%"></asp:Label>
                        </td>                        
                        <td style="text-align: left" width="60%">
                           <asp:TextBox ID="tbPaisValor" runat="server" CssClass="textbox" Width="100%"></asp:TextBox>                    
                        </td>  
                        <td align="left">
                            <asp:RequiredFieldValidator ID="rfvtbPaisValor" runat="server" ControlToValidate="tbPaisValor" ErrorMessage="Ingresar pais de procedencia" Text="*"></asp:RequiredFieldValidator>                  
                        </td>                        
                    </tr>
                    <tr>                  
                        <td colspan="2">
                            <table width="100%">
                                <tr>
                                    <td align="left" width="50%"> 
                                        <asp:Button ID="btnAccion" runat="server" CssClass="Boton" OnClick="menu" />
                                    </td>                        
                                    <td align="right" width="50%">
                                        <asp:Button ID="btnCancelarAccion" runat="server" Text="Cancelar" 
                                            CssClass="Boton" CausesValidation="false" 
                                            />
                                    </td>   
                                </tr>
                            </table>
                        </td>                             
                    </tr>
                </table>
            </asp:Panel>
        </asp:Panel>          
    
    <asp:Button ID="btnShowPopUp_EliminarRegistro" runat="server" Style="display:none; " />
    <AjaxToolkit:ModalPopupExtender ID="mpeEliminarRegistro" runat="server"
        TargetControlID="btnShowPopUp_EliminarRegistro"
        PopupControlID="pnlPopupEliminarRegistro"
        PopupDragHandleControlID="pnlEliminarRegistro"
        BackgroundCssClass="modalBackground"
        CancelControlID="btnCancelarEliminar"
        Drag="false"
        DynamicServicePath="" Enabled="true">
    </AjaxToolkit:ModalPopupExtender>       
                    
    <asp:Panel ID="pnlPopupEliminarRegistro" runat="server" Width="320px" HorizontalAlign="Center" Style="display:none;">
        <asp:Panel ID="pnlEliminarRegistro" runat="server" BackColor="White" Width="100%">               
            <table class="Tabla" width="100%">
                <tr>                           
                    <td class="Titulo" colspan="3">
                        <center>
                            TIPO LISTA NEGRA
                        </center>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <asp:Label ID="lblMensajeEliminarRegsitro" runat="server" CssClass="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left"> 
                        <asp:Button ID="btnAceptarEliminar" runat="server" Text="Aceptar" CssClass="Boton" OnClick="menu" CommandName="ELIMINAR" CausesValidation="false" />
                    </td>
                    <td></td>
                    <td align="right">
                        <asp:Button ID="btnCancelarEliminar" runat="server" Text="Cancelar" CssClass="Boton" CausesValidation="false"  />
                    </td>         
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>     
    
      <asp:Button ID="btnShowPopUp_EditarAgregarRegistro" runat="server" Style="display:none; " />
    <AjaxToolkit:ModalPopupExtender ID="mpeEditarAgregarRegistro" runat="server"
        TargetControlID="btnShowPopUp_EditarAgregarRegistro"
        PopupControlID="pnlPopupEditarAgregarRegistro"
        PopupDragHandleControlID="pnlEditarAgregarRegistro"
        BackgroundCssClass="modalBackground"
       
        Drag="false"
        DynamicServicePath="" Enabled="true">
    </AjaxToolkit:ModalPopupExtender>                                   
    <asp:Panel ID="pnlPopupEditarAgregarRegistro" runat="server" Width="400px" HorizontalAlign="Center" Style="display:none;">
        <asp:Panel ID="pnlEditarAgregarRegistro" runat="server" BackColor="White" Width="100%">               
            <table class="Tabla" width="100%">
                <tr>                           
                    <td class="Titulo" colspan="3">
                        <center>
                            REGISTRO TIPO TIPIFICACIÓN
                        </center>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbTitIdTipoTipificación" runat="server" CssClass="Label" Text="ID TIPO TIPIFICACIÓN"></asp:Label>                        
                    </td>
                    <td>
                        <asp:Label ID="lbTitTipoTipificacion" runat="server" CssClass="Label" Text="TIPO TIPIFICACIÓN"></asp:Label>
                    </td>                  
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lbIdTipoTipificacionValor" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbTipoTipificacionValor" runat="server" Width="150px" ValidationGroup="AgregarEditar"></asp:TextBox>
                    </td>
                </tr>
                <tr>                      
                    <td align="left">
                        <asp:RequiredFieldValidator ID="rfvtbRegistroTipoAccion" runat="server" Display="Dynamic" ControlToValidate="tbTipoTipificacionValor" Text="INGRESAR REGISTRO" ValidationGroup="AgregarEditar"></asp:RequiredFieldValidator>
                    </td>
                    <td align="left">
                        <%--<asp:RequiredFieldValidator ID="rfvtbIDCNBV" runat="server" Display="Dynamic" ControlToValidate="tbIDCNBV" Text="INGRESAR CLAVE" ValidationGroup="AgregarEditar"></asp:RequiredFieldValidator>--%>
                    </td>
                </tr>
                <tr>
                    <td align="left"> 
                        <asp:Button ID="btnAceptarAccion" runat="server" CssClass="Boton" OnClick="accion" ValidationGroup="AgregarEditar" />
                    </td>                                               
                    <td align="right">                                                                            
                        <asp:Button ID="btnCancelar" runat="server" CssClass="Boton" Text="CANCELAR"  OnClick="mantenerPanelCaptura" CausesValidation="false" />                        
                    </td>         
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel> 
                  
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" HeaderText="Existen campos faltantes en la captura." DisplayMode="List"  />        
   
    </ContentTemplate>
   <%-- <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnAccionMB" />
    </Triggers>--%>
</asp:UpdatePanel>

<asp:UpdatePanel ID="upPanelRegistro" runat="server">
    <ContentTemplate>
       

</ContentTemplate>         
</asp:UpdatePanel>
                
   
    

</asp:Content>
