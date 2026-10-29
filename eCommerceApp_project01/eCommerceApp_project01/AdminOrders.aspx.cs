using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace eCommerceApp_project01
{
    public partial class AdminOrders : System.Web.UI.Page
    {
        ConnectionCls db = new ConnectionCls();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["RegId"] == null || Session["UserType"] == null || Session["UserType"].ToString() != "admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            string qry = "SELECT Orders.orderId, Users.user_Name, Products.productName, " + "Orders.orderQty, Orders.orderTotalAmount, Orders.orderDate, " + "Orders.orderStatus, Orders.paymentStatus " + "FROM Orders " + "INNER JOIN Users ON Orders.userId = Users.userId " + "INNER JOIN Products ON Orders.productId = Products.productId " + "ORDER BY Orders.orderDate DESC";

            DataTable dt = db.executeDataTable(qry);

            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string status = ddlOrderStatus.SelectedValue;

            if (status == "All")
            {
                LoadOrders();
                return;
            }

            string qry = "SELECT O.orderId, U.user_Name, P.productName, " + "O.orderQty, O.orderTotalAmount, O.orderDate, " + "O.orderStatus, O.paymentStatus " + "FROM Orders O " + "INNER JOIN Users U ON O.userId = U.userId " + "INNER JOIN Products P ON O.productId = P.productId " + "WHERE O.orderStatus = '" + status + "' " + "ORDER BY O.orderDate DESC";

            DataTable dt = db.executeDataTable(qry);

            gvOrders.DataSource = dt;
            gvOrders.DataBind();

            lblMessage.Text = dt.Rows.Count + " order record(s) found.";
        }

        protected void btnClearFilter_Click(object sender, EventArgs e)
        {
            ddlOrderStatus.SelectedValue = "All";
            lblMessage.Text = "";
            LoadOrders();
        }

        protected void btnUpdateOrder_Command(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);


            Button btn = (Button)sender;

            GridViewRow row = (GridViewRow)btn.NamingContainer;

            DropDownList ddlOrderStatusRow = (DropDownList)row.FindControl("ddlOrderStatusRow");

            DropDownList ddlPaymentStatusRow = (DropDownList)row.FindControl("ddlPaymentStatusRow");

            string orderStatus = ddlOrderStatusRow.SelectedValue;
            string paymentStatus = ddlPaymentStatusRow.SelectedValue;

            string qry =
                "UPDATE Orders SET " +
                "orderStatus = '" + orderStatus + "', " +
                "paymentStatus = '" + paymentStatus + "' " +
                "WHERE orderId = " + orderId;

            int result = db.executeNonQuery(qry);

            if (result > 0)
            {
                lblMessage.Text = "Order #" + orderId + " updated successfully.";
            }
            else
            {
                lblMessage.Text = "Unable to update order #" + orderId + ".";
            }

            LoadOrders();


        }

    }
}