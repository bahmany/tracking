<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="GoogleMap"
    EnableViewState="false" %>


<html>
<head runat="server">
 



    
        
  <link href="css/StyleSheet.css" rel="stylesheet" type="text/css" />  



    







  
    <title></title>
    </head>
<body>


    <form id="form1" runat="server" dir="rtl">
    




    
    
    
     
    
    
    
    
    
    <asp:Panel ID="Panel1" runat="server">


 <div id="div_loginPanel"> 
 
   
     <br />
     <asp:Login ID="Login1" runat="server" BackColor="#F7F6F3" BorderColor="#E6E2D8" 
         BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" 
         FailureText="ورود ناموفق لطفا مجددا تلاش کنید" Font-Names="Tahoma" 
         Font-Size="15px" ForeColor="#333333" LoginButtonText="ورود" 
         onauthenticate="Login1_Authenticate" PasswordLabelText="رمز عبور" 
         PasswordRequiredErrorMessage="رمز عبور را وارد نمایید" 
         RememberMeText="من را بخاطر بسپار" TitleText="ورود به سیستم" 
         UserNameLabelText="نام کاربری" 
         UserNameRequiredErrorMessage="نام کاربری را وارد نمایید" Width="306px">
         <TextBoxStyle Font-Size="12pt" Width="200px" />
         <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#003366" BorderStyle="Solid" 
             BorderWidth="1px" Font-Names="Tahoma" Font-Size="12pt" ForeColor="#284775" 
             Font-Bold="True" Height="30px" Width="100px" />
         <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
         <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" 
             ForeColor="White" Height="30px" HorizontalAlign="Center" 
             VerticalAlign="Middle" />
     </asp:Login>
     <br />
 
 
 </div>
 
    </asp:Panel>
    </form>

   


</body>
</html> 