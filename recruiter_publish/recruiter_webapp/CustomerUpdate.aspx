<%@ Page Title="Customer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerUpdate.aspx.cs" Inherits="recruiter_webapp.CustomerUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="customer_form" runat="server">
        <div class="card z-depth-1 border-radius-5">
        <div class="row">
            <div class="col s12">
        <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
                </div>
        </div>
    </div>
        <% if (Request.QueryString["id"] != null)
            { %>
        <div class="row">
        <div class="col s12 m12 l6 card white lighten-2 z-depth-0 padding-1">
        
        <a class="btn waves-effect waves-light blue lighten-2 left " href="<%=WebURL %>CustomerStaffUpdate?customer_id=<%=Request.QueryString["id"] %>">Add Staff</a>
        <a class="btn waves-effect waves-light blue lighten-2 right" href="<%=WebURL %>CustomerStaff?customer_id=<%=Request.QueryString["id"] %>">View Staffs</a>
        
            </div>
    </div>
        <%} %>

        <div class="row no-padding">
        <div class="col s12 m12 l6 card blue-grey lighten-4 z-depth-0 border-radius-5 no-margin padding-1">
        <% if (!IsPostBack && (Request.QueryString["id"] !=null))
            { %>
         <h6>Edit Customer - <%if (customerList.Count > 0)
                                {%><%:customerList[0]["name"]%><%}%></h6>
        <%}
            else
            { %>
       
            <h6>Add Customer</h6>
        <%} %>
            </div>
    </div>
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        

        <div class="row">
            <div class="input-field col s12 m12 l6 card white lighten-3 z-depth-3 padding-2 border-radius-5">

                <input type="hidden" id="id" name="id" value="<%if (customerList.Count > 0)
                    {%><%:customerList[0]["id"]%><%}%>" />
                <div class="row">
                    <div class="input-field col s12">

                        <input type="text" id="name" name="name" value="<%if (customerList.Count > 0)
                            {%><%:customerList[0]["name"]%><%}%>" />
                        <label class="input-label" for="name">Name*</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <textarea id="address" name="address"><%if (customerList.Count > 0)
                                                                  {%><%:customerList[0]["address"]%><%}%></textarea>
                        <label class="input-label" for="address">Address*</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6 left">
                        <input type="text" id="city" name="city" value="<%if (customerList.Count > 0)
                            {%><%:customerList[0]["city"]%><%}%>" />
                        <label class="input-label" for="city">City*</label>
                    </div>
                    <div class="input-field col s6 right">
                        <input type="text" id="state" name="state" value="<%if (customerList.Count > 0)
                            {%><%:customerList[0]["state"]%><%}%>" />
                        <label class="input-label" for="state">State*</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6 left">
                        <input type="text" id="zip" name="zip" value="<%if (customerList.Count > 0)
                            {if(customerList[0]["zip"].ToString()!="0") {%><%:customerList[0]["zip"]%><%} }%>" />
                        <label class="input-label" for="zip">Zip</label>
                    </div>
                    <div class="input-field col s6 right">
                        <input type="text" id="contact" name="contact" value="<%if (customerList.Count > 0)
                            {%><%:customerList[0]["contact"]%><%}%>" />
                        <label class="input-label" for="contact">Primary Contact*</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6 left">
                        <input type="text" id="email" name="email" value="<%if (customerList.Count > 0)
                            {%><%:customerList[0]["email"]%><%}%>" />
                        <label class="input-label" for="email">Primary Email*</label>
                    </div>
                    <div class="input-field col s6 right">
                        <input type="text" id="phone" name="phone" value="<%if (customerList.Count > 0)
                            {%><%:customerList[0]["phone"]%><%}%>" />
                        <label class="input-label" for="phone">Phone</label>
                    </div>
                </div>
                <div class="row">

                    <div class="col s4 input-field switch left">
                        <label>
                            Active<input type="checkbox" id="active" name="active" class="filled-in blue lighten-3" <%= (customerList.Count > 0) ? (customerList[0]["active"] == null) ? "checked" : (customerList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                            <span class="lever"></span>
                        </label>
                    </div>


                </div>
                <br />
                <br />
                <div class="row">

                    <div class="col s6 input-field left">

                        <a href="<%=Session["previous_url"] %>" class="btn waves-effect waves-light blue lighten-1 left" id="btn-cancel">Cancel<i class="material-icons right">close</i></a>
                    </div>
                    <div class="col s6 input-field right">
                        <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="" Style="display: none" />
                        <a class="btn waves-effect waves-light blue lighten-1 right" id="btn-submit"><%=(!IsPostBack && (Request.QueryString["id"] !=null))? "Update" : "Submit"%><i class="material-icons right">send</i></a>
                    </div>

                    </div>
                </div>

            </div>
    </form>
    <style>
        .input-label {
            margin-left: 10px;
        }
    </style>

    <script>
        $(document).ready(function () {

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

            $('#<%=customer_form.ClientID%>').validate({
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
                    address: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    city: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    state: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    zip: {
                        validateNullOrWhiteSpace: true,
                        digits: true,
                        minlength: 5,
                        maxlength: 10,
                    },
                    contact: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^[0-9 +()\/-]{5,20}$"
                    },

                    email: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([a-z0-9\\\\.-]{2,20})@([a-z0-9]{2,20})(\.)([a-z]{2,8})(.[a-z]{2,8})?$"
                    },

                    phone: {
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^[0-9 +()\/-]{5,20}$",
                    },

                },
                messages: {
                    name: {
                        required: "Required*",
                    },
                    address: {
                        required: "Required*",
                    },
                    city: {
                        required: "Required*",
                    },
                    state: {
                        required: "Required*",
                    },
                    zip: {
                        digits: "Please enter valid zip",
                        minlength: "Please enter valid zip",
                        maxlength: "Please enter valid zip",
                    },
                    contact: {
                        required: "Required*",
                        regexMatch: "Please enter valid contact number",
                    },
                    email: {
                        required: "Required*",
                        regexMatch: "Please enter a valid email address."
                    },
                    phone: {
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
                if ($('#<%=customer_form.ClientID%>').valid()) {
                    document.getElementById('<%= btnSubmit.ClientID %>').click();
                };
            });
        });



    </script>


</asp:Content>
