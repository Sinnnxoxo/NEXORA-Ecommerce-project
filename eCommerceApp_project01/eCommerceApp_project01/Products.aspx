<%@ Page Title="Shop" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="eCommerceApp_project01.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  
    <section class="section-container">

        <div class="section-heading">
            <div>
                <span class="section-eyebrow">NEXORA COLLECTION</span>
                <h2>Explore Our Products</h2>
                <p>Find something you'll love.</p>
            </div>
        </div>

        <div class="product-filter">

            <div class="filter-field">
                <asp:Label ID="lblSearch" runat="server"
                    AssociatedControlID="txtSearch"
                    Text="Search Products" />

                <asp:TextBox ID="txtSearch" runat="server"
                    CssClass="form-control"
                    placeholder="Enter product name..." />
            </div>

            <div class="filter-field">
                <asp:Label ID="lblCategory" runat="server"
                    AssociatedControlID="ddlCategory"
                    Text="Category" />

                <asp:DropDownList ID="ddlCategory" runat="server"
                    CssClass="form-select"
                    AppendDataBoundItems="true">
                    <asp:ListItem Text="All Categories" Value="" />
                </asp:DropDownList>
            </div>

            <div class="filter-field">
                <asp:Label ID="lblBrand" runat="server"
                    AssociatedControlID="ddlBrand"
                    Text="Brand" />

                <asp:DropDownList ID="ddlBrand" runat="server"
                    CssClass="form-select"
                    AppendDataBoundItems="true">
                    <asp:ListItem Text="All Brands" Value="" />
                </asp:DropDownList>
            </div>

            <div class="filter-buttons">
                <asp:Button ID="btnSearch" runat="server"
                    Text="Search"
                    CssClass="btn btn-primary"
                    OnClick="btnSearch_Click" />

                <asp:Button ID="btnClear" runat="server"
                    Text="Clear Filters"
                    CssClass="btn btn-outline-secondary"
                    OnClick="btnClear_Click" />
            </div>

        </div>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="product-message" />

        <div class="product-grid">

            <asp:Repeater ID="rptProducts" runat="server"
                OnItemCommand="rptProducts_ItemCommand">

                <ItemTemplate>

                    <div class="product-card">

                        <a class="product-image-link"
                            href='<%# ResolveUrl("~/ProductDetails.aspx?id=") + Eval("productId") %>'>

                            <img class="product-image"
                                src='<%# ResolveUrl("~/Images/Products/") + System.IO.Path.GetFileName(Convert.ToString(Eval("productImage"))) %>'
                                alt='<%# Server.HtmlEncode(Convert.ToString(Eval("productName"))) %>' />

                        </a>

                        <div class="product-card-info">

                            <span class="product-category">
                                <%#: Eval("Category") %>
                            </span>

                            <h3>
                                <%#: Eval("productName") %>
                            </h3>

                            <p class="product-brand">
                                Brand: <%#: Eval("Brand") %>
                            </p>

                            <div class="product-card-bottom">

                                <span class="product-price">₹<%# Eval("Price", "{0:N0}") %>
                                </span>

                                <a class="product-view-btn"
                                    href='<%# ResolveUrl("~/ProductDetails.aspx?id=") + Eval("productId") %>'>View Details
                                </a>

                                <asp:Button ID="btnAddToWishlist" runat="server"
                                    Text="♡ Add to Wishlist"
                                    CssClass="admin-order-button admin-order-button-light"
                                    CommandName="AddToWishlist"
                                    CommandArgument='<%# Eval("productId") %>'
                                    CausesValidation="false" />

                            </div>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </div>

        <asp:Panel ID="pnlNoProducts" runat="server" Visible="false">
            <div class="no-products">
                <h3>No products found</h3>
                <p>Try another search term or change your filters.</p>
            </div>
        </asp:Panel>

    </section>
   

</asp:Content>
