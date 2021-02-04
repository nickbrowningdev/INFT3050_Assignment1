<%@ Page Title="Error" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="c3302779_Assig1.UL.Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- returns error message -->
    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Oops, Something Went Wrong Here!</h2>
        </div>

        <div class="text-center">
            <asp:Button runat="server" Text="Return" Class="btn btn-primary" OnClick="Return"/>
        </div>
    </div>

</asp:Content>
