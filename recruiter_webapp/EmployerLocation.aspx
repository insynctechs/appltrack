﻿<%@ Page Language="C#" Title="Employer Location" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerLocation.aspx.cs" Inherits="recruiter_webapp.EmployerLocation" %>

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
        <div id="employerLocsAddForm">
            <%if (Request.QueryString["employer_id"] != null)
                { %>
            <a href="<%= WebURL %>EmployerLocationAdd?employer_id=<%=Request.QueryString["employer_id"] %>" class="btn waves-effect waves-light blue lighten-1" id="btn-insert">Add Location<i class="material-icons right">add</i>
            </a>
            <div style="display: inline; padding: 0px 10px"></div>
            <%} %>
            <br />


            <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        </div>
        <div>
        </div>
        <br />
        <br />
        <div class="row">
            
        </div>
        <div class="row">
            <div id="employerLocsForm">
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
                <div class="input-field col s3 m3 l4">
                    <input id="srchVal" name="srchVal" type="text" class="commenttextbox" runat="server">
                    <label id="lbl_srchVal" for="srchVal">Search Value</label>
                </div>
                <div class="input-field col s3 m3 l2">
                    <select id="srchBy" name="srchBy" runat="server">
                        <option value="address" selected>Address</option>
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
                            <tr class="card blue-grey z-depth-1 lighten-4 bold">
                                <th class="center">#</th>
                                <th class="center">Employer Name</th>
                                <th class="center">Location</th>
                                <th class="center">Active</th>
                                <th class="center">Actions</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="center"><%#Eval("RowNumber")%></td>
                            <td class="center"><%#Eval("employer_name")%></td>
                            <td class="center"><%#Eval("employer_loc_address")%></td>
                            <td class="center">
                                <div class="switch">
                                    <label>
                                        <input type="checkbox" <%# Eval("employer_loc_active").ToString()=="1"?"Checked":"Unchecked" %> />
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                            <td class="center">
                                <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%= WebURL %>EmployerLocationAdd?id=<%#Eval("employer_loc_id")%>">Edit</a>
                                
                                <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%= WebURL %>EmployerStaff?employer_id=<%#Eval("employer_loc_id")%>">Staffs</a>
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
