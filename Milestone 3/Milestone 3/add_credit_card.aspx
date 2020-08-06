<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_credit_card.aspx.cs" Inherits="Milestone_3.add_credit_card" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Add Credit Card</h2>
            <br /><br />
            <asp:Label ID="Label1" runat="server" Text="Credit Card Number:"></asp:Label>&emsp;
            <asp:TextBox ID="credit_card_number" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Label2" runat="server" Text="Expiry Date:"></asp:Label>
            <br /><br />
            <asp:Calendar ID="Calendar1" runat="server" Height="50px" Width="50px"></asp:Calendar>
            <br /><br />
            <asp:Label ID="Label3" runat="server" Text="CVV:"></asp:Label>&emsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="cvv" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Button ID="addCreditCard" runat="server" Text="Add credit card" OnClick="addCreditCard_Click" />&emsp;
            <asp:Label ID="errorMessage" runat="server" class="errorLabel" ForeColor="Red"></asp:Label>
        </div>
    </form>
</body>
</html>
