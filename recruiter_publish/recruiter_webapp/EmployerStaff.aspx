<%@ Page Title="Employer Staffs" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="EmployerStaff.aspx.cs" Inherits="recruiter_webapp.EmployerStaff" %>
<%@ Register Namespace="ASPnetControls" Assembly="ASPnetPagerV2_8" TagPrefix="cc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_employer_staffs" runat="server">
        <div class="card z-depth-1 border-radius-5">
            <div class="row">
                <div class="col s12">
        <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
                    </div>
            </div>
        </div>
        <div id="employerStaffsAddForm">
            <%if (Request.QueryString["employer_id"] != null)
                { %>
            <a href="<%= WebURL %>EmployerStaffUpdate?employer_id=<%=Request.QueryString["employer_id"] %>" class="btn waves-effect waves-light blue lighten-1" id="btn-insert">Add Staff<i class="material-icons right">add</i>
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
                <select id="cmb_employers" name="cmb_employers">
                    <option value="0" <%=(Request.QueryString["employer_id"]==null) ? "selected" : "" %>>All</option>
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
                <a class="btn waves-effect waves-light blue lighten-1" id="btn-search">Search<i class="material-icons right">search</i>
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
                            <tr class="card blue-grey z-depth-1 lighten-4 bold">
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
                            <td class="center"><%#Eval("name")%></td>
                            <td class="center"><%#Eval("email")%></td>                           
                            <td class="center"><%#Eval("employer_location_address")%></td>
                            <td class="center"><%#Eval("user_type")%></td>
                            <td class="center">
                                <div class="switch">
                                    <label>
                                        <input type="checkbox" <%# Eval("active").ToString()=="1"?"Checked":"Unchecked" %> />
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                            <td class="center">
                                <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%= WebURL %>EmployerStaffUpdate?id=<%#Eval("id")%>">Edit</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="card blue-grey lighten-4 bold">
                    <cc:PagerV2_8 ID="pager1" runat="server"
                        OnCommand="pager_Command"
                        GenerateGoToSection="true" NormalModePageCount="3" PageSize="3" />
                </div>
                <%}
                else
    { %>
                <p class="center">No Records Found!</p>
                <%
    }%>
            </div>

        </div>

    </form>
    <script>
        // Scripts for html anchors to asp button mapping
        $(document).ready(function () {

            $('select').formSelect();

            $.validator.setDefaults({
                ignore: []
            });

            $.validator.addMethod("valueNotEquals", function (value, element, arg) {
                return arg != value;
            }, "Select an Employer*");

            $('#<%=frm_employer_staffs.ClientID%>').validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },

                rules: {
                    cmb_employers: {
                        required: true,
                    },
                },
                messages: {
                    cmb_employers: {
                        required: "Please select an employer."
                    },
                },
                errorElement: 'div',
                errorPlacement: function (error, element) {
                    var placement = $(element).data('error');
                    if (placement) {
                        $(placement).append(error)
                    } else {
                        error.insertAfter(element);
                    }
                }

            });

            $('#btn-search').click(function () {
                if ($('#<%=frm_employer_staffs.ClientID%>').valid()) {
                    $('#<%= employer_id.ClientID %>').val($('#cmb_employers').val());
                    document.getElementById('<%= btnSearch.ClientID %>').click();
                };
            });

            function setEmployerId() {
                $('#<%= employer_id.ClientID %>').val($('#cmb_employers').val());
            }
        });

    </script>
</asp:Content>
