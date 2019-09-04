<%@ Page Language="C#" Title="Vacancies" MasterPageFile="~/SiteClient.Master" AutoEventWireup="true" CodeBehind="Vacancies.aspx.cs" Inherits="recruiter_webapp.Vacancies" %>
<%@ MasterType VirtualPath="~/SiteClient.Master" %>
<%@ Register Namespace="ASPnetControls" Assembly="ASPnetPagerV2_8" TagPrefix="cc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Search results from here on -->
    <div class="row">
        <%if (jobList.Items.Count > 0)
                { %>
        <div class="col s12 m12 l12">
            
            <asp:Repeater ID="jobList" runat="server">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>

                    <div class="col s12 card blue lighten-5 z-depth-1" style="min-height: 100px">
                        <h6><a href="<%=WebURL %>JobDetails?customer=<%:Request.QueryString["customer"]%>&job_id=<%#Eval("id")%>"><%#Eval("job_code")%> (<%#Eval("min_exp")%> - <%#Eval("max_exp")%> yrs)</a></h6>
                        <p><%#Eval("industry_name")%> / <%#Eval("category_name")%></p>
                        <p><%#Eval("description")%></p>
                        <p class="left">Vacancies: <%#Eval("vacancy_count")%></p>
                        <p class="right">Posted On: <%#Convert.ToDateTime(Eval("date_added")).ToShortDateString()%></p>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                </FooterTemplate>
            </asp:Repeater>

        </div>
        <div class="col s12">
            <div class="col s12 card blue-grey lighten-4 bold bottom">
                                <cc:PagerV2_8 ID="pager1" runat="server"
                                    OnCommand="pager_Command"
                                    GenerateGoToSection="true" NormalModePageCount="3" PageSize="3" />
                </div>
        </div>
                

        <%}
                else
                {%>
            <p class="center">No Records Found!</p>
            <% } %>
    </div>





</asp:Content>
