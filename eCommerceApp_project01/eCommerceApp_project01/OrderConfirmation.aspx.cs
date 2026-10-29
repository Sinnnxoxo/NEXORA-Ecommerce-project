using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerceApp_project01
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["RegId"] == null ||
            Session["OrderPlaced"] == null ||
            Session["OrderPlaced"].ToString() != "true")
            {
                Response.Redirect("Default.aspx");
                return;
            }


            Session.Remove("OrderPlaced");
        }
    }
    
}