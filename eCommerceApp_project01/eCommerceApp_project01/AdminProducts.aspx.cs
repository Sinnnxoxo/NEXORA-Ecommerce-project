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
    public partial class AdminProducts : System.Web.UI.Page
    {

        ConnectionCls db = new ConnectionCls();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["RegId"] == null ||
            Session["UserType"] == null ||
            Session["UserType"].ToString() != "admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            string qry = "SELECT productId, productName, Category, Brand, " +
                         "Price, RemainingQty, Status FROM Products " +
                         "ORDER BY productId DESC";

            DataTable dt = db.executeDataTable(qry);

            gvProducts.DataSource = dt;
            gvProducts.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string productName = txtProductName.Text.Trim().Replace("'", "''");
            string category = txtCategory.Text.Trim().Replace("'", "''");
            string brand = txtBrand.Text.Trim().Replace("'", "''");
            string description = txtDescription.Text.Trim().Replace("'", "''");

            decimal price;
            int stock;

            if (productName == "" || category == "" || brand == "")
            {
                lblMessage.Text = "Please enter the product name, category, and brand.";
                return;
            }

            price = Convert.ToDecimal(txtPrice.Text);

            if (price < 0)
            {
                lblMessage.Text = "Please enter a valid price.";
                return;
            }

            stock = Convert.ToInt32(txtStock.Text);

            if (stock < 0)
            {
                lblMessage.Text = "Please enter a valid stock quantity.";
                return;
            }

            if (!fuProductImage.HasFile && hfProductId.Value == "")
            {
                lblMessage.Text = "Please select a product image.";
                return;
            }

            string imageName = fuProductImage.FileName;

            if (fuProductImage.HasFile)
            {
                string path = "~/Images/Products/" + imageName;
                fuProductImage.SaveAs(MapPath(path));

            }

            string priceValue = price.ToString();

            if (hfProductId.Value == "")
            {
                string qry =
                    "INSERT INTO Products " +
                    "(productName, Description, Price, Category, Brand, " +
                    "RemainingQty, Status, productImage) VALUES ('" +
                    productName + "', '" + description + "', " +
                    priceValue + ", '" + category + "', '" + brand + "', " +
                    stock + ", '" + ddlStatus.SelectedValue + "', '" +
                    imageName + "')";

                db.executeNonQuery(qry);

                lblMessage.Text = "Product added successfully.";
            }
            else
            {
                int productId = Convert.ToInt32(hfProductId.Value);

                string qry =
                    "UPDATE Products SET " +
                    "productName = '" + productName + "', " +
                    "Description = '" + description + "', " +
                    "Price = " + priceValue + ", " +
                    "Category = '" + category + "', " +
                    "Brand = '" + brand + "', " +
                    "RemainingQty = " + stock + ", " +
                    "Status = '" + ddlStatus.SelectedValue + "'";

                if (imageName != "")
                {
                    qry += ", productImage = '" + imageName + "'";
                }

                qry += " WHERE productId = " + productId;

                db.executeNonQuery(qry);

                lblMessage.Text = "Product updated successfully.";
            }

            ClearForm();
            LoadProducts();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminProducts.aspx");
        }

        protected void gvProducts_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditProduct")
            {
                string qry = "SELECT * FROM Products WHERE productId = " + productId;

                DataTable dt = db.executeDataTable(qry);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    hfProductId.Value = row["productId"].ToString();
                    txtProductName.Text = row["productName"].ToString();
                    txtDescription.Text = row["Description"].ToString();
                    txtPrice.Text = row["Price"].ToString();
                    txtCategory.Text = row["Category"].ToString();
                    txtBrand.Text = row["Brand"].ToString();
                    txtStock.Text = row["RemainingQty"].ToString();

                    string status = row["Status"].ToString();

                    if (ddlStatus.Items.FindByValue(status) != null)
                    {
                        ddlStatus.SelectedValue = status;
                    }

                    lblMessage.Text = "Edit the product details and click Save Product.";
                }
            }
            else if (e.CommandName == "DeleteProduct")
            {
                string qry =
                    "UPDATE Products SET Status = 'Inactive' " +
                    "WHERE productId = " + productId;

                int result = db.executeNonQuery(qry);

                if (result > 0)
                {
                    lblMessage.Text = "Product deactivated successfully.";
                }
                else
                {
                    lblMessage.Text = "Unable to deactivate the product.";
                }

                ClearForm();
                LoadProducts();
            }


        }

        private void ClearForm()
        {
            hfProductId.Value = "";
            txtProductName.Text = "";
            txtCategory.Text = "";
            txtBrand.Text = "";
            txtPrice.Text = "";
            txtStock.Text = "";
            txtDescription.Text = "";
            ddlStatus.SelectedValue = "Active";
        }

    }


}
