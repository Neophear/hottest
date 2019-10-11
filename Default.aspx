<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ImageButton ID="imgbtnUser1" BorderWidth="2px" runat="server" 
        onclick="imgbtnUser1_Click" />
    <asp:ImageButton ID="imgbtnUser2" BorderWidth="2px" runat="server" 
        onclick="imgbtnUser2_Click" />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="personID" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="personID" HeaderText="personID" 
                InsertVisible="False" ReadOnly="True" SortExpression="personID" />
            <asp:BoundField DataField="personName" HeaderText="personName" 
                SortExpression="personName" />
            <asp:CheckBoxField DataField="personIsFemale" HeaderText="personIsFemale" 
                SortExpression="personIsFemale" />
            <asp:BoundField DataField="personNumberShown" HeaderText="personNumberShown" 
                SortExpression="personNumberShown" />
            <asp:BoundField DataField="personPoint" HeaderText="personPoint" 
                SortExpression="personPoint" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT * FROM [persons] ORDER BY [personPoint] DESC">
    </asp:SqlDataSource>
    </form>
</body>
</html>
