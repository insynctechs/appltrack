<%@ Page Language="C#" Title="Job Details" MasterPageFile="~/SiteClient.Master" AutoEventWireup="true" CodeBehind="JobDetails.aspx.cs" Inherits="recruiter_webapp.JobDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 <form id="frm_job" runat="server">
     <div class="col s12 white padding-2 border-radius-5" style="min-height: 560px; margin-top: 15px; margin-bottom: 15px">
                    <%if (jobDetailList.Count > 0)
                        {%>
                    <h5 class="grey lighten-3 z-depth-1 padding-1 border-radius-5"><%:jobDetailList[0]["job_code"]%></h5>
                    <div class="padding-2">
                        <h6>Job Description</h6>
                    <p><%:jobDetailList[0]["description"]%></p>
                    <p><b>Date of Posting: </b><%:Convert.ToDateTime(jobDetailList[0]["date_added"]).ToShortDateString()%></p>
                    <p><b>Industry: </b><%:jobDetailList[0]["industry"]%> / <%:jobDetailList[0]["category"]%></p>

                    <p><b>Key Skills: </b><%:jobDetailList[0]["skills"]%></p>
                    <p><b>Qualifications: </b><%:jobDetailList[0]["qualifications"]%></p>
                    <p><b>Vacancies: </b><%:jobDetailList[0]["vacancy_count"]%></p>
                    <p><b>Experience Required: </b><%:jobDetailList[0]["min_exp"]%> to <%:jobDetailList[0]["max_exp"]%> Yrs</p>
                    <p><b>Salary: </b><%:jobDetailList[0]["min_sal"]%> to <%:jobDetailList[0]["max_sal"]%> <%:jobDetailList[0]["currency"]%></p>
                    <p><b>Other Details: </b><%:jobDetailList[0]["other_notes"]%></p>
                    <p><b>Date of Joining: </b><%:Convert.ToDateTime(jobDetailList[0]["join_date"]).ToLongDateString()%></p>
                    </div>
                    
                    <%}%>
                

                    <div class="popupApply">
                        <div class="poppupContent border-radius-10">
                            <div class="row padding-1">
                                <span class="close right">&times;</span>
                                <div class="center padding-1">
                                    <a class="btn waves-effect waves-light blue lighten-1" name="btn-login-apply" id="btn-login-apply">Login For Existing Users</a>
                                </div>
                                <div class="center padding-1">
                                    <a class="btn waves-effect waves-light blue lighten-1" name="btn-new-apply" id="btn-new-apply">Register For New User</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 padding-2">
                            <% if (isCandidate)
                                     {
                                         if (!isApplied)
                                         { %>
                            <a class="btn waves-effect waves-light blue lighten-1 left" id="btn-apply">Apply Now</a>
                            <%}
                                     else
                                     {%>
                            <a class="btn waves-effect waves-light green lighten-1 left">Applied</a>
                            <%}
                                //} %>
                            <asp:Button ID="btnApply" OnClick="btnApply_Click" runat="server" Text="" Style="display: none" />

                            <a href="<%:WebURL%>Vacancies?customer=<%:Request.QueryString["customer"]%>" class="btn waves-effect waves-light blue lighten-1 right" id="btn-cancel">Cancel</a>
                                </div>
                           </div>
                    </div>
 </form>
                

        




    <style>
        .flex-parent {
            display: flex; /* equal height of the children */
        }

        .flex-child {
            display: flex;
        }

        .popupApply {
            display: none;
            position: fixed;
            z-index: 1; /* Sits on top */
            right: 0;
            top: 0;
            width: 100%;
            height: 100%;
            /*overflow: auto; */ /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        .poppupContent {
            background-color: #fefefe;
            padding: 10px;
            margin: auto;
            margin-top: 300px;
            border: 1px solid #888;
            width: 40%;
        }

        .close {
            color: #aaaaaa;
            /*float: right;*/
            font-size: 28px;
            font-weight: bold;
        }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }
    </style>

    <script>
        $(document).ready(function () {

            $('#btn-apply').click(function () {
                <%if (Session["user_type"] == null) {%>
                $('.popupApply').show('slow');
                <%} else {%>
                    document.getElementById('<%= btnApply.ClientID %>').click();
                <%}%>
            });

            $('.close').click(function () {
                $('.popupApply').hide('slow');
            });

            $('#btn-login-apply').click(function () {
                $('#btn-login-apply').webuiPopover({ url: '#login-form' });
            });

            $('#btn-new-apply').click(function () {
                var url = '<%:WebURL%>CandidateUpdate.aspx';
                window.location.replace(url);
            });
        });
    </script>

</asp:Content>
