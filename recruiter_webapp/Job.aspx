<%@ Page Language="C#" Title="Job" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Job.aspx.cs" Inherits="recruiter_webapp.Job" %>

<%@ Register Namespace="ASPnetControls" Assembly="ASPnetPagerV2_8" TagPrefix="cc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">

                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>
        </div>
        <div id="employersAddForm">
            <%-- Require Rework
            <a href="#" class="btn waves-effect waves-light blue lighten-1" id="btn-insert">Button<i class="material-icons right">add</i>
            </a>
                --%>
            <div style="display: inline; padding: 0px 10px"></div>

            <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        </div>
        <div>
        </div>

        <div class="row no-padding">
            <div class="col s12 m12 l12 card grey lighten-4 z-depth-0 no-padding">
                <div id="employersForm">
                    <div class="col s12 l8 no-padding">
                        <div class="input-field col s8 m8 l4">
                            <input id="srchVal" name="srchVal" type="text" class="commenttextbox" runat="server">
                            <label id="lbl_srchVal" for="srchVal">Search Value</label>

                        </div>
                        <div class="input-field col s4 m4 l2">
                            <input id="employer_id" value="" hidden runat="server" />
                            <input id="location_id" value="" hidden runat="server" />
                            <select id="srchBy" name="srchBy" runat="server">
                                <option value="job_code" selected>Job Code</option>
                                <option value="employer_id">Employer</option>
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


            <%-- <div class="row"> --%>
            <div class="col s12 m12 l12">
                <%if (jobList.Items.Count > 0)
                    { %>
                <asp:Repeater ID="jobList" runat="server">
                    <HeaderTemplate>
                        <table class="table center">
                            <tr class="card blue-grey z-depth-1 lighten-4 bold">
                                <th class="center">#</th>
                                <th class="center">Job Code</th>
                                <th class="center">Employer</th>
                                <th class="center">Description</th>
                                <th class="center">Active</th>
                                <th class="center"></th>
                                <th class="center">Interview</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>

                        <tr>
                            <td class="center"><%#Eval("RowNumber")%></td>
                            <td class="center"><a href="<%=WebURL %>JobUpdate?id=<%#Eval("id")%>"><%#Eval("job_code")%></a></td>
                            <td class="center"><%#Eval("employer")%></td>
                            <td class="center"><%#Eval("description")%></td>
                            <td class="center">
                                <div class="switch">
                                    <label>
                                        <input type="checkbox" <%# Eval("active").ToString()=="1"?"Checked":"Unchecked" %> />
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                            <td><a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%=WebURL %>InterviewResults?job_id=<%#Eval("id")%>">Results</a></td>
                            <td class="center"><a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%=WebURL %>InterviewUpdate?job_id=<%#Eval("id")%>">Schedule</a></td>

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
            <%--</div> --%>
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
