<%@ Page Language="C#" Title="Customer Staffs" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="CustomerStaff.aspx.cs" Inherits="recruiter_webapp.CustomerStaff" %>

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

        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>

        <div class="row no-padding">
            <div class="col s12 m12 l12 card grey lighten-4 z-depth-0 no-padding">
                <div id="customersForm">
                    <input type="hidden" name="srchBy" id="srchBy" value="name" runat="server" />
                    <div class="col s12 l6">
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
                        <table class="table center">
                            <tr class="card blue-grey z-depth-1 lighten-4 bold">
                                <th class="center">#</th>
                                <th class="center">Name</th>
                                <th class="center">Designation</th>
                                <th class="center">Usertype</th>
                                <th class="center">Email</th>
                                <th class="center">Active</th>
                                <th class="center">Action</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr class="hoverable border-radius-5">
                            <td class="center"><%#Eval("RowNumber")%></td>
                            <td class="center"><a href="<%= WebURL %>CustomerStaffUpdate?id=<%#Eval("customer_staff_id")%>"><%#Eval("customer_staff_name")%></a></td>
                            <td class="center"><%#Eval("customer_staff_designation")%></td>
                            <td class="center"><%#Eval("customer_staff_user_type")%></td>
                            <td class="center"><%#Eval("customer_staff_email")%></td>
                            <td class="center">
                                <div class="switch">
                                    <label>
                                        <input type="checkbox" <%# Eval("customer_staff_active").ToString()=="1"?"Checked":"Unchecked" %> />
                                        <span class="lever"></span>
                                    </label>
                                </div>
                            </td>
                            <td class="center">
                                <a class="white-text waves-light blue lighten-1 padding-2 border-radius-5" style="margin:3px" href="<%= WebURL %>CustomerStaffUpdate?id=<%#Eval("customer_staff_id")%>">Edit</a>
                                <a class="btn-delete white-text waves-light blue lighten-1 padding-2 border-radius-5" style="margin:3px" href="<%= WebURL %>CustomerStaff/Delete?id=<%#Eval("customer_staff_id")%>">Delete</a>                              
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
        function doDelete(url) {
            $('a').webuiPopover({ title: 'Are you sure to delete?', content: '<a href="'+url+'">Yes</a><a class="right" href="2">No</a>'});
        };
 

        $(document).ready(function () {
            $('.btn-delete').click(function () {
                $(this).webuiPopover({ title: 'Sure to delete?', content: '<a href="'+this.getAttribute("href")+'">Yes</a>', closeable:true});
                return false;
            });
                     
        });
    </script>

</asp:Content>
