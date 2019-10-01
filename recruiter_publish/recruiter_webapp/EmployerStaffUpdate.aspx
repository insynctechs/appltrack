<%@ Page Language="C#" Title="Employer Staff" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerStaffUpdate.aspx.cs" Inherits="recruiter_webapp.EmployerStaffUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_employer_staff" runat="server">
        <div class="card z-depth-1 border-radius-5">
            <div class="row">
                <div class="col s12">
                    <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
                </div>
            </div>
        </div>
        <div class="row no-padding">
            <div class="col s12 m12 l8 card grey lighten-2 padding-1 border-radius-5 no-margin padding-1">
                <% if (string.IsNullOrEmpty(Request.QueryString["id"]))

                    { %>
                <h6>Add Staff for <%if (employerList.Count > 0)
                                      {%><%:employerList[0]["name"]%><%}%></h6>
                <%}
                    else
                    { %>
                <h6>Edit Staff - <%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["name"]%><%}%></h6>
                <%}%>
            </div>
        </div>

        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>

        <div class="row">
            <div class="col s12 m12 l8 card white lighten-3 z-depth-3 padding-3 border-radius-5">

                <input type="hidden" id="employer_id" name="employer_id" value="<%if (employerList.Count > 0)
                    {%><%:employerList[0]["id"]%><%}%>" />
                <%if (employerStaffList.Count > 0)
                    { %>
                <input type="hidden" id="id" name="id" value="<%if (employerStaffList.Count > 0)
                    {%><%:employerStaffList[0]["id"]%><%}%>" />
                <%} %>
 
                    <input type="hidden" id="employer_name" name="employer_name" value="<%if (employerList.Count > 0)
                        {%><%:employerList[0]["name"]%><%}%>" />

                <div class="row">
                    <div class="col s8 input-field">
                        <select id="employer_loc_id" name="employer_loc_id" <%:(employerLocationList.Count==0)?"disabled":"" %>>
                            <% foreach (var location in locations)
                                { %>
                            <option value="<%=location.Key %>" <%=(location.Key=="") ? "disabled" : "" %> <%=(((employerStaffList.Count > 0) && employerStaffList[0]["employer_location_id"].ToString()== location.Key) || location.Key=="") ? "selected" : "" %>><%=location.Value%></option>
                            <%} %>
                        </select>
                    </div>
                    <div class="col s4 input-field">
                        <select id="user_type" name="user_type">
                            <% foreach (var user_type in user_types)
                                { %>
                            <option value="<%=user_type.Key %>" <%=(user_type.Key=="") ? "disabled" : "" %> <%=(((employerStaffList.Count > 0) && employerStaffList[0]["user_type"].ToString()== user_type.Key) || user_type.Key=="") ? "selected" : "" %>><%=user_type.Value%></option>
                            <%} %>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col s8 input-field">
                        <input type="text" id="name" name="name" value="<%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["name"]%><%}%>" />
                        <label class="input-label" for="name">Name*</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col s8 input-field">
                        <input type="text" id="designation" name="designation" value="<%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["designation"]%><%}%>" />
                        <label class="input-label" for="designation">Designation*</label>
                    </div>

                    <div class="col s4 input-field">
                        <select id="gender" name="gender">
                            <% foreach (var gender in genders)
                                { %>
                            <option value="<%=gender.Key %>" <%=(gender.Key=="") ? "disabled" : "" %> <%=(((employerStaffList.Count > 0) && employerStaffList[0]["gender"].ToString().Trim()== gender.Key) || gender.Key=="") ? "selected" : "" %>><%=gender.Value%></option>
                            <%} %>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col s12 input-field">
                        <textarea id="address" name="address"><%if (employerStaffList.Count > 0){%><%:employerStaffList[0]["address"]%><%}%></textarea>
                        <label class="input-label" for="address">Address*</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col s6 input-field">
                        <input type="text" id="email" name="email" value="<%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["email"]%><%}%>" />
                        <label class="input-label" for="email">Email*</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="phone" name="phone" value="<%if (employerStaffList.Count > 0)
                            {%><%:employerStaffList[0]["phone"]%><%}%>" />
                        <label class="input-label" for="phone">Phone*</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col s4 input-field switch left">
                        <label>
                            Active<input type="checkbox" id="active" name="active" class="filled-in blue lighten-3" <%= (employerStaffList.Count > 0) ? (employerStaffList[0]["active"] == null) ? "checked" : (employerStaffList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                            <span class="lever"></span>
                        </label>
                    </div>

                    <div class="col s4 input-field">
                        <label class="input-checkbox">
                            <input type="checkbox" id="notification" class="filled-in blue lighten-3" />
                            <span>Send Notification</span>
                        </label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field s4 right">
                        <a id="btn_submit" class="btn waves-effect waves-light blue lighten-1 right"><%:Request.QueryString["id"]!=null?"Update":"Submit"%></a>
                        <asp:Button Style="display: none" ID="btnSubmit" CssClass="btn waves-effect waves-light blue lighten-1 right" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        $(document).ready(function () {

            $.validator.setDefaults({
                ignore: []
            });

            // For select input
            $.validator.addMethod("valueNotEquals", function (value, element, arg) {
                return arg !== value;
            }, "Value must not equal arg.");

            $.validator.addMethod("regexMatch", function (value, element, regexp) {
                var regex = new RegExp(regexp);
                return this.optional(element) || regex.test(value);
            },
                "Not a valid input!"
            );

            $("#<%:frm_employer_staff.ClientID%>").validate({
                // Specify validation rules
                rules: {
                    name: "required",
                    address: "required",
                    designation: "required",
                    employer_loc: { required: true },
                    user_type: { required: true },
                    gender: { required: true },
                    email: {
                        required: true,
                        regexMatch: "[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
                    },
                    phone: {
                        required: true,
                        regexMatch: "^[0-9+()\/-]{5,20}$"
                    },
                },
                messages: {
                    name: {
                        required: "Required*",
                    },
                    address: {
                        required: "Required*",
                    },
                    designation: {
                        required: "Required*",
                    },
                    employer_loc: {
                        required: "Please select a location."
                    },
                    user_type: {
                        required: "Please select user type."
                    },
                    gender: {
                        required: "Please select a Gender."
                    },
                    phone: {
                        required: "Required*",
                        regexMatch: "Please enter valid phone number",
                    },
                    email: {
                        required: "Required*",
                        regexMatch: "Please enter a valid email address.",
                    },
                },
                errorElement: 'div',
                errorPlacement: function (error, element) {
                    var placement = $(element).data('error');
                    if (placement) {
                        $(placement).append(error)
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

            $("#btn_submit").click(function () {
                if ($("#<%:frm_employer_staff.ClientID%>").valid()) {
                    document.getElementById('<%= btnSubmit.ClientID %>').click();
                }
            });
        });
    </script>
</asp:Content>
