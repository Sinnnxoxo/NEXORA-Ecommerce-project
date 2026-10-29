<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="eCommerceApp_project01.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

```
<section class="auth-section">
    <div class="auth-container">

        <div class="auth-header">
            <span class="auth-badge">JOIN NEXORA</span>
            <h1>Create your account</h1>
            <p>Sign up to explore products and enjoy a better shopping experience.</p>
        </div>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="auth-message" EnableViewState="false" />

        <div class="auth-form">

            <div class="form-group">
                <label for="<%= txtName.ClientID %>">Full Name</label>
                <asp:TextBox ID="txtName" runat="server"
                    CssClass="form-control"
                    placeholder="Enter your full name"
                    MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvName" runat="server"
                    ControlToValidate="txtName"
                    ErrorMessage="Full name is required."
                    CssClass="validation-error"
                    Display="Dynamic" />
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="<%= txtEmail.ClientID %>">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server"
                        CssClass="form-control"
                        TextMode="Email"
                        placeholder="you@example.com"
                        MaxLength="100" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Email is required."
                        CssClass="validation-error"
                        Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label for="<%= txtPhone.ClientID %>">Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server"
                        CssClass="form-control"
                        TextMode="Phone"
                        placeholder="Enter phone number"
                        MaxLength="15" />
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                        ControlToValidate="txtPhone"
                        ErrorMessage="Phone number is required."
                        CssClass="validation-error"
                        Display="Dynamic" />
                </div>
            </div>

            <div class="form-group">
                <label for="<%= txtAddress.ClientID %>">Address</label>
                <asp:TextBox ID="txtAddress" runat="server"
                    CssClass="form-control"
                    placeholder="Enter your address"
                    TextMode="MultiLine"
                    Rows="3"
                    MaxLength="250" />
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                    ControlToValidate="txtAddress"
                    ErrorMessage="Address is required."
                    CssClass="validation-error"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="<%= txtPincode.ClientID %>">PIN Code</label>
                <asp:TextBox ID="txtPincode" runat="server"
                    CssClass="form-control"
                    placeholder="Enter your PIN code"
                    MaxLength="6" />
                <asp:RequiredFieldValidator ID="rfvPincode" runat="server"
                    ControlToValidate="txtPincode"
                    ErrorMessage="PIN code is required."
                    CssClass="validation-error"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="<%= txtUsername.ClientID %>">Username</label>
                <asp:TextBox ID="txtUsername" runat="server"
                    CssClass="form-control"
                    placeholder="Choose a username"
                    MaxLength="50" />
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                    ControlToValidate="txtUsername"
                    ErrorMessage="Username is required."
                    CssClass="validation-error"
                    Display="Dynamic" />
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="<%= txtPassword.ClientID %>">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server"
                        CssClass="form-control"
                        TextMode="Password"
                        placeholder="Create a password"
                        MaxLength="100" />
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required."
                        CssClass="validation-error"
                        Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label for="<%= txtConfirmPassword.ClientID %>">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server"
                        CssClass="form-control"
                        TextMode="Password"
                        placeholder="Repeat your password"
                        MaxLength="100" />
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Please confirm your password."
                        CssClass="validation-error"
                        Display="Dynamic" />
                    <asp:CompareValidator ID="cvPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ControlToCompare="txtPassword"
                        ErrorMessage="Passwords do not match."
                        CssClass="validation-error"
                        Display="Dynamic" />
                </div>
            </div>

            <asp:Button ID="btnRegister" runat="server"
                Text="Create Account"
                CssClass="auth-button"
                OnClick="btnRegister_Click" />

            <div class="auth-footer">
                Already have an account?
                <a href="Login.aspx">Sign in</a>
            </div>

        </div>
    </div>
</section>


</asp:Content>
