<%@ Page Title="Skill" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SkillUpdate.aspx.cs" Inherits="recruiter_webapp.SkillUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="skillForm" runat="server">
        <div class="card z-depth-1 border-radius-5">
            <div class="row">
                <div class="col s12">
                    <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
                </div>
            </div>
        </div>
        <div class="row no-padding">
            <div class="col s12 m12 l6 card blue-grey lighten-4 z-depth-0 border-radius-5 no-margin padding-1">
                <% if (string.IsNullOrEmpty(Request.QueryString["id"]))
                    { %>
                <h6>Add Skill</h6>
                <%}
                    else
                    { %>
                <h6>Edit Skill - <%if (SkillList.Count > 0)
                                     {%><%:SkillList[0]["title"]%><%}%></h6>
                <%}%>
            </div>
        </div>
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>

        <div class="row">
            <div id="skill-form">
                <div class="input-field col s12 m12 l6">
                    <%--<%if (SkillList != null){%> value="<%=SkillList[0]["id"]; %>"<%} %>--%>
                    <input type="hidden" id="id" name="id" value="<%if (SkillList.Count > 0)
                        {%><%:SkillList[0]["id"]%><%}%>" />
                    <input type="text" id="title" name="title" value="<%if (SkillList.Count > 0)
                        {%><%:SkillList[0]["title"]%><%}%>" />
                </div>
                </div>
        </div>
                <div class="row">
                    <div class="input-field col s12 m12 l6">
                    <asp:Button ID="btnSubmit" ClientIDMode="Static" OnClick="btnSubmit_Click" runat="server" Text="" Style="display: none" />
                    <a class="btn waves-effect waves-light blue lighten-1 right" id="btn-submit">
                        <%=(Request.QueryString["id"] !=null)? "Update" : "Submit"%><i class="material-icons right">send</i>
                    </a>
                </div>
                </div>
                
            


        <script>
            $(document).ready(function () {

                function isNullOrWhitespace(input) {
                    if (typeof input === 'undefined' || input == null)
                        return true;
                    return /^\s+$/.test(input);
                }

                $.validator.addMethod("validateNullOrWhiteSpace", function (value, element) {
                    return !isNullOrWhitespace(value);
                }, "Blank spaces not allowed!");

                $("#<%= skillForm.ClientID %>").validate({
                    rules: {
                        title: {
                            required: true,
                            validateNullOrWhiteSpace: true,
                        },
                    },
                    messages: {
                        title: {
                            required: "Required*",
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
                // Scripts for html anchors to asp button mapping
                $('#btn-submit').click(function () {
                    if ($("#<%= skillForm.ClientID %>").valid()) {
                    document.getElementById('<%= btnSubmit.ClientID %>').click();
                    };
                });
            });



        </script>

    </form>
</asp:Content>
