<%@ Page Title="Product Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminProducts.aspx.cs" Inherits="eCommerceApp_project01.AdminProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <section class="section-container">

        <div class="section-heading">
            <div>
                <span class="section-eyebrow">ADMINISTRATION</span>
                <h2>Product Management</h2>
                <p>Manage your store's products, prices, stock, and availability.</p>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" />

        <div class="admin-product-form">

            <h3>Add / Edit Product</h3>

            <asp:HiddenField ID="hfProductId" runat="server" />

            <div class="admin-form-grid">

                <div>
                    <asp:Label ID="lblProductName" runat="server"
                        AssociatedControlID="txtProductName"
                        Text="Product Name" />
                    <asp:TextBox ID="txtProductName" runat="server"
                        CssClass="form-control" MaxLength="50" />
                </div>

                <div>
                    <asp:Label ID="lblCategory" runat="server"
                        AssociatedControlID="txtCategory"
                        Text="Category" />
                    <asp:TextBox ID="txtCategory" runat="server"
                        CssClass="form-control" MaxLength="50" />
                </div>

                <div>
                    <asp:Label ID="lblBrand" runat="server"
                        AssociatedControlID="txtBrand"
                        Text="Brand" />
                    <asp:TextBox ID="txtBrand" runat="server"
                        CssClass="form-control" MaxLength="50" />
                </div>

                <div>
                    <asp:Label ID="lblPrice" runat="server"
                        AssociatedControlID="txtPrice"
                        Text="Price (₹)" />
                    <asp:TextBox ID="txtPrice" runat="server"
                        CssClass="form-control" TextMode="Number" />
                </div>

                <div>
                    <asp:Label ID="lblStock" runat="server"
                        AssociatedControlID="txtStock"
                        Text="Available Quantity" />
                    <asp:TextBox ID="txtStock" runat="server"
                        CssClass="form-control" TextMode="Number" />
                </div>

                <div>
                    <asp:Label ID="lblStatus" runat="server"
                        AssociatedControlID="ddlStatus"
                        Text="Availability" />
                    <asp:DropDownList ID="ddlStatus" runat="server"
                        CssClass="form-select">
                        <asp:ListItem Text="Active" Value="Active" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>
                </div>

                <div class="admin-form-full">
                    <asp:Label ID="lblDescription" runat="server"
                        AssociatedControlID="txtDescription"
                        Text="Description" />
                    <asp:TextBox ID="txtDescription" runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine" Rows="4" />
                </div>

                <div class="admin-form-full">
                    <asp:Label ID="lblImage" runat="server"
                        AssociatedControlID="fuProductImage"
                        Text="Product Image" />
                    <asp:FileUpload ID="fuProductImage" runat="server"
                        CssClass="form-control" />
                    <small>Choose an image when adding a product. When editing, leave this empty to keep the existing image.</small>
                </div>

            </div>

            <div class="admin-form-buttons">
                <asp:Button ID="btnSave" runat="server"
                    Text="Save Product"
                    CssClass="btn btn-primary"
                    OnClick="btnSave_Click" />

                <asp:Button ID="btnCancel" runat="server"
                    Text="Clear Form"
                    CssClass="btn btn-outline-secondary"
                    OnClick="btnCancel_Click"
                    CausesValidation="false" />
            </div>

        </div>

        <h3 class="admin-list-heading">Existing Products</h3>

        <div class="table-responsive">
            <asp:GridView ID="gvProducts" runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-bordered table-striped"
                DataKeyNames="productId"
                OnRowCommand="gvProducts_RowCommand">

                <Columns>

                    <asp:BoundField DataField="productId" HeaderText="ID" />
                    <asp:BoundField DataField="productName" HeaderText="Product" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="Brand" HeaderText="Brand" />
                    <asp:BoundField DataField="Price" HeaderText="Price (₹)" DataFormatString="{0:N0}" />
                    <asp:BoundField DataField="RemainingQty" HeaderText="Stock" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>

                            <asp:Button ID="btnEdit" runat="server"
                                Text="Edit"
                                CssClass="btn btn-sm btn-outline-primary"
                                CommandName="EditProduct"
                                CommandArgument='<%# Eval("productId") %>'
                                CausesValidation="false" />

                            <asp:Button ID="btnDelete" runat="server"
                                Text="Delete"
                                CssClass="btn btn-sm btn-outline-danger"
                                CommandName="DeleteProduct"
                                CommandArgument='<%# Eval("productId") %>'
                                OnClientClick="return confirm('Are you sure you want to deactivate this product?');"
                                CausesValidation="false" />

                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>
        </div>

    </section>


</asp:Content>
