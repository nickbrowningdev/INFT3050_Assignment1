<%@ Page Title="Product Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminProductManagement.aspx.cs" Inherits="c3302779_Assig1.UL.AdminProductManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Accounts</h2>
        </div>
        <asp:Panel ID="productManagementPanel" CssClass="row" runat="server">
            <div class="col-md-6">

                 <asp:GridView ID="gridProducts" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnSelectedIndexChanged="gridProducts_SelectedIndexChanged" CssClass="table">
                    <Columns>  
                        <asp:BoundField DataField="productVendorUID" HeaderText="ID" ReadOnly="True" />  
                        <asp:BoundField DataField="productDescription" HeaderText="Description" ReadOnly="True" />  
                        <asp:BoundField DataField="productImage" HeaderText="Price" ReadOnly="True" />  
                        <asp:BoundField DataField="productPrice" HeaderText="Image" ReadOnly="True" />  
                        <asp:BoundField DataField="teamID" HeaderText="Team ID" ReadOnly="True" HeaderStyle-Wrap="False" /> 
                        <asp:BoundField DataField="teamLocation" HeaderText="Team Location" ReadOnly="True" HeaderStyle-Wrap="False" />  
                        <asp:BoundField DataField="teamName" HeaderText="Team Name" ReadOnly="True" HeaderStyle-Wrap="False" />  
                        <asp:BoundField DataField="playerFirstName" HeaderText="Player First" ReadOnly="True" HeaderStyle-Wrap="False" />  
                        <asp:BoundField DataField="playerLastName" HeaderText="Player Last" ReadOnly="True" HeaderStyle-Wrap="False" /> 
                        <asp:BoundField DataField="productIsActive" HeaderText="Active" ReadOnly="True" />
                 <asp:CommandField ShowSelectButton="True" ButtonType="Button"> 
                    <ControlStyle CssClass="btn btn-dark"></ControlStyle>
                 </asp:CommandField>
                 
             </Columns>
             <HeaderStyle HorizontalAlign="Center" />
             <RowStyle HorizontalAlign="Center" />
         </asp:GridView>

            </div>
        </asp:Panel>


    </div>

</asp:Content>
