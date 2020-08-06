<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vendor_registration.aspx.cs" Inherits="Milestone_3.vendor_registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <h1>Vendor Registration</h1>
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
            <asp:Label ID="Label6" runat="server" Text="Company Name:"></asp:Label>
            <br /><br />
            <asp:TextBox ID="company_name" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Label7" runat="server" Text="Bank Account Number:"></asp:Label>
            <br /><br />
            <asp:TextBox ID="bank_acc_no" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="errorMessage" runat="server" class="errorLabel" ForeColor="Red"></asp:Label>
            <br /><br /><br />
            <asp:Button ID="register" runat="server" Text="Register" OnClick="register_Click" />
        </div>
    </form>
</body></html>
