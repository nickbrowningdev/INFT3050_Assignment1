<%@ Page Title="User Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="c3302779_Assig1.UL.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Log-in</h2>
        </div>
        <asp:Panel ID="userLoginPanel" CssClass="row" runat="server">
            <div class="col-md-6">

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtEmail">Email</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtEmail" placeholder="Email" ToolTip="Email Here" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="Email Required." />
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtPassword">Password</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtPassword" TextMode="Password" placeholder="Password" ToolTip="Password Here" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="text-danger" ErrorMessage="Password Required." />
                </div>

                <div class="form-group">
                    <asp:Button runat="server" Text="Submit" Class="btn btn-dark" OnClick="LogIn"/>
                </div>
                
                <asp:Label runat="server" ID="errorMessage" Style="color: red"></asp:Label><br />

                <div class="form-group">
                    <div class="text-center">
                        <asp:HyperLink class="pb-3" runat="server" NavigateUrl="~/UL/Registration.aspx">Don't have an account? Click here to register.</asp:HyperLink> <br />
                        <asp:HyperLink class="pb-3" runat="server" NavigateUrl="~/UL/ForgetPassword.aspx">Forgot Password.</asp:HyperLink>
                    </div>
                </div>
            </div>
        </asp:Panel>

    </div>

</asp:Content>
