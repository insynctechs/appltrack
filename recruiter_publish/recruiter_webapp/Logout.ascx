<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Logout.ascx.cs" Inherits="recruiter_webapp.Logout" %>

<script>
    $('#logout').click(function() {
        $.ajax({
                      type: "POST",
                      url: "WebService.asmx/LogoutUser",
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      async: "true",
                      cache: "false",
                      success: function(data)
                      {
                        location.reload(true);
                          
                          //window.location.replace(<%=WebURL %>);
                      },
                      Error: function(error)
                      {
                          toastr.error("Unable to complete your request.");
                      }
                  });

    });
</script>