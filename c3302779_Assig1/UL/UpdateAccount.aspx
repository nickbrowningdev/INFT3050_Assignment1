<%@ Page Title="Update Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateAccount.aspx.cs" Inherits="c3302779_Assig1.UL.UpdateAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Update User</h2>
        </div>
        <asp:Panel ID="userUpdatePanel" CssClass="row" runat="server">
            <div class="col-md-6">

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtFirstName">First Name</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtFirstName" placeholder="First Name" ToolTip="First Name Here" />
                        
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="First Name Required." />
                </div>

                <!-- user last name -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtLastName">Last Name</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtLastName" placeholder="Last Name" ToolTip="Last Name Here" />
                        
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" ErrorMessage="Last Name Required." />
                </div>

                <!-- user phone number -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtPhoneNo">Phone Number</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtPhoneNo" placeholder="Phone Number" ToolTip="Phone Number Here" />

                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhoneNo" CssClass="text-danger" ErrorMessage="Phone Number Required." />

                    <!-- Expression validator -->
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhoneNo" CssClass="text-danger" ValidationExpression="^(04[\d]{8})$" ErrorMessage="Valid Phone Number Required."/>
                </div>

                <!-- user email -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtEmail">Email</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtEmail" placeholder="Email" ToolTip="Email Address Here" />
                    
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="Email Required." /> 

                    <asp:CustomValidator ID="csvEmail" runat="server" ErrorMessage="Email already registered" CssClass="text-danger" OnServerValidate="checkUserExists" ControlToValidate="txtEmail" Display="Dynamic" SetFocusOnError="True"></asp:CustomValidator>

                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="text-danger" ErrorMessage="Invalid email address." />
                </div>

                <!-- user password -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtPassword">Password</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtPassword" TextMode="Password" placeholder="Password" ToolTip="Password Here" />

                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="text-danger" ErrorMessage="Password Required." />
                </div>

                <!-- user password confirm -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtConfirmPassword">Confirm Password</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtConfirmPassword" TextMode="Password" placeholder="Confirm Password" ToolTip="Confirm Your Password" />

                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword" CssClass="text-danger" ErrorMessage="Password Required." />

                    <!--Comaparator validator, checks matching passwords-->
                    <asp:CompareValidator runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" CssClass="text-danger" ErrorMessage="Passwords do not match." />
                </div>

                <!-- user registers -->
                <div class="form-group">
                    <asp:Button runat="server" Text="Submit" Class="btn btn-dark" OnClick="UpdateUser"/>
                </div>

                <!-- error message -->
                <asp:Label runat="server" ID="errorMessage" Style="color: red"></asp:Label><br />

            </div>
        </asp:Panel>
    </div>

</asp:Content>
