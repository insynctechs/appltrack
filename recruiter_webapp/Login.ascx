<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Login.ascx.cs" Inherits="recruiter_webapp.Login" %>
<header>
    <script>
        $(document).ready(function () {
            $('#form_login').validate({
                // Specify validation rules
                rules: {
                    username: "required",
                    password: "required",
                },
                messages: {
                    username: {
                        required: "Required*",
                    },
                    password: {
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

            $("#btn_login").click(function () {
                if ($('#form_login').valid()) {
                    var username = $("#username").val();
                    var password = $("#password").val();
                    $("#preloader_form1").attr("display", "inline");
                    $("#preloader_form1").show();
                    $.ajax({
                        type: "POST",
                        url: "WebService.asmx/ValidateUser",
                        data: "{ username: '" + username + "', password: '" + password + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: "true",
                        cache: "false",
                        success: function (data) {
                            $("#preloader_form1").attr("display", "none");
                            $("#preloader_form1").hide();
                            var ret = parseInt(data.d);
                            if (ret > 0) {
                                location.reload(true);
                            }                           
                            else if (ret == -2)
                                toastr.error('Account deactivated!');
                            else if (ret==0 || ret==-1){
                                toastr.error('Invalid credentials!');
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
        });
    </script>
</header>
<div id="login-form" class="webui-popover-content">
    <form id="form_login" method="post">
        <div class="input-field">
            <input type="text" id="username" name="username" />
            <label for="username">Username</label>
        </div>
        <div class="input-field">
            <input type="password" id="password" name="password" />
            <label for="password">Password</label>
        </div>

        <div class="input-field">
            <a class="btn waves-effect waves-light blue lighten-1 right" id="btn_login">Login
            </a>
            <div id="preloader_form1" class="preloader-wrapper small active" style="display: none">
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
