<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_ReportPreviewWay.ascx.cs" Inherits="ascx_frm_ReportPreviewWay" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<style type="text/css">
    .style87465
    {
        text-align: center;
    }
</style>



<div dir="rtl" 
    style="font-family: tahoma; font-size: 11px; background-color: #FFFFFF;">
<div>
    <table>
                <tr>
            <td>
                    </td>
                    <td>
                        <a href="javascript:getNecInfoForReport();">مرور گزارش</a>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
            <td>
                از</td>
                    <td dir="rtl">
                        <asp:TextBox ID="txt_from" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp; </td>
                </tr>
                <tr>
                    <td>
                        تا&nbsp;</td>
                    <td  dir="rtl">
                        <asp:TextBox ID="txt_to" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3">
                        <hr />
                        <asp:CheckBox ID="chk_filter_reportID" runat="server" Checked="True" 
                            Enabled="False" />
                        <b>فیلتر نوع گزارش</b></td>
                </tr>
                <tr>
                    <td colspan="3">
                      <input 
                      id="chk_all_repid" 
                      name="chk_all_repid"  
                      type="checkbox" 
                      onclick="checkAllReportIDChecks()" />
                      تمامی موارد <br />
                       
                        <div id="divRepIDList" >
                           
                               <asp:DataList ID="DataList1" runat="server" DataKeyField="id" 
                                DataSourceID="ods_RepID">
                                <ItemTemplate>
            
                                    <input 
                                    type="checkbox" 
                                    class="CheckBoxRepID" 
                                    id=<%# Eval("RepDifID", "{0}")%> />
                                    
                                    <%# Eval("RepDifValue", "{0}") %><br />
                                    
                                    
        
                     
                                   
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                     
                            <asp:ObjectDataSource ID="ods_RepID" runat="server" DeleteMethod="Delete" 
                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                SelectMethod="GetDataBy" 
                                TypeName="MainDataModuleTableAdapters.tbl_report_defineTableAdapter" 
                                UpdateMethod="Update">
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_id" Type="Int32" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="RepDifID" Type="Int32" />
                                    <asp:Parameter Name="RepDifValue" Type="String" />
                                    <asp:Parameter Name="RepDifAgent" Type="Int32" />
                                    <asp:Parameter Name="RepUnitModel" Type="String" />
                                    <asp:Parameter Name="Original_id" Type="Int32" />
                                </UpdateParameters>
                                <SelectParameters>
                                    <asp:Parameter Name="RepUnitModel" Type="String" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="RepDifID" Type="Int32" />
                                    <asp:Parameter Name="RepDifValue" Type="String" />
                                    <asp:Parameter Name="RepDifAgent" Type="Int32" />
                                    <asp:Parameter Name="RepUnitModel" Type="String" />
                                </InsertParameters>
                            </asp:ObjectDataSource>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <hr />
                        <b>
                        <asp:CheckBox ID="chk_filter_io" runat="server" />
                        فیلتر ورودی و خروجی ها<br />
                        (غیرفعال)</b></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="style87465">
                                    &nbsp;</td>
                                <td class="style87465">
                                    حرارت</td>
                                <td class="style87465">
                                    1</td>
                                <td class="style87465">
                                    2</td>
                                <td class="style87465">
                                    3</td>
                                <td class="style87465">
                                    4</td>
                            </tr>
                            <tr>
                                <td>
                                    خروجی</td>
                                <td>
                                    <asp:CheckBox ID="chk_bit0_ignition" runat="server" />
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_bit1_input1" runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_bit2_input2" runat="server"  />
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_bit3_input3" runat="server" />
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_bit4_input4" runat="server"  />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ورودی</td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    <asp:CheckBox ID="chk_bit1_output1" runat="server"  />
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_bit2_output2" runat="server"  />
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_bit3_output3" runat="server"  />
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_bit4_output4" runat="server"  />
                                </td>
                            </tr>
                        </table>
                    </td>
            </tr>
                <tr>
                    <td colspan="3">
                        <hr />
                        <b>
                        <asp:CheckBox ID="chk_filter_speed" runat="server" />
                        فیلتر سرعت
                        </b>
                        <br />
                        
                        <table>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="drp_speed_select_arrows" runat="server">
                                        <asp:ListItem Selected="True" Value="&gt;">بالاتر از</asp:ListItem>
                                        <asp:ListItem Value="=">مساوی با</asp:ListItem>
                                        <asp:ListItem Value="&lt;">پایین تر از</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_speed_km" runat="server" Width="71px"></asp:TextBox>
                                </td>
                                <td>
                                    k/h</td>
                            </tr>
                            </table>
                        
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                    <hr />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <b>
                        <asp:CheckBox ID="chk_filter_geo" runat="server" />
                        فیلتر مکانی<br />
                        (غیرفعال)</b></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <table>
                            <tr>
                                <td>
                                    نام مکان مورد نظر را&nbsp; صورت انگلیسی<br />
&nbsp;وارد نمایید مثلا:&nbsp; Tehran</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txt_geo_center_name" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    محدوده قرارگیری وسیله&nbsp; نقلیه از نام<br />
                                    محل وارد شده را وارد نمایید :</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txt_geo_center_km" runat="server"></asp:TextBox>
                                    &nbsp;کیلومتر</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
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
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>

</div>


</div>