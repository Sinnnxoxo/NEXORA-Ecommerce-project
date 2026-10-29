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
    public partial class ProductDetails : System.Web.UI.Page
    {
        ConnectionCls db = new ConnectionCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProduct();
            }
        }

        private void LoadProduct()
        {
            int productId;

            productId = Convert.ToInt32(Request.QueryString["id"]);

            //if (!int.TryParse(Request.QueryString["id"], out productId))
            //{
            //    ShowInvalidProduct();
            //    return; 
            //}

            string qry = "SELECT productId, productName, Description, Price, Category, Brand, RemainingQty, productImage FROM Products WHERE productId = " + productId + " AND Status = 'Active'";

            DataTable dt = db.executeDataTable(qry);

            if (dt.Rows.Count == 0)
            {
                ShowInvalidProduct();
                return;
            }

            DataRow row = dt.Rows[0];

            lblProductName.Text = Convert.ToString(row["productName"]);
            lblCategory.Text = Convert.ToString(row["Category"]);
            lblBrand.Text = Convert.ToString(row["Brand"]);
            lblDescription.Text = Convert.ToString(row["Description"]);
            lblPrice.Text = Convert.ToDecimal(row["Price"]).ToString("N2");
            lblStock.Text = Convert.ToString(row["RemainingQty"]);
            imgProduct.ImageUrl = ResolveUrl("~/Images/Products/" + Convert.ToString(row["productImage"]));
            imgProduct.AlternateText = Convert.ToString(row["productName"]);

            btnAddToCart.Enabled = Convert.ToInt32(row["RemainingQty"]) > 0;

            if (!btnAddToCart.Enabled)
            {
                lblMessage.Text = "This product is currently out of stock.";
            }
        }

        private void ShowInvalidProduct()
        {
            lblProductName.Text = "Product not found";
            lblMessage.Text = "This product may be unavailable or the link is invalid.";
            btnAddToCart.Enabled = false;
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // 1. Check whether the customer is logged in
            if (Session["RegId"] == null || Session["UserType"] == null ||
            Session["UserType"].ToString() != "user")
            {
                Response.Redirect("Login.aspx");
                return;
            }


            // 2. Get the product ID
            int productId;

            productId = Convert.ToInt32(Request.QueryString["id"]);

            // 3. Validate the quantity
            int quantity;

            quantity = Convert.ToInt32(txtQuantity.Text);

            if (quantity < 1)
            {
                lblMessage.Text = "Please enter a valid quantity.";
                return;
            }

            // 4. Get the customer ID
            int userId = Convert.ToInt32(Session["RegId"]);

            // 5. Check whether the product is active and get its stock
            string stockQry = "SELECT RemainingQty FROM Products " +
                              "WHERE productId = " + productId +
                              " AND Status = 'Active'";

            string stockResult = db.executeScalar(stockQry);

            int stock;

            stock = Convert.ToInt32(stockResult);

            if (stock < 1)
            {
                lblMessage.Text = "This product is out of stock.";
                return;
            }

            // 6. Check whether the product is already in the customer's cart
            string cartQry = "SELECT Quantity FROM Cart WHERE userId = " + userId +
                             " AND productId = " + productId;

            DataTable cartDt = db.executeDataTable(cartQry);

            int existingQuantity = 0;

            if (cartDt.Rows.Count > 0)
            {
                existingQuantity = Convert.ToInt32(cartDt.Rows[0]["Quantity"]);
            }

            // 7. Check the total requested quantity against available stock
            if (existingQuantity + quantity > stock)
            {
                lblMessage.Text = "Only " + stock +
                                  " unit(s) are available. You already have " +
                                  existingQuantity + " in your cart.";
                return;
            }

            // 8. Calculate the total cart quantity and amount
            int totalQuantity = existingQuantity + quantity;

            string priceQry = "SELECT Price FROM Products WHERE productId = " +
                              productId + " AND Status = 'Active'";

            string priceResult = db.executeScalar(priceQry);

            decimal price;

            price = Convert.ToDecimal(priceResult);

            decimal totalAmount = price * totalQuantity;

            // 9. Update the existing cart record or insert a new one
            int result;

            if (cartDt.Rows.Count > 0)
            {
                string updateQry = "UPDATE Cart SET Quantity = " + totalQuantity +
                                   ", cartTotalAmount = " + totalAmount.ToString() +
                                   " WHERE userId = " + userId +
                                   " AND productId = " + productId;

                result = db.executeNonQuery(updateQry);
            }
            else
            {
                string insertQry = "INSERT INTO Cart " +
                                   "(userId, productId, Quantity, cartTotalAmount) VALUES (" +
                                   userId + ", " + productId + ", " + quantity + ", " +
                                   totalAmount.ToString() + ")";

                result = db.executeNonQuery(insertQry);
            }

            // 10. Display the result
            if (result > 0)
            {
                lblMessage.Text = "Product added to your cart successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMessage.Text = "Unable to add the product to your cart.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }


        }

        protected void btnAddToWishlist_Click(object sender, EventArgs e)
        {
            if (Session["RegId"] == null ||
            Session["UserType"] == null ||
            Session["UserType"].ToString() != "user")
            {
                Response.Redirect("Login.aspx");
                return;
            }


            int userId = Convert.ToInt32(Session["RegId"]);

            int productId;

            productId = Convert.ToInt32(Request.QueryString["id"]);

            string checkQry =
                "SELECT COUNT(*) FROM WishList " +
                "WHERE userId = " + userId +
                " AND productId = " + productId +
                " AND wishStatus = 'Active'";

            int count = Convert.ToInt32(db.executeScalar(checkQry));

            if (count > 0)
            {
                // The product is already in the wishlist.
                Response.Redirect("Wishlist.aspx");
                return;
            }

            string insertQry =
                "INSERT INTO WishList (userId, productId, wishStatus) " +
                "VALUES (" + userId + ", " + productId + ", 'Active')";

            db.executeNonQuery(insertQry);

            Response.Redirect("Wishlist.aspx");


        }


    }
}