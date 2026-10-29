<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="eCommerceApp_project01.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-dashboard">

        <div class="admin-dashboard-header">
            <h1>Admin Dashboard</h1>
            <p>Welcome to NEXORA administration. Manage your store from here.</p>
        </div>

        <div class="admin-dashboard-cards">

            <div class="admin-dashboard-card">
                <h3>Total Products</h3>
                <asp:Label ID="lblTotalProducts" runat="server" Text="0"
                    CssClass="admin-dashboard-number"></asp:Label>
                <p>Products in your database</p>
            </div>

            <div class="admin-dashboard-card">
                <h3>Active Products</h3>
                <asp:Label ID="lblActiveProducts" runat="server" Text="0"
                    CssClass="admin-dashboard-number"></asp:Label>
                <p>Products available in your shop</p>
            </div>

            <div class="admin-dashboard-card">
                <h3>Total Orders</h3>
                <asp:Label ID="lblTotalOrders" runat="server" Text="0"
                    CssClass="admin-dashboard-number"></asp:Label>
                <p>Orders received from customers</p>
            </div>

            <div class="admin-dashboard-card">
                <h3>Total Customers</h3>
                <asp:Label ID="lblTotalCustomers" runat="server" Text="0"
                    CssClass="admin-dashboard-number"></asp:Label>
                <p>Registered customer accounts</p>
            </div>

        </div>

        <div class="admin-dashboard-actions">
            <h2>Quick Actions</h2>

            <div class="admin-action-buttons">
                <a href="<%= ResolveUrl("~/AdminProducts.aspx") %>"
                    class="admin-action-btn">Manage Products
                </a>

                <a href="<%= ResolveUrl("~/AdminOrders.aspx") %>"
                    class="admin-action-btn">Manage Orders
                </a>

                <a href="<%= ResolveUrl("~/Products.aspx") %>"
                    class="admin-action-btn">View Online Store
                </a>
            </div>
        </div>

    </div>

</asp:Content>
