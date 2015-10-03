<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_POIManager.ascx.cs" Inherits="ascx_frm_POIManager" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
    

    <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
</telerik:RadScriptManager>

<div style="top: 220px">

<div id="div_RightBarPOI">
<table style="">
        <tr>
            <td style="width: 0px; vertical-align: top; text-align: right; background-color: #FFFFFF;    -moz-border-radius: 5px;border-radius: 5px;">
                          <asp:UpdatePanel ID="UpdatePanel_BTN" runat="server">
                      
                        <ContentTemplate>

            
                <table>
                    <tr>
                        <td>
                                 <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">افزودن شاخه جدید</asp:LinkButton>
                                <br />
                                <asp:LinkButton ID="LinkButton2" runat="server" onclick="LinkButton2_Click">افزودن زیر شاخه</asp:LinkButton>
               
                          &nbsp;<br />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td dir="rtl" style="text-align: right">
                            <asp:Panel ID="pnl_edit" runat="server" Visible="False">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtCaptionEdit" runat="server"></asp:TextBox>
                                            <br />
                                            <asp:LinkButton ID="LinkButton4" runat="server" onclick="LinkButton4_Click">تائید ویرایش</asp:LinkButton>
                                                             <br />
                                <asp:LinkButton ID="LinkButton3" runat="server" onclick="btnDeleteBranch_Click">حذف</asp:LinkButton>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <telerik:RadTreeView ID="rtvLayers" Runat="server" 
                                onnodeclick="RadTreeView1_NodeClick">
                                <CollapseAnimation Duration="100" Type="OutQuint" />
                                <ExpandAnimation Duration="100" />
                            </telerik:RadTreeView>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
                <div>

                    
                </div>
                
                                        </ContentTemplate>
                         
                        </asp:UpdatePanel>
                
                
            </td>
            <td style="vertical-align: top; text-align: right">
            



</td>
        </tr>
    </table>
</div>


<div id="div_Center_inf_poi" style="font-family: tahoma; font-size: 11px; background-color: #FFFFFF;" dir="rtl">
<div>
<div class="poi_list" id="div_poi_list">
</div>

                <div  class="map_canvas_div_poi">
                
                <div id="map_canvas" class="map_canvas">
                
                </div>
                
                </div>
</div>






    

</div>

</div>


<script type="text/javascript">

    var _map = new GMap2(document.getElementById("map_canvas"));  // creating map;
    _map.setCenter(new GLatLng(32, 51), 4);
    var gmrk;
    GEvent.addListener(_map, "singlerightclick", mapSingleRightClick);




timerID = setTimeout("showCountDown()", 999000);
</script>