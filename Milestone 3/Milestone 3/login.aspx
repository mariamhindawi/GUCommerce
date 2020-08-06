<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Milestone_3.home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Username:"></asp:Label>
            <br /><br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Label2" runat="server" Text="Password:"></asp:Label>
            <br /><br />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="errorMessage" runat="server" class="errorLabel" ForeColor="Red"></asp:Label>
            <br /><br />
            <asp:Button ID="login" runat="server" Text="Login" OnClick="login_Click" />
        </div>
        <br /><br />
        <asp:HyperLink ID="register" runat="server" NavigateUrl="~/registration.aspx">I don't have an account</asp:HyperLink>
    </form>
</body>
</html>
