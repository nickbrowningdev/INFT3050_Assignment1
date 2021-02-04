<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="c3302779_Assig1.UL.Checkout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Checkout</h2>
        </div>

        <hr />

        <asp:Panel ID="checkoutPanel" runat="server" >

            <div class="col-md-12 order-md-1">
                <h3 class="mb-3">User information</h3>

                <div class="row">
                    <div class="col-md-6">
                        <!-- first name -->
                        <!-- last name -->
                        <div class="form-group">
                            <asp:Label ID="lblFirstName" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblLastName" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- customer address -->
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtCustomerAddress">Billing Address</asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="txtCustomerAddress" placeholder="Customer Address" ToolTip="Customer Address Here" />
                        
                            <!--Required field validator-->
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCustomerAddress" CssClass="text-danger" ErrorMessage="Customer Address Required." />
                        </div>
                    </div>

                    <!-- postal address -->
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtOptionalAddress">Postal Address (PO Box, apartment, etc.)</asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="txtOptionalAddress" placeholder="Optional Address" ToolTip="Optional Address Here" />

                            <!--Required field validator-->
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOptionalAddress" CssClass="text-danger" ErrorMessage="Postal Address Required." />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- city -->
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtCity">City</asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="txtCity" placeholder="City" ToolTip="City" />
                        
                            <!--Required field validator-->
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" CssClass="text-danger" ErrorMessage="City Required." />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- country/region -->
                    <div class="col-md-4 mb-3">
                        <asp:Label runat="server" AssociatedControlID="ddlCountry">Country</asp:Label>
                        <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control">
                            <asp:ListItem Value="AU">Australia</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Choose a country" ControlToValidate="ddlCountry" InitialValue="Choose one..." ValidationGroup="Country" CssClass="text-danger"/>
                    </div>

                    <!-- state/terriotry -->
                    <div class="col-md-4 mb-3">
                        <asp:Label runat="server" AssociatedControlID="ddlStateTerritory">State/Terrority</asp:Label>
                        <asp:DropDownList ID="ddlStateTerritory" runat="server" CssClass="form-control">
                            <asp:ListItem Value="ACT">Australia Capital Territory</asp:ListItem>
                            <asp:ListItem Value="NSW">New South Wales</asp:ListItem>
                            <asp:ListItem Value="NT">Northern Territory</asp:ListItem>
                            <asp:ListItem Value="QLD">Queensland</asp:ListItem>
                            <asp:ListItem Value="SA">South Australia</asp:ListItem>
                            <asp:ListItem Value="TAS">Tasmania</asp:ListItem>
                            <asp:ListItem Value="VIC">Victoria</asp:ListItem>
                            <asp:ListItem Value="WA">Western Australia</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="Choose a country" ControlToValidate="ddlStateTerritory" InitialValue="Choose one..." ValidationGroup="State/Territory" CssClass="text-danger"/>
                    </div>

                    <!-- post/zip code -->
                    <div class="col-md-4">
                        <!-- first name -->
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtPostCode">Post Code</asp:Label>
                            <asp:TextBox runat="server" class="form-control" ID="txtPostCode" placeholder="Post Code" ToolTip="Post Code Here" />
                        
                            <!--Required field validator-->
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPostCode" CssClass="text-danger" ErrorMessage="Post Code Required." />

                            <!-- Expression validator -->
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPostCode" CssClass="text-danger" ValidationExpression="^[0-9]{4}$" ErrorMessage="Valid Post Code Required."/>
                        </div>
                    </div>
                </div>

                <hr class="mb-4">
                
                <h3 class="mb-3">Postage Option</h3>

                <div class="col-md-4 mb-3">
                    <asp:Label runat="server" AssociatedControlID="ddlPostageOption">Postage Options</asp:Label>
                
                    <asp:DropDownList ID="ddlPostageOption" OnDataBound="addInitialItem" CssClass="form-control" DataTextField="postageMethod" DataValueField="postageID" runat="server" OnSelectedIndexChanged="ddlPostageOption_SelectedIndexChanged" AutoPostBack="True">
                    </asp:DropDownList>
                        
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Select a postage method." ControlToValidate="ddlPostageOption" ValidationGroup="PostageOption" CssClass="text-danger"/>
                </div>

                <hr class="mb-4">

                <h3 class="mb-3">Card Details</h3>

                <div class="row">
                    <div class="form-group col-md-6">
                        <asp:Label runat="server" AssociatedControlID="cardName">Card Name</asp:Label>
                        <asp:TextBox runat="server" class="form-control" ID="cardName" placeholder="Card Name" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="cardName"
                            CssClass="text-danger" ErrorMessage="Card Name Required." />
                    </div>

                    <div class="form-group col-md-6">
                        <asp:Label runat="server" AssociatedControlID="cardNumber">Card Number</asp:Label>
                        <asp:TextBox runat="server" class="form-control" ID="cardNumber" placeholder="Card Number" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="cardNumber"
                            CssClass="text-danger" ErrorMessage="Card Number Required." />

                        <asp:RegularExpressionValidator ControlToValidate="cardNumber" runat="server" CssClass="text-danger" ValidationExpression="\d{16}" ErrorMessage="Must be valid Card." />

                        
                    </div>
                </div>

                <div class="form-group row ">
                    <!--Inline postcode control-->
                    <div class="form-group col-md-3">
                        <asp:label AssociatedControlID="txtExpiryDate" runat="server">Expiry Date (MM/YYYY)</asp:label>
                        <asp:TextBox class="form-control" ID="txtExpiryDate" placeholder="Expiry Date (MM/YYYY)" runat="server"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtExpiryDate" CssClass="text-danger" ErrorMessage="Expiry Date Required." />

                        <asp:RegularExpressionValidator ControlToValidate="txtExpiryDate" runat="server" CssClass="text-danger" ValidationExpression="^((0[1-9])|(1[0-2]))\-((2009)|(20[1-2][0-9]))$" ErrorMessage="Must be (MM-YYYY)." />                   
                    </div>
                        
                    <!--Inline postcode control-->
                    <div class="form-group col-md-3">
                        <asp:label AssociatedControlID="txtCVV" runat="server">CVV</asp:label>
                        <asp:TextBox class="form-control" ID="txtCVV" runat="server" Placeholder="CVV" ></asp:TextBox>
                        
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCVV" CssClass="text-danger" ErrorMessage="CVV Required." />

                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCVV" CssClass="text-danger" ValidationExpression="\d{3}" ErrorMessage="Valid CVV Required."/>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="form-group col-md-6">

                        <div class="form-control">
                            <asp:Button runat="server" class="btn btn-dark" Text="Confirm Payment" OnClick="MakePayment"/>
                        </div>

                        <div class="form-control">
                            <asp:Label ID="lblAmount" runat="server"></asp:Label>
                        </div>

                        <div class="form-control">
                            <asp:Label ID="lblResult" CssClass="text-danger" runat="server"></asp:Label>
                        </div>

                    </div>
                </div>
            </div>

        </asp:Panel>
    </div>

</asp:Content>
