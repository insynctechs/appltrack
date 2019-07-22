<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="recruiter_webapp.User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <br />
    <br />
    <div class="row">
    <div class="col s6 m6 l6">
        
            <input type="hidden" id="id" runat="server" />
            <input type="hidden" id="user_id" runat="server" />
            <div class="input-field col s12">
                <input type="text" id="name" name="name" value="<%:userList[0]["name"]%>" readonly />
                <label for="name">Name</label>
            </div>
            <%if (Session["user_type"].ToString() != "1" && Session["user_type"].ToString() != "6")
                { %>
            <div class="input-field col s6">
                <input type="text" id="designation" name="designation" value="<%:userList[0]["designation"]%>" />
                <label for="designation">Designation</label>
            </div>
            <%} %>
            <div class="input-field col s6">
                <input type="text" id="gender" name="gender" value="<%:userList[0]["gender"]%>" />
                <label for="gender">Gender</label>
            </div>

            <%if (Session["user_type"].ToString() == "4" || Session["user_type"].ToString()=="5")
                {%>
            <div class="input-field col s12">
                <input type="text" id="employer_name" name="employer_name" value="<%:userList[0]["employer_name"]%>" />
                <label for="employer_name">Employer Name</label>
            </div>
            <%} %>

            <%if (Session["user_type"].ToString() == "2" || Session["user_type"].ToString()=="3")
                {%>
            <div class="input-field col s12">
                <input type="text" id="customer_name" name="customer_name" value="<%:userList[0]["customer_name"]%>" />
                <label for="ecustomer_name">Customer Name</label>
            </div>
            <%} %>

            <div class="input-field col s6">
                <input type="text" id="user_type_name" name="user_type_name" value="<%:userList[0]["user_type_name"]%>" />
                <label for="user_type_name">User Type</label>
            </div>
            <div class="input-field col s12">
                <input type="text" id="address" name="address" value="<%:userList[0]["address"]%>" />
                <label for="address">Address</label>
            </div>
            <div class="input-field col s12">
                <input type="text" id="email" name="email" value="<%:userList[0]["email"]%>" />
                <label for="email">Email</label>
            </div>
            <div class="input-field col s6">
                <input type="text" id="phone" name="phone" value="<%:userList[0]["phone"]%>" />
                <label for="phone">Phone</label>
            </div>
            <%if (Session["user_type"].ToString() == "6")
                {%>
            <div class="input-field col s12">
                <input type="text" id="qualifications" name="qualifications" value="<%:userList[0]["qualifications"]%>" />
                <label for="qualifications">Qualifications</label>
            </div>
            <div class="input-field col s12">
                <input type="text" id="skills" name="skills" value="<%:userList[0]["skills"]%>" />
                <label for="skills">Skills</label>
            </div>
            <%} %>
            <div class="input-field col s6">
                <input type="text" id="last_logged_in" name="last_logged_in" value="<%:userList[0]["user_last_logged_in"]%>" />
                <label for="last_logged_in">Last Logged In</label>
            </div>
            

        </div>
    </div>
</asp:Content>
