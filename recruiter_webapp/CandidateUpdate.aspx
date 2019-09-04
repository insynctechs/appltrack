<%@ Page Language="C#" Title="Candidate" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CandidateUpdate.aspx.cs" Inherits="recruiter_webapp.CandidateUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_job" runat="server" enctype="multipart/form-data">
        <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">
                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>

        </div>
        <div class="row no-padding">
            <div class="col s12 m12 l8 card card grey lighten-2 padding-1 border-radius-5 no-margin padding-1">
                <% if (string.IsNullOrEmpty(Request.QueryString["id"]))

                    { %>
                <h6>Create Profile</h6>
                <%}
                    else
                    { %>
                <h6 style="display:inline">Edit Profile - <%if (candidateList.Count > 0)
                                     {%><%:candidateList[0]["name"]%><%}%></h6>
                <a href="<%= WebURL %>CandidateDocUpdate.aspx?id=<%:Request.QueryString["id"]%>" class="btn waves-effect waves-light blue lighten-1 right">Edit Documents</a>
                <%}%>
            </div>
        </div>


        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        <div class="row">
            <div class="input-field col s12 m12 l8 card white lighten-3 z-depth-3 padding-3 border-radius-5">
                
                <input type="hidden" id="user_id" name="user_id" value="<%:(candidateList.Count > 0)?candidateList[0]["user_id"]: "0"%>" />

                <input type="hidden" id="id" name="id" value="<%if (candidateList.Count > 0)
                    {%><%:candidateList[0]["id"]%><%}%>" />

                <div class="row">
                    <div class="col s8 input-field">
                        <input type="text" id="name" name="name" value="<%if (candidateList.Count > 0)
                            {%><%:candidateList[0]["name"]%><%}%>" />
                        <label class="input-label" for="name">Name*</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col s4 input-field left">
                        <select id="gender" name="gender">
                            <% foreach (var gender in genders)
                                { %>
                            <option value="<%=gender.Key %>" <%=(gender.Key=="") ? "disabled" : "" %> <%=(((candidateList.Count > 0) && candidateList[0]["gender"].ToString().Trim()== gender.Key) || gender.Key=="") ? "selected" : "" %>><%=gender.Value%></option>
                            <%} %>
                        </select>
                        <label class="input-label" for="gender">Gender*</label>
                    </div>

                    <div class="col s4 input-field">
                        <input type="text" class="datepicker" id="dob" name="dob" value="<%if (candidateList.Count > 0)
                                {%><%:Convert.ToDateTime(candidateList[0]["dob"]).Day.ToString("d2")+"-"+Convert.ToDateTime(candidateList[0]["dob"]).Month.ToString("d2")+"-"+Convert.ToDateTime(candidateList[0]["dob"]).Year%><%}%>" />
                        <label class="input-label" for="dob">Date of Birth*</label>
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
                    <div class="col s6 input-field">
                        <input type="text" id="email" name="email" value="<%if (candidateList.Count > 0)
                            {%><%:candidateList[0]["email"]%><%}%>" />
                        <label class="input-label" for="email">Email*</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="phone" name="phone" value="<%if (candidateList.Count > 0)
                            {%><%:candidateList[0]["phone"]%><%}%>" />
                        <label class="input-label" for="phone">Phone*</label>
                    </div>
                </div>


                <div class="row">
                    <div class="col s8 input-field">
                        <input type="text" id="candidate_skills" name="candidate_skills" />
                        <a id="btn-skill-add" class="btn blue lighten-1" style="display: inline">Add +</a>

                        <label class="input-label" for="candidate_skills">Key Skills*</label>

                    </div>
                    <input type="text" id="skills" name="skills" hidden value="<%
                        if (candidateSkillsList.Count > 0)
                        {
                            foreach (var skill in candidateSkillsList)
                            {
                            %>
                        <%:candidateSkillsList[0]["id"] + ","%>
                        <%}
                        }%>" />
                    <div class="col s6 input-field" id="div-skills">
                        <%if (candidateSkillsList.Count > 0)
                            {
                                foreach (var skill in candidateSkillsList)
                                {
                        %>
                        <div class="skill chip" id="<%:skill["id"]%>"><%:skill["skill"]%><i class="close material-icons">close</i></div>

                        <%}
                            }%>
                    </div>
                </div>

                <hr />
                <div class="row" id="div-qualification">
                    <div class="input-field col s12">
                        <h6 class="card card grey lighten-2 padding-1 border-radius-5">Qualifications</h6>
                        <div id="dialog-form1" title="Add Qualification">
                            <div class="frm-qualification">
                                <fieldset>
                                    <label for="qualification">Qualification</label>
                                    <input type="text" name="qualification" id="qualification" class="text ui-widget-content ui-corner-all">
                                    <label for="institute">Institute</label>
                                    <input type="text" name="institute" id="institute" class="text ui-widget-content ui-corner-all">
                                    <label for="year">Year</label>
                                    <input class="datepicker text ui-widget-content ui-corner-all" id="year" />
                                    <label for="percentage">Percentage</label>
                                    <input type="number" name="percentage" id="percentage" max="100" min="0" class="text ui-widget-content ui-corner-all">
                                    <!-- Allow form submission with keyboard without duplicating the dialog button -->
                                    <a tabindex="-1" style="position: absolute; top: -1000px">SUBMIT</a>
                                </fieldset>
                            </div>
                        </div>

                        <div id="qualifications-contain">
                            <table id="qualifications" class="">
                                <thead>
                                    <tr class="blue-grey lighten-4">
                                        <th class="font-weight-100">Course/Qualification</th>
                                        <th class="font-weight-100">Institute/University</th>
                                        <th class="font-weight-100">Year</th>
                                        <th class="font-weight-100">Percentage</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%if (candidateQualificationsList.Count > 0)
                                        {
                                            foreach (var qualification in candidateQualificationsList)
                                            {
                                    %>
                                    <tr id="data-qualification">
                                        <td class="qualification"><%:qualification["qualification"]%></td>
                                        <td class="qualification"><%:qualification["institute"]%></td>
                                        <td class="qualification"><%:qualification["year"]%></td>
                                        <td class="qualification"><%:qualification["percentage"]%></td>
                                        <td><a class="btn btn-remove white-text waves-light blue lighten-1 padding-2 border-radius-5 right">Remove</a></td>
                                    </tr>
                                    <%}
                                        }%>
                                </tbody>
                            </table>
                        </div>
                        <a class="right" id="create-qualification">Add Qualification +</a>
                    </div>
                </div>

                <!-- Experiences -->
                <hr />
                <div class="row" id="div-experience">
                    <div class="input-field col s12">
                        <h6 class="card card grey lighten-2 padding-1 border-radius-5">Experiences</h6>

                        <div id="dialog-form2" title="Add Experience">
                            <div class="frm-experience">
                                <fieldset>
                                    <label for="designation">Designation</label>
                                    <input type="text" name="designation" id="designation" class="text ui-widget-content ui-corner-all" required>
                                    <label for="organisation">Organisation</label>
                                    <input type="text" name="organisation" id="organisation" class="text ui-widget-content ui-corner-all">
                                    <label for="from_year">From Year</label>
                                    <input class="datepicker text ui-widget-content ui-corner-all" id="from_year" />
                                    <label for="to_year">To Year</label>
                                    <input class="datepicker text ui-widget-content ui-corner-all" id="to_year" />
                                    <label for="description">Description</label>
                                    <textarea name="description" id="description" class="text ui-widget-content ui-corner-all"></textarea>
                                    <!-- Allow form submission with keyboard without duplicating the dialog button -->
                                    <a tabindex="-1" style="position: absolute; top: -1000px">SUBMIT</a>
                                </fieldset>
                            </div>
                        </div>

                        <div id="experiences-contain">
                            <table id="experiences" class="">
                                <thead>
                                    <tr class="blue-grey lighten-4">
                                        <th class="font-weight-100">Designation</th>
                                        <th class="font-weight-100">Organisation</th>
                                        <th class="font-weight-100">From</th>
                                        <th class="font-weight-100">To</th>
                                        <th class="font-weight-100">Description</th>
                                        <th class="col s2"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%if (candidateExperiencesList.Count > 0)
                                        {
                                            foreach (var experience in candidateExperiencesList)
                                            {
                                    %>
                                    <tr>
                                        <td><%:experience["designation"]%></td>
                                        <td><%:experience["organisation"]%></td>
                                        <td><%:experience["from_year"]%></td>
                                        <td><%:experience["to_year"]%></td>
                                        <td><%:experience["description"]%></td>
                                        <td><a class="btn btn-remove white-text waves-light blue lighten-1 padding-2 border-radius-5 right">Remove</a></td>
                                    </tr>
                                    <%}
                                        }%>
                                </tbody>
                            </table>
                        </div>
                        <a class="right" id="create-experience">Add Experience +</a>
                    </div>
                </div>

                <div class="row">
                    <div class="col s12 input-field right">
                        <textarea id="others" name="others"><%if (candidateList.Count > 0)
                                                                {%><%:candidateList[0]["others"]%><%}%></textarea>
                        <label class="input-label" for="others">Other Notes</label>
                    </div>
                </div>

            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12 l8 card white lighten-3 z-depth-3 padding-3 border-radius-5">
                <% if (Session["user_type"] != null)
                         {
                             if (Convert.ToInt32(Session["user_type"].ToString()) < 6)
                             { %>
                <div class="row" hidden>
                    <div class="col s6 input-field left">
                        <input type="number" id="status" name="status" value="<%if (candidateList.Count > 0)
                         {%><%:candidateList[0]["status"]%><%}%>" />
                        <label class="input-label" for="status">Status *(Dummy Field)*</label>
                    </div>
                    <div class="col s6 input-field right">
                        <input type="number" id="rating" name="rating" value="<%if (candidateList.Count > 0)
                         {%><%:candidateList[0]["rating"]%><%}%>" />
                        <label class="input-label" for="rating">Rating *(Dummy Field)*</label>
                    </div>
                </div>

                <div class="row" hidden>
                    <div class="col s12 input-field">
                        <textarea id="employer_comments" name="employer_comments"><%if (candidateList.Count > 0)
                         {%><%:candidateList[0]["employer_comments"]%><%}%></textarea>
                        <label class="input-label" for="employer_comments">Comments *(Dummy Field)*</label>
                    </div>
                </div>
                <div class="row" hidden>
                    <div class="col s12 input-field switch left">
                        <label>
                            Active<input type="checkbox" id="active" name="active" class="filled-in blue lighten-3" <%= (candidateList.Count > 0) ? (candidateList[0]["active"] == null) ? "checked" : (candidateList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                            <span class="lever"></span>
                        </label>
                    </div>
                </div>
                <%}
                         } %>

                
                    <div class="col s12 input-field right">

                        <a href="<%=Session["previous_url"] %>" class="btn waves-effect waves-light blue lighten-1 left" id="btn-cancel">Cancel<i class="material-icons right">close</i></a>
  
                    <a id="btn-submit" class="btn waves-effect waves-light blue lighten-1 right"><%:Request.QueryString["id"]!=null?"Update":"Submit" %></a>
                    <asp:Button Style="display: none" ID="btn_submit" CssClass="btn waves-effect waves-light blue lighten-1 right" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                </div>
              
                
            </div>
        </div>

    </form>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="/Scripts/jquery.fileupload.js"></script>
    <script src="/Scripts/dropify.min.js"></script>
    <link rel="stylesheet" href="Styles/dropify.min.css">

    <style>
        .bar {
            height: 5px;
            background: #42a5f5;
        }


        label, input {
            display: block;
        }

            input.text {
                margin-bottom: 12px;
                width: 95%;
                padding: .4em;
            }

        fieldset {
            padding: 0;
            border: 0;
            margin-top: 25px;
        }

        h1 {
            font-size: 1.2em;
            margin: .6em 0;
        }

        div#qualifications-contain table {
            margin: 1em 0;
            border-collapse: collapse;
            width: 100%;
        }

            div#qualifications-contain table td, div#qualifications-contain table th {
                border: 1px solid #eee;
                padding: .6em 10px;
                text-align: left;
            }

        .ui-dialog .ui-state-error {
            padding: .3em;
        }

        .validateTips {
            border: 1px solid transparent;
            padding: 0.3em;
        }

        .input-label {
            margin-left: 10px;
        }

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

            var q = [];

            $('#dob').datepicker({
                maxDate: 0,
                dateFormat: 'dd-mm-yy',
                //changeMonth: true,
                //changeYear: true,
            });

            $("#year").datepicker({ dateFormat: 'yy' });
            $("#from_year").datepicker({ dateFormat: 'yy' });
            $("#to_year").datepicker({ dateFormat: 'yy' });



            var arrData = [];

            $('#check').click(function () {
                getSkills();

            });


            var documents = [];

            $("#cv").change(function (e) {
                $("#cv-filename").html("<b>Filename</b> : " + e.target.files[0].name);
            });

            $("#file_types").on('change', function () {
                var sel = document.getElementById('file_types');
                var opt = sel.options[sel.selectedIndex];
                $("#fileuploaders").append("<input type=\"file\" class=\"fileupload\" id=\"" + $('#file_types').val() + "\" name=\"doc" + $('#file_types').val() + "\" hidden />");

                $("#" + $("#file_types").val() + "").click();
                //$("#other_documents").click();
                var fileName;
                $("#" + $("#file_types").val() + "").change(function (e) {
                    fileName = e.target.files[0].name;
                });
                $("#" + $("#file_types").val() + "").fileupload({

                    progressall: function (e, data) {
                        $('#progress').show();
                        var progress = parseInt(data.loaded / data.total * 100, 10);

                        $('#progress .bar').css(
                            'width',
                            progress + '%'
                        );
                        $('#progress-indicator').html(
                            progress + '%'
                        );
                    },
                    done: function (e, data) {
                        $('#progress').hide();
                        $('#progress .bar').css(
                            'width', '0%'
                        );
                        $('#div-fileuploads').show();
                        $("#tbl-fileuploads tbody").append("<tr id=\"" + $("#file_types").val() + "\">" +
                            "<td>" + opt.text + "</td>" +
                            "<td>" + fileName + "</td>" +
                            "<td><a class=\"btn btn-remove white-text waves-light blue lighten-1 padding-2 border-radius-5\">Remove</a></td>" +
                            "</tr>");
                    }

                });
                documents.push($("#file_types").val());
            });

            $('#fileuploader').on('change', function () {
                for (var i = 0; i < this.files.length; i++) {
                    console.log(this.files[i].name);
                }
            });


            var qualifications = {};
            var experiences = {};



            $(document).on("click", "a.btn-remove", function () {
                $(this).parents("tr").remove();
            });

            var dialog, form,
                qualification = $("#qualification"),
                institute = $("#institute"),
                year = $("#year"),
                percentage = $("#percentage"),
                allFields = $([]).add(qualification).add(institute).add(year).add(percentage),
                tips = $(".validateTips");

            
            function validateQualDialogFields() {
            var valid = true;
            allFields.removeClass( "ui-state-error" );
 
                valid = valid && checkLength(qualification, "Qualification", 1, 100);
                valid = valid && checkLength(institute, "Institute", 1, 200);
                valid = valid && isBetween(year, "Year", 1950, new Date().getFullYear());
                valid = valid && isBetween(percentage, "Percentage", 0, 100);
      return valid;
    }


            var i = 0;
            function addQualification() {
                var valid = validateQualDialogFields();
                
                var exists = false;
                $('#qualifications-contain').show();
                if (valid) {
                    insertQualification();
                    $("#qualifications tr").each(function () {
                        var currentRow = $(this);
                        if (currentRow.find("td:eq(0)").text().toLowerCase() == $('#qualification').val().trim().toLowerCase()) {
                            exists = true;
                        }; 
                    });
                    if (!exists) {
                        $("#qualifications tbody").append("<tr\>" +
                            "<td>" + qualification.val() + "</td>" +
                            "<td>" + institute.val() + "</td>" +
                            "<td>" + year.val() + "</td>" +
                            "<td>" + percentage.val() + "</td>" +
                            "<td><a class=\"btn btn-remove white-text waves-light blue lighten-1 padding-2 border-radius-5 right\">Remove</a></td>" +
                            "</tr>");
                        dialog.dialog("close");
                        exists = false;
                    }
                    else {
                        alert("Similar record for qualification already exists.");
                    }
                    $('#qualification').val("");
                $('#institute').val("");
                $('#year').val("");
                $('#percentage').val("");
                return valid;
                }
                
            }

            function insertQualification() {
               var title = $('#qualification').val();
                if (title.trim() != "") {
                    var datastring = JSON.stringify({ 'title': title });
                $.ajax({
                    url: 'CandidateUpdate.aspx/InsertQualification',
                    type: 'post',
                    data: datastring,
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
 
                    },
                    error: function (error) {
                        toastr.error("Unable to complete process.");
                    }
                });

                }
            }




            dialog = $("#dialog-form1").dialog({
                autoOpen: false,
                height: 400,
                width: 350,
                modal: true,
                buttons: {
                    "Save": addQualification,
                    Cancel: function () {
                        dialog.dialog("close");
                    }
                },
                close: function () {
                    $('.frm-qualification').trigger("reset");
                    allFields.removeClass("ui-state-error");
                }
            });

            form = dialog.find("form").on("submit", function (event) {
                event.preventDefault();
                addUser();
            });

            $("#create-qualification").button().on("click", function () {
                dialog.dialog("open");
            });



            /* ------------------------------- */
            var dialog2, form2,
                designation = $("#designation"),
                organisation = $("#organisation"),
                from_year = $("#from_year"),
                to_year = $("#to_year"),
                description = $("#description"),
                allFields2 = $([]).add(designation).add(organisation).add(from_year).add(to_year).add(description),
                tips2 = $(".validateTips");

            function updateTips( t ) {
      tips
        .text( t )
        .addClass( "ui-state-highlight" );
      setTimeout(function() {
        tips.removeClass( "ui-state-highlight", 1500 );
                }, 500);

    }

            function checkLength(o, n, min, max) {
                if (o.val().length > max || o.val().length < min) {
                    o.addClass("ui-state-error");
                    updateTips("Length of " + n + " must be between " +
                        min + " and " + max + ".");
                    return false;
                } else {
                    return true;
                }
            }

            function isBetween(o, n, min, max) {
                if (o.val() == "")
                    return false;
                if (parseInt(o.val()) > max || parseInt(o.val()) < min) {
                    o.addClass("ui-state-error");
                    updateTips("Must be a valid year between" +
                        min + " and " + max + ".");
                    return false;
                } else {
                    return true;
                }
            }

      function validateExpDialogFields() {
      var valid = true;
      allFields.removeClass( "ui-state-error" );
 
                valid = valid && checkLength(designation, "Designation", 1, 50);
                valid = valid && checkLength(organisation, "Organisation", 1, 100);
                valid = valid && checkLength(description, "Description", 1, 200);
                valid = valid && isBetween(from_year, "From year", 1950, new Date().getFullYear());
                valid = valid && isBetween(to_year, "To year", 1950, new Date().getFullYear());

      return valid;
    }




            var j = 0;
            function addExperience() {

                var valid = validateExpDialogFields();

                var exists = false;
                $('#experiences-contain').show();
                if (valid) {
                    $("#experiences tr").each(function () {
                        var currentRow = $(this);
                        if (currentRow.find("td:eq(0)").text().toLowerCase() == $('#designation').val().trim().toLowerCase() && currentRow.find("td:eq(1)").text().toLowerCase() == $('#organisation').val().trim().toLowerCase()) {
                            exists = true;
                        }; 
                    });
                    if (!exists) {
                        $("#experiences tbody").append("<tr>" +
                            "<td>" + designation.val() + "</td>" +
                            "<td>" + organisation.val() + "</td>" +
                            "<td>" + from_year.val() + "</td>" +
                            "<td>" + to_year.val() + "</td>" +
                            "<td>" + description.val() + "</td>" +
                            "<td><a class=\"btn btn-remove white-text waves-light blue lighten-1 padding-2 border-radius-5 right\">Remove</a></td>" +
                            "</tr>");
                        dialog2.dialog("close");
                        exists = false;
                    }
                    else {
                        alert('Similar record for experience already exists.');
                    }
                    $('#designation').val("");
                $('#organisation').val("");
                $('#from_year').val("");
                $('#to_year').val("");
                $('#description').val("");
                return valid;
                }
                
            }




            dialog2 = $("#dialog-form2").dialog({
                autoOpen: false,
                height: 400,
                width: 350,
                modal: true,
                buttons: {
                    "Save": addExperience,
                    Cancel: function () {
                        dialog2.dialog("close");
                    }
                },
                close: function () {
                    $('.frm-experience').trigger("reset");
                    allFields2.removeClass("ui-state-error");
                }
            });

            form2 = dialog.find("form").on("submit", function (event) {
                event.preventDefault();
                addUser();
            });

            $("#create-experience").button().on("click", function () {
                dialog2.dialog("open");
            });

            $(".datepicker").datepicker({ maxDate: '0' });

            $('.fileupload').fileupload({

                progressall: function (e, data) {
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    $('#progress .bar').css(
                        'width',
                        progress + '%'
                    );
                }
            });

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
            });

            var arrSkills = [];
            var arrQualifications = [];
            $("#slider-range").slider({
                step: 100
            });


            $("#candidate_skills").autocomplete({
                source: function (request, response) {
                    var param = { searchValue: $('#candidate_skills').val() };
                    $.ajax({
                        url: "CandidateUpdate.aspx/GetSkillList",
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
                    $('#candidate_skills').val("");
                    return false;
                }

            });

            $("#qualification").autocomplete({
                source: function (request, response) {
                    var param = { searchValue: $('#qualification').val() };
                    $.ajax({
                        url: "CandidateUpdate.aspx/GetQualificationList",
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
                    /*var divs = $(".qualification").get();

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
                    return false;*/
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

            function isEmpty() {
                if ($('#div-skills').children().length == 0) {
                    return true;
                }
                return false;
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

            $.validator.addMethod("isEmpty", function (value, element) {
                return !isEmpty();
            }, "Please add a key skill!");

            $('#<%=frm_job.ClientID%>').validate({
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
                        regexMatch: "[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

                    },
                    phone: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^[0-9 +()\/-]{5,20}$"
                    },
                    candidate_skills: {
                        isEmpty: true,
                    }
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

            function getQualifications() {

                var i = 0;
                $("#qualifications tr").each(function () {

                    var currentRow = $(this);
                    if (currentRow.find("td:eq(0)").text() != "") {
                        i += 1;
                        var col1_value = currentRow.find("td:eq(0)").text();
                        var col2_value = currentRow.find("td:eq(1)").text();
                        var col3_value = currentRow.find("td:eq(2)").text();
                        var col4_value = currentRow.find("td:eq(3)").text();
                        var jsonData = {};
                        jsonData['qualification'] = col1_value;
                        jsonData['institute'] = col2_value;
                        jsonData['year'] = col3_value;
                        jsonData['percentage'] = col4_value;
                        qualifications[i] = jsonData;
                    };
                });
            };

            function getExperiences() {
                var i = 0;
                $("#experiences tr").each(function () {

                    var currentRow = $(this);
                    if (currentRow.find("td:eq(0)").text() != "") {
                        i += 1;
                        var col1_value = currentRow.find("td:eq(0)").text();
                        var col2_value = currentRow.find("td:eq(1)").text();
                        var col3_value = currentRow.find("td:eq(2)").text();
                        var col4_value = currentRow.find("td:eq(3)").text();
                        var col5_value = currentRow.find("td:eq(4)").text();
                        var jsonData = {};
                        jsonData['designation'] = col1_value;
                        jsonData['organisation'] = col2_value;
                        jsonData['from_year'] = col3_value;
                        jsonData['to_year'] = col4_value;
                        jsonData['description'] = col5_value;
                        experiences[i] = jsonData;
                    };
                });
            };

            var skillarray = [];
            function getSkills() {
                $('#div-skills > div').map(function () {
                    skillarray.push(this.id);
                });
            }

            $('#btn-skill-add').click(function () {
                var title = $('#candidate_skills').val();
                if (title.trim() != "") {
                    var datastring = JSON.stringify({ 'title': title });
                $.ajax({
                    url: 'CandidateUpdate.aspx/InsertSkill',
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
                        $('#candidate_skills').val("");
                        }
                        
                    },
                    error: function (error) {
                        toastr.error("Unable to complete process.");
                    }
                });

                }
                
            });


            $('#btn-submit').click(function () {
                if ($('#<%=frm_job.ClientID%>').valid()) {
                    getQualifications();
                    getExperiences();
                    getSkills();
                    $('#skills').val(skillarray);
                    /*AJAX call to webmethod*/
                    var datastring = JSON.stringify({ 'qualifications': qualifications, 'experiences': experiences, 'documents': documents });
                    $.ajax({
                        url: 'CandidateUpdate.aspx/SetFields',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                        },
                        error: function (error) {
                            toastr.error("Unable to complete process.");
                        }

                    });

                    document.getElementById('<%= btn_submit.ClientID %>').click();
                }
            });

        });


    </script>

</asp:Content>

