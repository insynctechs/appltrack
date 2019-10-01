<%@ Page Language="C#" Title="Interview" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InterviewUpdate.aspx.cs" Inherits="recruiter_webapp.InterviewUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_interview" runat="server">
        <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">
                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>

        </div>
        <div class="row no-padding">
            <div class="col s12 m12 l7 card blue-grey lighten-4 z-depth-0 border-radius-5 no-margin padding-1">
                <% if (Request.QueryString["id"]!=null)

                    { %>
                <h6>Edit Interview for <%if (jobList.Count > 0)
                                 {%><%:jobList[0]["job_code"]%><%}%></h6>
                
                <%}
                    else
                    { %>
                <h6>Add Interview for <%if (jobList.Count > 0)
                                {%><%:jobList[0]["job_code"]%><%}%></h6>
                <%}%>
            </div>
        </div>


        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        <div class="row">
            <div class="input-field col s12 m12 l7 card white lighten-3 z-depth-3 padding-1 border-radius-5">
                <div class="col s12">
                    <input type="hidden" id="id" name="id" value="<%if (interviewList.Count > 0)
                        {%><%:interviewList[0]["id"]%><%}%>" />
                    <input type="hidden" id="job_id" name="job_id" value="<%=(Request.QueryString["job_id"]!=null)? Request.QueryString["job_id"] : ""%><% if (interviewList.Count > 0)
                        {%><%:interviewList[0]["job_id"]%><%}%>" />

                    <div class="row">
                        <div class="col s8 input-field">
                            <input type="text" id="title" name="title" value="<%if (interviewList.Count > 0)
                                {%><%:interviewList[0]["title"]%><%}%>" />
                            <label class="input-label" for="title">Title*</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col s12 input-field">
                            <textarea id="description" name="description"><%if (interviewList.Count > 0)
                                {%><%:interviewList[0]["description"]%><%}%></textarea>
                            <label class="input-label" for="description">Description*</label>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col s2 input-field">
                            <input type="number" id="round" name="round" class="number" min="1" max="5" value="<%if (interviewList.Count > 0)
                                {%><%:interviewList[0]["round"]%><%}%>" />
                            <label class="input-label" for="vacancy_count">Round*</label>
                        </div>


                    
                    <div class="col s10 input-field">
                        <input type="text" id="venue" name="venue" value="<%if (interviewList.Count > 0)
                            {%><%:interviewList[0]["venue"]%><%}%>" />
                        <label class="input-label" for="description">Venue*</label>
                    </div>
                        </div>
                    <div class="row">
                        <div class="col s4 input-field left">
                            Date of Interview*
                        <%--<input type="text" class="datepicker" id="date_of_inteview" name="date_of_interview" value="<%if (interviewList.Count > 0)
                            {%><%:Convert.ToDateTime(interviewList[0]["date_of_interview"]).Month+"/"+Convert.ToDateTime(interviewList[0]["date_of_interview"]).Day+"/"+Convert.ToDateTime(interviewList[0]["date_of_interview"]).Year%><%}%>"/> --%>
                            <input type="text" class="datepicker" id="date_of_inteview" name="date_of_interview" value="<%if (interviewList.Count > 0)
                                {%><%:Convert.ToDateTime(interviewList[0]["date_of_interview"]).Day.ToString("d2")+"-"+Convert.ToDateTime(interviewList[0]["date_of_interview"]).Month.ToString("d2")+"-"+Convert.ToDateTime(interviewList[0]["date_of_interview"]).Year%><%}%>"/>
                        </div>
                        <%--
                        <div class="col s4 input-field">
                            Time of Interview*
                            <input type="text" class="timepicker" id="time_of_inteview" name="time_of_interview"/>
                        </div>
                                --%>

                        <div class="col s4 input-field switch right">
                            <label>
                                Active<input type="checkbox" id="active" name="active" class="filled-in blue lighten-3" <%= (interviewList.Count > 0) ? (interviewList[0]["active"] == null) ? "checked" : (interviewList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                                <span class="lever"></span>
                            </label>
                        </div>
                    </div>

                    <div class="col s12 input-field right">
                        <a id="btn-submit" class="btn waves-effect waves-light blue lighten-1 right"><%:Request.QueryString["id"]!=null?"Update":"Submit"%></a>
                        <asp:Button Style="display: none" ID="btn_submit" CssClass="btn waves-effect waves-light blue lighten-1 right" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                    </div>

                </div>
            </div>
            <div class="col s12 m12 l5">
                <div class="col s12 m12 l12 card white lighten-3 z-depth-3 padding-2 border-radius-5 right" style="min-height: 445px">
                <div id="interviews-contain">
                            <table id="interviews" class="">
                                <thead>
                                    <tr class="blue-grey lighten-4">
                                        <th class="font-weight-100">Title</th>
                                        <th class="font-weight-100">Round</th>
                                        <th class="font-weight-100">Date</th>
                                        <th class="font-weight-100">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%if (interviewListForJob.Count > 0)
                                        {
                                            foreach (var interview in interviewListForJob)
                                            {
                                    %>
                                    <tr>
                                        <td><%:interview["title"]%></td>
                                        <td><%:interview["round"]%></td>
                                        <td><%:Convert.ToDateTime(interview["date_of_interview"]).ToShortDateString()%></td>
                                        <td><a class="btn-edit white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%=WebURL%>InterviewUpdate.aspx?id=<%:interview["id"]%>&job_id=<%:Request.QueryString["job_id"]%>">Edit</a>
                                        <a class="btn-remove white-text waves-light blue lighten-1 padding-2 border-radius-5" href="<%=WebURL%>InterviewUpdate/Delete?id=<%:interview["id"]%>&job_id=<%:Request.QueryString["job_id"]%>">Delete</a></td>
                                    </tr>
                                    <%}
                                        }%>
                                </tbody>
                            </table>
                        </div>
            </div>
            </div>
            

        </div>
        
    </form>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <style>
        .input-label {
            margin-left: 10px;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('.datepicker').datepicker(
                {
                minDate: 0,
                dateFormat: 'dd-mm-yy'
                }
            );
            $('.timepicker').timepicker();

            $('.close').click(function () {
                var closebtns = $(".qualification").get();
                alert(closebtns);
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

            $('#<%=frm_interview.ClientID%>').validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },
                rules: {
                    title: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    description: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    round: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                        regexMatch: "^([0-9]{1,2})$"
                    },
                    venue: {
                        required: true,
                        validateNullOrWhiteSpace: true,
                    },
                    date_of_interview: {
                        required: true,
                    },
                    time_of_inteview: {
                        required: true,
                    },
                },
                messages: {
                    title: {
                        required: "Required*",
                    },
                    description: {
                        required: "Required*",
                    },
                    round: {
                        required: "Required*",
                    },
                    venue: {
                        required: "Required*",
                    },
                    date_of_interview: {
                        required: "Required*",
                    },   
                    time_of_interview: {
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


            $('#btn-submit').click(function () {
                if ($('#<%=frm_interview.ClientID%>').valid()) {
                    document.getElementById('<%= btn_submit.ClientID %>').click();
                }
            });
        });


    </script>

</asp:Content>
