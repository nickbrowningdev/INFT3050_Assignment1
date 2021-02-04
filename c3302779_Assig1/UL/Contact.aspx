<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="c3302779_Assig1.UL.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Contact Us</h2>
        </div>

        <hr />

        <!-- table content -->
        <asp:Table class="table table-borderless" runat="server">
            <asp:TableHeaderRow runat="server">
                <asp:TableHeaderCell Scope="Column" Text="Company Name" />
                <asp:TableHeaderCell Scope="Column" Text="Address" />
                <asp:TableHeaderCell Scope="Column" Text="Phone" />
                <asp:TableHeaderCell Scope="Column" Text="Email" />
            </asp:TableHeaderRow>              

            <asp:TableRow>
                <asp:TableCell Text="Nicholas Browning Enterprises" />
                <asp:TableCell Text="18 Parkes Road, Melbourne, 3004" />
                <asp:TableCell Text="+61 491 570 156" />
                <asp:TableCell Text="nicholas.browning@uon.edu.au" />
            </asp:TableRow>
        </asp:Table>
    </div>

</asp:Content>
