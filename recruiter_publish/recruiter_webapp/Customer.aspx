<%@ Page Title="Customer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="recruiter_webapp.Customer" %>

<%@ Register Namespace="ASPnetControls" Assembly="ASPnetPagerV2_8" TagPrefix="cc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <div class="card z-depth-1 border-radius-5">
            <div class="row">
                <div class="col s12">
                    <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
                </div>
            </div>
        </div>
        <div class="row no-padding">
            <div class="col s12 m12 l6 no-margin no-padding">
                <a href="<%= WebURL %>CustomerUpdate.aspx" class="btn waves-effect waves-light blue lighten-2" id="btn-insert">Add Customer<i class="material-icons right">add</i>
                </a>
            </div>
        </div>

        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>

        <div class="row no-padding">
            <div class="col s12 m12 l12 card grey lighten-4 z-depth-0 no-padding">
                <div id="customersForm">
                    <input type="hidden" name="srchBy" id="srchBy" value="name" runat="server" />
                    <div class="col s12 l6 no-padding">
                        <div class="input-field col s8">
                            <input id="srchVal" name="srchVal" type="text" class="commenttextbox" runat="server">
                            <label for="srchVal">Search By Name</label>
                        </div>
                        <div class="input-field col s4">
                            <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="" Style="display: none" />
                            <a class="btn waves-effect waves-light blue lighten-1 right" id="btn-search" onclick="doSearch()">Search<i class="material-icons right">search</i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="row">
            <div class="col s12 m12 l12">
                <%if (customerList.Items.Count > 0)
                    { %>
                <asp:Repeater ID="customerList" runat="server">
                    <HeaderTemplate>
                        <table class="table striped center">
                            <tr class="card blue-grey z-depth-1 lighten-4 bold">
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
                        <tr class="hoverable border-radius-5">
                            <td class="center"><%#Eval("RowNumber")%></td>
                            <td class="center"><a href="<%= WebURL %>CustomerUpdate?id=<%#Eval("id")%>"><%#Eval("name")%></a></td>
                            <td class="center"><%#Eval("address")%></td>
                            <td class="center"><%#Eval("city")%></td>
                            <td class="center"><%#Eval("state")%></td>
                            <td class="center"><%#Eval("contact")%></td>
                            <td class="center"><%#Eval("email")%></td>
                            <td class="center">
                                <div class="switch">
                                    <label>
                                        <input type="checkbox" <%# Eval("active").ToString()=="1"?"Checked":"Unchecked" %> />
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                            <td class="center">
                                <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" style="margin:3px" href="<%= WebURL %>CustomerUpdate?id=<%#Eval("id")%>">Edit</a>
                                <a class="btn-delete white-text waves-light blue lighten-1 padding-2 border-radius-5" style="margin:3px" href="<%= WebURL %>Customer/Delete?id=<%#Eval("id")%>">Delete</a>                              
                                <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" style="margin:3px" href="<%= WebURL %>CustomerStaffUpdate?customer_id=<%#Eval("id")%>" ">Add Staff</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="card blue-grey lighten-4 bold">
                    <cc:PagerV2_8 ID="pager1" runat="server"
                        OnCommand="pager_Command"
                        GenerateGoToSection="true" NormalModePageCount="3" PageSize="3" />
                </div>

                <%}
                    else
                    {%>
                <p class="center">No Records Found!</p>
                <% } %>
            </div>
        </div>


            </div>
        </div>


        

    </form>




    <script>
        // Scripts for html anchors to asp button mapping
        function doSearch() {
            document.getElementById('<%= btnSearch.ClientID %>').click();
        };
        function doDelete() {
            $(this).webuiPopover({ title: 'Are you sure to delete?', content: '<a href="#">Yes</a><a class="right" href="2">No</a>' });
        };

        $(document).ready(function () {
            $('.btn-delete').on('focus', function () {

                $(this).webuiPopover('destroy'); // the trick
                $(this).webuiPopover({
                    placement: 'left',
                    title: 'Sure to delete?',
                    content: '<a href="' + this.getAttribute("href") + '">Yes</a>',
                    closeable: true,
                    cache: false
                });
            });

        });
    </script>

</asp:Content>

