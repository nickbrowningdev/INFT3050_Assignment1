<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="c3302779_Assig1.UL.Products" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Products</h2>
        </div>

        <hr />

        <!-- returns product items from the database -->
        <div class="row margin-space-top-20">
            <asp:Repeater ID="productsRepeat" runat="server">
                <ItemTemplate>
                    <div class="col-sm-3">
                        <h2 class="product-buy-heading"><%# DataBinder.Eval(Container.DataItem, "playerFirstName") + "<br/>" + DataBinder.Eval(Container.DataItem, "playerLastName")%></h2>
                        <img alt="" src="/UL/IMG/<%# DataBinder.Eval(Container.DataItem, "productImage") %>"  class="d-block w-100" />
                        <h3 class="product-price-title"><%# string.Format("{0:C0}", DataBinder.Eval(Container.DataItem, "productPrice")) %></h3>
                        <div class="d-flex justify-content-center">
                            <asp:LinkButton ID="btnProduct" runat="server" CssClass="product-buy-btn btn btn-dark" onClick="btnSelectProduct" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "productVendorUID") %>'>View Product</asp:LinkButton>
                        </div> 
                        <hr/>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

</asp:Content>
