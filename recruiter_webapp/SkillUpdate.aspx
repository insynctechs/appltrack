<%@ Page Title="Skill" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SkillUpdate.aspx.cs" Inherits="recruiter_webapp.SkillUpdate" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <% if (string.IsNullOrEmpty(Request.QueryString["id"]))
             { %>
    <h6>Add Skill</h6>
    <%}
             else
             { %>   
    <h6>Edit Skill <%if (SkillList.Count>0) {%><%:SkillList[0]["title"]%><%}%></h6>
    <%}%>
    <br /><br />
    <div class="row">
        <div id="skill-form">
            <div class="input-field col s12 m12 l6">
                <%--<%if (SkillList != null){%> value="<%=SkillList[0]["id"]; %>"<%} %>--%>
                <input type="hidden" id="id" class="commenttextbox" runat="server"/>
                <input type="text" id="title" class="commenttextbox" runat="server"/> 
            </div>
            <div class="col s2 left">
                <asp:Button CssClass="btn waves-effect waves-light blue lighten-1 display-block" id="btnSubmit" onclick="btnSubmit_Click" runat="server" Text="Submit"/>
            </div>                     
        </div>
    </div>




</asp:Content>