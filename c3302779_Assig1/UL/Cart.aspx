<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="c3302779_Assig1.UL.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Cart</h2>
        </div>

        <hr />

        <!-- displays the products in the user's cart -->
        <ul class="list-group list-group-flush">
            <asp:ListView ID="ItemList" runat="server" ItemType="c3302779_Assig1.BL.ShoppingCartItems" SelectMethod="GetShoppingCartItems">
                <EmptyDataTemplate>
                    <li class="list-group-item">Shopping Cart is currently empty...</li>
                </EmptyDataTemplate>
                        
                <ItemTemplate>
                    <li class="list-group-item">
                        <div class="row">
                            <div class="col">
                                <img alt="" src="\UL\IMG\<%#:Item.Product.productImage %>" width="50" height="50" />
                            </div>
                                    
                            <div class="col-6 center-text">
                                <%#:Item.ToString() %>
                            </div>
                                    
                            <div class="col">
                                <asp:CheckBox ID="checkRemove" runat="server" Text="&nbsp;Remove" />
                            </div>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:ListView>
        </ul>

        <div class="form-control">
            <asp:LinkButton ID="remove" runat="server" CssClass="btn btn-dark" OnClick="btnRemove">Remove Selected</asp:LinkButton>
        </div>

        <div class="form-control">
            <h3>Total Cost:</h3>
            <asp:Label ID="Cost" runat="server"></asp:Label>
        </div>
                
        <div class="form-control">
            <asp:LinkButton ID="checkout" runat="server" CssClass="btn btn-dark" OnClick="btnCheckout">Checkout</asp:LinkButton>
        </div>

        <div class="form-control">
            <asp:LinkButton ID="empty" runat="server" CssClass="btn btn-dark" OnClick="btnEmptyCart">Empty Cart</asp:LinkButton>
        </div>
        
        
        <div class="form-control">
            <asp:HyperLink ID="productslink" runat="server" NavigateUrl="~/UL/Products.aspx">Continue shopping?</asp:HyperLink>
        </div>
                
        <div class="margin-space-top-20">
            <asp:Label ID="errorCart" runat="server" ForeColor="Red"></asp:Label>
        </div>
        
    </div>

</asp:Content>
