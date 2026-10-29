<%@ Page Title="Order Confirmation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="eCommerceApp_project01.OrderConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"> <div class="container my-5 text-center"> <h2 class="text-success">Order Placed Successfully!</h2>

    <p class="mt-3">
        Thank you for shopping with NEXORA.
    </p>

    <p>
        Your order has been placed using Cash on Delivery.
        Payment is pending until delivery.
    </p>

    <asp:HyperLink
        ID="lnkContinueShopping"
        runat="server"
        NavigateUrl="~/Default.aspx"
        CssClass="btn btn-primary mt-3"
        Text="Continue Shopping" />
</div>


</asp:Content>
