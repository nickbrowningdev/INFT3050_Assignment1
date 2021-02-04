<%@ Page Title="Forget Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminForgetPassword.aspx.cs" Inherits="c3302779_Assig1.UL.AdminForgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="text-center">
            <h2>Recover Password</h2>
        </div>
        
    <!-- user enters email -->
        <asp:Panel ID="forgetPanel" CssClass="row" runat="server">
            <div class="col-md-6">
                <p>
                    Please enter your email address to reset your password.
                </p>

                <div class="form-group">
                    <asp:TextBox ID="EmailTextBox" CssClass="form-control" runat="server" Placeholder="Account Email" TextMode="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic" ControlToValidate="EmailTextBox"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="csvEmail" runat="server" ErrorMessage="No account exists under this email" CssClass="text-danger" OnServerValidate="checkExists" ControlToValidate="EmailTextBox" Display="Dynamic" SetFocusOnError="True"></asp:CustomValidator>
                </div>
                <div class="form-group">
                    <asp:Button runat="server" Text="Get Verification Email" CssClass="btn btn-dark" OnClick="RequestButton" />
                </div>
                <div class="form-group">
                    <asp:Label ID="ErrorLabel" runat="server" ForeColor="Red"></asp:Label>
                </div>
            </div>
        </asp:Panel>

</asp:Content>
