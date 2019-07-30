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
                <% if (string.IsNullOrEmpty(Request.QueryString["employer_loc_id"]))

                    { %>
                <h6>Add Job <%if (jobList.Count > 0)
                                {%><%:jobList[0]["job_code"]%><%}%></h6>
                <%}
                    else
                    { %>
                <h6>Edit Job <%if (jobList.Count > 0)
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
                    <input type="hidden" id="employer_id" name="employer_id" value="<%=(Request.QueryString["employer_id"]!=null)? Request.QueryString["employer_id"] : ""%><% if (jobList.Count > 0)
                        {%><%:jobList[0]["employer_id"]%><%}%>" />

                    <div class="row">
                        <div class="col s8 input-field">
                            <input type="text" id="job_code" name="job_code" value="<%if (jobList.Count > 0)
                                {%><%:jobList[0]["job_code"]%><%}%>" />
                            <label class="input-label" for="job_code">Job Code*</label>
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
                            <select id="location_id" name="location_id">
                                <option value="" disabled selected>Choose Location*</option>
                                <%foreach (var loc in employerLocationList)
                                    {%>
                                <option value="<%=loc["employer_loc_id"] %>"><%=loc["employer_loc_address"] %></option>
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
                            <p class="">Salary</p>
                            <div class="col s10 input-field" id="slider-range"></div>
                            <div class="col s10">
                                <div class="col s4 input-field">
                                    <input type="text" id="min_salary" name="min_salary" value="<%if (jobList.Count > 0)
                                        {%><%:jobList[0]["min_sal"]%><%}
                                        else
                                        {%><%:0 %><%} %>" />
                                    <label class="input-label" for="min-salary">Min</label>
                                </div>
                                <div class="col s4 right input-field">
                                    <input type="text" id="max_salary" name="max_salary" value="<%if (jobList.Count > 0)
                                        {%><%:jobList[0]["max_sal"]%><%}
                                        else
                                        {%><%:0 %><%} %>" />
                                    <label class="input-label" for="max-salary">Max</label>
                                </div>
                            </div>
                        </div>



                        <div class="col s4 input-field">
                            <select id="currency" name="currency">
                                <option value="" disabled selected>Choose Currency*</option>
                                <%foreach (var currency in currencyList)
                                    {%>
                                <option value="<%=currency["id"] %>"><%=currency["code"] %></option>
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
                            <p class="">Experience (In Years)</p>

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
                            <input type="text" id="job_skills" name="job_skills" value="<%if (jobList.Count > 0)
                                {%><%:jobList[0]["job_skills"]%><%}%>" />
                            <label class="input-label" for="job_skills">Required Skills</label>
                        </div>
                        <input type="text" id="skills" name="skills" hidden />
                        <div class="col s6 input-field">
                            <input type="text" id="job_qualifications" name="job_qualifications" value="<%if (jobList.Count > 0)
                                {%><%:jobList[0]["job_qualifications"]%><%}%>" />
                            <label class="input-label" for="job_qualifications">Required Qualifications</label>
                        </div>
                        <input type="text" id="qualifications" name="qualifications" hidden />
                    </div>


                    <div class="row">
                        <div class="col s6 input-field" id="div-skills"></div>
                        <div class="col s6 input-field" id="div-qualifications"></div>
                    </div>


                    <div class="row">
                        <div class="col s6 input-field left">
                            
                            <input type="text" class="datepicker" id="join_date" name="join_date" value="<%if (jobList.Count > 0)
                                {%><%:jobList[0]["join_date"]%><%}%>" />
                            <label class="input-label" for="join_date">Date of Joining</label>
                        </div>

                        <div class="col s6 input-field switch right">
                            <label>
                                Active<input type="checkbox" id="active" name="active" class="filled-in blue lighten-3" <%= (jobList.Count > 0) ? (jobList[0]["active"] == null) ? "checked" : (jobList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                                <span class="lever"></span>
                            </label>
                        </div>
                    </div>

                    <div class="col s12 input-field right">
                        <a id="btn-submit" class="btn waves-effect waves-light blue lighten-1 right">Submit</a>
                        <asp:Button Style="display: none" ID="btn_submit" CssClass="btn waves-effect waves-light blue lighten-1 right" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                    </div>

                </div>
            </div>
        </div>
    </form>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script>
        $(document).ready(function () {
            $('.datepicker').datepicker();

            $('.close').click(function () {
                var closebtns = $(".qualification").get();
                alert(closebtns);
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
