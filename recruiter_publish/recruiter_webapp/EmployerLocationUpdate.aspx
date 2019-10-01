<%@ Page Language="C#" Title="Employer Location" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerLocationUpdate.aspx.cs" Inherits="recruiter_webapp.EmployerLocationUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_employer_loc" runat="server">
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
                <h6>Add Location for <%if (employerList.Count > 0)
                                      {%><%:employerList[0]["name"]%><%}%></h6>
                <%}
                    else
                    { %>
                <h6>Edit Location - <%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["address"]%><%}%></h6>
                <%}%>
            </div>
        </div>

        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>

        <div class="row">
            <div class="col s12 m12 l8 card white lighten-3 z-depth-3 padding-3 border-radius-5">

                <input type="hidden" id="employer_id" name="employer_id" value="<%if (employerList.Count > 0)
                    {%><%:employerList[0]["id"]%><%}%>" />
                <%if (employerLocationList.Count > 0)
                    { %>
                <input type="hidden" id="id" name="id" value="<%if (employerLocationList.Count > 0)
                    {%><%:employerLocationList[0]["id"]%><%}%>" />
                <%} %>

                <div class="row">
                    <div class="col s8 input-field">
                    <input type="text" id="employer_name" name="employer_name" value="<%if (employerList.Count > 0)
                        {%><%:employerList[0]["name"]%><%}%><%if (employerLocationList.Count > 0)
                        {%><%:employerLocationList[0]["employer_name"]%><%}%>" readonly />
                        <label class="input-label" for="employer_name">Employer</label>
                        </div>
                </div>

                <div class="row">
                    <div class="col s12 input-field">
                     <textarea id="address" name="address"><%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["address"]%><%}%></textarea>
                        <label class="input-label" for="address">Address</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col s4 input-field">
                        <input type="text" id="city" name="city" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["city"]%><%}%>" />
                        <label class="input-label" for="city">City</label>
                    </div>

                    <div class="col s4 input-field">
                       <input type="text" id="country" name="country" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["country"]%><%}%>" />
                        <label class="input-label" for="country">Country</label>
                    </div>
                    <div class="col s4 input-field">
                        <input type="text" id="zip" name="zip" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["zip"]%><%}%>"/>
                        <label class="input-label" for="zip">P.O.Box</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col s6 input-field">
                        <input type="text" id="email" name="email" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["email"]%><%}%>"/>
                        <label class="input-label" for="email">Email</label>
                    </div>
                    <div class="col s6 input-field">
                        <input type="text" id="phone" name="phone" value="<%if (employerLocationList.Count > 0)
                            {%><%:employerLocationList[0]["phone"]%><%}%>"/>
                        <label class="input-label" for="phone">Phone</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col s4 input-field switch left">
                        <label>
                            Active<input type="checkbox" id="active" class="filled-in blue lighten-3" <%= (employerLocationList.Count > 0) ? (employerLocationList[0]["active"] == null) ? "checked" : (employerLocationList[0]["active"].ToString() == "1") ? "checked" : ""  : "checked" %> />
                            <span class="lever"></span>
                        </label>
                        <input type="hidden" name="active" />
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
            $.validator.addMethod("valueNotEquals", function(value, element, arg){
            return arg !== value;
            }, "Value must not equal arg.");

            $.validator.addMethod("regexMatch", function (value, element, regexp) {
                var regex = new RegExp(regexp);
                return this.optional(element) || regex.test(value);
            },
                "Not a valid input!"
            );
            
            $('#<%=frm_employer_loc.ClientID%>').validate({
                onfocusout: false,
                invalidHandler: function (form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        validator.errorList[0].element.focus();
                    }
                },
                // Specify validation rules
                rules: {
                    address: "required",
                    city: "required",
                    country: "required",
                    zip: {
                        required: true,
                        digits: true,
                        minlength: 4,
                        maxlength: 10,
                    },
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
                    address: {
                        required: "Required*",
                    },
                    city: {
                        required: "Required*",
                    },
                    employer_loc_country: {
                        required: "Required*",
                    },
                    zip: {
                        required: "Required*",
                        digits: "Please enter valid zip / p.o.box",
                        minlength: "Please enter valid zip / p.o.box",
                        maxlength: "Please enter valid zip / p.o.box",
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
                if ($("#<%:frm_employer_loc.ClientID%>").valid()) {
                    if ($('#active').prop('checked')) {
                        $('[name="active"]').val(1);
                    }
                    else {
                        $('[name="active"]').val(0);
                    }
                    document.getElementById('<%= btnSubmit.ClientID %>').click();
                }
            });

        });
        
    </script>

   <link href="/Styles/form_styles.css" rel="stylesheet">
</asp:Content>