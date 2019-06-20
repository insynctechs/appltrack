<%@ Page Language="C#" Title="Employer Staff" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerStaffAdd.aspx.cs" Inherits="recruiter_webapp.EmployerStaffAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="employer_staff_form" runat="server">
        <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
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
        <br />
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
                            <option value="" disabled selected>Choose Location</option>
                            <%foreach (var loc in employerLocationList)
                                {%>
                            <option value="<%=loc["employer_loc_id"] %>"><%=loc["employer_loc_address"] %></option>
                            <%} %>
                        </select>
                    </div>
                    <div class="col s4 input-field">
                        <select id="employer_staff_user_type" name="employer_staff_user_type">
                            <option value="" disabled selected>Choose Usertype</option>
                            <option value="4">Admin</option>
                            <option value="5">Staff</option>
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
                            <option value="" disabled selected>Choose Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="other">Other</option>
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

                    <div class="col s4 input-field">
                        <label class="input-checkbox">
                            <input type="checkbox" id="employer_staff_active" class="filled-in blue lighten-3" <%= (employerStaffList.Count > 0) ? (employerStaffList[0]["active"] == null) ? "checked" : (employerStaffList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                            <span>Active</span>
                        </label>
                        <input type="hidden" id="e" />
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
            $("#employer_staff_form").validate({
                // Specify validation rules
                rules: {
                    employer_staff_name: "required",
                    employer_staff_address: "required",
                    employer_staff_designation: "required",
                    //employer_staff_gender: { valueNotEquals: "default" },
                    employer_staff_email: {
                        required: true,
                        email: true
                    },
                    employer_staff_phone: {
                        required: true,
                        minlength: 5,
                        maxlength: 20,
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
                    //employer_staff_gender: { valueNotEquals: "Please select a gender!" },
                    employer_staff_phone: {
                        required: "Required*",
                        digits: "Please enter valid phone number",
                        minlength: "Please enter valid phone number",
                        maxlength: "Please enter valid phone number",
                    },
                    employer_staff_email: {
                        required: "Required*",
                        email: "Please enter a valid email address.",
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
