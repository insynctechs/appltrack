<%@ Page Language="C#" Title="Customer Staff" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerStaffUpdate.aspx.cs" Inherits="recruiter_webapp.CustomerStaffUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card z-depth-1 border-radius-5">
        <div class="row">
            <div class="col s12">
                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>
        </div>
    </div>

    <div class="row no-padding">
        <div class="col s12 m12 l6 card blue-grey lighten-4 z-depth-0 border-radius-5 no-margin padding-1">


            <% if (!IsPostBack && (Request.QueryString["id"] !=null))
            { %>
            <h6>Edit Staff - <%if (customerStaffList.Count > 0)
                                 {%><%:customerStaffList[0]["name"]%><%}%></h6>
            
            <%}
                else
                { %>
            <h6>Add Staff</h6>
            <% } %>
        </div>
    </div>
    <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
    <div class="row">
        <form id="customerForm" runat="server">
            <div class="input-field col s12 m12 l6 card white lighten-3 z-depth-3 padding-2">

                <input type="hidden" id="id" name="id" value="<%if (customerStaffList.Count > 0)
                    {%><%:customerStaffList[0]["id"]%><%}%>" />
                <input type="hidden" id="customer_id" name="customer_id" value="<%if (Request.QueryString["customer_id"] != null) { %><%=Request.QueryString["customer_id"]%><%} else if (customerStaffList.Count > 0)
                    {%><%:customerStaffList[0]["customer_id"]%><%}%>" />
                <div class="row">
                    <div class="input-field col s12">
                        <input type="text" id="name" name="name" value="<%if (customerStaffList.Count > 0)
                            {%><%:customerStaffList[0]["name"]%><%}%>" />
                        <label class="input-label" for="name">Name*</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s8 left">
                        <input type="text" id="designation" name="designation" value="<%if (customerStaffList.Count > 0)
                            {%><%:customerStaffList[0]["designation"]%><%}%>" />
                        <label class="input-label" for="designation">Designation*</label>
                    </div>
                    <div class="col s4 input-field right">
                        <select id="user_type" name="user_type"> 
                            <% foreach (var user_type in user_types)
                                { %>
                            <option value="<%=user_type.Key %>" <%=(user_type.Key=="") ? "disabled" : "" %> <%=(((customerStaffList.Count > 0) && customerStaffList[0]["user_type"].ToString()== user_type.Key) || user_type.Key=="") ? "selected" : "" %>><%=user_type.Value%></option>
                            <%} %>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <textarea id="address" name="address"><%if (customerStaffList.Count > 0)
                                                                  {%><%:customerStaffList[0]["address"]%><%}%></textarea>
                        <label class="input-label" for="address">Address*</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col s4 input-field left">
                        <select id="gender" name="gender">
                            <% foreach (var gender in genders)
                                { %>
                            <option value="<%=gender.Key %>" <%=(gender.Key=="") ? "disabled" : "" %> <%=(((customerStaffList.Count > 0) && customerStaffList[0]["gender"].ToString().Trim()== gender.Key) || gender.Key=="") ? "selected" : "" %>><%=gender.Value%></option>
                            <%} %>
                        </select>
                    </div>
                    <div class="input-field col s6 offset-s2 right">
                        <input type="text" id="email" name="email" value="<%if (customerStaffList.Count > 0)
                            {%><%:customerStaffList[0]["email"]%><%}%>" />
                        <label class="input-label" for="email">Email*</label>
                    </div>

                </div>
                <div class="row">
                    <div class="input-field col s6 left">
                        <input type="text" id="phone" name="phone" value="<%if (customerStaffList.Count > 0)
                            {%><%:customerStaffList[0]["phone"]%><%}%>" />
                        <label class="input-label" for="phone">Phone*</label>
                    </div>
                    <div class="col s4 input-field switch right">
                        <label>
                            Active<input type="checkbox" id="active" name="active" class="filled-in blue lighten-3" <%= (customerStaffList.Count > 0) ? (customerStaffList[0]["active"] == null) ? "checked" : (customerStaffList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                            <span class="lever"></span>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="col s6 input-field left">

                        <a href="<%=Session["previous_url"] %>" class="btn waves-effect waves-light blue lighten-1 left" id="btn-cancel">Cancel<i class="material-icons right">close</i></a>
                    </div>
                    <div class="input-field col s6 right">
                        <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="" Style="display: none" />
                        <a class="btn waves-effect waves-light blue lighten-1 right" id="btn-submit"><%=(Request.QueryString["id"] !=null)? "Update" : "Submit"%><i class="material-icons right">send</i>
                        </a>
                    </div>
                </div>













            </div>

        </form>
    </div>
    <style>
        .input-label {
            margin-left: 10px;
        }
    </style>
    <script>
        $(document).ready(function () {
            $.validator.setDefaults({
                ignore: []
            });
            function isNullOrWhitespace(input) {
                if (typeof input === 'undefined' || input == null)
                    return true;
                return /^\s+$/.test(input);
            }

            $.validator.addMethod("valueNotEquals", function (value, element, arg) {
                return arg != value;
            }, "Required");

            $.validator.addMethod("regexMatch", function (value, element, regexp) {
                var regex = new RegExp(regexp);
                return this.optional(element) || regex.test(value);
            },
                "Not a valid input!"
            );

            $.validator.addMethod("validateNullOrWhiteSpace", function (value, element) {
                return !isNullOrWhitespace(value);
            }, "Blank spaces not allowed!");

            $('#<%=customerForm.ClientID%>').validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },

                rules: {
                    name: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    designation: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    address: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    gender: {
                        required: true,
                        valueNotEquals: "0",
                    },
                    user_type: {
                        required: true,
                        valueNotEquals: "0",
                    },
                    email: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([a-z0-9\\\\.-]{2,20})@([a-z0-9]{2,20})(\.)([a-z]{2,8})(.[a-z]{2,8})?$"
                    },
                    phone: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^[0-9 +()\/-]{5,20}$"
                    },
                },
                messages: {
                    name: {
                        required: "Required*",
                    },
                    designation: {
                        required: "Required*",
                    },
                    address: {
                        required: "Required*",
                    },
                    gender: {
                        required: "Please select a gender.",
                        valueNotEquals: "Please select a gender."
                    },
                    user_type: {
                        required: "Please select a user type.",
                        valueNotEquals: "Please select a user type."
                    },
                    email: {
                        required: "Required*",
                        regexMatch: "Please enter a valid email address."
                    },
                    phone: {
                        required: "Required*",
                        regexMatch: "Please enter valid phone number",
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

            $('#btn-submit').click(function () {
                if ($('#<%=customerForm.ClientID%>').valid()) {
                    
                    document.getElementById('<%= btnSubmit.ClientID %>').click();
                    
                };
            });
        });



    </script>

</asp:Content>
