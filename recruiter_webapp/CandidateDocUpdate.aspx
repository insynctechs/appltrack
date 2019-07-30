﻿<%@ Page Language="C#" AutoEventWireup="true" Title="Candidate" MasterPageFile="~/Site.Master" CodeBehind="CandidateDocUpdate.aspx.cs" Inherits="recruiter_webapp.CandidateDocUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="frm_candidate_doc" runat="server" enctype="multipart/form-data">
        <div class="card z-depth-1 border-radius-5" style="padding-left: 10px">
            <div class="row">
                <h5>Dashboard <i class="material-icons">chevron_right</i> <%: Title %></h5>
            </div>

        </div>
        <div class="row no-padding">
            <div class="col s12 m12 l8 card card light-blue lighten-5 padding-1 border-radius-5 no-margin padding-1">
                <% if (string.IsNullOrEmpty(Request.QueryString["id"]))

                    { %>
                <h6>Upload Documents</h6>
                <%}
                    else
                    { %>
                <h6>Edit Documents <%if (candidateList.Count > 0)
                                       {%><%:candidateList[0]["name"]%><%}%></h6>
                <%}%>
            </div>
        </div>

        <asp:Label ID="lblResponseMsg" runat="server"></asp:Label>

        <div class="row">
            <div class="input-field col s12 m12 l8 card white lighten-3 z-depth-3 padding-3 border-radius-5">
                <div class="row">
                    <div class="col s12 input-field">                    
                        <div id="div-fileuploads" style="display: none">
                            <h6>Documents Uploaded</h6>
                            <table id="tbl-fileuploads" class="">
                                <thead>
                                    <tr class="card z-index-0 light-blue lighten-5 border-radius-5 no-margin ">
                                        <th class="font-weight-100">Document</th>
                                        <th class="font-weight-100">Filename</th>
                                        <th class="font-weight-100"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                    </tr>
                                </tbody>
                            </table>
                            <br />
                        </div>
                        
                    </div>
                    <div class="col s6 input-field">
                        <h6>Add Documents to complete your profile.</h6>
                        <select id="document_types" name="document_types">
                            <option value="" disabled selected>Choose Document</option>
                            <option value="1">Photograph</option>
                            <option value="2">CV / Resume</option>
                            <option value="3">Passport</option>
                            <option value="4">Experience</option>
                            <option value="5">Other</option>
                        </select>  
                    </div>

                        <div class="col s12 input-field light-blue lighten-5 border-radius-5 no-margin padding-1" id="div-fileuploader" style="display:none">
                            <input type="file" id="fileuploader" name="fileuploader" hidden />
                            <div class="col s2 left">
                                <a class="btn left white-text waves-light blue lighten-1 border-radius-5" id="btn-fileupload">Upload File</a>
                            </div>
                                <div id="progress" class="col s8" style="margin-top: 10px">
                            <div class="bar" style="width: 0%;"></div>
                            <p id="progress-indicator" class="no-margin right"></p>
                        </div>
                            <div class="col s2 right">
                                <a class="btn white-text waves-light blue lighten-1 border-radius-5" id="btn-savefile" style="display:none">Save</a>
                            </div>
                            
                            
                        </div>


                </div>

                <div class="col s12 input-field right">
                    <a id="btn-check" class="btn waves-effect waves-light blue lighten-1 right">Check</a>
                    <a id="btn-submit" class="btn waves-effect waves-light blue lighten-1 right">Submit</a>
                    <asp:Button Style="display: none" ID="btn_submit" CssClass="btn waves-effect waves-light blue lighten-1 right" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                </div>

            </div>
        </div>

    </form>


    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="/Scripts/jquery.fileupload.js"></script>
    <script src="/Scripts/dropify.min.js"></script>
    <link rel="stylesheet" href="Styles/dropify.min.css">

    <style>
        .bar {
            height: 5px;
            background: #42a5f5;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }
    </style>


    <script>
        $(document).ready(function () {


            var opt;
            var filename;

            $('#btn-fileupload').click(function () {
                $('#btn-savefile').hide();
                $('#fileuploader').click();
            });

            $("#fileuploader").fileupload({

                    progressall: function (e, data) {
                        $('#progress').show();
                        var progress = parseInt(data.loaded / data.total * 100, 10);

                        $('#progress .bar').css(
                            'width',
                            progress + '%'
                        );
                        $('#progress-indicator').html(
                            progress + '%'
                        );
                    },
                    done: function (e, data) {
                        
                        $('#btn-savefile').show();
                       
                    }

            });

            $('#btn-savefile').click(function () {
                $('#div-fileuploader').hide();
                $('#progress').hide();
                        $('#progress .bar').css(
                            'width', '0%'
                        );
                 $('#div-fileuploads').show();
                        $("#tbl-fileuploads tbody").append("<tr id=\"" + $("#document_types").val() + "\">" +
                            "<td>" + opt.text + "</td>" +
                            "<td>" + fileName + "</td>" +
                            "<td><a class=\"btn btn-remove white-text waves-light blue lighten-1 border-radius-5 right\">Remove</a></td>" +
                            "</tr>");
            });




            var documents = [];
            $("#document_types").on('change', function () {
                var sel = document.getElementById('document_types');
                opt = sel.options[sel.selectedIndex];
                $('#div-fileuploader').show();

                $("#fileuploader").change(function (e) {
                    fileName = e.target.files[0].name;
                });
                
                documents.push($("#document_types").val());
            });

            $('#fileuploader').on('change', function () {
                for (var i = 0; i < this.files.length; i++) {
                    console.log(this.files[i].name);
                }
            });

            $(document).on("click", "a.btn-remove", function () {
                $(this).parents("tr").remove();
            });

            $('#btn-submit').click(function () {
                if ($('#<%=frm_candidate_doc.ClientID%>').valid()) {
                    /* AJAX call to webmethod */
                    /*
                    var datastring = JSON.stringify({ 'qualifications': qualifications, 'experiences': experiences, 'documents': documents });
                    $.ajax({
                        url: 'CandidateUpdate.aspx/SetFields',
                        type: 'post',
                        data: datastring,
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (data) {
                        },
                        error: function (error) {
                            toastr.error("Unable to complete process.");
                        }
                    });
                    */
                    document.getElementById('<%= btn_submit.ClientID %>').click();
                }

            });

        });


    </script>

</asp:Content>
