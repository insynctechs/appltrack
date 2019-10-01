<%@ Page Language="C#" Title="Reports" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="recruiter_webapp.Report" %>
    <form id="frm_reports" runat="server">
        <div class="row">
            <div class="col s8">
                <div class="row">
                    <div class="col s12" id="section-to-print">
                        <%if (reportList.Count > 0) {%>
                        <div class="row center">
                            <a class="btn waves-effect waves-light blue lighten-1 border-radius-10" onclick="window.print();">Print</a>
                        </div>
                    <p class="center"><b>Interview Report generated on <%:DateTime.Now%></b></p>
                        <%if (Request.QueryString["from_date"] != "" && Request.QueryString["to_date"] != "")
                            {%><p class="center"><b>(<%:Request.QueryString["from_date"]%> to <%:Request.QueryString["to_date"]%>)</b></p> <%} %>
                    <table class="bordered" style="font-size: 12px">
                                <thead>
                                    <tr class="blue-grey lighten-4">
                                        <th class="font-weight-100">S.No</th>
                                        <th class="font-weight-100">Employer</th>
                                        <th class="font-weight-100">Job Code</th>
                                        <th class="font-weight-100">Joining Date</th>
                                        <th class="font-weight-100">Int. Title</th>
                                        <th class="font-weight-100">Round</th>
                                        <th class="font-weight-100">Venue</th>
                                        <th class="font-weight-100">Int. Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%foreach (var item in reportList)
                                        { %>
                                    <tr id="data-qualification">
                                        <td class="qualification"><%:item["row_number"]%></td>
                                        <td class="qualification"><%:item["employer"]%></td>
                                        <td class="qualification"><%:item["job_code"]%></td>
                                        <td class="qualification"><%:Convert.ToDateTime(item["join_date"]).ToShortDateString()%></td>
                                        <td class="qualification"><%:item["title"]%></td>
                                        <td class="qualification"><%:item["round"]%></td>
                                        <td class="qualification"><%:item["venue"]%></td>
                                        <td class="qualification"><%:Convert.ToDateTime(item["date_of_interview"]).ToShortDateString()%></td>
                                    </tr>
                                    <%
                                    }%>
                                </tbody>
                            </table>
                          
                    <br /><br />
                    
                        <%} else { %>
                    <p class="center">No interviews scheduled for this job.</p>
                        <%} %>
                    </div>
                        </div>
            </div>
        </div>
    </form>

<script src="/Scripts/materialize.js"></script>
<link rel="stylesheet" href="/Styles/materialize.css">

<style>
    td {
      padding: 5px;
    }
    p {
        margin: 5px;
    }
    @media print {
  
  body * {
    visibility: hidden;
  }
  #section-to-print, #section-to-print * {
    visibility: visible;
  }
  #section-to-print {
    position: absolute;
    left: 0;
    top: 0;
  }
  .btn {
    display: none;
  }
}
</style>