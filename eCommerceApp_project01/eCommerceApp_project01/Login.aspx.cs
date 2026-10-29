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
    public partial class Login : System.Web.UI.Page
    {
        ConnectionCls cls = new ConnectionCls();

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (!Page.IsValid) 
            { 
                return; 
            }

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text; 

            string qry = "SELECT RegId, Username, UserType, Status FROM LoginTab " + "WHERE Username = '" + username + "' AND Password = '" + password + "'";
            
            DataTable dt = cls.executeDataTable(qry);

            if (dt.Rows.Count > 0) 
            {
                string status = dt.Rows[0]["Status"].ToString();
                string userType = dt.Rows[0]["UserType"].ToString();
                string regId = dt.Rows[0]["RegId"].ToString();

                if (status == "Active") 
                {
                    Session["RegId"] = regId;
                    Session["Username"] = username; 
                    Session["UserType"] = userType;
                    
                    if (userType == "admin") 
                    {
                        Response.Redirect("AdminDashboard.aspx");
                    }
                    else if (userType == "user")
                    {
                        Response.Redirect("Default.aspx"); 
                    }
                    else 
                    {
                        Session.Clear();
                        lblMessage.Text = "Invalid account type."; 
                    }
                }
                else 
                {
                    lblMessage.Text = "Your account is inactive. Please contact the administrator."; 
                }
            }
            else
            {
                lblMessage.Text = "Invalid username or password.";
            }
        }
    }
}
