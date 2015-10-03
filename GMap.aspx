<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="GMap.aspx.cs" Inherits="GMap"  EnableViewState="false" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     
            <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
            </telerik:RadStyleSheetManager>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            </telerik:RadScriptManager>
            
            <div id="div_RightBar">
         <div class="div_RightBarCarsList">
              <asp:DataList ID="DataList1" runat="server" DataKeyField="id" 
                 DataSourceID="ods_carslist" Width="100%" CellPadding="4" 
                  ForeColor="#333333" Visible="False">
                  <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                 <ItemTemplate>
                     &nbsp;<asp:Label ID="Label1" runat="server" Text='<%# Eval("gd_car_id") %>'>
                     &nbsp; &nbsp;
                     </asp:Label><asp:HyperLink ID="hl_more" runat="server" 
                         NavigateUrl='<%# Eval("gd_car_id", "javascript:ShowLastPostStaticWin({0})") %>'>
                         
                         &gt;&gt;&gt;</asp:HyperLink>
               
                 </ItemTemplate>
                  <AlternatingItemStyle BackColor="White" />
                  <ItemStyle BackColor="#E3EAEB" />
                  <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                  <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
             </asp:DataList>
<div dir="ltr" style="color: #FFFFFF;">

<b>لیست متحرک ها</b>
<br />
             <telerik:RadTreeView ID="RadTreeView1" Runat="server" Height="100%" 
        Width="100%" CausesValidation="False" ForeColor="White">
                 <Nodes>
                     <telerik:RadTreeNode runat="server" Text="Root RadTreeNode1">
                         <Nodes>
                             <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 1">
                             </telerik:RadTreeNode>
                             <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 2">
                             </telerik:RadTreeNode>
                             <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 3">
                             </telerik:RadTreeNode>
                             <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 4">
                             </telerik:RadTreeNode>
                         </Nodes>
                     </telerik:RadTreeNode>
                     <telerik:RadTreeNode runat="server" Text="Root RadTreeNode2">
                     </telerik:RadTreeNode>
                     <telerik:RadTreeNode runat="server" Text="Root RadTreeNode3">
                     </telerik:RadTreeNode>
                 </Nodes>
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>

<ExpandAnimation Duration="250" Type="Linear"></ExpandAnimation>
             </telerik:RadTreeView>
<br />
</div>
         </div>
             <br />
             
             <asp:ObjectDataSource ID="ods_carslist" runat="server" 
                 OldValuesParameterFormatString="original_{0}" 
                 SelectMethod="GetData" 
                 TypeName="MainDataModuleTableAdapters.GPS_DataGetTopTableAdapter">
                 <SelectParameters>
                     <asp:SessionParameter DefaultValue="-1" Name="OwnerID" SessionField="OwnerID" 
                         Type="Int32" />
                 </SelectParameters>
             </asp:ObjectDataSource>
                 
            <div id="LastPosDialg" class="LastPosDialg">
            آخرین موقعیت وسیله انتخابی
            </div>


             <div class="LastPosDialg" >
                 <img src="img/aim.png" />
            <table style="font-family: tahoma; font-size: 11px">
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lbl_msg" runat="server"></asp:Label>
                        </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                    <tr>
                        <td>
                            از</td>
                        <td>
                            00:00 1300/00/00<br />
                            <asp:TextBox ID="txt_from" runat="server" Width="90px"></asp:TextBox>
                        
                        </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    تا</td>
                                <td>
                                    <asp:TextBox ID="txt_to" runat="server" Width="90px"></asp:TextBox>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chk_Filter" runat="server" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="drp_selectFilter" runat="server" Font-Names="Tahoma" 
                                        Font-Size="12px">
                                            <asp:ListItem Value="gd_speed">سرعت</asp:ListItem>
                                                        <asp:ListItem Value="gd_rep_id">نوع گزارش</asp:ListItem>
                                               
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    <asp:DropDownList ID="drp_selectMass" runat="server" Font-Names="Tahoma" 
                                        Font-Size="12px" Height="16px" Width="35px">
                                            <asp:ListItem Selected="True">=</asp:ListItem>
                                                        <asp:ListItem>&gt;</asp:ListItem>
                                               
                                            <asp:ListItem Value="&lt;"></asp:ListItem>
                                               
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txt_FilterValue" runat="server" Width="52px"></asp:TextBox>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    <a href="javascript:getPrevWayString();"> مرور مسیر</a> <br />
                                    <a href="javascript:CPW_Clear();"> حذف مسیر</a>
                                    <a href="gmap.aspx"> برگشت</a>
                          
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    <div>
                    
                        <table>
                            <tr>
                                <td>
                                    سرعت حرکت</td>
                                <td>
                                    <asp:TextBox ID="txt_play_speed" runat="server" Width="40px">30</asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                <a href="javascript:start();">
                                    نمایش
                                    
                                    </a></td>
                                    
                                <td>
                                <a href="javascript:__stop(1);">
                                    توقف
                                    </a>
                                    <br />
                                                               <a href="javascript:__stop(0);">
                                    ادامه
                                    </a>     
                                </td>
                                    
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    
                    </div>    
                        
            </div>
          
          <div id="PrevWayGridDiv" class="PrevWayGrid">
         
          
              <asp:HyperLink ID="HyperLink3" runat="server" 
                  NavigateUrl="javascript:hideWayPrevGrid(); " ForeColor="White">بستن</asp:HyperLink>
               <div id="PrevWayGridDivChild">
               
               </div>
           
         
         
         </div>
       
            
                </div>
            <div id="div_Center_inf">
         
         <!--
         <div id="div_loading">لطفا صبر کنید سیستم در حال خوانی اطلاعات می باشد...<img src="img/wait30trans.gif" /></div>
         -->
         
         <table style="font-family: tahoma; font-size: 11px; color: #FFFFFF;">
                     <tr>
                         <td class="Baafheiuwfhefrthyeryerrthyeryer">
                             کد</td>
                         <td ID="gd_car_id">
                             <img src="img/icons/lowicon59.png" /> </td>
                         <td class="Baafheiuwfhefrthyeryerrthyeryer">
                             ارسال</td>
                         <td ID="gd_date">
                             <img src="img/icons/lowicon59.png" /></td>
                         <td class="Baafheiuwfhefrthyeryerrthyeryer">
                             نوع موقعیت</td>
                         <td ID="RepDifValue">
                            <img src="img/icons/lowicon59.png" /></td>
                         <td class="Baafheiuwfhefrthyeryerrthyeryer">
                             ورودی ها</td>
                         <td ID="gd_input_id">
                             <img src="img/icons/lowicon59.png" /></td>
                         <td class="Baafheiuwfhefrthyeryerrthyeryer">
                             خروجی ها</td>
                         <td ID="gd_output_id">
                             <img src="img/icons/lowicon59.png" /></td>
                         <td class="Baafheiuwfhefrthyeryerrthyeryer">
                             موقعیت</td>
                         <td ID="gd_en">
                            <img src="img/icons/lowicon59.png" /></td>
                         <td class="Baafheiuwfhefrthyeryerrthyeryer">
                             سرعت</td>
                         <td ID="gd_speed">
                            <img src="img/icons/lowicon59.png" /></td>
                         <td>
                         </td>
                         <td>
                             &nbsp;</td>
                     </tr>
                 </table>
          <table id="tbl_information">
                    <tr>
                        <td>
                            <img alt="" src="img/icons/licon47_003.png"/></td>
                        <td>
                            ایستاده&nbsp;&nbsp;                 </td>
                        <td>
                            <img alt="" src="img/icons/licon15_004.png"/></td>
                        <td>
                            سرعت غیر مجاز&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                        <td>
                            <img alt="" src="img/icons/licon62_002.png" /></td>
                        <td>
                            سرعت مجاز
                        </td>
                                   
                                  
                                    <td>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                      
                                        
                    </tr>
                </table>
           
           
                
             <div id="map_canvas_div" class="map_canvas_div" onunload="GUnload()">
                 <div id="map_canvas" class="map_canvas">
            
                             
            </div>
            
                             
            </div>


        </div>  
        
        
        <div id="div_play_properties">
        
    
        
        </div>
        
            <div id="div_STATIC_button">
               
            </div>
            <div class="commandWindows" id="div_commandWindows" style="visibility: hidden">
            
            </div>



       <script type="text/javascript">


           //ShowPosition(0, false);
           var map = new GMap2(document.getElementById("map_canvas"));  // creating map;
           map.setCenter(new GLatLng(32, 51), 4);
           requestFirstCallPositionsString(map);
           //var AllCarBound;
           map.setMapType(G_NORMAL_MAP);
           map.setUIToDefault();

           // Enable the additional map types within
           // the map type collection
           map.enableRotation();



           // creating markers
           // first gathering informations from Object Array :)
            
            </script>
</asp:Content>
