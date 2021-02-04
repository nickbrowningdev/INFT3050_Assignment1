<%@ Page Title="Postage Option Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPostageOptionManagement.aspx.cs" Inherits="c3302779_Assig1.UL.AdminPostageOptionManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top:30px">
        <div class="text-center">
            <h2>Postage Option</h2>
        </div>
        <asp:Panel ID="postageOptionPanel" CssClass="row" runat="server">
            <div class="col-md-6">

                <asp:ListView runat="server" ID="lsvPostage">
                    <ItemTemplate>
                        <li class="list-group-item">
                            <div class="row">
                                <div class="col-6">
                                    <%-- Data-bound content. --%>
                                    <asp:Label ID="lblPostageID" runat="server" Text='<%#Eval("postageID") %>' />,&nbsp;<asp:Label ID="lblPostageType" runat="server" Text='<%#Eval("postageType") %>' />,&nbsp;<asp:Label ID="lblPostageCost" runat="server" Text='<%#string.Format("{0:C}",Eval("postageCost")) %>' />
                                </div>
                    
                                <div class="col">
                                    <asp:CheckBox ID="checkActive" runat="server" OnCheckedChanged="checkActive_CheckedChanged" Checked='<%# Eval("postageIsActive") %>' Text="&nbsp;Active" AutoPostBack="True" />
                                </div>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:ListView>
                
                <hr />

                <h3>Add Postage Option</h3>

                <!-- shipping type -->
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtPostageType">Postage Type</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtPostageType" placeholder="Postage Type" ToolTip="Postage Type Here" />
                        
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPostageType" CssClass="text-danger" ErrorMessage="Postage Type Required." />
                </div>

                <div class="form-group">
                    <!-- shipping days -->
                    <asp:Label runat="server" AssociatedControlID="txtPostageDays">Postage Days</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtPostageDays" placeholder="Postage Days" ToolTip="Postage Days Here" />
                        
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPostageDays" CssClass="text-danger" ErrorMessage="Postage Days Required." />
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Must be a whole number" ValidationExpression="\d{1,2}" CssClass="text-danger" ControlToValidate="txtPostageDays" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group">
                    <!-- shipping cost -->
                    <asp:Label runat="server" AssociatedControlID="txtPostageCost">Postage Cost</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="txtPostageCost" placeholder="Postage Cost" ToolTip="Postage Cost Here" />
                        
                    <!--Required field validator-->
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPostageCost" CssClass="text-danger" ErrorMessage="Postage Cost Required." />
                    <asp:RegularExpressionValidator  runat="server" ErrorMessage="Enter a money value" CssClass="text-danger" ControlToValidate="txtPostageCost" ValidationExpression="\d+(\.\d{2})?"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group">
                    <asp:Button runat="server" Text="Create Product" Class="btn btn-dark" OnClick="CreatePostageOption"/>
                </div>

                <div class="form-group">
                    <asp:HyperLink class="pb-3" runat="server" NavigateUrl="~/UL/AdminAccount.aspx">Return</asp:HyperLink>
                </div>
            </div>
        </asp:Panel>
    </div>

</asp:Content>
