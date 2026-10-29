using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerceApp_project01
{
    public partial class Register : System.Web.UI.Page
    {
        ConnectionCls cls = new ConnectionCls();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // 1. Check whether the passwords match
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.Text = "Passwords do not match!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }


            // 2. Check whether the username already exists
            string checkQry = "SELECT COUNT(*) FROM LoginTab WHERE Username = '" +
                              txtUsername.Text.Trim() + "'";

            string usernameCount = cls.executeScalar(checkQry);

            if (Convert.ToInt32(usernameCount) > 0)
            {
                lblMessage.Text = "Username already exists. Please choose another.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // 3. Generate the next registration ID
            string maxregid = "";
            int regId = 0;

            string maxQry = "SELECT MAX(RegId) FROM LoginTab";
            maxregid = cls.executeScalar(maxQry);

            if (maxregid != "")
            {
                regId = Convert.ToInt32(maxregid) + 1;
            }
            else
            {
                regId = 1;
            }

            // 4. Insert login details
            string logQry = "INSERT INTO LoginTab (RegId, Username, Password, UserType, Status) VALUES (" +
                            regId + ", '" + txtUsername.Text.Trim() + "', '" +
                            txtPassword.Text + "', 'user', 'Active')";

            int i = cls.executeNonQuery(logQry);

            if (i == 1)
            {
                // 5. Insert user details
                string userQry = "INSERT INTO Users (userId, user_Name, userEmail, userPhone, userAddress, userPincode) VALUES (" +
                                 regId + ", '" + txtName.Text.Trim() + "', '" +
                                 txtEmail.Text.Trim() + "', " + txtPhone.Text.Trim() + ", '" +
                                 txtAddress.Text.Trim() + "', " + txtPincode.Text.Trim() + ")";

                int j = cls.executeNonQuery(userQry);

                if (j == 1)
                {
                    lblMessage.Text = "Registration successful! Please log in.";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    txtName.Text = "";
                    txtEmail.Text = "";
                    txtPhone.Text = "";
                    txtAddress.Text = "";
                    txtPincode.Text = "";
                    txtUsername.Text = "";
                    txtPassword.Text = "";
                    txtConfirmPassword.Text = "";
                }
                else
                {
                    lblMessage.Text = "User registration failed.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblMessage.Text = "Registration failed.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }


        }


    }
}