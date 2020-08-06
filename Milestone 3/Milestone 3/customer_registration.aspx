<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customer_registration.aspx.cs" Inherits="Milestone_3.registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <h1>Customer Registration</h1>
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
            <asp:Label ID="Label3" runat="server" Text="First Name:"></asp:Label>
            <br /><br />
            <asp:TextBox ID="first_name" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Label4" runat="server" Text="Last Name:"></asp:Label>
            <br /><br />
            <asp:TextBox ID="last_name" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Label5" runat="server" Text="E-mail:"></asp:Label>
            <br /><br />
            <asp:TextBox ID="email" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="errorMessage" runat="server" class="errorLabel" ForeColor="Red"></asp:Label>
            <br /><br /><br />
            <asp:Button ID="register" runat="server" Text="Register" OnClick="register_Click" />
        </div>
    </form>
</body>
</html>
