<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="c3302779_Assig1.UL.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Change Password</h2>
        </div>

        <asp:Panel ID="changePanel" CssClass="row" runat="server">
            <div class="col-md-6">

                <div class="form-group">
                    <asp:TextBox ID="Password1TextBox" CssClass="form-control" runat="server" Placeholder="Enter Password" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic" ControlToValidate="Password1TextBox"></asp:RequiredFieldValidator>
                </div>
                    
                <div class="form-group">
                    <asp:TextBox ID="Password2TextBox" CssClass="form-control" runat="server" Placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic" ControlToValidate="Password2TextBox"></asp:RequiredFieldValidator>
                    <asp:CompareValidator runat="server" ControlToValidate="Password2TextBox" CssClass="text-danger" ControlToCompare="Password1TextBox" ErrorMessage="Passwords do not match" ToolTip="Password must be the same" />
                </div>
                    
                <div class="form-group">
                    <asp:Button runat="server" Text="Update" CssClass="btn btn-dark" OnClick="SubmitButton_Click" />
                </div>

            </div>
        </asp:Panel>
    </div>

</asp:Content>
