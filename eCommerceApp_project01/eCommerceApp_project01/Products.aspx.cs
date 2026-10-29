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
    public partial class Products : System.Web.UI.Page
    {
        ConnectionCls db = new ConnectionCls();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadBrands();

                if (Request.QueryString["category"] != null)
                {
                    string category = Request.QueryString["category"];
                    ListItem item = ddlCategory.Items.FindByValue(category);
                    if (item != null)
                    {
                        ddlCategory.SelectedValue = category;
                    }
                }

                LoadProducts();

            }
        }

        private void LoadCategories()
        {
            string qry = "SELECT DISTINCT Category FROM Products " + "WHERE Status = 'Active' ORDER BY Category";
            DataTable dt = db.executeDataTable(qry);

            ddlCategory.DataSource = dt;

            ddlCategory.DataTextField = "Category";
            ddlCategory.DataValueField = "Category";

            ddlCategory.DataBind();

        }

        private void LoadBrands()
        {
            string qry = "SELECT DISTINCT Brand FROM Products " + "WHERE Status = 'Active' ORDER BY Brand";
            DataTable dt = db.executeDataTable(qry);

            ddlBrand.DataSource = dt;

            ddlBrand.DataTextField = "Brand";
            ddlBrand.DataValueField = "Brand";

            ddlBrand.DataBind();
        }

        private void LoadProducts()
        {
            string qry = "SELECT productId, productName, Description, Price, " + "Category, Brand, RemainingQty, productImage " + "FROM Products WHERE Status = 'Active'";

            if (txtSearch.Text.Trim() != "")
            {
                string search = txtSearch.Text.Trim().Replace("'", "''");
                qry += " AND productName LIKE '%" + search + "%'";
            }

            if (ddlCategory.SelectedValue != "")
            {
                string category = ddlCategory.SelectedValue.Replace("'", "''");
                qry += " AND Category = '" + category + "'";
            }

            if (ddlBrand.SelectedValue != "")
            {
                string brand = ddlBrand.SelectedValue.Replace("'", "''");
                qry += " AND Brand = '" + brand + "'";
            }

            qry += " ORDER BY productId DESC";

            DataTable dt = db.executeDataTable(qry);

            rptProducts.DataSource = dt;
            rptProducts.DataBind();

            pnlNoProducts.Visible = dt.Rows.Count == 0;

            lblMessage.Text = dt.Rows.Count + " product(s) found.";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadProducts();
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";

            ddlCategory.SelectedIndex = 0;
            ddlBrand.SelectedIndex = 0;

            LoadProducts();
        }

        protected void rptProducts_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "AddToWishlist")
            {
                return;
            }


            if (Session["RegId"] == null ||
                Session["UserType"] == null ||
                Session["UserType"].ToString() != "user")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["RegId"]);
            int productId = Convert.ToInt32(e.CommandArgument);

            string checkQry =
                "SELECT COUNT(*) FROM WishList " +
                "WHERE userId = " + userId +
                " AND productId = " + productId +
                " AND wishStatus = 'Active'";

            int count = Convert.ToInt32(db.executeScalar(checkQry));

            if (count == 0)
            {
                string insertQry =
                    "INSERT INTO WishList (userId, productId, wishStatus) " +
                    "VALUES (" + userId + ", " + productId + ", 'Active')";

                db.executeNonQuery(insertQry);
            }

            Response.Redirect("Wishlist.aspx");


        }

    }
}