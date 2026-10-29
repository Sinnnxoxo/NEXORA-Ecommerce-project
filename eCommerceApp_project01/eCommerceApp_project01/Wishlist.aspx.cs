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
    public partial class Wishlist : System.Web.UI.Page
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
                LoadWishlist();
            }
        }

        private void LoadWishlist()
        {
            int userId = Convert.ToInt32(Session["RegId"]);

            string qry = "SELECT W.wishId, W.productId, P.productName, " + "P.Price, P.productImage " + "FROM WishList W " + "INNER JOIN Products P ON W.productId = P.productId " + "WHERE W.userId = " + userId + " " + "AND W.wishStatus = 'Active' " + "ORDER BY W.wishId DESC";

            DataTable dt = db.executeDataTable(qry);

            rptWishlist.DataSource = dt;
            rptWishlist.DataBind();

            if (dt.Rows.Count == 0)
            {
                lblMessage.Text = "Your wishlist is empty. Explore our store and save your favourite products!";
            }

            else
            {
                lblMessage.Text = "";
            }

        }

        protected void rptWishlist_ItemCommand(object source,RepeaterCommandEventArgs e)
        {
            int userId = Convert.ToInt32(Session["RegId"]);


            if (e.CommandName == "RemoveFromWishlist")
            {
                int wishId = Convert.ToInt32(e.CommandArgument);

                string deleteQry =
                    "DELETE FROM WishList " +
                    "WHERE wishId = " + wishId +
                    " AND userId = " + userId;

                db.executeNonQuery(deleteQry);

                lblMessage.Text = "Product removed from your wishlist.";

                LoadWishlist();
            }
            else if (e.CommandName == "AddToCart")
            {
                int productId = Convert.ToInt32(e.CommandArgument);

                // Check whether the product is active and has available stock.
                string stockQry =
                    "SELECT RemainingQty FROM Products " +
                    "WHERE productId = " + productId +
                    " AND Status = 'Active'";

                string stockResult = db.executeScalar(stockQry);

                if (stockResult == null ||
                    stockResult == "" ||
                    stockResult == "0")
                {
                    lblMessage.Text = "This product is unavailable or out of stock.";
                    return;
                }

                int stock = Convert.ToInt32(stockResult);

                // Check whether the product is already in the customer's cart.
                string cartQry =
                    "SELECT Quantity FROM Cart " +
                    "WHERE userId = " + userId +
                    " AND productId = " + productId;

                DataTable cartDt = db.executeDataTable(cartQry);

                if (cartDt.Rows.Count > 0)
                {
                    int currentQty = Convert.ToInt32(cartDt.Rows[0]["Quantity"]);

                    if (currentQty >= stock)
                    {
                        lblMessage.Text = "You already have the maximum available quantity in your cart.";
                        return;
                    }

                    int newQty = currentQty + 1;

                    string updateQry =
                        "UPDATE Cart SET Quantity = " + newQty +
                        ", cartTotalAmount = " + newQty +
                        " * (SELECT Price FROM Products WHERE productId = " +
                        productId + ") " +
                        "WHERE userId = " + userId +
                        " AND productId = " + productId;

                    db.executeNonQuery(updateQry);
                }
                else
                {
                    string insertQry =
                        "INSERT INTO Cart (userId, productId, Quantity, cartTotalAmount) " +
                        "SELECT " + userId + ", productId, 1, Price " +
                        "FROM Products " +
                        "WHERE productId = " + productId +
                        " AND Status = 'Active'";

                    db.executeNonQuery(insertQry);
                }

                Response.Redirect("Cart.aspx");
            }


        }

    }
}