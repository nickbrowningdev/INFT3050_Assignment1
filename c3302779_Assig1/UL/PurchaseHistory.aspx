<%@ Page Title="Purchase History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseHistory.aspx.cs" Inherits="c3302779_Assig1.UL.PurchaseHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>My Purchase History</h2>
        </div> 

        <hr />

        <!-- returns transactions made by a certain user -->
        <div class="text-center">
                <asp:GridView ID="phGridView" AllowPaging="True" AutoGenerateColumns="False"  runat="server" >

                <Columns>  
                    <asp:BoundField DataField="orderID" HeaderText="Order ID" ReadOnly="True" />  
                    <asp:BoundField DataField="orderDate" HeaderText="Date Ordered" ReadOnly="True" DataFormatString="{0:d}" />  
                    <asp:BoundField DataField="orderCost" HeaderText="Subtotal" ReadOnly="True" DataFormatString="{0:C}" />  
                    <asp:BoundField DataField="orderTotalCost" HeaderText="Total" ReadOnly="True" DataFormatString="{0:C}" />  
                    <asp:BoundField DataField="orderIsPaid" HeaderText="Paid" ReadOnly="True" />
                </Columns>
        
                <HeaderStyle HorizontalAlign="Center" CssClass="thead-dark" />
                <RowStyle HorizontalAlign="Center" />

            </asp:GridView>
        </div>

        

    </div>

</asp:Content>
