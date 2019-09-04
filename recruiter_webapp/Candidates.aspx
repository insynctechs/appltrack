<%@ Page Language="C#" Title="Candidates" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Candidates.aspx.cs" Inherits="recruiter_webapp.Candidates" %>

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
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        <div class="row">
            
            <div id="candidatesForm">

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
                <%if (candidateList.Items.Count > 0)
                    { %>
                <asp:Repeater ID="candidateList" runat="server">
                    <HeaderTemplate>
                        <table class="table center">
                            <tr class="card blue-grey z-depth-1 lighten-4 bold">
                                <th class="center">#</th>
                                <th class="center">Name</th>
                                <th class="center">Email</th>
                                <th class="center">Address</th>
                                <th class="center">Active</th>
                                <th class="center">Actions</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="center"><%#Eval("RowNumber")%></td>
                            <td class="center"><%#Eval("name")%></td>
                            <td class="center"><%#Eval("email")%></td>                           
                            <td class="center"><%#Eval("address")%></td>
                            <td class="center">
                                <div class="switch">
                                    <label>
                                        <input type="checkbox" <%# Eval("active").ToString()=="1"?"Checked":"Unchecked" %> />
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                            <td class="center">
                                <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%= WebURL %>CandidateUpdate.aspx?id=<%#Eval("id")%>">Edit</a>
                                <a class="btn-delete white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%= WebURL %>Candidates/Delete?id=<%#Eval("id")%>" onclick="setId(<%#Eval("id")%>)">Delete</a>
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
