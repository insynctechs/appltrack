<%@ Page Title="Candidates" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Candidate.aspx.cs" Inherits="recruiter_webapp.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Candidates List</h3>
   
      <ul>
    <% foreach (var tr in CandidateList )
        {
      %>   
        <li>            <%: tr["candidate_name"] %> </li>

    <%
        }


                %>
        </ul>
</asp:Content>
