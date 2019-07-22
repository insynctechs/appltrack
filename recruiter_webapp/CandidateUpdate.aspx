<%@ Page Language="C#" Title="Candidate" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CandidateUpdate.aspx.cs" Inherits="recruiter_webapp.CandidateUpdate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_job" runat="server">
        <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">
                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>

        </div>
        <div class="row no-padding">
            <div class="col s12 m8 l8 card blue-grey lighten-4 z-depth-0 border-radius-5 no-margin padding-1">
                <% if (string.IsNullOrEmpty(Request.QueryString["id"]))

                    { %>
                <h6>Add Candidate</h6>
                <%}
                    else
                    { %>
                <h6>Edit Candidate <%if (candidateList.Count > 0)
                                       {%><%:candidateList[0]["name"]%><%}%></h6>
                <%}%>
            </div>
        </div>


        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        <div class="row">
            <div class="input-field col s12 m12 l8 card white lighten-3 z-depth-3 padding-2 border-radius-5">
                <div class="col s12">
                    <input type="hidden" id="id" name="id" value="<%if (candidateList.Count > 0)
                        {%><%:candidateList[0]["id"]%><%}%>" />

                    <div class="row">
                        <div class="col s8 input-field">
                            <input type="text" id="name" name="name" value="<%if (candidateList.Count > 0)
                                {%><%:candidateList[0]["name"]%><%}%>" />
                            <label class="input-label" for="name">Name*</label>
                        </div>

                        <div class="col s4 input-field right">
                            <input type="file" class="dropify" id="profile_picture" name="profile_picture" runat="server" data-height="150" />
                        </div>

                        <div class="col s4 input-field">

                            <input type="text" class="datepicker" id="dob" name="dob" value="<%if (candidateList.Count > 0)
                                {%><%:candidateList[0]["dob"]%><%}%>" />
                            <label class="input-label" for="dob">Date of Birth*</label>
                        </div>

                        <div class="col s4 input-field">
                            <select id="gender" name="gender">
                                <option value="" disabled selected>Choose Gender</option>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                                <option value="other">Other</option>
                            </select>
                            <label class="input-label" for="gender">Gender*</label>
                        </div>


                    </div>

                    <div class="row">
                        <div class="col s12 input-field left">
                            <textarea id="address" name="address"><%if (candidateList.Count > 0)
                                                                      {%><%:candidateList[0]["address"]%><%}%></textarea>
                            <label class="input-label" for="qualifications">Address*</label>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col s8 input-field">
                            <input type="text" id="candidate_skills" name="candidate_skills" value="<%if (candidateList.Count > 0)
                                {%><%:candidateList[0]["skills"]%><%}%>" />
                            <label class="input-label" for="job_skills">Key Skills*</label>
                        </div>
                        <input type="text" id="skills" name="skills" hidden />
                        <div class="col s6 input-field" id="div-skills"></div>
                    </div>




                    <div class="row" id="div-qualification">
                        <div class="col s12 input-field">
                            <p>Qualifcations</p>
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        <asp:Button ID="Button1" CssClass="btn waves-effect waves-light blue lighten-1" Text="Add" style="display: none" runat="server"></asp:Button>
                            <a href="javascript:function() { return false; }" id="a-qualification-add" class="right">+ Add Qualification</a>
                        <!-- USING ASP AJAX TOOLKIT-->
                        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="Button1"
                            CancelControlID="Button2" BackgroundCssClass="Background">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
                            <iframe id="irm1" src="CandidateQualification.aspx" runat="server" style="width: 350px; height: 300px;"></iframe>
                            <br />
                            <asp:Button CssClass="btn waves-effect waves-light blue lighten-1" ID="Button2" runat="server" Text="Close" />
                        </asp:Panel>
                        </div>
                                                      
                        <!-- USING JQUERY -->
                        <%--
                        <a href="javascript:function() { return false; }" class="right" id="btn-qualification-add">Add Qualification</a>
                    --%>
                            </div>










                    <div class="row">
                        <div class="col s2 input-field left">
                            <input type="number" id="experience" name="experience" class="number" min="0" value="<%if (candidateList.Count > 0)
                                {%><%:candidateList[0]["experience"]%><%}%>" />
                            <label class="input-label" for="experience">Experience*</label>
                        </div>

                        <div class="col s10 input-field right">
                            <textarea id="others" name="others"><%if (candidateList.Count > 0)
                                                                    {%><%:candidateList[0]["others"]%><%}%></textarea>
                            <label class="input-label" for="others">Other Notes</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col s8 input-field">
                            <div class="file-field input-field">
                            <div class="btn-small waves-effect waves-light blue lighten-1">
                                <span>Add Resume</span>
                                <input type="file">
                            </div>
                            <div class="file-path-wrapper">
                                <input class="file-path validate" />
                            </div>
                        </div>

                        </div>
                        
                    </div>


                    <%if (Convert.ToInt32(Session["user_type"].ToString()) < 6)
                        { %>
                    <div class="row">
                        <div class="col s12 input-field switch left">
                            <label>
                                Active<input type="checkbox" id="active" name="active" class="filled-in blue lighten-3" <%= (candidateList.Count > 0) ? (candidateList[0]["active"] == null) ? "checked" : (candidateList[0]["active"].ToString() == "1") ? "checked" : "" : "checked" %> />
                                <span class="lever"></span>
                            </label>
                        </div>
                    </div>
                    <%} %>




                    <div class="col s12 input-field right">
                        <a id="btn-check" class="btn waves-effect waves-light blue lighten-1 right">Check</a>
                        <a id="btn-submit" class="btn waves-effect waves-light blue lighten-1 right">Submit</a>
                        <asp:Button Style="display: none" ID="btn_submit" CssClass="btn waves-effect waves-light blue lighten-1 right" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                    </div>

                </div>
            </div>
        </div>
    </form>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="/Scripts/dropify.min.js"></script>
    <link rel="stylesheet" href="Styles/dropify.min.css">
    <style>
        .input-label {
            margin-left: 10px;
        }
    </style>
    <style type="text/css">
        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 400px;
            height: 350px;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('.datepicker').datepicker();


            $('.dropify').dropify({
                messages: {
                    'default': 'Drag and drop or click to Upload Profile Picture',
                    'replace': 'Drag and drop or click to replace',
                    'remove': 'Remove',
                    'error': 'File doesnot meet specifications.'
                }
            });

            $('.close').click(function () {
                var closebtns = $(".qualification").get();
                alert(closebtns);
            });

            var arrSkills = [];
            var arrQualifications = [];
            $("#slider-range").slider({
                step: 100
            });

            $('#a-qualification-add').click(function () {
                $('#<%=Button1.ClientID%>').click();
            });


            /*
            var formCount = 0;
            
            $('#btn-qualification-add').click(function () {
                formCount += 1;
                var $Qfrm = $('<div />', { id: 'div-Qfrm' + formCount }),
                    divQual = $('<div />', { id: 'div-Qfrm' + formCount }),
                    lblqualification = $('<label />', { text: 'Qualification' }),
                    qualification = $('<input />', { id: 'qualification' + formCount, name: 'qualification' + formCount, type: 'text' }),
                    
                    institute = $('<input />', { id: 'institute' + formCount, name: 'institute' + formCount, type: 'text' }),
                    year = $('<input />', { id: 'year'+ formCount, name: 'year'+ formCount, type: 'number' }),
                    percentage = $('<input />', { id: 'percentage'+ formCount, name: 'percentage'+ formCount, type: 'number' }),
                    button = $('<a />', { id: 'btn-save-form'+ formCount });

                $Qfrm.append(lblqualification, qualification, institute, year, percentage, $('<br />'), button).appendTo($('#div-qualification'));
            });
            */
            $('#btn-check').click(function () {
                alert($('#qualification1').val());
            });

            $("#slider-range").slider({
                range: true,
                min: 0,
                max: 200000,
                values: [10000, 20000],
                slide: function (event, ui) {
                    $('#min_salary').val(ui.values[0]);
                    $('#max_salary').val(ui.values[1]);
                }
            });
            $('#min_salary').val($("#slider-range").slider("values", 0));
            $('#max_salary').val($("#slider-range").slider("values", 1));

            $("#slider-range2").slider({
                range: true,
                min: 0,
                max: 30,
                values: [0, 3],
                slide: function (event, ui) {
                    $('#min_experience').val(ui.values[0]);
                    $('#max_experience').val(ui.values[1]);
                }
            });
            $('#min_experience').val($("#slider-range2").slider("values", 0));
            $('#max_experience').val($("#slider-range2").slider("values", 1));



            $("#job_skills").autocomplete({
                source: function (request, response) {
                    var param = { searchValue: $('#job_skills').val() };
                    $.ajax({
                        url: "JobUpdate.aspx/GetSkillList",
                        data: JSON.stringify(param),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {

                            response($.parseJSON(data.d));
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(err.Message)
                            // console.log("Ajax Error!");  
                        }
                    });
                },
                minLength: 2, //This is the Char length of inputTextBox
                select: function (event, ui) {
                    var divs = $(".skill").get();
                    for (var i = 0; i < divs.length; i++) {
                        if (divs[i].getAttribute('id') == ui.item.id) {
                            $('#job_skills').val("");
                            return false;
                        }
                    }
                    $("#div-skills").append('<div class="skill chip" id = "' + ui.item.id + '">' + ui.item.value + '<i class="close material-icons">close</i></div>');
                    arrSkills.push(ui.item.id);
                    $('#job_skills').val("");
                    return false;
                }

            });

            $("#job_qualifications").autocomplete({
                source: function (request, response) {
                    var param = { searchValue: $('#job_qualifications').val() };
                    $.ajax({
                        url: "JobUpdate.aspx/GetQualificationList",
                        data: JSON.stringify(param),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {

                            response($.parseJSON(data.d));
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(err.Message)
                            // console.log("Ajax Error!");  
                        }
                    });
                },
                minLength: 2, //This is the Char length of inputTextBox
                select: function (event, ui) {
                    var divs = $(".qualification").get();

                    for (var i = 0; i < divs.length; i++) {
                        if (divs[i].getAttribute('id') == ui.item.id) {
                            $('#job_qualifications').val("");
                            return false;
                        }
                    }
                    $("#div-qualifications").append('<div class="qualification chip" id="' + ui.item.id + '">' + ui.item.value + '<i class="close material-icons">close</i></div>');
                    arrQualifications.push(ui.item.id);
                    console.log($(".qualification").get());
                    $('#job_qualifications').val("");
                    return false;
                }
            });

            // Validation specific codes
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

            $('#<%=frm_job.ClientID%>').validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },
                rules: {
                    job_code: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    location_id: {
                        required: true,
                    },
                    description: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    vacancy_count: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([0-9]{1,2})$"
                    },
                    currency: {
                        required: true,
                    },

                    min_salary: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([0-9]{1,6})$"
                    },

                    max_salary: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([0-9]{1,6})$"
                    },

                    other_notes: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },

                    min_experience: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([0-9]{1,2})$"
                    },

                    max_experience: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([0-9]{1,2})$"
                    },

                },
                messages: {
                    job_code: {
                        required: "Required*",
                    },
                    location_id: {
                        required: "Required*",
                    },
                    description: {
                        required: "Required*",
                    },
                    vacancy_count: {
                        required: "Required*",
                    },
                    currency: {
                        required: "Required*",
                    },
                    min_salary: {
                        required: "Required*",
                        regexMatch: "Please enter a valid salary",
                    },
                    max_salary: {
                        required: "Required*",
                        regexMatch: "Please enter a valid salary",
                    },
                    min_experience: {
                        required: "Required*",
                        regexMatch: "Please enter valid no. of years",
                    },
                    max_experience: {
                        required: "Required*",
                        regexMatch: "Please enter valid no. of years",
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
                if ($('#<%=frm_job.ClientID%>').valid()) {
                    $('#skills').val(arrSkills);
                    $('#qualifications').val(arrQualifications);
                    document.getElementById('<%= btn_submit.ClientID %>').click();
                }

            });

        });


    </script>

</asp:Content>

