<%@ Page Title="User Profile" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="recruiter_webapp.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_userprofile" runat="server" enctype="multipart/form-data">
        <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">
                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>

        </div>
        <div class="row no-padding">
            <div class="col s12 m12 l8 card card grey lighten-2 padding-1 border-radius-5 no-margin padding-1">
                <h6><%if (userList.Count > 0)
                        {%><%:userList[0]["name"]%><%}%></h6>
            </div>
        </div>
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        <div class="row">
            <div class="input-field col s12 m12 l8 card white lighten-3 z-depth-3 padding-3 border-radius-5">

                <input type="hidden" id="id" runat="server" />
                <input type="hidden" id="user_id" runat="server" />

                <div class="row">
                    <div class="input-field col s8">
                    <input type="text" id="name" name="name" value="<%:userList[0]["name"]%>" readonly />
                    <label for="name">Name</label>
                </div>
                <%if (Session["user_type"].ToString() != "1" && Session["user_type"].ToString() != "6")
                    { %>
                <div class="input-field col s6">
                    <input type="text" id="designation" name="designation" value="<%:userList[0]["designation"]%>" />
                    <label for="designation">Designation*</label>
                </div>
                <%} %>
                    <%if (Session["user_type"].ToString() == "6")
                    { %>
                    <div class="input-field col s4">
                    <input type="text" class="datepicker" id="dob" name="dob" value="<%if (userList.Count > 0)
                            {%><%:Convert.ToDateTime(userList[0]["dob"]).Month+"/"+Convert.ToDateTime(userList[0]["dob"]).Day+"/"+Convert.ToDateTime(userList[0]["dob"]).Year%><%}%>"/>
                    <label for="dob">Date of Birth*</label>
                        
                </div>
                    <%} %>
                </div>
                
                <div class="row">
                    <%if (Session["user_type"].ToString() != "1")
                    {%>
                <div class="col s4 input-field left">
                    <select id="gender" name="gender">
                        <% foreach (var gender in genders)
                            { %>
                        <option value="<%=gender.Key %>" <%=(gender.Key == "") ? "disabled" : "" %> <%=(((userList.Count > 0) && userList[0]["gender"].ToString().Trim() == gender.Key) || gender.Key == "") ? "selected" : "" %>><%=gender.Value%></option>
                        <%} %>
                    </select>
                    <label class="input-label" for="gender">Gender*</label>
                </div>
                <%}%>
                <div class="input-field col s6">
                    <input type="text" id="user_type_name" name="user_type_name" value="<%:userList[0]["user_type_name"]%>" readonly/>
                    <label for="user_type_name">User Type</label>
                </div>
                </div>
                


                <div class="row">
                    <%if (Session["user_type"].ToString() == "4" || Session["user_type"].ToString() == "5")
                    {%>
                <div class="input-field col s12">
                    <input type="text" id="employer_name" name="employer_name" value="<%:userList[0]["employer_name"]%>" />
                    <label for="employer_name">Employer Name</label>
                </div>
                <%} %>

                <%if (Session["user_type"].ToString() == "2" || Session["user_type"].ToString() == "3")
                    {%>
                <div class="input-field col s12">
                    <input type="text" id="customer_name" name="customer_name" value="<%:userList[0]["customer_name"]%>" />
                    <label for="customer_name">Customer Name</label>
                </div>
                <%} %>
                </div>

                
                <div class="row">
                    <%if (Session["user_type"].ToString() != "1")
                    {%>
                <div class="input-field col s12">
                    <textarea id="address" name="address"><%:userList[0]["address"]%></textarea>
                    <label for="address">Address*</label>
                </div>
                <% }%>
                </div>

                <div class="row">
                    <div class="input-field col s6 left">
                    <input type="text" id="email" name="email" value="<%:userList[0]["email"]%>" />
                    <label for="email">Email*</label>
                </div>
                <%if (Session["user_type"].ToString() != "1")
                    {%>
                <div class="input-field col s6 right">
                    <input type="text" id="phone" name="phone" value="<%:userList[0]["phone"]%>" />
                    <label for="phone">Phone*</label>
                </div>
                <%} %>
                </div>
                
                
               
                <%if (Session["user_type"].ToString() == "6")
                    {%>
                <div class="row">
                    <div class="input-field col s12">
                    <a href="<%= WebURL %>CandidateUpdate.aspx?id=<%:Session["user_ref_id"]%>" class="btn waves-light blue lighten-1 border-radius-5 right">Edit Full Profile</a>
                </div>
                </div>
                

                <%} %>
                <hr />
                <div class="row">
                    <div class="input-field col s6">
                    <input type="text" id="last_logged_in" name="last_logged_in" value="<%:userList[0]["last_logged_in"]%>" readonly/>
                    <label for="last_logged_in">Last Logged In</label>
                </div>
                <div class="input-field col s6">
                    <input type="text" id="ip_address" name="ip_address" value="<%:userList[0]["ip_address"]%>" readonly/>
                    <label for="ip_address">IP Address</label>
                </div>
                </div>
                
                


            </div>
        </div>
        <div class="row">
            <div class="input-field col s12 m12 l8 card white lighten-3 z-depth-3 padding-3 border-radius-5">
                <a id="btn-change-pwd" class="btn waves-effect waves-light blue lighten-1 border-radius-5 left">Change Password</a>
                <a id="btn-submit" class="btn waves-effect waves-light blue lighten-1 border-radius-5 right">Update</a>
                <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="" Style="display: none" />
            </div>
        </div>
    </form>
    <div id="frm_change_pwd" class="webui-popover-content">
        <form id="form_change_pwd" method="post">
            <div class="input-field">
                <input type="password" id="old_password" name="old_password" />
                <label for="old_password">Old Password</label>
            </div>
            <div class="input-field">
                <input type="password" id="new_password" name="new_password" />
                <label for="new_password">New Password</label>
            </div>
            <div class="input-field">
                <input type="password" id="re_new_password" name="re_new_password" />
                <label for="re_new_password">Re-enter New Password</label>
            </div>

            <div class="input-field">
                <a class="btn waves-effect waves-light blue lighten-1 right" id="btn_change_pwd">Change
                </a>
                <div id="preloader_form2" class="preloader-wrapper small active" style="display: none">
                    <div class="spinner-layer spinner-blue-only">
                        <div class="circle-clipper left">
                            <div class="circle"></div>
                        </div>
                        <div class="gap-patch">
                            <div class="circle"></div>
                        </div>
                        <div class="circle-clipper right">
                            <div class="circle"></div>
                        </div>
                    </div>
                </div>

            </div>

        </form>
    </div>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script>
        $(document).ready(function () {
            $(".datepicker").datepicker({ maxDate: '0' });
            $('#btn-change-pwd').webuiPopover({ url: '#frm_change_pwd', placement: 'right-top' });

            $.validator.setDefaults({
                ignore: []
            });

            function isNullOrWhitespace(input) {
                if (typeof input === 'undefined' || input == null)
                    return true;
                return /^\s+$/.test(input);
            }

            $.validator.addMethod("validateNullOrWhiteSpace", function (value, element) {
                return !isNullOrWhitespace(value);
            }, "Blank spaces not allowed!");

            $.validator.addMethod("regexMatch", function (value, element, regexp) {
                var regex = new RegExp(regexp);
                return this.optional(element) || regex.test(value);
            },
                "Not a valid input!"
            );

            $.validator.addMethod("valueNotEquals", function (value, element, arg) {
                return arg != value;
            }, "Required");

            $('#form_change_pwd').validate({
                // Specify validation rules
                rules: {
                    old_password: {
                        required: "Required*",
                        maxlength: 8,
                        minlength: 5,
                        validateNullOrWhiteSpace: true
                    },
                    new_password: {
                        required: "Required*",
                        maxlength: 8,
                        minlength: 5,
                        validateNullOrWhiteSpace: true
                    },
                    re_new_password: {
                        required: "Required*",
                        maxlength: 8,
                        minlength: 5,
                        validateNullOrWhiteSpace: true,
                        equalTo: "#new_password"
                    },
                },
                messages: {
                    old_password: {
                        required: "Required*",
                    },
                    new_password: {
                        required: "Required*",
                    },
                    re_new_password: {
                        required: "Required*",
                        equalTo: "Mismatch with new password."
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

            $('#<%=frm_userprofile.ClientID%>').validate({
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
                    dob: {
                        required: true,
                    },
                    gender: {
                        required: true,
                        valueNotEquals: "0",
                    },
                    address: {
                        required: true,
                        validateNullOrWhiteSpace: true,
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
                    dob: {
                        required: "Required*",
                    },
                    gender: {
                        required: "Please select a gender.",
                        valueNotEquals: "Please select a gender."
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



            $("#btn_change_pwd").click(function () {
                if ($('#form_change_pwd').valid()) {
                    var old_password = $("#old_password").val();
                    var new_password = $("#new_password").val();

                    $("#preloader_form1").attr("display", "inline");
                    $("#preloader_form1").show();
                    $.ajax({
                        type: "POST",
                        url: "WebService.asmx/ChangePassword",
                        data: "{ old_password: '" + old_password + "', new_password: '" + new_password + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: "true",
                        cache: "false",
                        success: function (data) {
                            $("#preloader_form2").attr("display", "none");
                            $("#preloader_form2").hide();
                            var ret = parseInt(data.d);
                            if (ret > 0) {
                                toastr.info('Password successfully changed!');
                                location.reload(true);
                            }                           
                            else if (ret == -2)
                                toastr.error('Account deactivated!');
                            else if (ret==0 || ret==-1){
                                toastr.error('Wrong Password!');
                                //location.reload(true);
                            }
                            else
                                toastr.error('Database Error!');
                        },
                        Error: function (error) {
                            toastr.error("Unable to complete your request.");
                        }
                    });
                };
            });

            $('#btn-submit').click(function () {
                if ($('#<%=frm_userprofile.ClientID%>').valid()) {
                    $('#<%:btnSubmit.ClientID%>').click();
                }
                
            });
        });
    </script>

</asp:Content>

