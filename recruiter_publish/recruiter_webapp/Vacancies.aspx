<%@ Page Language="C#" Title="Vacancies" MasterPageFile="~/SiteClient.Master" AutoEventWireup="true" CodeBehind="Vacancies.aspx.cs" Inherits="recruiter_webapp.Vacancies" %>

<%@ MasterType VirtualPath="~/SiteClient.Master" %>
<%@ Register Namespace="ASPnetControls" Assembly="ASPnetPagerV2_8" TagPrefix="cc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_vacancies" runat="server">
        <div class="row flex-parent">
            <div class="col s12 m3 l3 left flex-child">
                <div class="col s12 white" style="min-height: 560px; margin-top: 15px; margin-bottom: 15px; padding-left: 0px; padding-right: 0px">
                    <div class="red darken-3 padding-2 border-radius-5">
                        <div class="row">
                            <div class="input-field col s12 center filter">
                                <input type="text" id="job_code" name="job_code" class="pretty-box pretty-font" runat="server" />
                                <label class="input-label" for="job_code">Job Title</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12 textbox">
                                <input type="text" id="skill" name="skill" class="pretty-box pretty-font" />
                                <label class="input-label" for="skill">Key Skill</label>
                                <input hidden id="hdn_skill" value="0" />
                                <asp:HiddenField ID="skill_id" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s12 input-field filter">
                                <select id="cmb_industry" name="cmb_industry" class="white">
                                    <option value="0" selected>All Industries</option>
                                    <%foreach (var industry in industryList)
                                        {%>
                                    <option value="<%=industry["id"] %>" <%if (Request.QueryString["industry"] != null)
                                        {%><%:(Request.QueryString["industry"].ToString() == industry["id"].ToString()) ? "selected" : ""%><%}%>><%=industry["title"] %></option>
                                    <%} %>
                                </select>
                                <label class="input-label" for="industry">Industry</label>
                                <asp:HiddenField ID="industry" Value="0" runat="server" />
                                <asp:HiddenField ID="employer" Value="0" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12">
                                <select id="cmb_category" name="cmb_category">
                                    <option value="0" selected>All Categories</option>
                                    <%foreach (var category in categoryList)
                                        {%>
                                    <option value="<%=category["id"] %>" <%if (Request.QueryString["category"] != null)
                                        {%><%:(Request.QueryString["category"].ToString() == category["id"].ToString()) ? "selected" : ""%><%}%>><%=category["title"] %></option>
                                    <%} %>
                                </select>
                                <label class="input-label" for="category">Category</label>
                                <asp:HiddenField ID="category" Value="0" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s6 left filter">
                                <select id="cmb_min_exp" name="cmb_min_exp">
                                    <option value="0" selected></option>
                                    <%foreach (int i in Enumerable.Range(1, 21))
                                        { %>
                                    <option value="<%:i %>"><%:i %></option>
                                    <%} %>
                                </select>
                                <label class="input-label" for="min_exp">Minimum Experience</label>
                                <asp:HiddenField ID="min_exp" Value="0" runat="server" />
                            </div>
                            <div class="input-field col s6 right filter">
                                <select id="cmb_max_exp" name="cmb_max_exp">
                                    <option value="0" selected></option>
                                    <%foreach (int i in Enumerable.Range(1, 31))
                                        { %>
                                    <option value="<%:i %>"><%:i %></option>
                                    <%} %>
                                </select>
                                <label class="input-label" for="max_exp">Maximum Experience</label>
                                <asp:HiddenField ID="max_exp" Value="0" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s12">
                                <a href="<%:WebURL%>Vacancies?customer=<%:Request.QueryString["customer"]%>" class="btn waves-effect waves-light blue-grey darken-3 btn-search border-radius-5">Clear<i class="material-icons right">clear</i></a>
                                <a class="btn waves-effect waves-light blue-grey darken-3 btn-search right border-radius-5" id="btn-search2">Search<i class="material-icons right">search</i></a>
                                <asp:Button ID="btnSearch" runat="server" Text="" Style="display: none" OnClick="btnSearch_Click" />
                                <asp:Button ID="jobLink" runat="server" Text="" Style="display: none" OnClick="JobLink_Click" />
                                <asp:HiddenField ID="job_id" runat="server" Value="0" />
                            </div>
                        </div>
                    </div>
                    <div class="card red darken-3 padding-2 border-radius-5">
                        <div class="row">
                            <div class="col s12 center">
                                <b class="white-text" style="margin-top: 0px; font-size: 16px">By Industry</b>
                                <div class="white" style="font-size: 14px; min-height: 250px; max-height: 250px; overflow: auto">
                                    <table>
                                        <tbody>
                                            <%foreach (var industry in industryListWithJobCount)
                                                {%>
                                            <tr>
                                                <td>
                                                    <a name="<%:industry["id"] %>" class="black-text industry left-menu" href="<%:WebURL %>Vacancies?customer=<%:Request.QueryString["customer"]%>"><%:industry["title"].ToString().ToUpper()%> (<%:industry["count"]%>)</a>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                    </table>
                                    <asp:HiddenField ID="hdn_industry" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card red darken-3 padding-2 border-radius-5">
                        <div class="row">
                            <div class="col s12 center">
                                <b class="white-text" style="margin-top: 0px; font-size: 16px">By Employer</b>
                                <div class="white" style="font-size: 14px; min-height: 250px; max-height: 250px; overflow: auto">
                                    <table>
                                        <tbody>
                                            <%foreach (var employer in employerListWithJobCount)
                                                {%>
                                            <tr>
                                                <td>
                                                    <a name="<%:employer["id"]%>" class="black-text employer left-menu" href="<%:WebURL %>Vacancies?customer=<%:Request.QueryString["customer"]%>"><%:employer["name"].ToString().ToUpper()%> (<%:employer["count"]%>)</a>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                    </table>
                                    <asp:HiddenField ID="hdn_employer" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:Button ID="btnLink" runat="server" Text="" Style="display: none" OnClick="btnLink_Click" />
                </div>
            </div>

            <div class="col s12 m9 l9 right flex-child">
                <div class="col s12 lighten-3 border-radius-5" style="min-height: 560px; margin-top: 15px; margin-bottom: 15px; padding-left: 0px; padding-right: 0px">
                    <%if (employerList.Count > 0 && job_id.Value=="0" && hdn_employer.Value!="")
                            {%>
                    <div class="red darken-3 padding-1 border-radius-5">
                        <%foreach (var employer in employerList)
                            {%>
                        <h6 class="white-text"><%:employer["name"]%></h6>
                        <span class="white-text"><%:employer["description"]%></span>
                        <%} %>
                    </div>
                    <%} %>
                    <div class="col s12 white" style="min-height: 875px">
                        <div>
                           <b class="white-text">.</b>
                        </div>
                        <!--Listing of Vacancies begins-->
                        <%if (job_id.Value == "0")
                            {%>
                            <!-- Repeater begins -->
                            <%  if (jobList.Items.Count > 0){ %>
                                <asp:Repeater ID="jobList" runat="server">
                                <HeaderTemplate>
                                </HeaderTemplate>
                                <ItemTemplate>
                                <div class="col s12 white lighten-5 z-depth-1 pretty-font border-radius-5" style="min-height: 100px; opacity: <%#Convert.ToDateTime(Eval("join_date").ToString())>=DateTime.Now?1.0:0.5%>">
                                    <h6><a name="<%#Eval("id")%>" class="black-text job" href="<%=WebURL %>Vacancies?customer=<%:Request.QueryString["customer"]%>"><b class="grey-text text-darken-3"><%#Eval("job_code")%></b><b class="grey-text text-darken-1">(<%#Eval("min_exp")%> - <%#Eval("max_exp")%> yrs)</b></a></h6>
                                    <b class="grey-text text-darken-3"><%#Eval("industry_name")%></b> / <b class="grey-text text-darken-1"><%#Eval("category_name")%></b><br />
                                    <br />
                                    <%#Eval("description")%><br />
                                    <b>Key Skills:</b> <%#Eval("skills")%><br />
                                    <p class="left"><b>Vacancies:</b> <%#Eval("vacancy_count")%></p>
                                    <p class="right"><b>Posted On:</b> <%#Convert.ToDateTime(Eval("date_added")).ToShortDateString()%></p>
                                </div>
                                    <div>
                                        <b class="white-text">.</b>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                </FooterTemplate>
                                </asp:Repeater>
                            <%} %>
                            <!-- Repeater ends -->
                            <%if (jobList.Items.Count ==0){ %>
                                <p class="center">No Records Found!</p>
                            <%} %>
                        <%} %>
                        <!--Listing of Vacancies ends-->

                        <!--Job Details begins-->
                        <%if (job_id.Value != "0") { %>
                            <%if (jobDetailList.Count > 0){%>
                                <h5 class="grey-text darken-4 z-depth-1 padding-1 border-radius-5">Code: <%:jobDetailList[0]["job_code"]%> <b style="color: black"><%:jobDetailList[0]["title"]%></b> </h5>
                                <span class="right"><b>Date of Posting: </b><%:Convert.ToDateTime(jobDetailList[0]["date_added"]).ToShortDateString()%></span>
                        <div class="padding-2">
                                    <h6 style="font-size: 17px">Job Description</h6>
                                    <p><%:jobDetailList[0]["description"]%></p>
                                    <br />
                                    <b style="font-size: 17px">Employer: </b><%:jobDetailList[0]["employer"]%>
                                    <br />
                                    <span><%:jobDetailList[0]["employer_description"]%></span>
                                    <br/>
                                    <br />
                                    <b style="font-size: 17px">Industry: </b><b><%:jobDetailList[0]["industry"]%></b> / <%:jobDetailList[0]["category"]%>
                                    <br />
                                    <b style="font-size: 17px">Key Skills: </b><%:jobDetailList[0]["skills"]%>
                                    <br />
                                    <b style="font-size: 17px">Qualifications: </b><%:jobDetailList[0]["qualifications"]%>
                                    <br />
                                    <br />
                                    <b style="font-size: 17px">Vacancies: </b><%:jobDetailList[0]["vacancy_count"]%>
                                    <br />
                                    <br />
                                    <b style="font-size: 17px">Experience Required: </b><%:jobDetailList[0]["min_exp"]%> to <%:jobDetailList[0]["max_exp"]%> Yrs
                                    <br />
                                    <b style="font-size: 17px">Salary: </b><%:jobDetailList[0]["min_sal"]%> to <%:jobDetailList[0]["max_sal"]%> <%:jobDetailList[0]["currency"]%>
                                    <br />
                                    <b style="font-size: 17px">Other Details: </b><%:jobDetailList[0]["other_notes"]%>
                                    <br />
                                    <br />
                                    <b style="font-size: 17px">Date of Joining: </b><%:Convert.ToDateTime(jobDetailList[0]["join_date"]).ToLongDateString()%>
                                </div>
                                <div class="popupApply">
                                    <div class="poppupContent border-radius-10">
                                    <div class="row padding-1">
                                    <span class="close right">&times;</span>
                                    <div class="center padding-1">
                                        <a class="btn waves-effect waves-light red darken-3 border-radius-10" name="btn-login-apply" id="btn-login-apply">Login For Existing Users</a>
                                    </div>
                                    <div class="center padding-1">
                                        <a class="btn waves-effect waves-light red darken-3 border-radius-10" name="btn-new-apply" id="btn-new-apply">Register For New User</a>
                                    </div>
                                    </div>
                                    </div>
                                </div>
                            <%} %>
                            <!-- Apply buttons begin -->
                            <div class="row">
                                <div class="col s6">
                                    <% if (isCandidate || Session["user_id"]==null)
                                { %>
                                <%if (!isExpired)
                                {%>
                                <%if (!isApplied)
                                    { %>
                                <a class="btn waves-effect waves-light red darken-3 right border-radius-5" id="btn-apply">Apply Now</a>
                                <%}
                                else
                                {%>
                                <a class="btn waves-effect waves-light green lighten-1 right border-radius-5">Applied</a>
                                <%} %>
                                <%} %>
                                <%} %>
                                    </div>
                                <div class="col s6">
                                    <!-- Apply buttons end -->
                                    <asp:Button ID="btnApply" OnClick="btnApply_Click" runat="server" Text="" Style="display: none" />
                                    <a class="btn waves-effect waves-light blue-grey darken-3 left border-radius-5" id="btn-cancel">Cancel</a>
                                    <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" Text="" Style="display: none" />
                                </div>
                            </div>
                        <%} %>
                        <!--Job Details ends-->
                    </div>

                    <!-- Pagination Control -->
                    <asp:HiddenField ID="hdn_itemCount" runat="server" />
                    <div class="col s12 no-padding">
                        <%if (job_id.Value=="0"){ %>
                           <% if (jobList.Items.Count > 0){ %>
                                <div class="col s12 red darken-3 z-depth-1 white-text bold border-radius-5">
                                <cc:PagerV2_8 ID="pager1" runat="server"
                                OnCommand="pager_Command"
                                GenerateGoToSection="true" NormalModePageCount="3" PageSize="5" />
                                    
                                </div>
                        <%} %>
                           <% } %>
                    </div>




                    


                </div>
            </div>
        </div>
    </form>




    <script>
        $(document).ready(function () {
            
            $('#cmb_min_exp').change(function () {
                $('#<%:min_exp.ClientID%>').val($('#cmb_min_exp').val());
                $('#cmb_max_exp').empty();
                $('#cmb_max_exp').append('<option value="0" selected disabled></option>');
                for (var i = parseInt($('#cmb_min_exp').val()); i <= 31; i++) {
                    $('#cmb_max_exp').append('<option value="'+i+'">'+i+'</option>');
                }
                $('select').formSelect();
            });

            $('#cmb_max_exp').change(function () {
                $('#<%:max_exp.ClientID%>').val($('#cmb_max_exp').val());
            });

            


            $(".industry").on('click', function() {
                $('#<%:hdn_industry.ClientID%>').val(this.getAttribute('name'));
                $('#<%:hdn_employer.ClientID%>').val('0');
                $('#<%:skill_id.ClientID%>').val('0');
                $('#<%= btnLink.ClientID %>').click();
                return false;
            });

            $(".employer").on('click', function() {
                $('#<%:hdn_employer.ClientID%>').val(this.getAttribute('name'));
                $('#<%:hdn_industry.ClientID%>').val('0');
                $('#<%:skill_id.ClientID%>').val('0');
                $('#<%= btnLink.ClientID %>').click();
                return false;
            });

            $(".job").on('click', function () {
                $('#<%:job_id.ClientID%>').val(this.getAttribute('name'));
                $('#<%= jobLink.ClientID %>').click();
                return false;
            });

            $('.btn-search').click(function () {
                $('#<%:skill_id.ClientID%>').val($('#hdn_skill').val());
                $('#<%= btnSearch.ClientID %>').click();
            });

            $('#btn-cancel').click(function () {
                $('#<%= btnCancel.ClientID %>').click();
            });
        
            $("#skill").autocomplete({
                source: function (request, response) {
                    var param = { searchValue: $('#skill').val() };
                    $.ajax({
                        url: "Vacancies.aspx/GetSkillList",
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
                minLength: 1, //This is the Char length of inputTextBox
                select: function (event, ui) {
                    $('#hdn_skill').val(ui.item.id);
                }
            });




            $('#btn-apply').click(function () {
                <%if (Session["user_type"] == null)
        {%>
                $('.popupApply').show('slow');
                <%}
        else
        {%>
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

    <style>
        .pretty-font {
            font-size: 14px !important;
        }

        .pretty-box {
            background: #fff !important;
            border-radius: 5px !important;
            -moz-border-radius: 5px !important;
            -webkit-border-radius: 5px !important;
            padding-left: 10px !important;
            padding-right: 10px !important;
            box-sizing: border-box !important;
            height: 2em !important;
        }

        .select-wrapper input.select-dropdown {
            background: #fff !important;
            border-radius: 5px !important;
            -moz-border-radius: 5px !important;
            -webkit-border-radius: 5px !important;
            padding-left: 10px !important;
            padding-right: 10px !important;
            box-sizing: border-box !important;
            height: 2em !important;
            font-size: 14px !important;
        }

        .input-field label {
            color: white;
            padding-left: 10px;
        }

        

        .input-field label {
            font-size: 14px;
            color: black;
            top: -8px;
            padding-left: 15px;
        }

        .input-field input:focus + label {
            color: white !important;
        }

        .select-wrapper + label {
            top: -30px;
            color: white !important;
            font-size: 12px;
        }

        .left-menu {
            font-size: 12px;
            font-weight: bold;
        }

        .btn-search {
            margin: 0px;
        }

        .popupApply {
            display: none;
            position: fixed;
            z-index: 100; /* Sits on top */
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

            .PagerHyperlinkStyle {
                font-family: Arial, Helvetica, sans-serif;
                font-size: 16px;
                color: lightgray;
            }

            .PagerHyperlinkStyle strong {
                color: white;
                font-weight: bold;
            }
    </style>



</asp:Content>
