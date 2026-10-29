<%@ Page Title="Home | NEXORA"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Default.aspx.cs"
    Inherits="eCommerceApp_project01.Default" %>

<asp:Content ID="HeadSection"
    ContentPlaceHolderID="HeadContent"
    runat="server">

    <meta name="description"
        content="Discover quality products at NEXORA." />

</asp:Content>

<asp:Content ID="HomeContent"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <!-- Hero Section -->

    <section class="hero-section">

        <div class="hero-content">

            <span class="hero-label">YOUR NEXT FAVOURITE FIND
            </span>

            <h1>Discover more.
                <br />
                <span>Live better.</span>
            </h1>

            <p>
                Explore a collection of products designed
                to bring quality, convenience, and style
                into your everyday life.
            </p>

            <a href="<%= ResolveUrl("~/Products.aspx") %>"
                class="primary-button">Explore Collection
                <span aria-hidden="true">&rarr;</span>
            </a>

            <div class="hero-note">
                <span class="hero-dot"></span>
                A better shopping experience starts here.
            </div>

        </div>

        <div class="hero-visual">

            <div class="hero-decoration"></div>

            <div class="hero-placeholder">
                <span class="hero-placeholder-icon">N.
                </span>

                <p>
                    YOUR NEXT FAVOURITE
                    <br />
                    THING STARTS HERE.
                </p>
            </div>

            <div class="floating-card">
                <span class="floating-card-icon">&#10003;
                </span>

                <div>
                    <strong>Find your favourites</strong>
                    <small>Explore our collection</small>
                </div>
            </div>

        </div>

    </section>


    <!-- Category Section -->

    <section class="section-container">

        <div class="section-heading">

            <div>
                <span class="section-eyebrow">EXPLORE THE STORE
                </span>

                <h2>Shop by category</h2>

                <p>
                    Find something you'll love.
                </p>
            </div>

            <a href="<%= ResolveUrl("~/Products.aspx") %>"
                class="text-link">View all products &rarr;
            </a>

        </div>

        <div class="category-grid">

            <a class="category-card" href="<%= ResolveUrl("~/Products.aspx?category=Electronics") %>">
                <div class="category-art category-electronics">
                    <span>&#9881;</span>
                </div>

                <div class="category-info">
                    <h3>Electronics</h3>
                    <span>Explore collection &rarr;</span>
                </div>
            </a>

            <a class="category-card" href="<%= ResolveUrl("~/Products.aspx?category=Fashion") %>">
                <div class="category-art category-fashion">
                    <span>&#9733;</span>
                </div>

                <div class="category-info">
                    <h3>Fashion</h3>
                    <span>Explore collection &rarr;</span>
                </div>
            </a>

            <a class="category-card" href="<%= ResolveUrl("~/Products.aspx?category=Home & Living") %>">
                <div class="category-art category-home">
                    <span>&#8962;</span>
                </div>

                <div class="category-info">
                    <h3>Home &amp; Living</h3>
                    <span>Explore collection &rarr;</span>
                </div>
            </a>

            <a class="category-card" href="<%= ResolveUrl("~/Products.aspx?category=Accessories") %>">
                <div class="category-art category-accessories">
                    <span>&#10022;</span>
                </div>

                <div class="category-info">
                    <h3>Accessories</h3>
                    <span>Explore collection &rarr;</span>
                </div>
            </a>

        </div>

    </section>


    <!-- Featured Products Introduction -->

    <section class="featured-section">

        <div class="section-container">

            <div class="section-heading">

                <div>
                    <span class="section-eyebrow">CURATED FOR YOU
                    </span>

                    <h2>Featured products</h2>

                    <p>
                        Discover something new for your everyday life.
                    </p>
                </div>

                <a href="<%= ResolveUrl("~/Products.aspx") %>"
                    class="text-link">Shop all &rarr;
                </a>

            </div>
            <div class="product-grid">
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <div class="product-card">
                            <div class="product-image">
                                <img src='<%# ResolveUrl("~/Images/Products/" + Eval("productImage")) %>'
                                    alt='<%# Eval("productName") %>' />
                            </div>


                            <div class="product-info">
                                <span class="product-category"><%# Eval("Category") %></span>
                                <h3><%# Eval("productName") %></h3>
                                <p><%# Eval("Description") %></p>

                                <div class="product-bottom">
                                    <span class="product-price">₹<%# Eval("Price", "{0:N2}") %></span><span class="product-stock"><%# Eval("RemainingQty") %>in stock
                                    </span>
                                </div>

                                <asp:HyperLink ID="lnkViewProduct" runat="server"
                                    CssClass="btn-product"
                                    NavigateUrl='<%# "ProductDetails.aspx?id=" + Eval("productId") %>'
                                    Text="View Product" />
                            </div>
                        </div>
                    </ItemTemplate>


                </asp:Repeater>
            </div>

        </div>

    </section>

</asp:Content>
