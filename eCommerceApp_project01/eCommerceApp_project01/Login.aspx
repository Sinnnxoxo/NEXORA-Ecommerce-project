<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="eCommerceApp_project01.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<section class="auth-section">
    <div class="auth-container auth-login-container">

        <div class="auth-header">
            <span class="auth-badge">WELCOME BACK</span>
            <h1>Sign in to NEXORA</h1>
            <p>Enter your account details to continue shopping.</p>
        </div>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="auth-message" EnableViewState="false" />

        <div class="auth-form">

            <div class="form-group">
                <label for="<%= txtUsername.ClientID %>">Username</label>

                <asp:TextBox ID="txtUsername" runat="server"
                    CssClass="form-control"
                    placeholder="Enter your username"
                    MaxLength="50" />

                <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                    ControlToValidate="txtUsername"
                    ErrorMessage="Username is required."
                    CssClass="validation-error"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="<%= txtPassword.ClientID %>">Password</label>

                <asp:TextBox ID="txtPassword" runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    placeholder="Enter your password"
                    MaxLength="50" />

                <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="Password is required."
                    CssClass="validation-error"
                    Display="Dynamic" />
            </div>

            <asp:Button ID="btnLogin" runat="server"
                Text="Sign In"
                CssClass="auth-button"
                OnClick="btnLogin_Click" />

            <div class="auth-footer">
                Don't have an account?
                <a href="Register.aspx">Create an account</a>
            </div>

        </div>
    </div>
</section>


</asp:Content>

