<%@ Page Title="Product" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="c3302779_Assig1.UL.Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <!-- displays product information -->
        <div class="text-center">
            <asp:Label ID="lblProductTitle" runat="server" CssClass="h2"></asp:Label><br/>
            <asp:Label ID="lblProductDescription" runat="server" CssClass="h3"></asp:Label><br/>
            <asp:Label ID="lblProductPrice" runat="server" CssClass="h4"></asp:Label>
        </div>

        
        
        <hr />

        <!-- returns product image -->
        <div class="text-center">
            <asp:Image ID="productImage" width="500" height="500"  runat="server" />
        </div>

        <!-- user can enters the quantity -->
        <div id="quantity-select" class="input-group d-flex justify-content-center">
            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" PlaceHolder="How many?" TextMode="Number"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtQuantity" CssClass="text-danger" ErrorMessage="Invalid number." />
            <asp:rangevalidator errormessage="Please enter value between 1-99." forecolor="Red" controltovalidate="txtQuantity" minimumvalue="1" maximumvalue="99" runat="server" Type="Integer" />
        </div>

        <!-- adds to cart -->
        <div class="d-flex justify-content-center">
            <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="btn btn-dark" OnClick="AddToCart">Add to Cart</asp:LinkButton>
        </div>
    </div>

</asp:Content>
