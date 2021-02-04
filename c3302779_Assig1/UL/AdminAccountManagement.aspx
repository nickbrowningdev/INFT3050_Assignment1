<%@ Page Title="Account Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminAccountManagement.aspx.cs" Inherits="c3302779_Assig1.UL.AdminAccountManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Accounts</h2>
        </div>
        <asp:Panel ID="accountManagementPanel" CssClass="row" runat="server">
                <div class="col-md-6">

                <asp:GridView ID="gvUsers" runat="server" OnRowCommand="gvUsers_OnRowCommand" AutoGenerateColumns="False" OnRowDataBound="gvUsers_OnRowDataBound" HeaderStyle-HorizontalAlign="Center">
                    <Columns>  
                        <asp:BoundField DataField="userID" HeaderText="userID" ReadOnly="True" />  
                        <asp:BoundField DataField="userFirstName" HeaderText="First Name" ReadOnly="True" />  
                        <asp:BoundField DataField="userLastName" HeaderText="Last Name" ReadOnly="True" />  
                        <asp:BoundField DataField="userEmail" HeaderText="Email" ReadOnly="True" /> 
                        <asp:BoundField DataField="userPhone" HeaderText="Phone" ReadOnly="True" />  
                        
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Button ID="btnAccountStatus" runat="server" CausesValidation="False" CommandName="Status" CommandArgument="<%# (Container as GridViewRow).RowIndex %>" Text="Activated" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>  
                    <HeaderStyle HorizontalAlign="Center" CssClass="thead-dark" />
                    <RowStyle HorizontalAlign="Center" />
                </asp:GridView>
                </div>

            <br />
                
            <div class="col-md-6">
                <asp:GridView ID="gvTransaction" runat="server" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center">
                    <Columns>  
                        <asp:BoundField DataField="orderID" HeaderText="orderID" ReadOnly="True" />  
                        <asp:BoundField DataField="FK_userID" HeaderText="userID" ReadOnly="True" />
                        <asp:BoundField DataField="orderDate" HeaderText="Date Ordered" ReadOnly="True" DataFormatString="{0:d}" />  
                        <asp:BoundField DataField="orderCost" HeaderText="Subtotal" ReadOnly="True" DataFormatString="{0:C}" />  
                        <asp:BoundField DataField="orderTotalCost" HeaderText="Total" ReadOnly="True" DataFormatString="{0:C}" />  
                        <asp:BoundField DataField="orderIsPaid" HeaderText="Paid" ReadOnly="True" />
                    </Columns>  
                    <HeaderStyle HorizontalAlign="Center" CssClass="thead-dark" />
                    <RowStyle HorizontalAlign="Center" />
                </asp:GridView>

                <div class="form-group">
                    <asp:HyperLink class="pb-3" runat="server" NavigateUrl="~/UL/AdminAccount.aspx">Return</asp:HyperLink>
                </div>
            </div>
        </asp:Panel>
    </div>

</asp:Content>
