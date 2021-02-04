<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminChangePassword.aspx.cs" Inherits="c3302779_Assig1.UL.AdminChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Change Password</h2>
        </div>

        <!-- changes password -->
        <asp:Panel ID="changePanel" CssClass="row" runat="server">
            <div class="col-md-6">

                <div class="form-group">
                    <asp:TextBox ID="Password1TextBox" CssClass="form-control" runat="server" Placeholder="Enter Password" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword1" runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic" ControlToValidate="Password1TextBox"></asp:RequiredFieldValidator>
                </div>
                    
                <div class="form-group">
                    <asp:TextBox ID="Password2TextBox" CssClass="form-control" runat="server" Placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword2" runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic" ControlToValidate="Password2TextBox"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="Password2TextBox" CssClass="text-danger" ControlToCompare="Password1TextBox" ErrorMessage="Passwords do not match" ToolTip="Password must be the same" />
                </div>
                    
                <div class="form-group">
                    <asp:Button runat="server" Text="Update" CssClass="btn btn-dark" OnClick="SubmitButton_Click" />
                </div>

            </div>
        </asp:Panel>
    </div>

</asp:Content>
