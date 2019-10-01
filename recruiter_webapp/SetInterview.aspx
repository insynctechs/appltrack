<%@ Page Language="C#" Title="Set Interview" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SetInterview.aspx.cs" Inherits="recruiter_webapp.SetInterview" %>

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
            <div class="input-field col s12 m12 l6" style="padding: 0px 5px 0px 0px">
                <div class="col s12 m12 l12 card white lighten-3 z-depth-3 no-margin border-radius-5 right" style="min-height: 490px; max-height: 490px; padding: 5px 10px 5px 10px">
                    
                    <div class="row">
                        <div class="col s8">
                            <h6 class="right"><b>Applied / Eligible Candidates</b></h6>
                        </div>
                        <div class="col s4 right">
                            <select id="cmb_status" name="cmb_status">
                                <option value="all" <%:Request.QueryString["status"]==null || Request.QueryString["status"]=="all"? "selected":"" %>>All</option>
                                <option value="applied" <%:Request.QueryString["status"]=="applied"? "selected":"" %>>Applied</option>
                                <option value="eligible" <%:Request.QueryString["status"]=="eligible"? "selected":"" %>>Eligible</option>
                            </select>
                        </div>  
                    </div>
                    
                    <div id="div_candidates" style="min-height: 350px; max-height: 350px; overflow: auto">
                        <table id="tbl_candidates" class="">
                            <thead>
                                <tr class="blue-grey lighten-4">
                                    <th class="center"><b>Name</b></th>
                                    <th class="center"><b>Profile</b></th>
                                    <th class="center"><b>Applied</b></th>
                                    <th class="center"><b>Eligible</b></th>
                                    <th class="center"><b>Notification</b></th>
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
                                    <td class="center">
                                        <input type="hidden" class="status" value="<%:candidate["status"]%>" />
                                        <%if (candidate["status"].ToString() == "1")
                                            { %>
                                        <span><i class="material-icons">check</i></span>
                                        <%}
                                        else
                                        {%>
                                        <span><i class="material-icons">clear</i></span>
                                        <%} %> 
                                    </td>
                                    <td class="center">
                                        <%if (candidate["status"].ToString() == "0" || candidate["status"].ToString() == "7")
                                            { %>
                                        <span><i class="material-icons">check</i></span>
                                        <%}
                                        else
                                        {%>
                                        <span><i class="material-icons">clear</i></span>
                                        <%} %>
                                    </td>
                                    <td class="center">
                                        <%if (candidate["status"].ToString() == "7")
                                            { %>
                                        <span><i class="material-icons">notifications</i></span>
                                        <%} %>
                                    </td>
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
            <div class="input-field col s12 m12 l6" style="padding: 0px 0px 0px 5px">
                <div class="col s12 m12 l12 card white lighten-3 z-depth-3 no-margin border-radius-5 right" style="min-height: 490px; max-height: 490px; padding: 5px 10px 5px 10px">
                    <div class="row" style="min-height: 52px">
                        <div class="col s12">
                            <h6 class="center"><b>Scheduled Candidates</b></h6>
                        </div>
                    </div>
                    
                    <div id="div_scheduled_candidates" style="min-height: 350px; max-height: 350px; overflow: auto">
                        <table id="tbl_scheduled_candidates" class="table">
                            <thead>
                                <tr class="blue-grey lighten-4">
                                    <th hidden></th>
                                    <th class="center"><b>Name</b></th>
                                    <th class="center"><b>Status</b></th>
                                    <th class="center"><b>Rating</b></th>
                                    <th class="center"><b>Score</b></th>
                                    <th class="center"><b>Comments</b></th>
                                    <%--<th class="font-weight-100"></th> --%>
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
                                    <td class=""><%:candidate["name"]%></td>
                                    <td class="center"><%:candidate["status"]%></td>
                                    <td class="center" style="max-width:10px">
                                        <input class="score" type="number" value="<%:candidate["score"]%>" min="0" /></td>
                                    <td class="cneter" style="max-width:10px">
                                        <input class="rating" type="number" value="<%:candidate["rating"]%>" min="0" /></td>
                                    <td class="center" style="max-width:100px">
                                        <input class="employer_comments" type="text" value="<%:candidate["employer_comments"]%>" /></td>
                                    <%--<td><a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" style="margin: 3px" href="#">Update</a></td> --%>
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

            $('#cmb_status').change(function () {
                var url = '<%=WebURL%>SetInterview.aspx?id=<%=Request.QueryString["id"]%>&job_id=<%=Request.QueryString["job_id"]%>&status='+$('#cmb_status').val();
                window.location.replace(url);
            });

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
                    if ($('#left_panel_status').val() == "2" && !NoEntriesSelected('frm_left_panel') && !IsAllApplied()) {
                        toastr.error("Selected action not supported for selected entries!");
                        return false;
                    }

                    if ($('#left_panel_status').val() == "7" && !NoEntriesSelected('frm_left_panel') && !IsAllEligible()) {
                        toastr.error("Selected action not supported for selected entries!");
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
