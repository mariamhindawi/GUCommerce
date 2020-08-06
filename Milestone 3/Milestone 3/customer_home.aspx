<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customer_home.aspx.cs" Inherits="Milestone_3.customer_home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>Customer</p>
            <br /><br />
            <asp:Button ID="viewProducts" runat="server" Text="View products" OnClick="viewProducts_Click" />
            <br /><br />
            <asp:Button ID="addCreditCard" runat="server" Text="Add credit card" OnClick="addCreditCard_Click" />&emsp;
            <br /><br />
            <asp:TextBox ID="mobile_number" runat="server"></asp:TextBox>&emsp;
            <asp:Button ID="addMobile" runat="server" Text="Add mobile" OnClick="addMobile_Click" />&emsp;
            <asp:Label ID="mobileMessage" runat="server" ForeColor="Red"></asp:Label>
            <br /><br />
            <asp:TextBox ID="wishlist_name" runat="server"></asp:TextBox>&emsp;
            <asp:Button ID="createWishlist" runat="server" Text="Create wishlist" OnClick="createWishlist_Click" />&emsp;
            <asp:Label ID="wishlistMesage" runat="server" Text="" ForeColor="Red"></asp:Label>
            <br /><br />
            <asp:Button ID="previous" runat="server" Text="View previous page" OnClick="previous_Click" />
        </div>
    </form>
</body>
</html>
