<%@ Page Language="C#" Title="Interview Results" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InterviewResults.aspx.cs" Inherits="recruiter_webapp.InterviewResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">
                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>
        </div>
            <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>

        <div class="row">
            <div class="col s12 m12 l12 card card grey lighten-2 padding-1 border-radius-5 no-margin padding-1">
                <h6><%if (jobList.Count > 0)
                        { %>Results For <%:jobList[0]["job_code"] %><%} %></h6>
            </div>
            <div class="input-field col s12 m12 l12 card white lighten-3 z-depth-3 padding-3 border-radius-5">
                
                <div id="div_interview_results">
                    
                    <%if (ds.Tables.Count > 0)

                        { %>
                    <div class="row">
                        <div class="input-field col s6 m4 l4">
                            <select id="interview_id" name="interview_id">
                                <option value="0" <%:Request.QueryString["interview_id"]=="0"?"selected":"" %>>All</option>
                                <%foreach (var interview in interviewList)
                                    {%>
                                <option value="<%=interview["id"] %>" <%:Request.QueryString["interview_id"]==interview["id"].ToString()?"selected":"" %>><%:interview["title"] %></option>
                                <%} %>
                            </select>
                            <label class="input-label" for="location_id">Interview</label>
                            
                    </div>
                        <div class="input-field left">
                            <asp:Button ID="btnSubmit" CssClass="btn waves-effect waves-light blue lighten-1 right" runat="server" OnClick="btn_submit_Click" Text="Submit" />
                        </div>
                        
                        
                   
                        </div>
                    <div class="row">
                    
                        <%foreach (System.Data.DataTable table in ds.Tables)
                            { %>
                    <%if (table.Rows.Count > 0)
                        { %>
                            <h6><%:table.Rows[0]["title"] %> (Round <%:table.Rows[0]["round"] %>) On <%:Convert.ToDateTime(table.Rows[0]["date_of_interview"]).ToShortDateString() %></h6>
                           
                    <table class="">
                                <thead>
                                    <tr class="blue-grey lighten-4">
                                        <th class="font-weight-100">Candidate Name</th>
                                        <th class="font-weight-100">Status</th>
                                        <th class="font-weight-100">Score</th>
                                        <th class="font-weight-100">Rating</th>
                                        <th class="font-weight-100">Comments</th>
                                        <th class="font-weight-100">Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%foreach (System.Data.DataRow dr in table.Rows)
                                        { %>
                   
                                    <tr id="data-qualification">
                                        <td class="qualification"><%:dr["candidate_name"]%></td>
                                        <td class="qualification"><%:dr["status"]%></td>
                                        <td class="qualification"><%:dr["score"]%></td>
                                        <td class="qualification"><%:dr["rating"]%></td>
                                        <td class="qualification"><%:dr["employer_comments"]%></td>
                                        <td class="qualification"><%:dr["date_added"]%></td>
                                        <%--<td><a class="btn white-text waves-light blue lighten-1 padding-2 border-radius-5 right">Button</a></td>--%>
                                    </tr>
                                    <%
                                        }%>
                                </tbody>
                            </table>
                    <br /><br />
                    <%} %> 
                    <% } %>
                    <asp:Button ID="btn_export" CssClass="btn waves-effect waves-light blue lighten-1 right" runat="server" OnClick="btn_export_Click" Text="Export To Excel" />
                    <%}
                        else
                        {%>
                    <p class="center">No interviews scheduled for this job.</p>
                <%} %>
                        </div>
                    </div>
                
            </div>
            <div class="row">
                <div class="col s12">

                </div>
            </div>

        </div>

        </form>
    </asp:Content>
