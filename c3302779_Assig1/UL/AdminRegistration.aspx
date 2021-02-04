<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminRegistration.aspx.cs" Inherits="c3302779_Assig1.UL.AdminRegistration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <h2>Registration (Admin)</h2>
        <hr />

        <!-- register form -->
        <div class="col-md-6">

            

            <!-- user first name -->
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtFirstName">First Name</asp:Label>
                <asp:TextBox runat="server" class="form-control" ID="txtFirstName" placeholder="First Name" />
                        
                <!--Required field validator-->
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="First Name Required." />
            </div>

            <!-- user last name -->
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtLastName">Last Name</asp:Label>
                <asp:TextBox runat="server" class="form-control" ID="txtLastName" placeholder="Last Name" />
                        
                <!--Required field validator-->
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" ErrorMessage="Last Name Required." />
            </div>

            <!-- user email -->
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtEmail">Email</asp:Label>
                <asp:TextBox runat="server" class="form-control" ID="txtEmail" placeholder="Email" />
                    
                <!--Required field validator-->
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="Email Required." /> 

                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="text-danger" ErrorMessage="Invalid email address." />

                <asp:CustomValidator  runat="server" ErrorMessage="Email already registered" CssClass="text-danger" OnServerValidate="checkAdminExists" ControlToValidate="txtEmail" Display="Dynamic" SetFocusOnError="True"></asp:CustomValidator>
            </div>

            <!-- user registers -->
            <div class="form-group">
                <asp:Button runat="server" Text="Submit" Class="btn btn-dark" OnClick="RegisterAdmin"/>
            </div>

            <!-- error message -->
            <asp:Label runat="server" ID="errorMessage" Style="color: red"></asp:Label><br />

            <!-- login account, if user already has account -->
            <asp:HyperLink class="pb-3" runat="server" NavigateUrl="~/UL/AdminLogin.aspx">Already have an account? Log in here.</asp:HyperLink>
        </div>
    </div>

</asp:Content>
