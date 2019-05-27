<%@ Page Title="Skill" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Skill.aspx.cs" Inherits="recruiter_webapp.Skill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <div id="skillsAddForm">
        <a href="<%= WebURL %>SkillUpdate.aspx" class="btn waves-effect waves-light blue lighten-1" id="btn-insert">
                Add Skill<i class="material-icons right">add</i>
        </a>
        <div style="display: inline; padding:0px 10px"></div>
        <asp:FileUpload ID="fileUpload" Style="display: none" runat="server" onchange="upload()"/>
        <asp:Button ID="btnUpload"  OnClick="btnUpload_Click" runat="server" style="display: none" Text=""/>
        <a class="btn waves-effect waves-light blue lighten-1" id="btn-upload" onclick="showBrowseDialog()">
                Upload File<i class="material-icons right">backup</i>
        </a>
        <br />
        <br />
       
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
    </div>
    <div>
    </div>
    <br /><br />
    <div class="row">
        <div id="skillsForm">
            <input type="hidden" name="srchBy" id="srchBy" value="title" runat="server" />
            <div class="input-field col s12 m12 l6">
                <input id="srchVal" name="srchVal" type="text" class="commenttextbox" runat="server">
                <label for="srchVal">Search By Title</label>
            </div>
            <%--
            <button class="btn waves-effect waves-light blue lighten-1" id="btn-search">
                Search
                <i class="material-icons right">search</i>
            </button>
            --%>
            <asp:Button ID="btnSearch" onclick="btnSearch_Click" runat="server" Text="" Style="display: none"/>
            <a class="btn waves-effect waves-light blue lighten-1" id="btn-search" onclick="doSearch()">
                Search<i class="material-icons right">search</i>
            </a>
        </div>
    </div>

    <% if (!this.displayResult) { %>                  
    <div class="row">
        <div class="col s12 m12 l8">
            <% if (SkillList.Count > 0)
                {%>
            <table class="table">

                <tr class="blue-grey lighten-4 bold">
                    
                    <th class="center">Title</th>
                    <th class="center">Actions</th>
                </tr>
                <% foreach (var tr in SkillList)
    {
                %>
                <tr>
                    
                    <td class="center"><%: tr["title"] %> </td>
                    <td class="center">
                        <a href="<%= WebURL %>SkillUpdate?id=<%:tr["id"] %>">Edit</a>
                        <div style="display: inline; margin: 0px 5px; color: lightblue">|</div>
                        <a href="<%= WebURL %>Skill/Delete?id=<%:tr["id"] %>" onclick="setId(<%:tr["id"] %>)">Delete </a>                        
                    </td>
                </tr>

                <%}%>
            </table>
            <% }
            else
            {%> <p class="center">No records found!</p> <%}%>
        </div>
    </div>
    <%
    } else
        { %>
    <div class="row">
        <div class="col s12 m12 l8">
            <table class="table">

                <tr class="blue-grey lighten-4 bold">
                    <th class="center">ID</th>
                    <th class="center">Title</th>
                    <th class="center"></th>
                </tr>
                <% foreach (var tr in SkillListForDuplicates)
                    {
                %>
                <tr>
                    <td class="center"><%: tr["id"] %> </td>
                    <td class="center"><%: tr["title"] %> </td>
                </tr>
                <tr>
                    <td class="center"><%: tr["temp_id"] %> </td>
                    <td class="center"><%: tr["temp_title"] %> </td>
                    <td class="center">
                        <a >Update</a>
                        <div style="display: inline; margin: 0px 5px; color: lightblue">|</div>
                        <a onclick="setId(<%:tr["temp_id"] %>)">Discard </a>                        
                    </td>
                </tr>

                <%
                    }

    %>
            </table>
            
        </div>
    </div>
    <% } %>

<script>
    // Scripts for html anchors to asp button mapping
    function showBrowseDialog() {
        document.getElementById('<%= fileUpload.ClientID %>').click();
    }

    function upload() {
        document.getElementById('<%= btnUpload.ClientID %>').click();
    }

    function doSearch() {
        document.getElementById('<%= btnSearch.ClientID %>').click();
    }

    $(document).ready(function () {           

    });

</script>

</asp:Content>
