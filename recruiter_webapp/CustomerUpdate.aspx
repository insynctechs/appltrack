<%@ Page Title="Customer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerUpdate.aspx.cs" Inherits="recruiter_webapp.CustomerUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<form runat="server">
    <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <% if (string.IsNullOrEmpty(Request.QueryString["id"]))
        { %>
    <h6>Add Customer</h6>
    <%}
    else if (Request.Url.ToString().Contains("Edit"))
    { %>
    <h6>Edit Customer - <%if (customerList.Count > 0)
    {%><%:customerList[0]["name"]%><%}%></h6>
    <%}
    else if((Request.Url.ToString().Contains("View")))
    {%>
    <h6>View Customer - <%if (customerList.Count > 0)
    {%><%:customerList[0]["name"]%><%}%></h6>
    <% } %>

    <br />
    <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
    <br />
    <a class="btn waves-effect waves-light blue lighten-1 " href="<%=WebURL %>CustomerStaffUpdate?customer_id=<%=Request.QueryString["id"] %>">Add Staff</a>
    <div class="row">
        <div id="customerForm">
            <div class="input-field col s12 m12 l6">
                <div class="row">
                    <input type="hidden" id="id" class="commenttextbox" runat="server" />
                    <div class="input-field col s12">
                        <input type="text" id="name" class="commenttextbox" runat="server" />
                        <label for="name">Name</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" id="address" class="commenttextbox" runat="server" />
                        <label for="address">Address</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="city" class="commenttextbox" runat="server" />
                        <label for="city">City</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="state" class="commenttextbox" runat="server" />
                        <label for="state">State</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="zip" class="commenttextbox" runat="server" />
                        <label for="zip">Zip</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="contact" class="commenttextbox" runat="server" />
                        <label for="contact">Primary Contact</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="email" class="commenttextbox" runat="server" />
                        <label for="email">Primary Email</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="phone" class="commenttextbox" runat="server" />
                        <label for="phone">Phone</label>
                    </div>
                    <input type="hidden" id="active" class="commenttextbox" runat="server" />
                    <div class="input-field col s6">
                        <input type="text" id="license" class="commenttextbox" runat="server" />
                        <label for="license">License</label>
                    </div>
                    <input type="hidden" id="license_expiry" class="commenttextbox" runat="server" />
                    <input type="hidden" id="license_year" class="commenttextbox" runat="server" />
                    <input type="hidden" id="added_date" class="commenttextbox" runat="server" />
                    <input type="hidden" id="updated_date" class="commenttextbox" runat="server" />
                </div>


                <div class="row">
                    <div class="col s3">
                        <a class="btn waves-effect waves-light blue lighten-1" id="btn-clear" onclick="doClearForm()">Clear<i class="material-icons right">clear</i>
                        </a>
                    </div>

                    <div class="col s3 right">
                        <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="" Style="display: none" />
                        <a class="btn waves-effect waves-light blue lighten-1" id="btn-search" onclick="doSubmit()">Submit<i class="material-icons right">send</i>
                        </a>
                    </div>
                </div>


            </div>

        </div>
    </div>

</form>
    

    <script>

        // Scripts for html anchors to asp button mapping
        function doSubmit() {
            document.getElementById('<%= btnSubmit.ClientID %>').click();
        }
    </script>


</asp:Content>
