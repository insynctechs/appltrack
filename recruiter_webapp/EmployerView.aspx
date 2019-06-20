<%@ Page Title="Employer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerView.aspx.cs" Inherits="recruiter_webapp.EmployerView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
     <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <% if (string.IsNullOrEmpty(Request.QueryString["id"]))
        { %>
    <h6>View Employer - <%if (employerList.Count > 0)
                            {%><%:employerList[0]["name"]%><%}%></h6>
    <%}
        else
        { %>
    <h6>Edit Employer - <%if (employerList.Count > 0)
                            {%><%:employerList[0]["name"]%><%}%></h6>
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
                        <input type="text" id="name" class="commenttextbox" value="<%:employerList[0]["name"]%>" readonly />
                        <label for="name">Name</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" id="address" class="commenttextbox" value="<%:employerList[0]["address"]%>" readonly />
                        <label for="address">Address</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="city" class="commenttextbox" value="<%:employerList[0]["city"]%>" readonly />
                        <label for="city">City</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="state" class="commenttextbox" value="<%:employerList[0]["state"]%>" readonly />
                        <label for="state">State</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="zip" class="commenttextbox" value="<%:employerList[0]["zip"]%>" readonly />
                        <label for="zip">Zip</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="phone" class="commenttextbox" value="<%:employerList[0]["phone"]%>" readonly/>
                        <label for="contact">Primary Contact</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="email" class="commenttextbox" value="<%:employerList[0]["email"]%>" readonly/>
                        <label for="email">Primary Email</label>
                    </div>
                    <div class="input-field col s6">
                        <div class="switch">
                                    <label>
                                        Active
                                        <input id="active" type="checkbox" <%= employerList[0]["active"].ToString()=="1"?"Checked":"Unchecked" %> />
                                        <span class="lever"></span>
                                    </label>
                                </div>
                    </div>
                                     
                </div>
                <br />
                    <div class="row">
                        <input type="button" id="btn_employer_edit" value="Edit"/>
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
        </form>

    <script>
    // Scripts for html anchors to asp button mapping
        $(document).ready(function () {
            $('#btn_employer_edit').click(function () {
                if ($('#btn_employer_edit').val() == 'Edit') {
                    $('#btn_employer_edit').val('Update');
                    $('.commenttextbox').removeAttr('readonly');
                }
            })
        });
    function doAdd() {
        document.getElementById('<%= btnAdd.ClientID %>').click();
    }

    function doView() {
        document.getElementById('<%= btnView.ClientID %>').click();
    }
    </script>
</asp:Content>
