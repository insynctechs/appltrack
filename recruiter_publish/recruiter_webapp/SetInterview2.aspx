<%@ Page Language="C#" Title="Set Interview" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SetInterview2.aspx.cs" Inherits="recruiter_webapp.SetInterview2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
        <div class="row">
            <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
        </div>

    </div>
    <div class="row no-padding">
        <div class="col s12 m12 l12 card blue-grey lighten-4 z-depth-0 border-radius-5 no-margin padding-1">
            <% if (Request.QueryString["id"] != null)

                    { %>
            <h6><%:interviewList[0]["title"]%> On <%:Convert.ToDateTime(interviewList[0]["date_of_interview"]).ToShortDateString()%> for <%if (jobList.Count > 0)
                                          {%><%:jobList[0]["job_code"]%><%}%></h6>

            <%}
                    else
                    { %>
            <h6><%:interviewList[0]["title"]%> On <%:Convert.ToDateTime(interviewList[0]["date_of_interview"]).ToShortDateString()%> for <%if (jobList.Count > 0)
                                          {%><%:jobList[0]["job_code"]%><%}%></h6>
            <%}%>
        </div>
    </div>


    <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>

    <div class="row">
        <form id="frm_left_panel" runat="server">
            <div class="input-field col s12 m12 l6 ">
                <div class="col s12 m12 l12 card white lighten-3 z-depth-3 no-margin padding-1 border-radius-5 right" style="min-height: 445px; max-height: 445px;">
                    <h6 class="center">Shortlisted Candidates</h6>
                    <div id="div_candidates" style="min-height: 300px; max-height: 300px; overflow: auto">
                        <table id="tbl_candidates" class="">
                            <thead>
                                <tr class="blue-grey lighten-4">
                                    <th class="font-weight-100">Name</th>
                                    <th class="font-weight-100">Profile</th>
                                    <th class="font-weight-100 center">Score</th>
                                    <th class="font-weight-100 center">Rating</th>
                                    <th class="font-weight-100 center">Employer Comments</th>
                                    <th>
                                        <label class="input-checkbox right">
                                            <input type="checkbox" id="chkb_checkall_left" class="filled-in blue lighten-3" />
                                            <span></span>
                                        </label>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%if (candidateList.Count > 0)
                                    {
                                        foreach (var candidate in candidateList)
                                        {
                                %>
                                <tr>
                                    <td><%:candidate["name"]%></td>
                                    <td class="center"><a class="btn black-text waves-light white border-radius-5" style="margin: 3px" href="<%= WebURL %>CandidateUpdate?id=<%:candidate["id"]%>">View</a></td>
                                    <td><%:candidate["score"]%></td>
                                    <td><%:candidate["rating"]%></td>
                                    <td><%:candidate["employer_comments"]%></td>
                                    <td>
                                        <label class="input_field input-checkbox right">
                                            <input type="checkbox" value="<%:candidate["id"]%>" name="chkb_left" class="chkb_left filled-in blue lighten-3" />
                                            <span></span>
                                        </label>
                                    </td>
                                </tr>
                                <%}
                                    }%>
                            </tbody>
                        </table>
                    </div>
                    <div style="min-height: 10px"></div>
                    <div class="row">
                        <div class="col s12" style="bottom: 0px;">
                            <div class="col s6 input-field">
                                <select id="left_panel_status" name="left_panel_status">
                                    <% foreach (var status in leftPanelStatusList)
                                        { %>
                                    <option value="<%:status.Key%>" <%:(status.Key=="") ? "disabled selected" : "" %>><%:status.Value%></option>
                                    <%} %>
                                </select>
                            </div>
                            <div class="col s6 input-field">
                                <input type="hidden" name="interview_id" id="interview_id" value="<%:Request.QueryString["id"] %>" />
                                <input type="hidden" name="selected_eligible_candidates" id="selected_eligible_candidates" />
                                <a id="btn_submit" class="btn waves-effect waves-light blue lighten-1 right">Submit</a>
                                <asp:Button Style="display: none" ID="btnSubmit" CssClass="btn waves-effect waves-light blue lighten-1 right" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </form>
        <!-- Right Panel -->
        <form id="frm_right_panel">
            <div class="input-field col s12 m12 l6 ">
                <div class="col s12 m12 l12 card white lighten-3 z-depth-3 no-margin padding-1 border-radius-5 right" style="min-height: 445px">
                    <h6 class="center">Scheduled Candidates</h6>
                    <div id="div_scheduled_candidates" style="min-height: 300px; max-height: 300px; overflow: auto">
                        <table id="tbl_scheduled_candidates" class="">
                            <thead>
                                <tr class="blue-grey lighten-4">
                                    <th hidden></th>
                                    <th class="font-weight-100">Name</th>
                                    <th class="font-weight-100">Status</th>
                                    <th class="font-weight-100">Rating</th>
                                    <th class="font-weight-100">Score</th>
                                    <th class="font-weight-100">Comments</th>
                                    <%--<th class="font-weight-100"></th>--%>
                                    <th>
                                        <label class="input-checkbox right">
                                            <input type="checkbox" id="chkb_checkall_right" class="filled-in blue lighten-3" />
                                            <span></span>
                                        </label>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%if (selectedCandidateList.Count > 0)
                                    {
                                        foreach (var candidate in selectedCandidateList)
                                        {
                                %>
                                <tr>
                                    <td hidden><%:candidate["candidate_id"]%></td>
                                    <td><%:candidate["name"]%></td>
                                    <td><%:candidate["status"]%></td>
                                    <td>
                                        <input class="score" type="number" value="<%:candidate["score"]%>" /></td>
                                    <td>
                                        <input class="rating" type="number" value="<%:candidate["rating"]%>" /></td>
                                    <td>
                                        <input class="employer_comments" type="text" value="<%:candidate["employer_comments"]%>" /></td>
                                    <%--<td><a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" style="margin: 3px" href="#">Update</a></td>--%>
                                    <td>
                                        <label class="input_field input-checkbox right">
                                            <input type="checkbox" value="<%:candidate["candidate_id"]%>" name="chkb_right" class="chkb_right filled-in blue lighten-3" />
                                            <span></span>
                                        </label>
                                    </td>
                                </tr>
                                <%}
                                    }%>
                            </tbody>
                        </table>
                    </div>
                    <div style="min-height: 10px"></div>
                    <div class="row">
                        <div class="col s12" style="bottom: 0px;">
                            <div class="col s6 input-field">
                                <select id="right_panel_status" name="right_panel_status">
                                    <% foreach (var status in rightPanelStatusList)
                                        { %>
                                    <option value="<%:status.Key%>" <%:(status.Key=="") ? "disabled selected" : "" %>><%:status.Value%></option>
                                    <%} %>
                                </select>
                            </div>
                            <div class="col s6 input-field">
                                <input type="hidden" name="pnl_right_interview_id" id="pnl_right_interview_id" value="<%:Request.QueryString["id"] %>" />
                                <input type="hidden" name="pnl_right_selected_candidates" id="pnl_right_selected_candidates" />
                                <a id="btn_update" class="btn waves-effect waves-light blue lighten-1 right">Update</a>
                                <%--<asp:Button Style="display: none" ID="btnSubmit2" CssClass="btn waves-effect waves-light blue lighten-1 right" Text="Submit" runat="server" OnClick="btn_submit_Click" /> --%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>




    <script>
        $(document).ready(function () {
            $('#chkb_checkall_left').click(function () {
                $(".chkb_left").prop('checked', $(this).prop('checked'));
            });

            $('#chkb_checkall_right').click(function () {
                $(".chkb_right").prop('checked', $(this).prop('checked'));
            });

            function NoEntriesSelected(panel) {
                if ($("#" + panel + " input:checkbox:checked").length > 0) {
                    return false;
                }
                return true;
            }
            /*
            function IsAllApplied() {
                var ret = true;
                $("#tbl_candidates tbody tr").each(function () {
                    if (parseInt($(this).find('.status').val()) != 1 && $(this).find("input[name='chkb_left']").prop('checked') == true) {
                        ret = false;
                        return false;
                    }
                });
                return ret;
            }

            function IsAllEligible() {
                var ret = true;
                $("#tbl_candidates tbody tr").each(function () {
                    if (parseInt($(this).find('.status').val()) > 0 && $(this).find("input[name='chkb_left']").prop('checked') == true) {
                        ret = false;
                        return false;
                    }
                });
                return ret;
            }

            function IsNotNotified() {
                var ret = true;
                $("#tbl_candidates tbody tr").each(function () {
                    if (parseInt($(this).find('.status').val()) == 7 && $(this).find("input[name='chkb_left']").prop('checked') == true) {
                        ret = false;
                        return false;
                    }
                });
                return ret;
            }
            */
            $('#btn_check').click(function () {
                setInterviewCandidates();
                console.log(interviewCandidates);
            });


            // Validation specific codes
            $.validator.setDefaults({
                ignore: []
            });

            $.validator.addMethod("valueNotEquals", function (value, element, arg) {
                return arg != value;
            }, "Required");

            $('#<%:frm_left_panel.ClientID%>').validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },
                rules: {
                    left_panel_status: {
                        required: true,
                        valueNotEquals: "",
                    },
                },
                messages: {
                    left_panel_status: {
                        required: "Choose a Status.",
                        valueNotEquals: "Choose a Status.",
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

            // Validation for Right panel
            // Validation specific codes
            $.validator.setDefaults({
                ignore: []
            });

            $.validator.addMethod("valueNotEquals", function (value, element, arg) {
                return arg != value;
            }, "Required");

            $.validator.addClassRules('score', {
                required: true
            });

            $.validator.addClassRules('rating', {
                required: true
            });

            $.validator.addClassRules('employer_comments', {
                required: true
            });

            $('#frm_right_panel').validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },
                rules: {
                    right_panel_status: {
                        required: true,
                        valueNotEquals: "",
                    },
                },
                messages: {
                    right_panel_status: {
                        required: "Choose a Status.",
                        valueNotEquals: "Choose a Status.",
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



            var selected_eligible_candidates = [];


            var interviewCandidates = {};

            function setInterviewCandidates() {
                var i = 0;
                $("#tbl_scheduled_candidates tbody tr").each(function () {

                    var currentRow = $(this);
                    if (currentRow.find("input[name='chkb_right']").prop('checked') == true) {
                        i += 1;
                        var col1_value = currentRow.find("td:eq(0)").text();
                        var col2_value = currentRow.find(".score").val();
                        var col3_value = currentRow.find(".rating").val();
                        var col4_value = currentRow.find(".employer_comments").val();
                        var jsonData = {};
                        jsonData['candidate_id'] = col1_value;
                        jsonData['score'] = col2_value;
                        jsonData['rating'] = col3_value;
                        jsonData['employer_comments'] = col4_value;
                        interviewCandidates[i] = jsonData;
                    };
                });
            };


            $('#btn_submit').click(function () {
                if ($('#<%:frm_left_panel.ClientID%>').valid()) {
                    if (NoEntriesSelected('frm_left_panel')) {
                        toastr.error("No entries selected!");
                        return false;
                    }

                    $.each($("input[name='chkb_left']:checked"), function () {
                        selected_eligible_candidates.push($(this).val());
                    });
                    $('#selected_eligible_candidates').val(selected_eligible_candidates);
                    $('#<%:btnSubmit.ClientID%>').click();

                }
            });


            $('#btn_update').click(function () {
                if ($('#frm_right_panel').valid()) {
                    if (NoEntriesSelected('frm_right_panel')) {
                        toastr.error("No entries selected");
                        return false;
                    }
                    setInterviewCandidates();
                    var datastring = JSON.stringify({ 'candidatesDetails': interviewCandidates, 'interview_id': <%:Request.QueryString["id"]%>, 'status': $('#right_panel_status').val() });
                    $.ajax({
                        url: 'SetInterview.aspx/UpdateCandidates',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                            toastr.info("Records Updated!");
                            location.reload();
                        },
                        error: function (error) {
                            toastr.error("Unable to complete process.");
                        }
                    });
                }
            });


        });
    </script>
</asp:Content>

