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
    public partial class MyOrders : System.Web.UI.Page
    {

        ConnectionCls db = new ConnectionCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["RegId"] == null || Session["UserType"] == null || Session["UserType"].ToString() != "user")
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
            int userId = Convert.ToInt32(Session["RegId"]);

            string qry = "SELECT Orders.orderId, Products.productName, Orders.orderQty, " + "Orders.orderTotalAmount, Orders.orderDate, " + "Orders.orderStatus, Orders.paymentStatus " + "FROM Orders " + "INNER JOIN Products ON Orders.productId = Products.productId " + "WHERE Orders.userId = " + userId + " ORDER BY Orders.orderDate DESC";
            
            DataTable dt = db.executeDataTable(qry); 

            gvOrders.DataSource = dt;
            gvOrders.DataBind();
            
            pnlOrders.Visible = dt.Rows.Count > 0; 
            pnlNoOrders.Visible = dt.Rows.Count == 0;
        }
    }
}