<%@ Page Language="C#" Title="Customer" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerView.aspx.cs" Inherits="recruiter_webapp.CustomerView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <% if (string.IsNullOrEmpty(Request.QueryString["id"]))
        { %>
    <h6>View Customer</h6>
    <%}
        else
        { %>
    <h6>View Customer - <%if (customerList.Count > 0)
                            {%><%:customerList[0]["name"]%><%}%></h6>
    <%}%>

    <br />
    <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
    <br />
    <div class="row">
        <div id="entityDetails">
            <div class="input-field col s12 m12 l6">
                <div class="row">
                    <input type="hidden" id="id" class="commenttextbox" runat="server" />
                    <div class="input-field col s12">
                        <input type="text" id="name" class="commenttextbox" value="<%:customerList[0]["name"]%>" readonly />
                        <label for="name">Name</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" id="address" class="commenttextbox" value="<%:customerList[0]["address"]%>" readonly />
                        <label for="address">Address</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="city" class="commenttextbox" value="<%:customerList[0]["city"]%>" readonly />
                        <label for="city">City</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="state" class="commenttextbox" value="<%:customerList[0]["state"]%>" readonly />
                        <label for="state">State</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="zip" class="commenttextbox" value="<%:customerList[0]["zip"]%>" readonly />
                        <label for="zip">Zip</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="contact" class="commenttextbox" value="<%:customerList[0]["contact"]%>" readonly/>
                        <label for="contact">Primary Contact</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="email" class="commenttextbox" value="<%:customerList[0]["name"]%>" readonly/>
                        <label for="email">Primary Email</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="phone" class="commenttextbox" value="<%:customerList[0]["phone"]%>" readonly/>
                        <label for="phone">Phone</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="active" class="commenttextbox" value="<%:customerList[0]["active"]%>" readonly/>
                        <label for="active">Active</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="license" class="commenttextbox" <%:customerList[0]["license"]%> readonly/>
                        <label for="license">License</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="license_expiry" class="commenttextbox" value="<%:customerList[0]["license_expiry"]%>" readonly/>
                        <label for="license_expiry">License Expiry</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="license_year" class="commenttextbox" value="<%:customerList[0]["license_year"]%>" readonly/>
                        <label for="license_year">License Year</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="added_date" class="commenttextbox" value="<%:customerList[0]["added_date"]%>" readonly/>
                        <label for="added_date">Added Date</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="updated_date" class="commenttextbox" value="<%:customerList[0]["updated_date"]%>" readonly/>
                        <label for="updated_date">Updated Date</label>
                    </div>
                </div>
            </div>
            <div class="input-field col s12 m12 l6">
                <asp:Button ID="btnAdd" onclick="btnAdd_Click" runat="server" Text="" Style="display: none"/>
                <a class="btn waves-effect waves-light blue lighten-1" id="btn-add" onclick="doAdd()">
                Add Staff<i class="material-icons right">add</i>
                </a>
                <br />
                <br />
                <asp:Button ID="btnView" onclick="btnView_Click" runat="server" Text="" Style="display: none"/>
                <a class="btn waves-effect waves-light blue lighten-1" id="btn-view" onclick="doView()">
                View Staffs<i class="material-icons right">view_list</i>
                </a>
            </div>
        </div>
    </div>

    <script>
    // Scripts for html anchors to asp button mapping
    function doAdd() {
        document.getElementById('<%= btnAdd.ClientID %>').click();
    }

    function doView() {
        document.getElementById('<%= btnView.ClientID %>').click();
    }
    </script>
</asp:Content>

