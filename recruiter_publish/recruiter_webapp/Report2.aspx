<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report2.aspx.cs" Inherits="recruiter_webapp.Report2" %>

<form id="frm_reports" runat="server">
        <div class="row">
            <div class="col s8">
                <div class="row">
                   <div class="col s12" id="section-to-print">
                    <%if (resultList.Count > 0)
                        { %>
                       <div class="row center">
                           <a class="btn waves-effect waves-light blue lighten-1 border-radius-10" onclick="window.print();">Print</a>
                       </div>
                    <p class="center"><b>Interview Results generated on <%:DateTime.Now.ToLongDateString()%></b></p>
                       <table class="bordered" style="font-size: 12px">
                                <thead>
                                    <tr class="blue-grey lighten-4">
                                        <th class="font-weight-100">S.No</th>
                                        <th class="font-weight-100">Employer</th>
                                        <th class="font-weight-100">Job Code</th>
                                        <th class="font-weight-100">Title</th>
                                        <th class="font-weight-100">Round</th>
                                        <th class="font-weight-100">Venue</th>
                                        <th class="font-weight-100">Int. Date</th>
                                        <th class="font-weight-100">Candidate Name</th>
                                        <th class="font-weight-100">Score</th>
                                        <th class="font-weight-100">Rating</th>
                                        <th class="font-weight-100">Comments</th>
                                        <th class="font-weight-100">Status</th>
                                        <th class="font-weight-100">Status Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%foreach (var item in resultList)
                                        { %>
                   
                                    <tr id="data-qualification">
                                        <td class="qualification"><%:item["row_number"]%></td>
                                        <td class="qualification"><%:item["employer"]%></td>
                                        <td class="qualification"><%:item["job_code"]%></td>
                                        <td class="qualification"><%:item["title"]%></td>
                                        <td class="qualification"><%:item["round"]%></td>
                                        <td class="qualification"><%:item["venue"]%></td>
                                        <td class="qualification"><%:Convert.ToDateTime(item["date_of_interview"]).ToShortDateString()%></td>
                                        <td class="qualification"><%:item["candidate_name"]%></td>
                                        <td class="qualification"><%:item["score"]%></td>
                                        <td class="qualification"><%:item["rating"]%></td>
                                        <td class="qualification"><%:item["employer_comments"]%></td>
                                        <td class="qualification"><%:item["status"]%></td>
                                        <td class="qualification"><%:Convert.ToDateTime(item["date_added"]).ToShortDateString()%></td>
                                       
                                    </tr>
                                    <%
                                        }%>
                                </tbody>
                            </table>
                    <br /><br />
                    
                    <%} else {%> 
                    <p class="center">No records matching selected criteria.</p>
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
