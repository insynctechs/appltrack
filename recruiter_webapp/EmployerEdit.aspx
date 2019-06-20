<%@ Page Title="Employer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployerEdit.aspx.cs" Inherits="recruiter_webapp.EmployerEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="employer_form" runat="server">
     <h4>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h4>
    <h6>Edit Employer - <%if (employerList.Count > 0)
                            {%><%:employerList[0]["name"]%><%}%></h6>

    <br />
    <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>
    <br />
    <div class="row">
        <div id="entityDetails">
            <div class="input-field col s12 m12 l6">
                <div class="row">
                    <input type="hidden" id="id" runat="server"/>
                    <div class="input-field col s12">
                        <input type="text" id="name" name="name" value="<%:employerList[0]["name"]%>"/>
                        <label for="name">Name</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" id="address" name="address" value="<%:employerList[0]["address"]%>"/>
                        <label for="address">Address</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="city" name="city" value="<%:employerList[0]["city"]%>"/>
                        <label for="city">City</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="state" name="state" value="<%:employerList[0]["state"]%>"/>
                        <label for="state">State</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="zip" name="zip" value="<%:employerList[0]["zip"]%>"/>
                        <label for="zip">Zip</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="phone" name="phone"  value="<%:employerList[0]["phone"]%>"/>
                        <label for="contact">Primary Contact</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="text" id="email" name="email" value="<%:employerList[0]["email"]%>"/>
                        <label for="email">Primary Email</label>
                    </div>
                    <div class="input-field col s6">
                        <div class="switch">
                                    <label>
                                        Active
                                        <input id="active" name="active" type="checkbox" <%: employerList[0]["active"].ToString()=="1"?"Checked":"Unchecked" %> />
                                        <span class="lever"></span>
                                    </label>
                                </div>
                    </div>
                    <div class="input-field col s12">
                        <input type="button" class="btn waves-effect waves-light blue lighten-1 right" id="btn_employer_update" value="Update"/>
                        </div>
                    
                </div>
            </div>
            <div class="input-field col s12 m12 l6">
                <a href="<%=WebURL %>EmployerStaffAdd?employer_id=<%=Request.QueryString["id"] %>" class="btn waves-effect waves-light blue lighten-1" id="btn-add">
                Add Staff<i class="material-icons right">add</i>
                </a>
                <br />
                <br />
                <a href="<%=WebURL %>EmployerStaff?employer_id=<%=Request.QueryString["id"] %>" class="btn waves-effect waves-light blue lighten-1" id="btn-view">
                View Staffs<i class="material-icons right">view_list</i>
                </a>
            </div>
        </div>
    </div>
        </form>

    <script>
    // Scripts for html anchors to asp button mapping

    $(document).ready(function () {
            $('#<%=employer_form.ClientID%>').validate({
                // Specify validation rules
                rules: {
                    name : "required",
                    address: "required",
                    city: "required",
                    state : "required",
                    zip: "required",
                    phone: {
                        required: true,
                        minlength: 5,
                        maxlength: 20,
                    },
                    email: {
                        required: true,
                        email: true
                    },
                },
                messages: {
                    name: {
                        required: "Required*",
                    },
                    address: {
                        required: "Required*",
                    },
                    city: {
                        required: "Required*",
                    },
                    state: {
                        required: "Required*",
                    },
                    zip: {
                        required: "Required*",
                        digits: "Please enter valid zip",
                        minlength: "Please enter valid zip",
                        maxlength: "Please enter valid zip",
                    },
                    phone: {
                        required: "Required*",
                        minlength: "Please enter valid phone number",
                        maxlength: "Please enter valid phone number",
                    },
                    email: {
                        required: "Required*",
                        email: "Please enter a valid email address.",
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

            $("#btn_employer_update").click(function () {
                if ($("#employer_form").valid()) {
                    var id = $('#<%=id.ClientID%>').val();
                    var name = $('#name').val();
                    var address = $('#address').val();
                    var city = $('#city').val();
                    var state = $('#state').val();
                    var zip = $('#zip').val();
                    var email = $('#email').val();
                    var phone = $('#phone').val();
                    var active;
                    if ($('#active').prop('checked')) {
                        active = 1;
                    }
                    else {
                        active = 0;
                    }
                    var datastring = JSON.stringify({ 'id': id, 'name': name, 'address': address, 'city': city, 'state': state, 'zip': zip, 'email': email, 'phone': phone, 'active': active });
                    $.ajax({
                        url: 'EmployerEdit.aspx/UpdateEmployer',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                            var ret = parseInt(data.d);
                            if (ret > 0) {
                                toastr.info('Record successfully updated!');
                            }
                            else {
                                toastr.error('Error updating record!');
                            }
                        },
                        error: function (error) {
                            toastr.error("Database error! Unable to complete process.");
                        }
                    });
                };
            });

        });
    </script>
</asp:Content>
