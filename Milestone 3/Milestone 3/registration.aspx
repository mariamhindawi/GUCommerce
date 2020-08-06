<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registration.aspx.cs" Inherits="Milestone_3.registration1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="vendor_button" runat="server" Text="I am a Vendor" Height="50px" OnClick="vendor_button_Click" />&emsp;
            <asp:Button ID="customer_button" runat="server" Text="I am a Customer" Height="50px" OnClick="customer_button_Click" />
        </div>
    </form>
</body>
</html>
