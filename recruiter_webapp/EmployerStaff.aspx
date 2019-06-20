<%@ Page Title="Employer Staffs" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="EmployerStaff.aspx.cs" Inherits="recruiter_webapp.EmployerStaff" %>
<%@ Register Namespace="ASPnetControls" Assembly="ASPnetPagerV2_8" TagPrefix="cc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
        <div id="employerStaffsAddForm">
            <%if (Request.QueryString["employer_id"] != null)
                { %>
            <a href="<%= WebURL %>EmployerStaffAdd?employer_id=<%=Request.QueryString["employer_id"] %>" class="btn waves-effect waves-light blue lighten-1" id="btn-insert">Add Staff<i class="material-icons right">add</i>
            </a>
            <div style="display: inline; padding: 0px 10px"></div>
            <br />
            <%} %>
            <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        </div>
        <div>
        </div>
        <br />
        <br />
        <div class="row">
            
        </div>
        <div class="row">
            
            <div id="employerStaffsForm">
                <div class="input-field col s6 m6 l3">
                <select id="combo_employers" onchange="setEmployerId();">
                    <option disabled <%=(Request.QueryString["employer_id"]==null) ? "selected" : "" %>>Choose Employer</option>
                    <% foreach (var employer in listEmployers)
                        {
                    %>
                    <option value="<%:employer["id"]%>" <%= Request.QueryString["employer_id"] == employer["id"].ToString() ? "selected" : "" %>><%: employer["name"] %></option>
                    <%
                        }

                    %>
                </select>
            </div>
                <input id="employer_id" type="hidden" runat="server" />
                <div class="input-field col s8 m8 l4">
                    <input id="srchVal" name="srchVal" type="text" runat="server">
                    <label id="lbl_srchVal" for="srchVal">Search Value</label>
                </div>
                <div class="input-field col s4 m4 l2">
                    <select id="srchBy" name="srchBy" runat="server">
                        <option value="name" selected>Name</option>
                        <option value="email">Email</option>
                    </select>
                </div>
                <div class="input-field col s4 m4 l2">
                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="" Style="display: none" />
                <a class="btn waves-effect waves-light blue lighten-1" id="btn-search" onclick="doSearch()">Search<i class="material-icons right">search</i>
                </a>
                    </div>
                
            </div>
        </div>


        <div class="row">
            <div class="col s12 m12 l12">
                <%if (employerList.Items.Count > 0)
                    { %>
                <asp:Repeater ID="employerList" runat="server">
                    <HeaderTemplate>
                        <table class="table center">
                            <tr class="blue-grey lighten-4 bold">
                                <th class="center">#</th>
                                <th class="center">Name</th>
                                <th class="center">Email</th>
                                <th class="center">Location</th>
                                <th class="center">User Type</th>
                                <th class="center">Active</th>
                                <th class="center">Actions</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="center"><%#Eval("RowNumber")%></td>
                            <td class="center"><%#Eval("employer_staff_name")%></td>
                            <td class="center"><%#Eval("employer_staff_email")%></td>                           
                            <td class="center"><%#Eval("employer_staff_location")%></td>
                            <td class="center"><%#Eval("employer_staff_user_type")%></td>
                            <td class="center">
                                <div class="switch">
                                    <label>
                                        <input type="checkbox" <%# Eval("employer_staff_active").ToString()=="1"?"Checked":"Unchecked" %> />
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                            <td class="center">
                                <a href="<%= WebURL %>EmployerStaffAdd?id=<%#Eval("employer_staff_id")%>">Edit</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="blue-grey lighten-4 bold">
                    <cc:PagerV2_8 ID="pager1" runat="server"
                        OnCommand="pager_Command"
                        GenerateGoToSection="true" NormalModePageCount="3" PageSize="3" />
                </div>
                <%}
                else
    {
        if (Request.QueryString["employer_id"] == null)
        {%>
                <p class="center">Choose an Employer!</p>
                <%  }
    else
    { %>
                <p class="center">No Records Found!</p>
                <% }
    }%>
            </div>

        </div>

    </form>
    <script>
        // Scripts for html anchors to asp button mapping

        function doSearch() {
            document.getElementById('<%= btnSearch.ClientID %>').click();
        }

        function setEmployerId() {
                $('#<%= employer_id.ClientID %>').val($('#combo_employers').val());
            }

        $(document).ready(function () {
            $('select').formSelect();
        });
       
    </script>
</asp:Content>
