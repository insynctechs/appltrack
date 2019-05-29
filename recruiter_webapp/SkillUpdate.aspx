﻿<%@ Page Title="Skill" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SkillUpdate.aspx.cs" Inherits="recruiter_webapp.SkillUpdate" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <% if (string.IsNullOrEmpty(Request.QueryString["id"]))
             { %>
    <h6>Add Skill</h6>
    <%}
             else
             { %>   
    <h6>Edit Skill - <%if (SkillList.Count>0) {%><%:SkillList[0]["title"]%><%}%></h6>
    <%}%>
    
    <br />
    <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
    <br />
    <div class="row">
        <div id="skill-form">
            <div class="input-field col s12 m12 l6">
                <%--<%if (SkillList != null){%> value="<%=SkillList[0]["id"]; %>"<%} %>--%>
                <input type="hidden" id="id" class="commenttextbox" runat="server"/>
                <input type="text" id="title" class="commenttextbox" runat="server"/>
            </div>
            <div class="col s2 left">
            <asp:Button ID="btnSubmit" onclick="btnSubmit_Click" runat="server" Text="" Style="display: none"/>
            <a class="btn waves-effect waves-light blue lighten-1" id="btn-search" onclick="doSubmit()">
                Submit<i class="material-icons right">send</i>
            </a>
            </div>                     
        </div>
    </div>


    <script>
        $(document).ready(function () {
        $.validator.setDefaults({
        ignore: []
        });
        $.validator.addMethod("valueNotEquals", function(value, element, arg){
            return arg != value;
        }, "Required");
      
        /*$("#skill-form").validate({
            rules: {
                title: { valueNotEquals: "" }
            },
            messages: {
                title: {
                    valueNotEquals: "Enter a valid skill"
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
        */
    });

        // Scripts for html anchors to asp button mapping
        function doSubmit() {
        document.getElementById('<%= btnSubmit.ClientID %>').click();
    }
    </script>


</asp:Content>