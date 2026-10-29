<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Checkout.aspx.cs"
    Inherits="eCommerceApp_project01.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <section class="auth-section">
        <div class="auth-container" style="max-width: 900px;">

            <div class="auth-header">
                <span class="auth-badge">ALMOST THERE</span>
                <h1>Checkout</h1>
                <p>Review your order before confirming your purchase.</p>
            </div>

            <asp:Label ID="lblMessage" runat="server"
                CssClass="auth-message" EnableViewState="false" />

            <asp:Panel ID="pnlCheckout" runat="server" Visible="false">

                <h2>Order Summary</h2>

                <div style="overflow-x: auto;">
                    <asp:GridView ID="gvCheckout" runat="server"
                        AutoGenerateColumns="False"
                        CssClass="cart-table"
                        GridLines="None">

                        <Columns>
                            <asp:BoundField DataField="productName"
                                HeaderText="Product" />

                            <asp:BoundField DataField="Price"
                                HeaderText="Price (₹)"
                                DataFormatString="{0:N2}" />

                            <asp:BoundField DataField="Quantity"
                                HeaderText="Quantity" />

                            <asp:BoundField DataField="Subtotal"
                                HeaderText="Subtotal (₹)"
                                DataFormatString="{0:N2}" />
                        </Columns>

                    </asp:GridView>
                </div>

                <div style="text-align: right; margin-top: 25px;">
                    <h2>Order Total: ₹<asp:Label ID="lblTotal"
                        runat="server" Text="0.00" />
                    </h2>
                </div>

                <div class="form-group" style="margin-top: 25px;">
                    <label>Payment Method</label>
                    <asp:TextBox ID="txtPaymentMethod" runat="server"
                        CssClass="form-control"
                        Text="Cash on Delivery" ReadOnly="true" />
                </div>

                <asp:Button ID="btnPlaceOrder" runat="server"
                    Text="Place Order"
                    CssClass="auth-button"
                    OnClick="btnPlaceOrder_Click"
                    CausesValidation="false" />

            </asp:Panel>

            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
                <p style="text-align: center; padding: 25px;">
                    Your cart is empty. Add products before checking out.
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
