<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_UnitsManager.ascx.cs" Inherits="ascx_frm_CustomerManager" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<div style="padding: 7px; font-family: tahoma; font-size: 15px; font-weight: bold; background-color: #EBD7C2">
مدیریت وسائط نقلیه
</div>



<div style="font-family: tahoma; font-size: 12px; background-color: #FFFFFF;" 
    dir="rtl">


<style type="text/css">

#mask {
  position:absolute;
  left:0;
  top:0;
  z-index:9000;
  background-color:#000;
  display:none;
}
  #DsCus {
  
}
  
#boxes .window {
  position:absolute;
  left:0;
  top:0;
  width:440px;
  height:200px;
  display:none;
  z-index:9999;
  padding:20px;
  overflow:scroll;
}

#boxes #dialog {
  width:375px; 
  height:450px;
  padding:10px;
  background-color:#ffffff;
}

#boxes #dialog1 {
  width:375px; 
  height:203px;
}

#dialog1 .d-header {
  background:url(images/login-header.png) no-repeat 0 0 transparent; 
  width:375px; 
  height:150px;
}

#dialog1 .d-header input {
  position:relative;
  top:60px;
  left:100px;
  border:3px solid #cccccc;
  height:22px;
  width:200px;
  font-size:15px;
  padding:5px;
  margin-top:4px;
}

#dialog1 .d-blank {
  float:left;
  background:url(images/login-blank.png) no-repeat 0 0 transparent; 
  width:267px; 
  height:53px;
}

#dialog1 .d-login {
  float:left;
  width:108px; 
  height:53px;
}

#boxes #dialog2 {
  background:url(images/notice.png) no-repeat 0 0 transparent; 
  width:326px; 
  height:229px;
  padding:50px 0 20px 25px;
}
    .style2
    {
        width: 89px;
    }
    </style>

    <br />

<div>
    <br />
    </div>
<div id="boxes">

<div>

      <div id="div_AddNewCustomer">
                <table>
                    <tr>
                        <td style="border-style: none none none solid; border-width: 1px; border-color: #333333">
                <table>
                    <tr>
                        <td>
                            کد دستگاه</td>
                        <td>
                            <asp:TextBox ID="txt_UnittID" runat="server" ReadOnly="True"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            سیم کارت</td>
                        <td>
                            <asp:TextBox ID="txt_cellno" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            شماره متحرک</td>
                        <td>
                            <asp:TextBox ID="txt_PelakNo" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            مدل متحرک</td>
                        <td>
                            <asp:TextBox ID="txt_Model" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            سایرتوضیحات</td>
                        <td>
                            <asp:TextBox ID="txt_ShomarehKhas" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            نام</td>
                        <td>
                            <asp:TextBox ID="txt_name" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            نام خانوادگی</td>
                        <td>
                            <asp:TextBox ID="txt_family" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            جنسیت</td>
                        <td>
                            <asp:DropDownList ID="drp_jensiat" runat="server">
                                <asp:ListItem Selected="True" Value="-1">-</asp:ListItem>
                                <asp:ListItem Value="0">مرد</asp:ListItem>
                                <asp:ListItem Value="1">زن</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            تاریخ تولد</td>
                        <td>
                            <asp:TextBox ID="txt_datebirth" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            کد ملی</td>
                        <td>
                            <asp:TextBox ID="txt_MilliCode" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            شماره ش</td>
                        <td>
                            <asp:TextBox ID="txt_shsh" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            کد پستی</td>
                        <td>
                            <asp:TextBox ID="txt_postalcode" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            تلفن ثابت</td>
                        <td>
                            <asp:TextBox ID="txt_tel" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            آدرس</td>
                        <td>
                            <asp:TextBox ID="txt_addr" runat="server" Height="22px"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            تلفن ضروری</td>
                        <td>
                            <asp:TextBox ID="txt_telzarori" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            آدرس ضروری</td>
                        <td>
                            <asp:TextBox ID="txt_addrzarori" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            کد دستی</td>
                        <td>
                            <asp:TextBox ID="txt_handcode" runat="server"></asp:TextBox>
&nbsp;</td>
                        <td>
                            <asp:HyperLink ID="HyperLink3" runat="server">?</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            گروه</td>
                        <td>
                            <asp:DropDownList ID="drp_group" runat="server" 
                                DataSourceID="ods_UnitGroups" DataTextField="cg_name" 
                                DataValueField="cg_id">
                            </asp:DropDownList>
                            <asp:ObjectDataSource ID="ods_UnitGroups" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" 
                                SelectMethod="GetDataBy" 
                                TypeName="MainDataModuleTableAdapters.tbl_units_groupsTableAdapter">
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_cg_id" Type="Int32" />
                                </DeleteParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="OwnerID" SessionField="OwnerID" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink5" runat="server">?</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td>
                            <br />
                            &nbsp;
                            <asp:LinkButton ID="lnk_post" runat="server" onclick="lnk_post_Click" >ثبت</asp:LinkButton>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <br />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
                            </td>
                            <td style="padding: 12px">
                                <asp:DataList ID="dls_custmers" runat="server" DataSourceID="ods_customer" onitemcommand="DataList1_ItemCommand" 
               DataKeyField="c_id" RepeatDirection="Horizontal" RepeatColumns="2">
               <ItemTemplate>
               <div style="border: 1px solid #666666; " class="DsCus" >                   <table>
                       <tr>
                           <td class="style2">
                               <asp:Label ID="Label3" runat="server" Text='<%# Eval("c_unit_id") %>'></asp:Label>
                               </td>
                           <td class="style2">
                               <asp:Label ID="Label4" runat="server" Text='<%# Eval("cg_name") %>'></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td class="style2">
                               <asp:Label ID="Label1" runat="server" Text='<%# Eval("c_name") %>'></asp:Label>
                           </td>
                           <td class="style2">
                               <asp:Label ID="Label2" runat="server" Text='<%# Eval("c_family") %>'></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td style="background-color: #FFFFCC; font-weight: bold" class="style2">
                               <asp:LinkButton ID="lnk_edit" runat="server" onclick="lnk_edit_Click" 
                                   ToolTip='<%# Eval("c_id") %>'>ویرایش</asp:LinkButton>
                           </td>
                           <td class="style2" style="background-color: #FFFFCC; font-weight: bold">
                               <asp:LinkButton ID="lnk_delete" runat="server" onclick="lnk_delete_Click2" 
                                   ToolTip='<%# Eval("c_id") %>'>حذف</asp:LinkButton>
                           </td>
                       </tr>
                   </table>
                   </div>

               </ItemTemplate>
           </asp:DataList>
                            </td>
                        </tr>
                    </table>
                </div>


</div>

<!-- Mask to cover the whole screen -->
  <div id="mask"></div>
</div>

       <div style="padding: 10px">
       <br />
       <div style="display: table-cell">
       </div>
       <br />
       
       </div>


</div>
<asp:ObjectDataSource ID="ods_customer" runat="server" 
    InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" 
    SelectMethod="GetData" 
    TypeName="MainDataModuleTableAdapters.tbl_unitsTableAdapter" 
    UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery">
    <DeleteParameters>
        <asp:Parameter Name="UnitROWID" Type="Int32" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:ControlParameter ControlID="drp_group" Name="c_group_link" 
            PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="txt_name" Name="c_name" PropertyName="Text" 
            Type="String" />
        <asp:ControlParameter ControlID="txt_family" Name="c_family" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="drp_jensiat" Name="c_sex" 
            PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="txt_datebirth" Name="c_birth_date" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_postalcode" Name="c_postal_code" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_MilliCode" Name="c_melli_code" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_shsh" Name="c_shsh" PropertyName="Text" 
            Type="String" />
        <asp:ControlParameter ControlID="txt_tel" Name="c_phonelineno" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_addr" Name="c_address" PropertyName="Text" 
            Type="String" />
        <asp:ControlParameter ControlID="txt_telzarori" Name="c_phoneline_necessary" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_addrzarori" Name="c_address_necessary" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_handcode" Name="c_handcode" 
            PropertyName="Text" Type="String" />
        <asp:SessionParameter DefaultValue="2" Name="c_owner_link" SessionField="owner" 
            Type="Int32" />
        <asp:ControlParameter ControlID="txt_UnittID" Name="c_unit_id" 
            PropertyName="Text" Type="Int32" />
        <asp:ControlParameter ControlID="txt_PelakNo" DefaultValue="" Name="c_car_no" 
            PropertyName="Text" Type="String" />
        <asp:Parameter DefaultValue="1" Name="c_car_bimeh" Type="String" />
        <asp:ControlParameter ControlID="txt_ShomarehKhas" DefaultValue="" 
            Name="c_car_badaneh" PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_cellno" Name="c_car_cellno" 
            PropertyName="Text" Type="String" />
        <asp:SessionParameter DefaultValue="10" Name="ID" SessionField="code" 
            Type="Int32" />
    </UpdateParameters>
    <SelectParameters>
        <asp:SessionParameter DefaultValue="2" Name="c_owner_link" 
            SessionField="OwnerID" Type="Int32" />
    </SelectParameters>
    <InsertParameters>
        <asp:SessionParameter DefaultValue="2" Name="c_owner_link" SessionField="owner" 
            Type="Int32" />
        <asp:ControlParameter ControlID="drp_group" DefaultValue="" Name="c_group_link" 
            PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="txt_name" Name="c_name" PropertyName="Text" 
            Type="String" />
        <asp:ControlParameter ControlID="txt_family" Name="c_family" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="drp_jensiat" Name="c_sex" 
            PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="txt_datebirth" Name="c_birth_date" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_postalcode" Name="c_postal_code" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_MilliCode" Name="c_melli_code" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_shsh" Name="c_shsh" PropertyName="Text" 
            Type="String" />
        <asp:ControlParameter ControlID="txt_tel" Name="c_phonelineno" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_addr" Name="c_address" PropertyName="Text" 
            Type="String" />
        <asp:ControlParameter ControlID="txt_telzarori" Name="c_phoneline_necessary" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_addrzarori" Name="c_address_necessary" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_handcode" Name="c_handcode" 
            PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_UnittID" Name="c_unit_id" 
            PropertyName="Text" Type="Int32" />
        <asp:ControlParameter ControlID="txt_PelakNo" Name="c_car_no" 
            PropertyName="Text" Type="String" />
        <asp:Parameter DefaultValue="0" Name="c_car_bimeh" Type="String" />
        <asp:ControlParameter ControlID="txt_ShomarehKhas" DefaultValue="" 
            Name="c_car_badaneh" PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txt_cellno" Name="c_car_cellno" 
            PropertyName="Text" Type="String" />
    </InsertParameters>
</asp:ObjectDataSource>


    





    

