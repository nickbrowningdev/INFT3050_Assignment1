<%@ Page Title="Confirmed" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Confirmed.aspx.cs" Inherits="c3302779_Assig1.UL.Confirmed" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container py-5">
        <!--Heading-->
        <h2 class="text-center pb-5 text-white">Payment confirmed</h2>
        <div class="row justify-content-center text-center bg-light py-5">
            <div class="col-md-4">
                <!--return home link-->
                <asp:HyperLink class="pb-3" runat="server" NavigateUrl="~/UL/Home.aspx">Return.</asp:HyperLink> <br />
            </div>
        </div>
    </div>

</asp:Content>
