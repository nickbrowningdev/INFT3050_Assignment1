<%@ Page Title="Update Product" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminUpdateProduct.aspx.cs" Inherits="c3302779_Assig1.UL.AdminUpdateProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Update Product</h2>
        </div>
        <asp:Panel ID="updateProductPanel" CssClass="row" runat="server">
            <div class="col-md-6">

                <!-- player first name -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtPlayerFirstName">Player First Name</asp:Label>
                    <asp:TextBox runat="server" Enabled="False" class="form-control" ID="txtPlayerFirstName" placeholder="Player First Name" ToolTip="Player First Name Here" />
                        
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPlayerFirstName" CssClass="text-danger" ErrorMessage="Player First Name Required." />
                </div>

                <!-- player last name -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtPlayerLastName">Player Last Name</asp:Label>
                    <asp:TextBox runat="server" Enabled="False" class="form-control" ID="txtPlayerLastName" placeholder="Player Last Name" ToolTip="Player Last Name Here" />
                        
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPlayerLastName" CssClass="text-danger" ErrorMessage="Player Last Name Required." />
                </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="ddlTeamList">Select A Team</asp:Label>
                    <asp:DropDownList ID="ddlTeamList" Enabled="False" CssClass="form-control" runat="server" DataTextField="teamFullName" DataValueField="teamID" OnDataBound="addInitialItem"></asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Choose a Team" ControlToValidate="ddlTeamList" InitialValue="Choose one..." ValidationGroup="Team" CssClass="text-danger"/>
                </div>

                <!-- product description -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtProductDescription">Product Description</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtProductDescription" placeholder="Product Description" ToolTip="Product Description Here" TextMode="MultiLine" Rows="5" MaxLength="0" Columns="100"/>
                        
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtProductDescription" CssClass="text-danger" ErrorMessage="Product Description Required." />
                </div>

                <!-- price -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtPrice">Price (AUD $)</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtPrice" placeholder="Price (AUD $)" ToolTip="Price (AUD $) Here" />
                        
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrice" CssClass="text-danger" ErrorMessage="Price (AUD $) Required." />

                    <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic" ControlToValidate="txtPrice"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="rxvPrice" runat="server" ErrorMessage="Enter a money value" CssClass="text-danger" ControlToValidate="txtPrice" ValidationExpression="\d+(\.\d{2})?"></asp:RegularExpressionValidator>
                </div>

                <!-- image -->
                <div class="form-group">
                    <asp:Table ID="imageUploadForm" runat="server">
                        <asp:TableRow runat="server">
                            <asp:TableCell runat="server">Upload Image</asp:TableCell>
                            <asp:TableCell runat="server"><asp:Image ID="productImage" width="50" height="50" runat="server" /></asp:TableCell>
                            <asp:TableCell runat="server"><asp:FileUpload ID="fullImage" CssClass="form-control-file" runat="server"></asp:FileUpload></asp:TableCell>
                            <asp:TableCell runat="server">
                                <asp:CustomValidator ID="csvFullImageFile" runat="server" ErrorMessage="Must be a jpg or png file" CssClass="text-danger" OnServerValidate="checkValidImage" ControlToValidate="fullImage" Display="Dynamic" SetFocusOnError="True"></asp:CustomValidator>
                                <asp:CustomValidator ID="csvFullImageExists" runat="server" ErrorMessage="Image name exists on server" CssClass="text-danger" OnServerValidate="fileExists" ControlToValidate="fullImage" Display="Dynamic" SetFocusOnError="True"></asp:CustomValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>

                <div class="form-group">
                    <asp:Button ID="Update" runat="server" Text="Update Product" Class="btn btn-dark" OnClick="Update_Click"/>
                </div>

                <div class="form-group">
                    <asp:Button ID="ToggleProduct" runat="server" Text="Active" CssClass="btn btn-dark" OnClick="ToggleProductButton_Click" CausesValidation="False" />
                </div>

                <div class="form-group">
                    <asp:HyperLink class="pb-3" runat="server" NavigateUrl="~/UL/AdminAccount.aspx">Return</asp:HyperLink>
                </div>

            </div>
        </asp:Panel>
    </div>

</asp:Content>
