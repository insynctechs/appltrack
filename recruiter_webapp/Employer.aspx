﻿<%@ Page Title="Employer" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Employer.aspx.cs" Inherits="recruiter_webapp.Employer" %>

<%@ Register Namespace="ASPnetControls" Assembly="ASPnetPagerV2_8" TagPrefix="cc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <div class="card z-depth-1 border-radius-5">
            <div class="row">
                <div class="col s12">
                    <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
                </div>
            </div>
        </div>
        <div class="row no-padding">
            <div class="col s12 m12 l6 no-margin no-padding">
                <div id="employersAddForm">
                    <a href="<%= WebURL %>EmployerUpdate.aspx" class="btn waves-effect waves-light blue lighten-1" id="btn-insert">Setup New Employer<i class="material-icons right">add</i>
                    </a>
                </div>
            </div>

            <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        </div>


        <div class="row no-padding" style="margin-top: 10px">
            <div class="col s12 m12 l12 no-padding">
                <div id="employersForm">
                    <div class="col s12 l8 no-padding">
                        <div class="input-field col s8 m8 l4">
                            <input id="srchBy1" type="hidden" value="name" />
                            <input id="srchVal" name="srchVal" type="text" class="commenttextbox" runat="server">
                            <label id="lbl_srchVal" for="srchVal">Search By</label>

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
                                    <th class="center">Company Name</th>
                                    <th class="center">Primary Email</th>
                                    <th class="center">Phone</th>
                                    <th class="center">Active</th>
                                    <th class="center">Actions</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>

                            <tr>
                                <td class="center"><%#Eval("RowNumber")%></td>
                                <td class="center"><a href="<%= WebURL %>EmployerEdit?id=<%#Eval("id")%>"><%#Eval("name")%></a></td>
                                <td class="center"><%#Eval("email")%></td>
                                <td class="center"><%#Eval("phone")%></td>
                                <td class="center">
                                    <div class="switch">
                                        <label>
                                            <input type="checkbox" <%# Eval("active").ToString()=="1"?"Checked":"Unchecked" %> />
                                            <span class="lever"></span>
                                        </label>
                                    </div>

                                </td>
                                <td class="center">


                                    <div <%#Eval("progress").ToString()=="3"?"":"hidden" %>>
                                        <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%= WebURL %>EmployerEdit?id=<%#Eval("id")%>">Edit</a>

                                        <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%= WebURL %>EmployerLocation?employer_id=<%#Eval("id")%>">Locations</a>

                                        <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%= WebURL %>EmployerStaff?employer_id=<%#Eval("id")%>">Staffs</a>

                                        <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%= WebURL %>JobUpdate?employer_id=<%#Eval("id")%>">Add Job</a>
                                    </div>
                                    <div <%#Eval("progress").ToString()!="3"?"":"hidden" %>>
                                        <a href="<%=WebURL %>EmployerUpdate?employer_id=<%#Eval("id")%>"><%# 3-Convert.ToInt32(Eval("progress")) %> Step(s) Pending</a>
                                    </div>

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
                        {%>
                    <p class="center">No Records Found!</p>
                    <% } %>
                </div>
            </div>
        </div>
    </form>
    <script>
        // Scripts for html anchors to asp button mapping

        function doSearch() {
            document.getElementById('<%= btnSearch.ClientID %>').click();
        }

        $(document).ready(function () {
            $('select').formSelect();
        });

    </script>
</asp:Content>
