<%@ Page Language="C#" Title="Employer Reports" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerReport.aspx.cs" Inherits="recruiter_webapp.EmployerReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_reports" runat="server">
        <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">

                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>
        </div>
        <br />
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        <br />
        <div class="row no-padding">
            <div class="col s12 m12 l12 grey lighten-4 z-depth-0 no-padding">
                <div class="row">
                <div class="col s3 input-field">
                            <select id="employer" name="employer">
                                <%if (employer_id.Value == "0")
                                    {%>
                                <option value="2" selected>All Employers</option>
                                <%} %>
                                <%foreach (var employer in employerList)
                                    {%>
                                <option value="<%=employer["id"]%>" <%:employer_id.Value==employer["id"].ToString()?"selected":"" %>><%=employer["name"] %></option>
                                <%} %>
                            </select>
                            <label class="input-label" for="employer">Employer*</label>
                            <asp:HiddenField id="employer_id" Value="0" runat="server"/>
                        </div>
                    
                <div class="col s3 input-field">
                            <select id="job" name="job">
                                <option value="0" selected>All Jobs</option>
                                <%foreach (var job in jobList)
                                    {%>
                                <option value="<%=job["id"]%>"><%=job["job_code"] %></option>
                                <%} %>
                            </select>
                            <label class="input-label" for="job">Jobs*</label>
                            <asp:HiddenField id="job_id" Value="0" runat="server"/>
                        </div>

                    <div class="col s2 input-field">
                            <input type="text" class="datepicker" id="from_date" name="from_date" value="<%:DateTime.Now.Day.ToString("d2")+"-"+DateTime.Now.Month.ToString("d2")+"-"+DateTime.Now.Year%>" />
                            <label class="input-label" for="from_date">From</label>
                        <asp:HiddenField id="fromDate" runat="server" Value=""/>
                        </div>
                    <div class="col s2 input-field">
                            <input type="text" class="datepicker" id="to_date" name="to_date" value="<%:DateTime.Now.Day.ToString("d2")+"-"+DateTime.Now.Month.ToString("d2")+"-"+DateTime.Now.Year%>" />
                            <label class="input-label" for="to_date">To</label>
                        <asp:HiddenField id="toDate" runat="server" Value=""/>
                        </div>
            
                    <div class="input-field col s2">
                            <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="" Style="display: none" />
                            <asp:Button ID="btnRefresh" OnClick="btnRefresh_Click" runat="server" Text="" Style="display: none" />
                            <a class="btn waves-effect waves-light blue lighten-1" id="btn-search">Search<i class="material-icons right">search</i>
                            </a>
                        </div>

                </div>

                <div class="row">
                    <div class="col s10">   
                    <table>
                                <thead>
                                    <tr class="blue-grey lighten-4">
                                        <th class="font-weight-100">S.No</th>
                                        <th class="font-weight-100">Job Code</th>
                                        <th class="font-weight-100">Joining Date</th>
                                        <th class="font-weight-100">Int. Title</th>
                                        <th class="font-weight-100">Round</th>
                                        <th class="font-weight-100">Int. Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%foreach (var item in reportList)
                                        { %>
                                    <tr id="data-qualification">
                                        <td class="qualification"><%:item["row_number"]%></td>
                                        <td class="qualification"><%:item["job_code"]%></td>
                                        <td class="qualification"><%:item["join_date"]%></td>
                                        <td class="qualification"><%:item["title"]%></td>
                                        <td class="qualification"><%:item["round"]%></td>
                                        <td class="qualification"><%:item["date_of_interview"]%></td>
                                    </tr>
                                    <%
                                        }%>
                                </tbody>
                            </table>
                    <br /><br />
 
                    <a class="btn waves-effect waves-light blue lighten-1 right" id="btn-export">Export To Excel<i class="material-icons right">file_upload</i></a>
                    <asp:Button ID="btnExport" runat="server" Style="display: none" />

                    <p class="center">No interviews scheduled for this job.</p>

                    </div>
                        </div>
                
            </div>
        </div>
    </form>


    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(document).ready(function () {
            $('.datepicker').datepicker({
                maxDate: 0,
                dateFormat: 'dd-mm-yy',
                defaultDate: '<%:DateTime.Now.Day.ToString("d2")+"-"+DateTime.Now.Month.ToString("d2")+"-"+DateTime.Now.Year%>'
                //changeMonth: true,
                //changeYear: true,
            });


            $('#employer').change(function () {
                $('#<%:employer_id.ClientID%>').val($('#employer').val().trim());
                $('#<%:btnRefresh.ClientID%>').click();
            });

            $('#btn-search').click(function () {
                $('#<%:job_id.ClientID%>').val($('#job').val());
                $('#<%:fromDate.ClientID%>').val($('#from_date').val());
                $('#<%:toDate.ClientID%>').val($('#to_date').val());
                $('#<%:btnSearch.ClientID%>').click();
            });
        });
    </script>
</asp:Content>
