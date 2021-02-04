<%@ Page Title="Forget Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="c3302779_Assig1.UL.ForgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Recover Password</h2>
        </div>

        <asp:Panel ID="forgetPanel" CssClass="row" runat="server">
            <div class="col-md-6">
                <p>
                    Please enter your email address to reset your password.
                </p>

                <div class="form-group">
                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" Placeholder="Account Email" TextMode="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator  runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                    <asp:CustomValidator  runat="server" ErrorMessage="No account exists under this email" CssClass="text-danger" OnServerValidate="checkExists" ControlToValidate="txtEmail" Display="Dynamic" SetFocusOnError="True"></asp:CustomValidator>
                </div>
                <div class="form-group">
                    <asp:Button runat="server" Text="Get Verification Email" CssClass="btn btn-dark" OnClick="RequestButton" />
                </div>
                <div class="form-group">
                    <asp:Label ID="ErrorLabel" runat="server" ForeColor="Red"></asp:Label>
                </div>
            </div>
        </asp:Panel>
    </div>

</asp:Content>
