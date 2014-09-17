<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="wucBusquedaInteligente.ascx.cs" 
    Inherits="BIM.Regulatorios.Website.UserControl.Comun.wucBusquedaInteligente" %>

<%--<%@ Register Src="~/UserControl/Comun/Mensaje.ascx" TagName="wucMensaje" TagPrefix="uc1" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
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
<script type="text/javascript">
    // Work around browser behavior of "auto-submitting" simple forms
    var frm = document.getElementById("aspnetForm");
    if (frm) {
        frm.onsubmit = function () { return true; };
    }
</script>

<%--<uc1:wucMensaje ID="wucMensajeSistema" runat="server" />--%>
<table width="100%">
    <tr>
        <td class="style1">
        </td>
        <td align="right" class="style2">
            <asp:Label ID="lblBusqueda" runat="server" Text="Busqueda:" BackColor="" CssClass="Label"></asp:Label>
        </td>
        <td align="left">
            <asp:HiddenField ID="hdnValue" OnValueChanged="hdnValue_ValueChanged" runat="server" />
            <asp:TextBox runat="server" ID="myTextBox" Width="300" autocomplete="off" />
            <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="AutoCompleteEx" ID="autoComplete1"
                TargetControlID="myTextBox" ServicePath="~/WsRegulatorio/BusquedaInteligenteWS.asmx"
                ServiceMethod="GetCompletionList" MinimumPrefixLength="2" CompletionInterval="0"
                EnableCaching="false" CompletionListCssClass="autocomplete_completionListElement"
                CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" OnClientItemSelected="IAmSelected">
                <Animations>
                    <OnShow>
                        <Sequence>
                            <%-- Make the completion list transparent and then show it --%>
                            <OpacityAction Opacity="0" />
                            <HideAction Visible="true" />
                            
                            <%--Cache the original size of the completion list the first time
                                the animation is played and then set it to zero --%>
                            <ScriptAction Script="
                                // Cache the size and setup the initial size
                                var behavior = $find('AutoCompleteEx');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                    }
                                    "/>
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx')._height" />
                            </Parallel>
                        </Sequence>
                    </OnShow>
                    <OnHide>
                        <%-- Collapse down to 0px and fade out --%>
                        <Parallel Duration=".4">
                            <FadeOut />
                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx')._height" EndValue="0" />
                        </Parallel>
                    </OnHide>
                </Animations>
            </ajaxToolkit:AutoCompleteExtender>
            <%-- Prevent enter in textbox from causing the collapsible panel from operating --%>
            <input type="submit" style="display: none;" />
        </td>
        <td>
        </td>
    </tr>
</table>