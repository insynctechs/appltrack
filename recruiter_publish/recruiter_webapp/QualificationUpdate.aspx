<%@ Page Title="Qualification" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QualificationUpdate.aspx.cs" Inherits="recruiter_webapp.QualificationUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="qualificationForm" runat="server">
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
                <h6>Add Qualification</h6>
                <%}
                    else
                    { %>
                <h6>Edit Qualification - <%if (QualificationList.Count > 0)
    {%><%:QualificationList[0]["title"]%><%}%></h6>
                <%}%>
            </div>
        </div>

        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>

        <div class="row">
            <div id="qualification-form">
                <div class="input-field col s12 m12 l6">
                    <input type="hidden" id="id" name="id" value="<%if (QualificationList.Count > 0)
                        {%><%:QualificationList[0]["id"]%><%}%>" />
                    <input type="text" id="title" name="title" value="<%if (QualificationList.Count > 0)
                        {%><%:QualificationList[0]["title"]%><%}%>" />
                </div>
                </div>
            </div>
                <div class="row">
                    <div class="input-field col s12 m12 l6">
                    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="" Style="display: none" />
                    <a class="btn waves-effect waves-light blue lighten-1 right" id="btn-submit" onclick="doSubmit()">
                        <%=(Request.QueryString["id"] !=null)? "Update" : "Submit"%><i class="material-icons right">send</i>
                    </a>
                </div>
                </div>
                
            
        
    </form>
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

            $("#<%= qualificationForm.ClientID %>").validate({
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
                if ($("#<%= qualificationForm.ClientID %>").valid()) {
                    document.getElementById('<%= btnSubmit.ClientID %>').click();
                };
            });
        });


    </script>




</asp:Content>
