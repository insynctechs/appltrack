<%@ Page Language="C#" Title="Job" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JobUpdate.aspx.cs" Inherits="recruiter_webapp.JobUpdate" %>

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
                <h6>Add Job <%if (jobList.Count > 0)
                                {%><%:jobList[0]["job_code"]%><%}%></h6>
                <%}
                    else
                    { %>
                <h6>Edit Job - <%if (jobList.Count > 0)
                                   {%><%:jobList[0]["job_code"]%><%}%></h6>
                <%}%>
            </div>
        </div>


        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        <div class="row">
            <div class="input-field col s12 m12 l8 card white lighten-3 z-depth-3 padding-2 border-radius-5">
                <div class="col s12">
                    <input type="hidden" id="id" name="id" value="<%if (jobList.Count > 0)
                        {%><%:jobList[0]["id"]%><%}%>" />
                    <%--<input type="hidden" id="employer_id" name="employer_id" value="<%=(Request.QueryString["employer_id"]!=null)? Request.QueryString["employer_id"] : ""%><% if (jobList.Count > 0)
                        {%><%:jobList[0]["employer_id"]%><%}%>" /> --%>

                    <div class="row">


                        <div class="col s4 input-field">
                            <select id="employer_id" name="employer_id">
                                <%if (Request.QueryString["id"] == null || Request.QueryString["employer_id"] == null)
                                    { %>
                                <option value="" disabled selected>Choose Employer*</option>
                                <%} %>
                                <%foreach (var employer in employerList)
                                    {%>
                                <option value="<%=employer["id"] %>" <%if (jobList.Count > 0)
                                    {%><%:(jobList[0]["employer_id"].ToString()==employer["id"].ToString())?"selected":""%><%}%>
                                    <%if (Request.QueryString["employer_id"] != null)
                                    {%><%:(Request.QueryString["employer_id"].ToString()==employer["id"].ToString())?"selected":""%><%}%>><%=employer["name"] %></option>
                                <%} %>
                            </select>
                            <label class="input-label" for="employer_id">Employer*</label>
                        </div>

                        <div class="col s8 input-field">
                            <input type="text" id="job_code" name="job_code" value="<%if (jobList.Count > 0)
                                {%><%:jobList[0]["job_code"]%><%}%>" />
                            <label class="input-label" for="job_code">Job Code*</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s6 input-field">
                            <select id="industry" name="industry">
                                <%if (Request.QueryString["id"] == null)
                                    { %>
                                <option value="" disabled selected>Choose Industry*</option>
                                <%} %>
                                <%foreach (var industry in industryList)
                                    {%>
                                <option value="<%=industry["id"] %>" <%if (jobList.Count > 0)
                                    {%><%:(jobList[0]["industry"].ToString()==industry["id"].ToString())?"selected":""%><%}%>><%=industry["title"] %></option>
                                <%} %>
                            </select>
                            <label class="input-label" for="industry">Industry*</label>
                        </div>
                        <div class="col s6 input-field">
                            <select id="category" name="category">
                                <%if (Request.QueryString["id"] == null)
                                    { %>
                                <option value="" disabled selected>Choose Category*</option>
                                <%} %>

                                <%foreach (var category in categoryList)
                                    {%>
                                <option value="<%=category["id"] %>" <%if (jobList.Count > 0)
                                    {%><%:(jobList[0]["category"].ToString()==category["id"].ToString())?"selected":""%><%}%>><%=category["title"] %></option>
                                <%} %>
                            </select>
                            <label class="input-label" for="category">Category*</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 input-field">
                            <input type="text" id="description" name="description" value="<%if (jobList.Count > 0)
                                {%><%:jobList[0]["description"]%><%}%>" />
                            <label class="input-label" for="description">Description*</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col s8 input-field">
                            <select id="location_id" name="location_id" <%:!(employerLocationList.Count > 0)?"disabled":""%>>
                                <%if (Request.QueryString["id"] == null)
                                    { %>
                                <option value="" disabled selected>Choose Location*</option>
                                <%} %>
                                <%foreach (var loc in employerLocationList)
                                    {%>
                                <option value="<%=loc["employer_loc_id"] %>"
                                    <%if (jobList.Count > 0)
                                    {%><%:(jobList[0]["location_id"].ToString()==loc["employer_loc_id"].ToString())?"selected":""%><%}%>><%=loc["employer_loc_address"] %></option>
                                <%} %>
                            </select>
                            <label class="input-label" for="location_id">Location*</label>
                        </div>
                        <div class="col s4 input-field">
                            <input type="number" id="vacancy_count" name="vacancy_count" class="number" min="0" value="<%if (jobList.Count > 0)
                                {%><%:jobList[0]["vacancy_count"]%><%}%>" />
                            <label class="input-label" for="vacancy_count">Vacancy*</label>
                        </div>
                    </div>





                    <div class="row">
                        <div class="col s8" id="div-salary">
                            <p class="">Salary*</p>
                            <div class="col s10 input-field" id="slider-range"></div>
                            <div class="col s10">
                                <div class="col s4 input-field">
                                    <input type="text" id="min_salary" name="min_salary" value="<%if (jobList.Count > 0)
                                        {%><%:jobList[0]["min_sal"]%><%}
                                        else
                                        {%><%:0 %><%} %>" />
                                    <label class="input-label" for="min-salary">Min*</label>
                                </div>
                                <div class="col s4 right input-field">
                                    <input type="text" id="max_salary" name="max_salary" value="<%if (jobList.Count > 0)
                                        {%><%:jobList[0]["max_sal"]%><%}
                                        else
                                        {%><%:0 %><%} %>" />
                                    <label class="input-label" for="max-salary">Max*</label>
                                </div>
                            </div>
                        </div>



                        <div class="col s4 input-field">
                            <select id="currency" name="currency">
                                <%if (Request.QueryString["id"] == null)
                                    { %>
                                <option value="" disabled selected>Choose Currency*</option>
                                <%} %>
                                <%foreach (var currency in currencyList)
                                    {%>
                                <option value="<%=currency["id"] %>" <%if (jobList.Count > 0)
                                    {%><%:(jobList[0]["currency"].ToString()==currency["id"].ToString())?"selected":""%><%}%>><%=currency["code"] %></option>
                                <%} %>
                            </select>
                        </div>
                    </div>



                    <div class="row">
                        <div class="col s12 input-field">
                            <input type="text" id="other_notes" name="other_notes" value="<%if (jobList.Count > 0)
                                {%><%:jobList[0]["other_notes"]%><%}%>" />
                            <label class="input-label" for="other_notes">Other Notes</label>
                        </div>
                    </div>


                    <%--
                    <div class="col s12 input-field">
                        <input type="text" id="experience" name="experience" value="<%if (jobList.Count > 0)
                            {%><%:jobList[0]["experience"]%><%}%>" />
                        <label class="input-label" for="experience">Experience In Years</label>
                    </div>
                    --%>
                    <div class="row">
                        <div class="col s12" id="div-experience">
                            <p class="">Experience (In Years)*</p>

                            <div class="col s2 input-field">
                                <input type="text" id="min_experience" name="min_experience" value="<%if (jobList.Count > 0)
                                    {%><%:jobList[0]["max_exp"]%><%}
                                    else
                                    {%><%:0 %><%} %>" />
                                <label class="input-label" for="min-experience">Min*</label>
                            </div>
                            <div class="col s8 input-field" id="slider-range2">
                            </div>
                            <div class="col s2 right input-field">
                                <input type="text" id="max_experience" name="max_experience" value="<%if (jobList.Count > 0)
                                    {%><%:jobList[0]["max_exp"]%><%}
                                    else
                                    {%><%:0 %><%} %>" />
                                <label class="input-label" for="max-experience">Max*</label>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col s6 input-field">
                            <input type="text" id="job_skills" name="job_skills" value="" />
                            <a id="btn-skill-add" class="btn blue lighten-1" style="display: inline">Add +</a>
                            <label class="input-label" for="job_skills">Required Skills*</label>
                        </div>
                        <input type="text" id="skills" name="skills" hidden value="<%
                            if (jobSkillsList.Count > 0)
                            {
                                foreach (var skill in jobSkillsList)
                                {
                            %>
                        <%:jobSkillsList[0]["id"] + ","%>
                        <%}
                            }%>" />
                        <div class="col s6 input-field">
                            <input type="text" id="job_qualifications" name="job_qualifications" value="" />
                            <a id="btn-qualification-add" class="btn blue lighten-1" style="display: inline">Add +</a>
                            <label class="input-label" for="job_qualifications">Required Qualifications*</label>
                        </div>
                        <input type="text" id="qualifications" name="qualifications" hidden value="<%
                            if (jobQualificationsList.Count > 0)
                            {
                                foreach (var qualification in jobQualificationsList)
                                {
                            %>
                        <%:jobQualificationsList[0]["id"] + ","%>
                        <%}
                            }%>" />
                    </div>


                    <div class="row">
                        <div class="col s6 input-field" id="div-skills">
                            <%if (jobSkillsList.Count > 0)
                                {
                                    foreach (var skill in jobSkillsList)
                                    {
                            %>
                            <div class="skill chip" id="<%:skill["id"]%>"><%:skill["skill"]%><i class="close material-icons">close</i></div>

                            <%}
                                }%>
                        </div>
                        <div class="col s6 input-field" id="div-qualifications">
                            <%if (jobQualificationsList.Count > 0)
                                {
                                    foreach (var qualification in jobQualificationsList)
                                    {
                            %>
                            <div class="skill chip" id="<%:qualification["id"]%>"><%:qualification["qualification"]%><i class="close material-icons">close</i></div>

                            <%}
                                }%>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col s6 input-field left">
                            <input type="text" class="datepicker" id="join_date" name="join_date" value="<%if (jobList.Count > 0)
                                {%><%:Convert.ToDateTime(jobList[0]["join_date"]).Day.ToString("d2")+"-"+Convert.ToDateTime(jobList[0]["join_date"]).Month.ToString("d2")+"-"+Convert.ToDateTime(jobList[0]["join_date"]).Year%><%}%>" />
                            <label class="input-label" for="join_date">Date of Joining*</label>
                        </div>

                        <div class="col s6 input-field switch right">
                            <label>
                                Active<input type="checkbox" id="active" name="active" class="filled-in blue lighten-3" <%= (jobList.Count > 0) ? (jobList[0]["active"] == null) ? "checked" : (jobList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                                <span class="lever"></span>
                            </label>
                        </div>
                    </div>

                    <div class="col s12 input-field">
                        <a href="<%=Session["previous_url"] %>" class="btn waves-effect waves-light blue lighten-1 left" id="btn-cancel">Cancel</a>
                        <a id="btn-submit" class="btn waves-effect waves-light blue lighten-1 right"><%:(Request.QueryString["id"]!=null)?"Update":"Submit"%></a>
                        <asp:Button Style="display: none" ID="btn_submit" CssClass="btn waves-effect waves-light blue lighten-1 right" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                    </div>
                    <%-- <a class="btn" id="btncheck">check</a> --%>
                </div>
            </div>
        </div>
    </form>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!--<link rel="stylesheet" href="/Styles/style.css">-->

    <script>
        $(document).ready(function () {
            /*
            $('#btncheck').click(function () {
                alert($('#join_date').val());
            });
            */

            $('#join_date').datepicker({
                minDate: 0,
                dateFormat: 'dd-mm-yy',
                //changeMonth: true,
                //changeYear: true,
            });

            $('.close').click(function () {
                //var closebtns = $(".qualification").get();
                //alert(closebtns);
            });

            $('#employer_id').change(function () {
                window.location = "<%=WebURL%>JobUpdate.aspx?employer_id=" + $('#employer_id').val();
            });

            var arrSkills = [];
            var arrQualifications = [];
            $("#slider-range").slider({
                step: 100
            });



            $("#slider-range").slider({
                range: true,
                min: 0,
                max: 200000,
                values: [<%:(jobList.Count > 0)?jobList[0]["min_sal"]:0%>, <%:(jobList.Count > 0)?jobList[0]["max_sal"]:1000%>],
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
                values: [<%:(jobList.Count > 0)?jobList[0]["min_exp"]:0%>, <%:(jobList.Count > 0)?jobList[0]["max_exp"]:3%>],
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

            function isSkillEmpty() {
                if ($('#div-skills').children().length == 0) {
                    return true;
                }
                return false;
            }

            function isQualificationEmpty() {
                if ($('#div-qualifications').children().length == 0) {
                    return true;
                }
                return false;
            }

            function isValidDateString(dateString) {
                if (!moment(dateString, 'DD-MM-YYYY').isValid()) {
                    return false
                }
                else {
                     return true
                }
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

            $.validator.addMethod("isSkillEmpty", function (value, element) {
                return !isSkillEmpty();
            }, "Please select a key skill!");

            $.validator.addMethod("isQualificationEmpty", function (value, element) {
                return !isQualificationEmpty();
            }, "Please select a qualification!");

            $.validator.addMethod("validateNullOrWhiteSpace", function (value, element) {
                return !isNullOrWhitespace(value);
            }, "Blank spaces not allowed!");

             $.validator.addMethod("isValidDate", function (value, element) {
                return isValidDateString(value);
            }, "Must be a valid date in dd-mm-yyyy format!");

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
                    employer_id: {
                        required: true,
                        valueNotEquals: "0",
                    },
                    location_id: {
                        required: true,
                        valueNotEquals: "0",
                    },
                    industry: {
                        required: true,
                        valueNotEquals: "0",
                    },
                    category: {
                        required: true,
                        valueNotEquals: "0",
                    },
                    description: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    vacancy_count: {
                        required: true,
                        max: 500,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([0-9]{1,2})$"
                    },
                    currency: {
                        required: true,
                    },

                    min_salary: {
                        required: true,
                        max: 200000,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([0-9]{1,6})$"
                    },

                    max_salary: {
                        required: true,
                        max: 200000,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([0-9]{1,6})$"
                    },

                    other_notes: {
                        validateNullOrWhiteSpace: true,
                    },

                    min_experience: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        max: 30,
                        regexMatch: "^([0-9]{1,2})$"
                    },

                    max_experience: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        max: 30,
                        regexMatch: "^([0-9]{1,2})$"
                    },
                    job_skills: {
                        isSkillEmpty: true,
                    },
                    job_qualifications: {
                        isQualificationEmpty: true,
                    },
                    join_date: {
                        isValidDate: true,
                    }


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

            $('#btn-skill-add').click(function () {
                var title = $('#job_skills').val();
                if (title.trim() != "") {
                    var datastring = JSON.stringify({ 'title': title });
                    $.ajax({
                        url: 'JobUpdate.aspx/InsertSkill',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                            if (parseInt(data.d) > 0) {
                                var divs = $(".skill").get();
                                for (var i = 0; i < divs.length; i++) {
                                    if (divs[i].getAttribute('id') == data.d) {
                                        return false;
                                    }
                                }
                                $("#div-skills").append('<div class="skill chip user-chip" id = "' + data.d + '">' + title + '<i class="close material-icons">close</i></div>');
                                $('#job_skills').val("");
                            }

                        },
                        error: function (error) {
                            toastr.error("Unable to complete process.");
                        }
                    });

                }
            });

            $('#btn-qualification-add').click(function () {
                var title = $('#job_qualifications').val();
                if (title.trim() != "") {
                    var datastring = JSON.stringify({ 'title': title });
                    $.ajax({
                        url: 'JobUpdate.aspx/InsertQualification',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                            if (parseInt(data.d) > 0) {
                                var divs = $(".qualification").get();
                                for (var i = 0; i < divs.length; i++) {
                                    if (divs[i].getAttribute('id') == data.d) {
                                        return false;
                                    }
                                }
                                $("#div-qualifications").append('<div class="qualification chip user-chip" id = "' + data.d + '">' + title + '<i class="close material-icons">close</i></div>');
                                $('#job_qualifications').val("");
                            }

                        },
                        error: function (error) {
                            toastr.error("Unable to complete process.");
                        }
                    });

                }
            });





            var skillarray = [];
            function getSkills() {
                $('#div-skills > div').map(function () {
                    skillarray.push(this.id);
                });
            }

            var qualificationarray = [];
            function getQualifications() {
                $('#div-qualifications > div').map(function () {
                    qualificationarray.push(this.id);
                });
            }


            $('#btn-submit').click(function () {
                if ($('#<%=frm_job.ClientID%>').valid()) {
                    getQualifications();
                    getSkills();
                    $('#skills').val(skillarray);
                    $('#qualifications').val(qualificationarray);
                    //$('#skills').val(arrSkills);
                    //$('#qualifications').val(arrQualifications);
                    document.getElementById('<%= btn_submit.ClientID %>').click();
                }

            });

        });


    </script>

</asp:Content>
