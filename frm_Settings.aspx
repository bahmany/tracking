<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="frm_Settings.aspx.cs" Inherits="frm_Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    

    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
    </telerik:RadStyleSheetManager>
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>




    <div dir="rtl" 
        
        style="padding: 6px; margin: auto; font-family: tahoma; font-size: 11px; background-color: #FFFFFF; bottom: 20px; position: fixed; top: 43px; right: 10px; left: 10px; display: block; overflow: scroll;">
<div>


    <span>تنظیمات</span>
    <br />
    <br />


    <table style="width: 100%; z-index: 999999;">
        <tr>
            <td style="width: 150px">
            <script type="text/javascript">
                
                function AddElementToCookie(Obj) {
                


                }
            
            
            
            </script>
            
            
            
            
                <telerik:RadTreeView ID="rtv_settings" runat="server">
<CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>

<ExpandAnimation Duration="100"></ExpandAnimation>
                </telerik:RadTreeView>  
                
                
            </td>
            <td style="padding: 5px; border: 1px solid #000099;">
                
                
                
                
                
                
    <asp:PlaceHolder ID="ph" runat="server"></asp:PlaceHolder>
   
                
                </td>
        </tr>
    </table>

</div>





    </div>




</asp:Content>

