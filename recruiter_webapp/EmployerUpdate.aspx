<%@ Page Title="Setup Employer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerUpdate.aspx.cs" Inherits="recruiter_webapp.EmployerUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div id="msform" class="row">
            <!-- Progressbar -->
            <ul id="progressbar">
                <li class="active">Add Employer</li>
                <li>Add Location</li>
                <li>Add Admin</li>
                <li>Finish</li>
            </ul>
            <!-- Fieldsets -->

            <!-- FORM 1 - ADD EMPLOYER -->
            <form class="form" id="employer_form">
                <input type="hidden" id="steps" value="<%if (formDataList != null) { if (formDataList[0]["progress"] != null) {%><%=formDataList[0]["progress"]%><%} } %>" />
                <p class="fs-title">Add Employer</p>
                <p class="fs-subtitle">Enter details of your client.</p>
                <div class="col s12">

                    <input type="hidden" id="employer_id" value="<%if (formDataList != null) { if (formDataList[0]["employer_id"] != null) {%><%=formDataList[0]["employer_id"]%><%} } %>" />
                    <div class="col s12 input-field">
                        <input type="text" id="employer_name" name="employer_name" value="<%if (formDataList != null) { if (formDataList[0]["employer_name"] != null) {%><%=formDataList[0]["employer_name"]%><%} } %>"/>
                        <label class="input-label" for="employer_name">Name</label>
                    </div>
                    <div class="col s12 input-field">
                        <input type="text" id="employer_address" name="employer_address" />
                        <label class="input-label" for="employer_address">Address</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_city" name="employer_city" />
                        <label class="input-label" for="employer_city">City</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_state" name="employer_state" />
                        <label class="input-label" for="employer_state">State</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_zip" name="employer_zip" />
                        <label class="input-label" for="employer_zip">Zip</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_email" name="employer_email" />
                        <label class="input-label" for="employer_email">Email</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_phone" name="employer_phone" />
                        <label class="input-label" for="employer_phone">Phone</label>
                    </div>
                    <div class="col s6 input-field">
                        <label class="input-checkbox">
                            <input type="checkbox" id="employer_active" class="filled-in blue lighten-3" checked="checked" />
                            <span>Active</span>
                        </label>
                    </div>
                </div>

                <input type="button" id="btn_next_form1" name="next" value="Next" class="next action-button right" />
                <div id="preloader_form1" class="preloader-wrapper small active right" style="display: none; margin-right: 10px; margin-top: 10px">
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

            </form>

            <!-- FORM 2 - ADD EMPLOYER LOCATION -->
            <form class="form" id="employer_loc_form">

                <p id="title_location" class="fs-title"></p>
                <p class="fs-subtitle">Enter client branch details.</p>
                <div class="col s12">
                    <input type="hidden" id="employer_loc_id" value="<%if (formDataList != null) { if (formDataList[0]["employer_loc_id"] != null) {%><%=formDataList[0]["employer_loc_id"]%><%} } %>"/>

                    <div class="col s12 input-field">
                        <input type="text" id="employer_loc_address" name="employer_loc_address" />
                        <label class="input-label" for="employer_loc_address">Address</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_city" name="employer_loc_city" />
                        <label class="input-label" for="employer_loc_city">City</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_zip" name="employer_loc_zip" />
                        <label class="input-label" for="employer_loc_zip">P.O.Box</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_country" name="employer_loc_country" />
                        <label class="input-label" for="employer_loc_country">Country</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_email" name="employer_loc_email" />
                        <label class="input-label" for="employer_loc_email">Email</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_loc_phone" name="employer_loc_phone" />
                        <label class="input-label" for="employer_loc_phone">Phone</label>
                    </div>
                    <div class="col s2 input-field">
                        <label class="input-checkbox">
                            <input type="checkbox" id="employer_loc_active" class="filled-in blue lighten-3" checked="checked" />
                            <span>Active</span>
                        </label>
                    </div>
                </div>
                <input type="button" id="btn_next_form2" name="next" class="next action-button right" value="Next" />
                <input type="button" id="btn_skip_form2" class="skip action-button right" value="Skip" />
            </form>
            <!-- FORM 3 - ADD EMPLOYER ADMIN -->
            <form class="form" id="employer_admin_form">

                <p id="title_admin" class="fs-title"></p>
                <p class="fs-subtitle">Enter details of your client's administrator.</p>
                <div class="col s12">
                    <input type="hidden" id="employer_admin_id" />
                    <div class="col s12 input-field">
                        <input type="text" id="employer_admin_name" name="employer_admin_name" />
                        <label class="input-label" for="employer_admin_name">Name</label>
                    </div>

                    <div class="col s6 input-field">
                        <input type="text" id="employer_admin_designation" name="employer_admin_designation" />
                        <label class="input-label" for="employer_admin_designation">Designation</label>
                    </div>

                    <div class="col s6 input-field">
                        <select id="employer_admin_gender" name="employer_admin_gender">
                            <option value="" disabled selected>Choose Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="col s12 input-field">
                        <input type="text" id="employer_admin_address" name="employer_admin_address" />
                        <label class="input-label" for="employer_admin_address">Address</label>
                    </div>

                    <div class="col s6 input-field">
                        <input type="text" id="employer_admin_email" name="employer_admin_email" />
                        <label class="input-label" for="employer_admin_email">Email</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="employer_admin_phone" name="employer_admin_phone" />
                        <label class="input-label" for="employer_admin_phone">Phone</label>
                    </div>

                    <div class="col s6 input-field">
                        <label class="input-checkbox">
                            <input type="checkbox" id="employer_admin_active" class="filled-in blue lighten-3" checked />
                            <span>Active</span>
                        </label>
                        <input type="hidden" id="e" />
                    </div>
                    <div class="col s6 input-field">
                        <label class="input-checkbox">
                            <input type="checkbox" id="employer_admin_notification" class="filled-in blue lighten-3" />
                            <span>Send Notification</span>
                        </label>
                    </div>
                </div>
                <input type="button" id="btn_next_form3" name="next" class="next action-button right" value="Next" />

            </form>
            <form id="result_form">

                <p class="fs-title">Finished</p>
                <p class="fs-subtitle">You have successfully setup your client.</p>
                <a href="<%= WebURL %>Employer.aspx">Go to Employers Listing</a>

            </form>
        </div>
    </div>


    <!-- jQuery
    <script src="http://thecodeplayer.com/uploads/js/jquery-1.9.1.min.js" type="text/javascript"></script>  -->
    <!-- jQuery easing plugin -->
    <script src="http://thecodeplayer.com/uploads/js/jquery.easing.min.js" type="text/javascript"></script>



    <style>
        /*basic reset
        * {
            margin: 0;
            padding: 0;
        }
        */

        body {
            height: 100%;
        }
        /*    Image only BG fallback
        background: url('http://thecodeplayer.com/uploads/media/gs.png');
        /*background = gradient + image pattern combo
        background: linear-gradient(rgba(196, 102, 0, 0.2), rgba(155, 89, 182, 0.2)), url('http://thecodeplayer.com/uploads/media/gs.png');
        }
       
        body {
            color: rgba(0, 0, 0, .87);
        }
        /*form styles*/

        #msform {
            width: 100%;
            /* margin: 50px auto;*/
            margin-bottom: 50px;
            text-align: center;
            position: relative;
        }

            #msform form {
                background: #fff;
                border: 0 none;
                border-radius: 5px;
                box-shadow: 0 0 25px 1px rgba(0, 0, 0, 0.4);
                padding: 20px 30px;
                box-sizing: border-box;
                width: 80%;
                margin: 0 10%;
                /*stacking fieldsets above each other*/
                position: absolute;
            }
                /*Hide all except first fieldset*/
                #msform form:not(:first-of-type) {
                    display: none;
                }
            /*inputs*/

            #msform input, #msform textarea {
                /*padding: 5px;*/
                padding-left: 5px;
                border: 1px solid #ccc;
                border-radius: 3px;
                margin-bottom: 5px;
                margin-top: 3px;
                width: 100%;
                box-sizing: border-box;
                color: #2C3E50;
                font-size: 15px;
            }

        .input-field {
            margin: 4px 0px;
        }

        .input-label {
            margin-left: 10px;
        }

        .input-checkbox {
            margin-left: 10px;
        }

        [type="checkbox"].filled-in:checked + span:not(.lever):after {
            border: 2px solid #42a5f5;
            background-color: #42a5f5;
        }
        /*buttons*/
        #msform .action-button {
            width: 100px;
            background: #42a5f5;
            color: white;
            border: 0 none;
            border-radius: 3px;
            cursor: pointer;
            padding: 10px 5px;
            margin: 10px 5px;
        }

            #msform .action-button:hover, #msform .action-button:focus {
                box-shadow: 0 0 0 2px white, 0 0 0 3px #27AE60;
            }
        /*headings*/
        .fs-title {
            font-size: 18px;
            /*text-transform: capitalize;*/
            color: #2C3E50;
            margin-bottom: 5px;
        }

        .fs-subtitle {
            font-weight: normal;
            font-size: 15px;
            color: #666;
            margin-top: 0px;
            margin-bottom: 10px;
        }
        /*progressbar*/
        #progressbar {
            margin-bottom: 30px;
            overflow: hidden;
            /*CSS counters to number the steps*/
            counter-reset: step;
        }

            #progressbar li {
                list-style-type: none;
                color: #42a5f5;
                text-transform: uppercase;
                font-size: 12px;
                font-weight: bold;
                width: 25%;
                float: left;
                position: relative;
            }

                #progressbar li:before {
                    width: 30px;
                    height: 30px;
                    content: counter(step);
                    counter-increment: step;
                    line-height: 30px;
                    border: 2px solid #e0e0e0;
                    display: block;
                    text-align: center;
                    margin: 0 auto 10px auto;
                    border-radius: 50%;
                    background-color: white;
                }
                /*progressbar connectors*/
                #progressbar li:after {
                    width: 100%;
                    height: 3px;
                    content: '';
                    position: absolute;
                    background-color: #e0e0e0;
                    top: 15px;
                    left: -50%;
                    z-index: -1;
                }

                #progressbar li:first-child:after {
                    /*connector not needed before the first step*/
                    content: none;
                }
                /*marking active/completed steps green*/
                /*The number of the step and the connector before it = green*/
                #progressbar li.active:before, #progressbar li.active:after {
                    background: #42a5f5;
                    color: white;
                }
    </style>

    <script>

        $(document).ready(function () {
            if ($('#steps').val() == '1') {
                next($("#btn_next_form1"));
            }
            // for progress upto admin addition
            else if ($('#steps').val() == '2') {
                $('#employer_form').hide();
                $("#progressbar li").eq($(".form").index(next_fs)).addClass("active");
                next($("#btn_next_form2"));
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

            $("#employer_form").validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },
                // Specify validation rules
                rules: {
                    employer_name: "required",
                    employer_address: "required",
                    employer_city: "required",
                    employer_state: "required",
                    employer_zip: {
                        required: true,
                        digits: true,
                        minlength: 5,
                        maxlength: 10,
                    },
                    employer_email: {
                        required: true,
                        regexMatch: "^([a-z0-9\\\\.-]+)@([a-z0-9-]+).([a-z]{2,8})(.[a-z]{2,8})$"
                    },
                    employer_phone: {
                        required: true,
                        regexMatch: "^[0-9+()\/-]{5,20}$"
                    },
                },
                messages: {
                    employer_name: {
                        required: "Required*",
                    },
                    employer_address: {
                        required: "Required*",
                    },
                    employer_city: {
                        required: "Required*",
                    },
                    employer_state: {
                        required: "Required*",
                    },
                    employer_zip: {
                        required: "Required*",
                        digits: "Please enter valid zip",
                        minlength: "Please enter valid zip",
                        maxlength: "Please enter valid zip",
                    },
                    employer_phone: {
                        required: "Required*",
                        regexMatch: "Please enter valid phone number",
                    },
                    employer_email: {
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

            $("#employer_loc_form").validate({
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
                        digits: "Please enter valid P.O Box Number",
                        minlength: "Please enter valid P.O Box Number",
                        maxlength: "Please enter valid P.O Box Number",
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

            $("#employer_admin_form").validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },
                // Specify validation rules
                rules: {
                    employer_admin_name: "required",
                    employer_admin_address: "required",
                    employer_admin_designation: "required",
                    employer_admin_gender: {
                        required: true
                    },
                    employer_admin_email: {
                        required: true,
                        regexMatch: "^([a-z0-9\\\\.-]+)@([a-z0-9-]+).([a-z]{2,8})(.[a-z]{2,8})$"
                    },
                    employer_admin_phone: {
                        required: true,
                        regexMatch: "^[0-9+()\/-]{5,20}$"
                    },
                },
                messages: {
                    employer_admin_name: {
                        required: "Required*",
                    },
                    employer_admin_address: {
                        required: "Required*",
                    },
                    employer_admin_designation: {
                        required: "Required*",
                    },
                    employer_gender_address: {
                        required: "Required*",
                    },
                    employer_admin_gender: {
                       required: "Please select a Gender."
                    },
                    employer_admin_phone: {
                        required: "Required*",
                        regexMatch: "Please enter valid phone number",
                    },
                    employer_admin_email: {
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




            
            $("#btn_next_form1").click(function () {
                if ($("#employer_form").valid()) {
                    var name = $('#employer_name').val();
                    var address = $('#employer_address').val();
                    var city = $('#employer_city').val();
                    var state = $('#employer_state').val();
                    var zip = $('#employer_zip').val();
                    var email = $('#employer_email').val();
                    var phone = $('#employer_phone').val();
                    var active;
                    if ($('#employer_active').prop('checked')) {
                        active = 1;
                    }
                    else {
                        active = 0;
                    }
                    var datastring = JSON.stringify({ 'name': name, 'address': address, 'city': city, 'state': state, 'zip': zip, 'email': email, 'phone': phone, 'active': active });
                    $("#preloader_form1").attr("display", "inline");
                    $("#preloader_form1").show();
                    $.ajax({
                        url: 'EmployerUpdate.aspx/InsertEmployer',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                            $("#preloader_form1").attr("display", "none");
                            $("#preloader_form1").hide();
                            var ret = parseInt(data.d);
                            if (ret > 0) {
                                $('#employer_id').val(ret);
                                $('#title_location').html("Add location for " + name);
                                next($("#btn_next_form1"));
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

            $("#btn_next_form2").click(function () {
                if ($("#employer_loc_form").valid()) {
                    var employer_id = $('#employer_id').val();
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
                    var datastring = JSON.stringify({ 'employer_id': employer_id, 'address': address, 'city': city, 'zip': zip, 'email': email, 'phone': phone, 'country': country, 'active': active });
                    $.ajax({
                        url: 'EmployerUpdate.aspx/InsertEmployerLocation',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                            var ret = parseInt(data.d);
                            if (ret > 0) {
                                $('#employer_loc_id').val(ret);
                                $('#title_admin').html("Add Administrator for " + $('#employer_name').val());
                                next($("#btn_next_form2"));
                            }
                            else {
                                toastr.error('Record already exists!');
                            }
                        },
                        error: function (error) {
                            toastr.error("Database error! Unable to complete process.");
                        }
                    });
                }
            });

            $("#btn_skip_form2").click(function () {
                $('#employer_loc_id').val('0');
                $('#title_admin').html("Add Administrator for " + $('#employer_name').val());
                next($("#btn_next_form2"));
            });


            $("#btn_next_form3").click(function () {
                if ($("#employer_admin_form").valid()) {
                    var employer_id = $('#employer_id').val();
                    var employer_location_id = $('#employer_loc_id').val();
                    var name = $('#employer_admin_name').val();
                    var gender = $('#employer_admin_gender').val();
                    var designation = $('#employer_admin_designation').val();
                    var address = $('#employer_admin_address').val();
                    var email = $('#employer_admin_email').val();
                    var phone = $('#employer_admin_phone').val();
                    var active;
                    var notification;
                    if ($('#employer_admin_active').prop('checked')) {
                        active = 1;
                    }
                    else {
                        active = 0;
                    }
                    if ($('#employer_admin_notification').prop('checked')) {
                        notification = 1;
                    }
                    else {
                        notification = 0;
                    }

                    var datastring = JSON.stringify({ 'employer_id': employer_id, 'employer_location_id': employer_location_id, 'name': name, 'gender': gender, 'designation': designation, 'address': address, 'phone': phone, 'email': email, 'active': active, 'notification': notification, 'user_type': 4 });
                    $.ajax({
                        url: 'EmployerUpdate.aspx/InsertEmployerAdmin',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                            var ret = parseInt(data.d);
                            if (ret > 0) {
                                next($("#btn_next_form3"));
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



        var current_fs, next_fs, previous_fs; //fieldsets
        var left, opacity, scale; //fieldset properties which we will animate
        var animating; //flag to prevent quick multi-click glitches

        function next(btn_next) {
            if (animating) return false;
            animating = true;

            current_fs = $(btn_next).parent();
            
            next_fs = $(btn_next).parent().next();

            //activate next step on progressbar using the index of next_fs
            $("#progressbar li").eq($(".form").index(next_fs)).addClass("active");

            //show the next fieldset
            next_fs.show();
            //hide the current fieldset with style
            current_fs.animate({ opacity: 0 }, {
                step: function (now, mx) {
                    //as the opacity of current_fs reduces to 0 - stored in "now"
                    //1. scale current_fs down to 80%
                    scale = 1 - (1 - now) * 0.2;
                    //2. bring next_fs from the right(50%)
                    left = (now * 50) + "%";
                    //3. increase opacity of next_fs to 1 as it moves in
                    opacity = 1 - now;
                    current_fs.css({ 'transform': 'scale(' + scale + ')' });
                    next_fs.css({ 'left': left, 'opacity': opacity });
                },
                duration: 800,
                complete: function () {
                    current_fs.hide();
                    animating = false;
                },
                //this comes from the custom easing plugin
                easing: 'easeInOutBack'
            });
        };

        $(".previous").click(function () {
            if (animating) return false;
            animating = true;

            current_fs = $(this).parent();
            previous_fs = $(this).parent().prev();

            //de-activate current step on progressbar
            $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

            //show the previous fieldset
            previous_fs.show();
            //hide the current fieldset with style
            current_fs.animate({ opacity: 0 }, {
                step: function (now, mx) {
                    //as the opacity of current_fs reduces to 0 - stored in "now"
                    //1. scale previous_fs from 80% to 100%
                    scale = 0.8 + (1 - now) * 0.2;
                    //2. take current_fs to the right(50%) - from 0%
                    left = ((1 - now) * 50) + "%";
                    //3. increase opacity of previous_fs to 1 as it moves in
                    opacity = 1 - now;
                    current_fs.css({ 'left': left });
                    previous_fs.css({ 'transform': 'scale(' + scale + ')', 'opacity': opacity });
                },
                duration: 800,
                complete: function () {
                    current_fs.hide();
                    animating = false;
                },
                //this comes from the custom easing plugin
                easing: 'easeInOutBack'
            });
        });


    </script>
    <script src="/Scripts/materialize_inits.js"></script>

</asp:Content>
