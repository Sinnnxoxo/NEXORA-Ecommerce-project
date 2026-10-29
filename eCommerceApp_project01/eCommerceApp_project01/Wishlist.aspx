<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="eCommerceApp_project01.Wishlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="admin-dashboard">

    <div class="admin-dashboard-header">
        <h1>My Wishlist ❤️</h1>
        <p>Your favourite products, all in one place.</p>
    </div>

    <asp:Label ID="lblMessage" runat="server"></asp:Label>

    <asp:Repeater ID="rptWishlist" runat="server"
        OnItemCommand="rptWishlist_ItemCommand">

        <HeaderTemplate>
            <div class="product-grid">
        </HeaderTemplate>

        <ItemTemplate>
            <div class="product-card">

                <a href='<%# ResolveUrl("~/ProductDetails.aspx?id=") + Eval("productId") %>'>
                    <img src='<%# ResolveUrl("~/Images/Products/") + System.IO.Path.GetFileName(Convert.ToString(Eval("productImage"))) %>'
                        alt='<%# Eval("productName") %>'
                        class="product-image" />
                </a>

                <div class="product-card-content">

                    <h3><%# Eval("productName") %></h3>

                    <p class="product-price">
                        ₹<%# Eval("Price", "{0:N2}") %>
                    </p>

                    <asp:Button ID="btnAddToCart" runat="server"
                        Text="Add to Cart"
                        CssClass="admin-order-button"
                        CommandName="AddToCart"
                        CommandArgument='<%# Eval("productId") %>'
                        CausesValidation="false" />

                    <asp:Button ID="btnRemove" runat="server"
                        Text="Remove"
                        CssClass="admin-order-button admin-order-button-light"
                        CommandName="RemoveFromWishlist"
                        CommandArgument='<%# Eval("wishId") %>'
                        CausesValidation="false" />

                </div>

            </div>
        </ItemTemplate>

        <FooterTemplate>
            </div>
        </FooterTemplate>

    </asp:Repeater>

</div>


</asp:Content>
