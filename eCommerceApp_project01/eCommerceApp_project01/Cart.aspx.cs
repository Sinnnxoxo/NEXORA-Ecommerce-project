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
    public partial class Cart : System.Web.UI.Page
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
                LoadCart();
            }
        }

        private void LoadCart()
        {
            int userId = Convert.ToInt32(Session["RegId"]);
            string qry = "SELECT Cart.cartId, Products.productName, Products.Price, " + "Cart.Quantity, Cart.cartTotalAmount " + "FROM Cart INNER JOIN Products " + "ON Cart.productId = Products.productId " + "WHERE Cart.userId = " + userId;

            DataTable dt = db.executeDataTable(qry);

            gvCart.DataSource = dt;
            gvCart.DataBind();

            decimal total = 0;

            foreach (DataRow row in dt.Rows)
            {
                total += Convert.ToDecimal(row["cartTotalAmount"]);
            }

            lblTotal.Text = total.ToString();

            pnlCart.Visible = dt.Rows.Count > 0;

            pnlEmptyCart.Visible = dt.Rows.Count == 0;
        }

        protected void gvCart_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RemoveItem")
            {
                int cartId;

                cartId = Convert.ToInt32(e.CommandArgument.ToString());

                int userId = Convert.ToInt32(Session["RegId"]);

                string qry = "DELETE FROM Cart WHERE cartId = " + cartId + " AND userId = " + userId;

                int result = db.executeNonQuery(qry);

                if (result > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Product removed from your cart.";
                }
                else 
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red; 
                    lblMessage.Text = "Unable to remove the product.";
                }

                LoadCart();
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Checkout.aspx");
        }
    }
}