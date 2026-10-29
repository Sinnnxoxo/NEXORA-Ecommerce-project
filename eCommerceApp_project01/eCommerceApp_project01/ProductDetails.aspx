<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="eCommerceApp_project01.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="product-details-section">
        <div class="product-details-container">

            <div class="product-details-image">
                <asp:Image ID="imgProduct" runat="server" AlternateText="Product image" />
            </div>

            <div class="product-details-info">
                <asp:Label ID="lblCategory" runat="server" CssClass="product-category" />

                <h1>
                    <asp:Label ID="lblProductName" runat="server" />
                </h1>

                <p class="product-details-brand">
                    Brand:
                <asp:Label ID="lblBrand" runat="server" />
                </p>

                <p class="product-details-description">
                    <asp:Label ID="lblDescription" runat="server" />
                </p>

                <div class="product-details-price">
                    ₹<asp:Label ID="lblPrice" runat="server" />
                </div>

                <p class="product-details-stock">
                    Available stock:
                <asp:Label ID="lblStock" runat="server" />
                </p>

                <div class="quantity-selector">
                    <label for="<%= txtQuantity.ClientID %>">Quantity</label>
                    <asp:TextBox ID="txtQuantity" runat="server"
                        Text="1" TextMode="Number" />
                </div>

                <asp:Button ID="btnAddToCart" runat="server"
                    Text="Add to Cart"
                    CssClass="btn-product-details"
                    OnClick="btnAddToCart_Click" />

                <asp:Button ID="btnAddToWishlist" runat="server"
                    Text="♡ Add to Wishlist"
                    CssClass="admin-order-button admin-order-button-light"
                    OnClick="btnAddToWishlist_Click"
                    CausesValidation="false" />


                <asp:Label ID="lblMessage" runat="server"
                    CssClass="product-message" />

            </div>

        </div>
    </section>


</asp:Content>

