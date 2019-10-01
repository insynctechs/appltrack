<%@ Page Language="C#" Title="Interview Results" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InterviewResults.aspx.cs" Inherits="recruiter_webapp.InterviewResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <div class="z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">
                <%if (Request.QueryString["employer_id"] != null && Request.QueryString["job_id"] != null)
                    {%>
                <h5>Dashboard <i class="material-icons">chevron_right</i> Jobs <i class="material-icons">chevron_right</i> <%: Title %></h5>
                <%}
                else
                { %>
                <h5>Dashboard <i class="material-icons">chevron_right</i> Reports <i class="material-icons">chevron_right</i> <%: Title %></h5>
                <%} %>
            </div>
        </div>
        <br />
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
           <div class="row">
            <div class="col s12">
                <div class="col s6 white z-depth-1 padding-3 border-radius-10">
                        <div class="row">
                            <div class="col s6 input-field">
                             <span class="center">Employer</span>
                                </div>
                                <div class="col s6 input-field">
                            <select id="employer" name="employer" <%:Request.QueryString["job_id"]!=null?"disabled":""%>>
                                <option value="0" <%:employer_id.Value=="0"?"selected":""%>>All</option>
                                <%foreach (var employer in employerList)
                                    {%>
                                <option value="<%=employer["id"]%>" <%:Request.QueryString["employer_id"]!=null?Request.QueryString["employer_id"]==employer["id"].ToString()?"selected":"":"" %> <%:employer_id.Value==employer["id"].ToString()?"selected":"" %>><%=employer["name"] %></option>
                                <%} %>
                            </select>
                            <asp:HiddenField id="employer_id" Value="0" runat="server"/>
                        </div>
                        </div>
                
                    <div class="row">
                        <div class="col s6 input-field">
                            <label>Job</label>
                            </div>
                                <div class="col s6 input-field">
                            <select id="job" name="job" <%:Request.QueryString["job_id"]!=null?"disabled":""%>>
                                <option value="0" <%:job_id.Value=="0"?"selected":""%>>All Jobs</option>
                                <%foreach (var job in jobList)
                                    {%>
                                <option value="<%=job["id"] %>" <%:Request.QueryString["job_id"]!=null?Request.QueryString["job_id"]==job["id"].ToString()?"selected":"":"" %> <%:job_id.Value==job["id"].ToString()?"selected":""%>><%=job["job_code"] %></option>
                                <%} %>
                            </select>
                            <asp:HiddenField id="job_id" Value="0" runat="server"/>
                        </div>
                    </div>

                        <div class="row">
                            <div class="col s6 input-field">
                                <label>Interview</label>
                            </div>
                            <div class="col s6 input-field">
                            <select id="interview" name="interview">
                                <option value="0" <%:Request.QueryString["interview_id"] == "0" ? "selected" : "" %>>All</option>
                                <%foreach (var interview in interviewList)
                                    {%>
                                <option value="<%=interview["id"] %>" <%:Request.QueryString["interview_id"] == interview["id"].ToString() ? "selected" : "" %>><%:interview["title"] %></option>
                                <%} %>
                            </select>
                            <asp:HiddenField id="interview_id" Value="0" runat="server"/>
                    </div>
                        </div>
                <%--
                    <div class="row">
                        <div class="col s6 input-field">
                            <label>From</label>
                            </div>
                                <div class="col s6 input-field">
                            <input type="text" class="datepicker" id="from_date" name="from_date" value="<%:DateTime.Now.Day.ToString("d2")+"-"+DateTime.Now.Month.ToString("d2")+"-"+DateTime.Now.Year%>" />
                        <asp:HiddenField id="fromDate" runat="server" Value=""/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s6 input-field">
                            <label>To</label>
                            </div>
                                <div class="col s6 input-field">
                            <input type="text" class="datepicker" id="to_date" name="to_date" value="<%:DateTime.Now.Day.ToString("d2")+"-"+DateTime.Now.Month.ToString("d2")+"-"+DateTime.Now.Year%>" />
                        <asp:HiddenField id="toDate" runat="server" Value=""/>
                        </div>
                    </div>
                        --%>
                    
                        <div class="row">
                            <a class="btn waves-effect waves-light blue lighten-1 right" id="btn-print" style="margin-left: 10px">Print<i class="material-icons right">print</i></a>
                            <a class="btn waves-effect waves-light blue lighten-1 right" id="btn-export">Export To Excel<i class="material-icons right">file_upload</i></a>
                    <asp:Button ID="btnExport" runat="server" OnClick="btn_Export_Click" Style="display: none" />
                    <asp:Button ID="btnPrint" runat="server" OnClick="btnPrint_Click" Style="display: none" />
                    <asp:Button ID="btnRefresh" OnClick="btnRefresh_Click" runat="server" Text="" Style="display: none" />

                        </div>
                    </div>
                    <div class="col s6">

                    </div>
                </div>

            </div>
        </form>

    <script>
        $(document).ready(function () {
            $('#employer').change(function () {
                $('#<%:employer_id.ClientID%>').val($('#employer').val().trim());
                $('#<%:btnRefresh.ClientID%>').click();
            });

            $('#job').change(function () {
                $('#<%:job_id.ClientID%>').val($('#job').val().trim());
                $('#<%:btnRefresh.ClientID%>').click();
            });

            $('#interview').change(function () {
                $('#<%:interview_id.ClientID%>').val($('#interview').val().trim());
            });

            $('#btn-export').click(function () {
                $('#<%:employer_id.ClientID%>').val($('#employer').val().trim());
                $('#<%:job_id.ClientID%>').val($('#job').val().trim());
                $('#<%:interview_id.ClientID%>').val($('#interview').val().trim());
                $('#<%:btnExport.ClientID%>').click();
            });

            $('#btn-print').click(function () {
                $('#<%:employer_id.ClientID%>').val($('#employer').val().trim());
                $('#<%:job_id.ClientID%>').val($('#job').val().trim());
                $('#<%:interview_id.ClientID%>').val($('#interview').val().trim());
                $('#<%:btnPrint.ClientID%>').click();
            });
        });
    </script>
    </asp:Content>
