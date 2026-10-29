<%@ Page Title="My Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="eCommerceApp_project01.MyOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container my-5">

        <h2 class="mb-4">My Orders</h2>

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="text-muted"
            EnableViewState="false">
        </asp:Label>

        <asp:Panel ID="pnlOrders" runat="server" Visible="false">

            <div class="table-responsive">
                <asp:GridView
                    ID="gvOrders"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="table table-bordered table-striped"
                    EmptyDataText="You haven't placed any orders yet.">

                    <Columns>

                        <asp:BoundField
                            DataField="orderId"
                            HeaderText="Order ID" />

                        <asp:BoundField
                            DataField="productName"
                            HeaderText="Product" />

                        <asp:BoundField
                            DataField="orderQty"
                            HeaderText="Quantity" />

                        <asp:BoundField
                            DataField="orderTotalAmount"
                            HeaderText="Total Amount (₹)"
                            DataFormatString="{0:N2}" />

                        <asp:BoundField
                            DataField="orderDate"
                            HeaderText="Order Date"
                            DataFormatString="{0:dd MMM yyyy, hh:mm tt}" />

                        <asp:BoundField
                            DataField="orderStatus"
                            HeaderText="Order Status" />

                        <asp:BoundField
                            DataField="paymentStatus"
                            HeaderText="Payment Status" />

                    </Columns>

                </asp:GridView>
            </div>

        </asp:Panel>

        <asp:Panel ID="pnlNoOrders" runat="server" Visible="false">

            <div class="alert alert-info">
                You haven't placed any orders yet.
            </div>

            <asp:HyperLink
                ID="lnkShopNow"
                runat="server"
                NavigateUrl="~/Default.aspx"
                CssClass="btn btn-primary"
                Text="Start Shopping" />

        </asp:Panel>

    </div>


</asp:Content>
