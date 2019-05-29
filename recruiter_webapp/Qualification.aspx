<%@ Page Title="Qualification" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Qualification.aspx.cs" Inherits="recruiter_webapp.Qualification" %>
<%@ Register Namespace="ASPnetControls" Assembly="ASPnetPagerV2_8" TagPrefix="cc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <div id="qualificationAddForm">
        <a href="<%=WebURL %>QualificationUpdate.aspx" class="btn waves-effect waves-light blue lighten-1" id="btn-insert">
                Add Qualification<i class="material-icons right">add</i></a>

        <div style="display:inline; padding: 0px 10px"></div>
        <asp:FileUpload ID="fileUpload" Style="display:none" runat="server" onchange="upload()"/>
        <asp:Button ID="btnUpload" OnClick="btnUpload_Click" runat="server" Style="display:none" Text=""/>
        <a class="btn waves-effect waves-light blue lighten-1" id="btn-upload" onclick="showBrowseDialog()">Upload File<i class="material-icons right">backup</i></a>
        <br />
        <br />
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
        </div>
        <div>
    </div>
    <br /><br />
    <div class="row">
        <div id="qualificationsForm">
            <% if (!this.displayUploadResult) { %> 
            <input type="hidden" name="srchBy" id="srchBy" value="title" runat="server" />
            <div class="input-field col s12 m12 l6">
                <input id="srchVal" name="srchVal" type="text" class="commenttextbox" runat="server" />
                <label for="srchVal">Search By Title</label>
            </div>
                <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="" Style="display: none" />
                <a class="btn waves-effect waves-light blue lighten-1" id="btn-serach" onclick="doSearch()">
                    Search<i class="material-icons right">search</i>
                </a>
            </div>
        </div>
               
    <div class="row">
        <div class="col s12 m12 l8">
            <% if (qualificationList.Items.Count > 0)
                {%>
            <asp:Repeater id="qualificationList" runat="server">
            <HeaderTemplate>
                    <table class="table center">
                <tr class="blue-grey lighten-4 bold">
                    <th class="center">#</th>
                    <th class="center">Title</th>
                    <th class="center">Actions</th>
                </tr>
                </HeaderTemplate>
                 <ItemTemplate>
                <tr>                    
                    <td class="center"><%#Eval("RowNumber")%></td>
                    <td class="center"><%#Eval("title")%></td>
                    <td class="center">
                        <a href="<%= WebURL %>QualificationUpdate?id=<%#Eval("id")%>">Edit</a>
                        <div style="display: inline; margin: 0px 5px; color: lightblue">|</div>
                        <a href="<%= WebURL %>Qualification/Delete?id=<%#Eval("id")%>" onclick="setId(<%#Eval("id")%>)">Delete </a>                        
                    </td>
                </tr>                       
                </ItemTemplate> 
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:repeater>

            <div class="blue-grey lighten-4 bold">
                <cc:PagerV2_8 ID="pager1" runat="server" 
                OnCommand="pager_Command" 
                GenerateGoToSection="true" NormalModePageCount="3" PageSize="3"
                />
            </div>
            
            <%} else {%>
            <p class="center">No Records Found!</p>
            <% } %>
            </div>
    </div>

    <%
    } else
        { %>
    <div class="row">
        <div class="col s12 m12 l8">
            <table class="table">
                <tr class="blue-grey lighten-4 bold">
                    <th class="center">ID</th>
                    <th class="center">Skill</th>
                    <th class="center"></th>
                </tr>
                <% foreach (var tr in QualificationListForDuplicates)
                    {
                %>
                <tr>
                    <td class="center"><%: tr["qua_id"] %> </td>
                    <td class="center"><%: tr["qua_title"] %> </td>
                </tr>
                <tr>
                    <td class="center"><%: tr["tmp_id"] %> </td>
                    <td class="center"><%: tr["tmp_title"] %> </td>
                    <td class="center">
                        <a href="#">Update</a>
                        <div style="display: inline; margin: 0px 5px; color: lightblue">|</div>
                        <a href="#">Discard</a>                        
                    </td>
                </tr>

                <%
                    }

    %>
            </table>
            
        </div>
    </div>
    <% } %>

<script>
    // Scripts for html anchors to asp button mapping
    function showBrowseDialog() {
        document.getElementById('<%= fileUpload.ClientID %>').click();
    }

    function upload() {
        document.getElementById('<%= btnUpload.ClientID %>').click();
    }

    function doSearch() {
        document.getElementById('<%= btnSearch.ClientID %>').click();
    }

    $(document).ready(function () {           

    });

</script>


</asp:Content>