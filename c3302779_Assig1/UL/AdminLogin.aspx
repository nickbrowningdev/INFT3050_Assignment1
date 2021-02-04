<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="c3302779_Assig1.UL.AdminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <h2>Log In (Admin)</h2>
        <hr />

        <!-- admin login form -->
        <div class="col-md-6">
            <!-- email -->
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtEmail">Email</asp:Label>
                <asp:TextBox runat="server" class="form-control" ID="txtEmail" placeholder="Email" />
                <!--Required field validator-->
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="Email Required." />
            </div>

            <!-- password -->
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtPassword">Password</asp:Label>
                <asp:TextBox runat="server" class="form-control" ID="txtPassword" TextMode="Password" placeholder="Password" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="text-danger" ErrorMessage="Password Required." />
            </div>

            <!-- admin logs in -->
            <div class="form-group">
                <asp:Button runat="server" Text="Submit" Class="btn btn-dark" OnClick="LogInAdmin"/>
            </div>

            <!-- error message -->
            <asp:Label runat="server" ID="errorMessage" Style="color: red"></asp:Label><br />

            <!-- registration link, if user doesn't have account -->
            <div class="form-group">
                <div class="text-center">
                    <asp:HyperLink class="pb-3" runat="server" NavigateUrl="~/UL/AdminRegistration.aspx">Don't have an account? Click here to register.</asp:HyperLink> <br />
                        <asp:HyperLink class="pb-3" runat="server" NavigateUrl="~/UL/AdminForgetPassword.aspx">Forgot Password.</asp:HyperLink>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
