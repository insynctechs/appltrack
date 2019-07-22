<%@ Page Language="C#" Title="Employer Location" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerLocationAdd.aspx.cs" Inherits="recruiter_webapp.EmployerLocationAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="employer_loc_form" runat="server">
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
        <h6>Add Location for <%if (employerList.Count > 0)
                            {%><%:employerList[0]["name"]%><%}%></h6>
    <%}
             else
             { %> 
    <h6>Edit Location <%if (employerList.Count > 0)
                            {%><%:employerList[0]["name"]%><%}%></h6>
    <%}%>
    </div>
            </div>
        <br/>
    <div class="row">
                <div class="col s6">
                    <input type="hidden" id="employer_id" value="<%if (employerList.Count > 0)
                            {%><%:employerList[0]["id"]%><%}%><%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["employer_id"]%><%}%>"/>
                    <input type="hidden" id="employer_loc_id" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["id"]%><%}%>"/>
                    <div class="col s12 input-field">
                        <input type="text" id="employer_name" name="employer_name" value="<%if (employerList.Count > 0)
                            {%><%:employerList[0]["name"]%><%}%><%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["employer_id"]%><%}%>" readonly/>
                        <label class="input-label" for="employer_name">Company Name</label>
                    </div>
                    <div class="col s12 input-field">
                        <input type="text" id="employer_loc_address" name="employer_loc_address" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["address"]%><%}%>"/>
                        <label class="input-label" for="employer_loc_address">Address</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_city" name="employer_loc_city" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["city"]%><%}%>" />
                        <label class="input-label" for="employer_loc_city">City</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_zip" name="employer_loc_zip" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["zip"]%><%}%>"/>
                        <label class="input-label" for="employer_loc_zip">P.O.Box</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_country" name="employer_loc_country" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["country"]%><%}%>" />
                        <label class="input-label" for="employer_loc_country">Country</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_email" name="employer_loc_email" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["email"]%><%}%>"/>
                        <label class="input-label" for="employer_loc_email">Email</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_phone" name="employer_loc_phone" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["phone"]%><%}%>"/>
                        <label class="input-label" for="employer_loc_phone">Phone</label>
                    </div>
                    <div class="col s2 input-field">
                        <label class="input-checkbox">
                            <input type="checkbox" id="employer_loc_active" class="filled-in blue lighten-3" <%= (employerLocationList.Count > 0) ? (employerLocationList[0]["active"] == null) ? "checked" : (employerLocationList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                            <span>Active</span>
                        </label>
                    </div>

                    <div class="input-field col s12">
                        <a id="btn_employer_loc_submit" class="btn waves-effect waves-light blue lighten-1 right">Submit</a>
                        </div>
                </div>
                

    </div>
        </form>

    <script>
        $(document).ready(function () {
            if ($('#employer_loc_id').val() != "") {
                $('btn_employer_loc_submit').html('Update');
            }

            $.validator.setDefaults({
                ignore: []
            });
            // For select input
            $.validator.addMethod("valueNotEquals", function(value, element, arg){
            return arg !== value;
            }, "Value must not equal arg.");

            $.validator.addMethod("regexMatch", function (value, element, regexp) {
                var regex = new RegExp(regexp);
                return this.optional(element) || regex.test(value);
            },
                "Not a valid input!"
            );
            
            $('#<%=employer_loc_form.ClientID%>').validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },
                // Specify validation rules
                rules: {
                    employer_loc_address: "required",
                    employer_loc_city: "required",
                    employer_loc_country: "required",
                    employer_loc_zip: {
                        required: true,
                        digits: true,
                        minlength: 5,
                        maxlength: 10,
                    },
                    employer_loc_email: {
                        required: true,
                        regexMatch: "^([a-z0-9\\\\.-]+)@([a-z0-9-]+).([a-z]{2,8})(.[a-z]{2,8})$"
                    },
                    employer_loc_phone: {
                        required: true,
                        regexMatch: "^[0-9+()\/-]{5,20}$"
                    },
                },
                messages: {
                    employer_loc_address: {
                        required: "Required*",
                    },
                    employer_loc_city: {
                        required: "Required*",
                    },
                    employer_loc_country: {
                        required: "Required*",
                    },
                    employer_loc_zip: {
                        required: "Required*",
                        digits: "Please enter valid zip",
                        minlength: "Please enter valid zip",
                        maxlength: "Please enter valid zip",
                    },
                    employer_loc_phone: {
                        required: "Required*",
                        regexMatch: "Please enter valid phone number",
                    },
                    employer_loc_email: {
                        required: "Required*",
                        regexMatch: "Please enter a valid email address.",
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

            $("#btn_employer_loc_submit").click(function () {
                if ($("#employer_loc_form").valid()) {
                    var employer_id = $('#employer_id').val();
                    var employer_loc_id = $('#employer_loc_id').val();
                    var address = $('#employer_loc_address').val();
                    var city = $('#employer_loc_city').val();
                    var zip = $('#employer_loc_zip').val();
                    var email = $('#employer_loc_email').val();
                    var phone = $('#employer_loc_phone').val();
                    var country = $('#employer_loc_country').val();
                    var active;
                    if ($('#employer_loc_active').prop('checked')) {
                        active = 1;
                    }
                    else {
                        active = 0;
                    }
                    var datastring = JSON.stringify({ 'employer_loc_id': employer_loc_id, 'employer_id': employer_id, 'address': address, 'city': city, 'zip': zip, 'email': email, 'phone': phone, 'country': country, 'active': active });
                    $.ajax({
                        url: 'EmployerLocationAdd.aspx/InsertEmployerLocation',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                            var ret = parseInt(data.d);
                            if (ret > 0) {
                                toastr.info('Record successfully added!');
                            }
                            else {
                                toastr.error('Record already exists!');
                            }
                        },
                        error: function (error) {
                            toastr.error("Database error! Unable to complete process.");
                        }
                    });
                };
            });

        });
        
    </script>

   <link href="/Styles/form_styles.css" rel="stylesheet"></
</asp:Content>
