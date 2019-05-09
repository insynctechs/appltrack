<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Skill.aspx.cs" Inherits="recruiter_webapp.Skill" %>
   
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <h6>Search skills for Recruitments</h6>
    <div class="row">
        <div id="skillsForm">
        <input type="hidden" name="srchBy" id="srchBy" value="skill" />
        <div class="input-field col s12 m12 l6">
            <input id="srchVal" name="srchVal" type="text" class="validate">
            <label for="srchVal">Search By Skill</label>
        </div>
        <button class="btn waves-effect waves-light blue lighten-1" id="btn-search">
            Search
    <i class="material-icons right">search</i>
        </button>
    </div>
    </div>
    
    <div class="row">
        <div class="col s12 m12 l8">
        <table class="table">
            
        <tr class="blue-grey lighten-4 bold">
            <th class="center">ID</th>
            <th class="center">Skill</th>
            <th class="center">Actions</th>
        </tr>
        <% foreach (var tr in SkillList)
            {
      %>
        <tr>
            <td class="center"><%: tr["id"] %> </td>
            <td class="center"><%: tr["title"] %> </td>
            <td class="center">
                <a href="<%= WebURL %>Skill/Delete?id=<%:tr["id"] %>" onclick="setId(<%:tr["id"] %>)">Delete </a>
                <a href="<%= WebURL %>Skill/Edit?id=<%:tr["id"] %>">Edit</a>
               
            </td>
        </tr>

        <%
            }

    %>
    </table>
            <div class="grey">
                <tr class="light-blue"><td colspan="3">
                <input type="text" id="txtTitle" class="commenttextbox" runat="server" />
                <asp:Button ID="btnInsert" runat="server" Text="Send"  onclick="btnInsert_Click" CssClass="buttonBg"  />
                <input type="hidden" id="hdId" runat="server" />
                </td>
            </tr>
            </div>
    </div>
    </div>
    
    <script>
     $(document).ready(function()
     {
         $( "#btn-search" ).click(function() {
            alert( "btn-search clicked. Jquery loaded" );
         });
         
         function setId(id) { $("#hdId").val(id); alert(id); }
     });
        

       

            
    </script>     

</asp:Content>
