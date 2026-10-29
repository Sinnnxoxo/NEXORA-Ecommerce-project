using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerceApp_project01
{
    public partial class AdminDashboard : System.Web.UI.Page
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
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            string qry = "SELECT COUNT(*) FROM Products";
            lblTotalProducts.Text = db.executeScalar(qry);

            qry = "SELECT COUNT(*) FROM Products WHERE Status = 'Active'";
            lblActiveProducts.Text = db.executeScalar(qry);

            qry = "SELECT COUNT(*) FROM Orders";
            lblTotalOrders.Text = db.executeScalar(qry);

            qry = "SELECT COUNT(*) FROM Users";
            lblTotalCustomers.Text = db.executeScalar(qry);
        }
    }
}