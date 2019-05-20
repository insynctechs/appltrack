<%@ Page Title="Qualification" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Qualification.aspx.cs" Inherits="recruiter_webapp.Qualification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <div id="qulaificationAddForm">
        <a href="QualificationUpdate.aspx" class="btn waves-effect waves-light blue lighten-1" id="btn-insert">
                Add New Qualification<i class="material-icons right">add</i>
        </a>
        <br /><br /><hr style="color: lightblue"/>
        <asp:FileUpload ID="fileUpload" CssClass="file-field input-field" runat="server"/>
        <br />
        <asp:Button ID="btnUpload" CssClass="btn waves-effect waves-light blue lighten-1 white-text" OnClick="btnUpload_Click" runat="server" Text="Upload File"/>      
        <asp:Label ID="lblUploadMsg" style="padding-left: 10px" runat="server"></asp:Label>
    </div>
    <br /><br />
    <div class="row">
        <div id="qualificationsForm">
            <input type="hidden" name="srchBy" id="srchBy" value="title" runat="server" />
            <div class="input-field col s12 m12 l6">
                <input id="srchVal" name="srchVal" type="text" class="commenttextbox" runat="server">
                <label for="srchVal">Search By Qualification</label>
            </div>
            <%--
            <button class="btn waves-effect waves-light blue lighten-1" id="btn-search">
                Search
                <i class="material-icons right">search</i>
            </button>
            --%>
            <asp:Button CssClass="btn waves-effect waves-light blue lighten-1 white-text" id="btnSearch" onclick="btnSearch_Click" runat="server" Text="Search"/>
        </div>
    </div>

    <div class="row">
        <div class="col s12 m12 l8">
            <table class="table">

                <tr class="blue-grey lighten-4 bold">
                    <th class="center">ID</th>
                    <th class="center">Qualification</th>
                    <th class="center">Actions</th>
                </tr>
                <% foreach (var tr in QualificationList)
                    {
                %>
                <tr>
                    <td class="center"><%: tr["id"] %> </td>
                    <td class="center"><%: tr["title"] %> </td>
                    <td class="center">
                        <a href="<%= WebURL %>QualificationUpdate?id=<%:tr["id"] %>">Edit</a>
                        <div style="display: inline; margin: 0px 5px; color: lightblue">|</div>
                        <a href="<%= WebURL %>Qualification/Delete?id=<%:tr["id"] %>" onclick="setId(<%:tr["id"] %>)">Delete </a>                        
                    </td>
                </tr>

                <%
                    }

    %>
            </table>
        </div>
    </div>

    <script>
        $(document).ready(function () {

        });

    </script>

</asp:Content>