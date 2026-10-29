<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminOrders.aspx.cs" Inherits="eCommerceApp_project01.AdminOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="admin-dashboard">

        <div class="admin-dashboard-header">
            <h1>Order Management</h1>
            <p>View customer orders and manage their status.</p>
        </div>

        <div class="admin-order-filters">

            <asp:DropDownList ID="ddlOrderStatus" runat="server"
                CssClass="admin-order-dropdown">
                <asp:ListItem Text="All Orders" Value="All"></asp:ListItem>
                <asp:ListItem Text="Placed" Value="Placed"></asp:ListItem>
                <asp:ListItem Text="Shipped" Value="Shipped"></asp:ListItem>
                <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
            </asp:DropDownList>

            <asp:Button ID="btnFilter" runat="server"
                Text="Apply Filter"
                CssClass="admin-order-button"
                OnClick="btnFilter_Click" />

            <asp:Button ID="btnClearFilter" runat="server"
                Text="Clear Filter"
                CssClass="admin-order-button admin-order-button-light"
                OnClick="btnClearFilter_Click" />

        </div>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="admin-order-message"></asp:Label>

        <div class="admin-order-table-wrapper">

            <asp:GridView ID="gvOrders" runat="server"
                AutoGenerateColumns="False"
                CssClass="admin-order-table"
                GridLines="None"
                EmptyDataText="No orders found."
                DataKeyNames="orderId">

                <Columns>

                    <asp:BoundField DataField="orderId"
                        HeaderText="Order ID" />

                    <asp:BoundField DataField="user_Name"
                        HeaderText="Customer" />

                    <asp:BoundField DataField="productName"
                        HeaderText="Product" />

                    <asp:BoundField DataField="orderQty"
                        HeaderText="Quantity" />

                    <asp:BoundField DataField="orderTotalAmount"
                        HeaderText="Total Amount"
                        DataFormatString="₹{0:N2}" />

                    <asp:BoundField DataField="orderDate"
                        HeaderText="Order Date"
                        DataFormatString="{0:dd MMM yyyy}" />

                    <asp:BoundField DataField="orderStatus"
                        HeaderText="Order Status" />
                    <asp:TemplateField HeaderText="Order Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlOrderStatusRow" runat="server"
                                SelectedValue='<%# Bind("orderStatus") %>'>
                                <asp:ListItem Text="Placed" Value="Placed"></asp:ListItem>
                                <asp:ListItem Text="Shipped" Value="Shipped"></asp:ListItem>
                                <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                                <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Payment Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlPaymentStatusRow" runat="server"
                                SelectedValue='<%# Bind("paymentStatus") %>'>
                                <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                <asp:ListItem Text="Paid" Value="Paid"></asp:ListItem>
                                <asp:ListItem Text="Failed" Value="Failed"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnUpdateOrder" runat="server"
                                Text="Save Changes"
                                CssClass="admin-order-button"
                                CommandName="UpdateOrder"
                                CommandArgument='<%# Eval("orderId") %>'
                                CausesValidation="false"
                                OnCommand="btnUpdateOrder_Command" />
                        </ItemTemplate>
                    </asp:TemplateField>


                </Columns>

            </asp:GridView>

        </div>

    </div>


</asp:Content>
