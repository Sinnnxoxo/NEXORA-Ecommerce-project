<%@ Page Title="My Cart" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Cart.aspx.cs"
    Inherits="eCommerceApp_project01.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <section class="auth-section">
        <div class="auth-container" style="max-width: 1000px;">

            <div class="auth-header">
                <span class="auth-badge">YOUR SHOPPING CART</span>
                <h1>My Cart</h1>
                <p>Review your selected products before checkout.</p>
            </div>

            <asp:Label ID="lblMessage" runat="server"
                CssClass="auth-message" EnableViewState="false" />

            <asp:Panel ID="pnlCart" runat="server" Visible="false">

                <div style="overflow-x: auto;">
                    <asp:GridView ID="gvCart" runat="server"
                        AutoGenerateColumns="False"
                        CssClass="cart-table"
                        GridLines="None"
                        DataKeyNames="cartId"
                        OnRowCommand="gvCart_RowCommand"
                        EmptyDataText="Your cart is empty.">

                        <Columns>
                            <asp:BoundField DataField="productName"
                                HeaderText="Product" />

                            <asp:BoundField DataField="Price"
                                HeaderText="Price (₹)"
                                DataFormatString="{0:N2}" />

                            <asp:BoundField DataField="Quantity"
                                HeaderText="Quantity" />

                            <asp:BoundField DataField="cartTotalAmount"
                                HeaderText="Subtotal (₹)"
                                DataFormatString="{0:N2}" />

                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:Button ID="btnRemove" runat="server"
                                        Text="Remove"
                                        CssClass="auth-button"
                                        CommandName="RemoveItem"
                                        CommandArgument='<%# Eval("cartId") %>'
                                        CausesValidation="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>

                    </asp:GridView>
                </div>

                <div style="text-align: right; margin-top: 25px;">
                    <h2>Total:
                    ₹<asp:Label ID="lblTotal" runat="server" Text="0.00" />
                    </h2>

                    <asp:Button ID="btnCheckout" runat="server"
                        Text="Proceed to Checkout"
                        CssClass="auth-button"
                        OnClick="btnCheckout_Click"
                        CausesValidation="false" />
                </div>

            </asp:Panel>

            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
                <p style="text-align: center; padding: 25px;">
                    Your cart is empty. Browse our products to find something you love!
                </p>

                <div style="text-align: center;">
                    <a href="Products.aspx" class="auth-button"
                        style="display: inline-block; text-decoration: none;">Continue Shopping
                    </a>
                </div>
            </asp:Panel>

        </div>
    </section>


</asp:Content>
