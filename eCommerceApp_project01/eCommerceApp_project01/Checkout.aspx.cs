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
    public partial class Checkout : System.Web.UI.Page
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
                LoadCheckout();
            }
        }

        private void LoadCheckout()
        {
            int userId = Convert.ToInt32(Session["RegId"]);

            string qry = "SELECT Cart.productId, Products.productName, Products.Price, " +
                         "Cart.Quantity, (Products.Price * Cart.Quantity) AS Subtotal " +
                         "FROM Cart INNER JOIN Products " +
                         "ON Cart.productId = Products.productId " +
                         "WHERE Cart.userId = " + userId;

            DataTable dt = db.executeDataTable(qry);

            gvCheckout.DataSource = dt;
            gvCheckout.DataBind();

            decimal total = 0;

            foreach (DataRow row in dt.Rows)
            {
                total += Convert.ToDecimal(row["Subtotal"]);
            }

            lblTotal.Text = total.ToString();

            pnlCheckout.Visible = dt.Rows.Count > 0;
            pnlEmptyCart.Visible = dt.Rows.Count == 0;
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {

            int userId = Convert.ToInt32(Session["RegId"]);

            string cartQry = "SELECT Cart.productId, Cart.Quantity, Products.Price, " +
                             "Products.RemainingQty, Products.Status " +
                             "FROM Cart INNER JOIN Products " +
                             "ON Cart.productId = Products.productId " +
                             "WHERE Cart.userId = " + userId;

            DataTable dt = db.executeDataTable(cartQry);

            if (dt.Rows.Count == 0)
            {
                lblMessage.Text = "Your cart is empty.";
                return;
            }

            
            foreach (DataRow row in dt.Rows)
            {
                int quantity = Convert.ToInt32(row["Quantity"]);
                int stock = Convert.ToInt32(row["RemainingQty"]);
                string status = Convert.ToString(row["Status"]);

                if (status != "Active" || quantity < 1 || quantity > stock)
                {
                    lblMessage.Text =
                        "One or more products are unavailable or have insufficient stock.";
                    return;
                }
            }

           
            foreach (DataRow row in dt.Rows)
            {
                int productId = Convert.ToInt32(row["productId"]);
                int quantity = Convert.ToInt32(row["Quantity"]);
                decimal price = Convert.ToDecimal(row["Price"]);
                int stock = Convert.ToInt32(row["RemainingQty"]);

                decimal totalAmount = price * quantity;

                string orderQry =
                    "INSERT INTO Orders " +
                    "(userId, productId, orderTotalAmount, orderDate, " +
                    "orderStatus, paymentStatus, orderQty) VALUES (" +
                    userId + ", " + productId + ", " +
                    totalAmount.ToString() +
                    ", GETDATE(), 'Placed', 'Pending', " + quantity + ")";

                int orderResult = db.executeNonQuery(orderQry);

                if (orderResult > 0)
                {
                    string stockQry =
                        "UPDATE Products SET RemainingQty = RemainingQty - " +
                        quantity + " WHERE productId = " + productId +
                        " AND Status = 'Active' AND RemainingQty >= " + quantity;

                    int stockResult = db.executeNonQuery(stockQry);

                    if (stockResult == 0)
                    {
                        lblMessage.Text =
                            "Stock changed while placing your order. Please contact the administrator.";
                        return;
                    }
                }
                else
                {
                    lblMessage.Text = "Unable to place your order.";
                    return;
                }
            }

            string deleteQry = "DELETE FROM Cart WHERE userId = " + userId;

            int deleteResult = db.executeNonQuery(deleteQry);

            if (deleteResult >= 0)
            {
                Session["OrderPlaced"] = "true";

                Response.Redirect("OrderConfirmation.aspx");
            }
            else
            {
                lblMessage.Text = "Order placed, but the cart could not be cleared.";
            }


        }

    }


}
