<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CandidateQualification.aspx.cs" Inherits="recruiter_webapp.CandidateQualification" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Qualification</title>
    <link rel = "stylesheet" href = "https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.3/css/materialize.min.css"/>
    <script src="/Scripts/jquery-3.3.1.js"></script>
    <script src="/Scripts/materialize.js"></script>
    <script src="/Scripts/jquery.validate.js"></script>
    <script src="/Scripts/additional-methods.js"></script>
    <script src="/Scripts/toastr.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="row">
            <div class="col s8 input-field">
                <input type="text" id="qualification" name="qualification" />
                <label class="input-label" for="name">Qualification*</label>
            </div>
        </div>
        <div class="row">
            <div class="col s8 input-field">
                <input type="text" id="institute" name="institute" />
                <label class="input-label" for="name">University/Institute*</label>
            </div>
        </div>
        <div class="row">
            <div class="col s8 input-field">
                <input type="number" min="1900" max="2019" id="year" name="year" />
                <label class="input-label" for="name">Year of Passout*</label>
            </div>
        </div>

        <div class="row">
            <div class="col s8 input-field">
                <input type="number" min="0" max="100" id="percentage" name="percentage" />
                <label class="input-label" for="name">Percentage*</label>
            </div>
        </div>
    </form>
</body>
    
    
    
</html>

