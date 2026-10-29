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
    public partial class Default : System.Web.UI.Page
    {
        ConnectionCls db = new ConnectionCls();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
                LoadProducts();
            }
        }

        private void LoadProducts()
        { 
            string qry = "SELECT TOP 8 productId, productName, Description, Price, Category, Brand, RemainingQty, productImage FROM Products WHERE Status = 'Active' AND RemainingQty > 0 ORDER BY productId DESC";
            DataTable dt = db.executeDataTable(qry);
            rptProducts.DataSource = dt;
            rptProducts.DataBind(); 
        }


    }
}