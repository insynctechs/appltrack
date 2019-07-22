<%@ Page Language="C#" Title="Employer Staff" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerStaffAdd.aspx.cs" Inherits="recruiter_webapp.EmployerStaffAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="employer_staff_form" runat="server">
        <div class="card z-depth-1 border-radius-5">
        <div class="row">
            <div class="col s12">
        <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
                </div>
        </div>
    </div>
        <div class="row no-padding">
        <div class="col s12 m12 l6 card blue-grey lighten-4 z-depth-0 border-radius-5 no-margin padding-1">
        <% if (string.IsNullOrEmpty(Request.QueryString["employer_loc_id"]))

            { %>
        <h6>Add Staff for <%if (employerList.Count > 0)
                                 {%><%:employerList[0]["name"]%><%}%></h6>
        <%}
            else
            { %>
        <h6>Edit Staff for <%if (employerList.Count > 0)
                                  {%><%:employerList[0]["name"]%><%}%></h6>
        <%}%>
            </div>
    </div>

        <div class="row">
            <div class="col s10 m10 l6">
                <div class="col s12">
                    <input hidden id="emp_id" runat="server"/>
                    <input hidden id="emp_loc_id" runat="server"/>
                    <input hidden id="emp_name" runat="server" />
                    <input type="hidden" id="employer_id" value="<%if (employerList.Count > 0)
                                  {%><%:employerList[0]["id"]%><%}%>"/>                   
                    <input type="hidden" id="employer_staff_id" value="<%if (employerStaffList.Count > 0)
                                  {%><%:employerStaffList[0]["id"]%><%}%>"/>
                    <div class="col s12 input-field">
                        <input type="hidden" id="employer_name" name="employer_name" value="<%if (employerList.Count > 0)
                                  {%><%:employerList[0]["name"]%><%}%>"/>
                    </div>
                    <div class="col s8 input-field">
                        <select id="employer_loc_id" name="employer_loc">
                            <% foreach (var location in locations)
                                { %>
                            <option value="<%=location.Key %>" <%=(location.Key=="") ? "disabled" : "" %> <%=(((employerStaffList.Count > 0) && employerStaffList[0]["employer_location_id"].ToString()== location.Key) || location.Key=="") ? "selected" : "" %>><%=location.Value%></option>
                            <%} %>


                            <%--
                            <option value="" disabled selected>Choose Location</option>
                            <%foreach (var loc in employerLocationList)
                                {%>
                            <option value="<%=loc["employer_loc_id"] %>"><%=loc["employer_loc_address"] %></option>
                            <%} %>
                            --%>
                        </select>
                    </div>
                    <div class="col s4 input-field">
                        <select id="employer_staff_user_type" name="employer_staff_user_type">
                            <% foreach (var user_type in user_types)
                                { %>
                            <option value="<%=user_type.Key %>" <%=(user_type.Key=="") ? "disabled" : "" %> <%=(((employerStaffList.Count > 0) && employerStaffList[0]["user_type"].ToString()== user_type.Key) || user_type.Key=="") ? "selected" : "" %>><%=user_type.Value%></option>
                            <%} %>
                        </select>
                    </div>
                    <div class="col s12 input-field">
                        <input type="text" id="employer_staff_name" name="employer_staff_name" value="<%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["name"]%><%}%>"/>
                        <label class="input-label" for="employer_staff_name">Name</label>
                    </div>

                    <div class="col s8 input-field">
                        <input type="text" id="employer_staff_designation" name="employer_staff_designation" value="<%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["designation"]%><%}%>" />
                        <label class="input-label" for="employer_staff_designation">Designation</label>
                    </div>

                    <div class="col s4 input-field">
                        <select id="employer_staff_gender" name="employer_staff_gender">
                            <% foreach (var gender in genders)
                                { %>
                            <option value="<%=gender.Key %>" <%=(gender.Key=="") ? "disabled" : "" %> <%=(((employerStaffList.Count > 0) && employerStaffList[0]["gender"].ToString().Trim()== gender.Key) || gender.Key=="") ? "selected" : "" %>><%=gender.Value%></option>
                            <%} %>

                        </select>
                    </div>
                    <div class="col s12 input-field">
                        <input type="text" id="employer_staff_address" name="employer_staff_address" value="<%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["address"]%><%}%>" />
                        <label class="input-label" for="employer_staff_address">Address</label>
                    </div>

                    <div class="col s6 input-field">
                        <input type="text" id="employer_staff_email" name="employer_staff_email" value="<%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["email"]%><%}%>"/>
                        <label class="input-label" for="employer_staff_email">Email</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_staff_phone" name="employer_staff_phone" value="<%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["phone"]%><%}%>"/>
                        <label class="input-label" for="employer_staff_phone">Phone</label>
                    </div>
                        <input type="hidden" id="e" />
                    <div class="col s4 input-field switch left">
                        <label>
                            Active<input type="checkbox" id="employer_staff_active" name="active" class="filled-in blue lighten-3" <%= (employerStaffList.Count > 0) ? (employerStaffList[0]["active"] == null) ? "checked" : (employerStaffList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %>  />
                            <span class="lever"></span>
                        </label>
                    </div>

                    <div class="col s6 input-field">
                        <label class="input-checkbox">
                            <input type="checkbox" id="employer_staff_notification" class="filled-in blue lighten-3" />
                            <span>Send Notification</span>
                        </label>
                    </div>
                    <div class="input-field">
                <a id="btn_employer_staff_submit" name="next" class="btn waves-effect waves-light blue lighten-1 right">Submit</a>
                </div>
                </div>
                
            </div>                    
        </div>
        <br />
        <br />
    </form>

    <script>
        $(document).ready(function () {
            if ($('#employer_staff_id').val() != "") {
                $('btn_employer_staff_submit').html('Update');
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

            $("#employer_staff_form").validate({
                // Specify validation rules
                rules: {
                    employer_staff_name: "required",
                    employer_staff_address: "required",
                    employer_staff_designation: "required",
                    employer_loc: { required: true },
                    employer_staff_user_type: { required: true },
                    employer_staff_gender: { required: true },
                    employer_staff_email: {
                        required: true,
                        regexMatch: "^([a-z0-9\\\\.-]+)@([a-z0-9-]+).([a-z]{2,8})(.[a-z]{2,8})$"
                    },
                    employer_staff_phone: {
                        required: true,
                        regexMatch: "^[0-9+()\/-]{5,20}$"
                    },
                },
                messages: {
                    employer_staff_name: {
                        required: "Required*",
                    },
                    employer_staff_address: {
                        required: "Required*",
                    },
                    employer_staff_designation: {
                        required: "Required*",
                    },
                    employer_loc: {
                        required: "Please select a location."
                    },
                    employer_staff_user_type: {
                        required: "Please select user type."
                    },
                    employer_staff_gender: {
                        required: "Please select a Gender."
                    },
                    employer_staff_phone: {
                        required: "Required*",
                        regexMatch: "Please enter valid phone number",
                    },
                    employer_staff_email: {
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

             $("#btn_employer_staff_submit").click(function () {
                 if ($("#employer_staff_form").valid()) {
                    var employer_staff_id = $('#employer_staff_id').val();
                    var employer_id = $('#employer_id').val();
                    var employer_location_id = $('#employer_loc_id').val();
                    var name = $('#employer_staff_name').val();
                    var gender = $('#employer_staff_gender').val();
                    var designation = $('#employer_staff_designation').val();
                    var address = $('#employer_staff_address').val();
                    var email = $('#employer_staff_email').val();
                    var phone = $('#employer_staff_phone').val();
                    var active;
                    var notification;
                    if ($('#employer_staff_active').prop('checked')) {
                        active = 1;
                    }
                    else {
                        active = 0;
                    }
                    if ($('#employer_staff_notification').prop('checked')) {
                        notification = 1;
                    }
                    else {
                        notification = 0;
                    }
                    var user_type = $('#employer_staff_user_type').val();

                    var datastring = JSON.stringify({ 'employer_staff_id': employer_staff_id, 'employer_id': employer_id, 'employer_location_id': employer_location_id, 'name': name, 'gender': gender, 'designation': designation, 'address': address, 'phone': phone, 'email': email, 'active': active, 'notification': notification, 'user_type': user_type });
                     $.ajax({
                        url: 'EmployerStaffAdd.aspx/InsertEmployerStaff',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                            var ret = parseInt(data.d);
                            if (ret > 0) {
                                toastr.info('Record inserted successfully!');
                            }
                            else {
                                toastr.error('Record for ' + name + ' already exists!');
                            }
                        },
                        error: function (error) {
                            toastr.error("Database error! Unable to complete process.");
                        }
                    });
                }


            });
        });
    </script>
</asp:Content>
