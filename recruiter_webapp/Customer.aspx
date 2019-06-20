<%@ Page Title="Customer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="recruiter_webapp.Customer" %>
<%@ Register Namespace="ASPnetControls" Assembly="ASPnetPagerV2_8" TagPrefix="cc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<form runat="server">
     <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <div id="customersAddDiv">
        <a href="<%= WebURL %>CustomerUpdate.aspx" class="btn waves-effect waves-light blue lighten-1" id="btn-insert">
                Add Customer<i class="material-icons right">add</i>
        </a>
        <br />
        <br />
       
        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
    </div>
    <div>
    </div>
    <br /><br />
    <div class="row">
        <div id="customersForm">
            <input type="hidden" name="srchBy" id="srchBy" value="name" runat="server" />
            <div class="input-field col s12 m12 l6">
                <input id="srchVal" name="srchVal" type="text" class="commenttextbox" runat="server">
                <label for="srchVal">Search By Name</label>
            </div>            
            <asp:Button ID="btnSearch" onclick="btnSearch_Click" runat="server" Text="" Style="display: none"/>
            <a class="btn waves-effect waves-light blue lighten-1" id="btn-search" onclick="doSearch()">
                Search<i class="material-icons right">search</i>
            </a>
        </div>
    </div>

                    
    <div class="row">
        <div class="col s12 m12 l12">
            <%if (customerList.Items.Count > 0)
                { %>
        <asp:repeater id="customerList" runat="server">          
                <HeaderTemplate>
                    <table class="table center">
                <tr class="blue-grey lighten-4 bold">
                    <th class="center">#</th>
                    <th class="center">Name</th>
                    <th class="center">Address</th>
                    <th class="center">City</th>
                    <th class="center">State</th>
                    <th class="center">Contact</th>
                    <th class="center">Email</th>
                    <th class="center">Active</th>
                    <th class="center">Action</th>
                </tr>
                </HeaderTemplate>
                <ItemTemplate>
                <tr>                    
                    <td class="center"><%#Eval("RowNumber")%></td>
                    <td class="center"><a href="<%= WebURL %>CustomerView?id=<%#Eval("id")%>"><%#Eval("name")%></a></td>
                    <td class="center"><%#Eval("address")%></td>
                    <td class="center"><%#Eval("city")%></td>
                    <td class="center"><%#Eval("state")%></td>
                    <td class="center"><%#Eval("contact")%></td>
                    <td class="center"><%#Eval("email")%></td>
                    <td class="center"><%#Eval("active")%></td>
                    <td class="center">
                        <a href="<%= WebURL %>CustomerUpdate?id=<%#Eval("id")%>">Edit</a>
                        <div style="display: inline; margin: 0px 5px; color: lightblue">|</div>
                        <a href="<%= WebURL %>Customer/Delete?id=<%#Eval("id")%>" onclick="setId(<%#Eval("id")%>)">Delete </a>                        
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

</form>

   


<script>
    // Scripts for html anchors to asp button mapping

    function doSearch() {
        document.getElementById('<%= btnSearch.ClientID %>').click();
    }

    $(document).ready(function () {           

    });

</script>

</asp:Content>

