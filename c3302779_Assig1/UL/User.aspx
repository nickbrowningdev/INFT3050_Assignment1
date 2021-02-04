<%@ Page Title="User" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="c3302779_Assig1.UL.User" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Account</h2>
        </div>
        
        <hr />

        <!-- account landing links -->
        <div class="row justify-content-center text-center bg-light py-5">
            <div class="col-md-4">
                <!--purchase history link-->
                <asp:HyperLink runat="server" class="text-decoration-none" NavigateUrl="~/UL/PurchaseHistory.aspx">
                    <h5>Purchase History</h5>
                </asp:HyperLink>

                <!-- update user account -->
                <asp:HyperLink runat="server" class="text-decoration-none" NavigateUrl="~/UL/UpdateAccount.aspx">
                    <h5>Update Account</h5>
                </asp:HyperLink>
            </div>
        </div>
    </div>

</asp:Content>
