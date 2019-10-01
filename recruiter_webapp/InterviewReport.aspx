<%@ Page Language="C#" Title="Interview Report" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InterviewReport.aspx.cs" Inherits="recruiter_webapp.InterviewReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_reports" runat="server">
        <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">

                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>
        </div>
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        <div class="row no-padding">
            <div class="col s12">
                <div class="row">
                    <div class="col s6 white z-depth-1 padding-3 border-radius-10">
                        <div class="row">
                            <div class="col s6 input-field">
                                <span class="center">Employer</span>
                            </div>
                            <div class="col s6 input-field">
                                <select id="employer" name="employer">
                                    <option value="0" <%:employer_id.Value=="0"?"selected":""%>>All</option>
                                    <%foreach (var employer in employerList)
                                        {%>
                                    <option value="<%=employer["id"]%>" <%:employer_id.Value==employer["id"].ToString()?"selected":"" %>><%=employer["name"] %></option>
                                    <%} %>
                                </select>
                                <asp:HiddenField ID="employer_id" Value="0" runat="server" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col s6 input-field">
                                <label>Job</label>
                            </div>
                            <div class="col s6 input-field">
                                <select id="job" name="job">
                                    <option value="0" selected>All Jobs</option>
                                    <%foreach (var job in jobList)
                                        {%>
                                    <option value="<%=job["id"] %>"><%=job["job_code"] %></option>
                                    <%} %>
                                </select>
                                <asp:HiddenField ID="job_id" Value="0" runat="server" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col s6 input-field">
                                <label>From</label>
                            </div>
                            <div class="col s6 input-field">
                                <input type="text" class="datepicker" id="from_date" name="from_date" value="" placeholder="All Dates" />
                                <asp:HiddenField ID="fromDate" runat="server" Value="" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s6 input-field">
                                <label>To</label>
                            </div>
                            <div class="col s6 input-field">
                                <input type="text" class="datepicker" id="to_date" name="to_date" value="" placeholder="All Dates" />
                                <asp:HiddenField ID="toDate" runat="server" Value="" />
                            </div>
                        </div>

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
        </div>
    </form>


    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(document).ready(function () {

            $.datepicker.setDefaults({
                dateFormat: 'dd-mm-yy'
            });
            $('#from_date').datepicker({
                maxDate: '0',
                onSelect: function (dateStr) {
                    var min = $(this).datepicker('getDate') || new Date(); // Selected date or today if none
                    var max = 0;
                    $('#to_date').datepicker('option', { minDate: min, maxDate: max });
                    if ($('#to_date').val() == '') {
                        $('#to_date').val($('#from_date').val());
                    }
                }
            });

            $('#to_date').datepicker({
                maxDate: '0',
                onSelect: function (dateStr) {
                    var max = $(this).datepicker('getDate'); // Selected date or null if none
                    $('#from_date').datepicker('option', { maxDate: max });
                    if ($('#from_date').val() == '') {
                        $('#from_date').val($('#to_date').val());
                    }
                }

            });

            $('#employer').change(function () {
                $('#<%:employer_id.ClientID%>').val($('#employer').val().trim());
                $('#<%:btnRefresh.ClientID%>').click();
            });



            $('#btn-export').click(function () {
                $('#<%:job_id.ClientID%>').val($('#job').val());
                $('#<%:fromDate.ClientID%>').val($('#from_date').val());
                $('#<%:toDate.ClientID%>').val($('#to_date').val());
                $('#<%:btnExport.ClientID%>').click();
            });

            $('#btn-print').click(function () {
                $('#<%:job_id.ClientID%>').val($('#job').val());
                $('#<%:fromDate.ClientID%>').val($('#from_date').val());
                $('#<%:toDate.ClientID%>').val($('#to_date').val());
                $('#<%:btnPrint.ClientID%>').click();
            });
        });
    </script>
</asp:Content>

