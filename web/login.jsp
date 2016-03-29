
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>Libro - A library Management System</title>
    <link rel="icon" type="image/png" href="img/mail.png" />
    <link rel="icon" type="image/png" href="images/icon.png" />
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/pnotify.custom.min.css" media="all" rel="stylesheet" type="text/css" />
    
  </head>
  <body style="
        background-repeat: no-repeat;
        background-attachment: fixed;
        font-family: Open Sans;
  ">
      <br>
      <br><br><br><br><br>
      
      
      <br>
      <div class="container">
              <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="jumbotron" style="background-color: white;border-style: solid; border-width: 0px; border-color: black; box-shadow: 10px 10px 35px #D3D4D5;">
                        <div class="jumbotron" style="padding: 5px !important; background-color: #00EFFF;">
                            <span><center>Libro - Library Management System login</center></span>
                        </div>
                        <form class="form-horizontal" action="authenticate" method="POST" style="margin-left: 10px; margin-right:10px;">
                            <div class="form-group">
                                <label for="email_addr">Enter Username : </label>
                                
                                <input type="text" tabindex="1" id="emai_addr" autocomplete="off" name="email_addr" required class="form-control" placeholder="Enter Username : ">
                                    
                            </div>
                            
                            <div class="form-group has-feedback">
                                <label for="pass">Enter Password : </label>
                                <input type="password" tabindex="2" id="pass" name="pass" class="form-control" required placeholder="Enter Password :">
                                <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                            </div>

                            <div class="form-group" style="margin-bottom: -20px;">
                              <div class="col-sm-offset-5 col-sm-12">
                                  <input type="submit" value="Login" class="btn btn-success">
                              </div>
                            </div>
                          </form>
                    </div>
                </div>
            </div>
          </div>
      </div>
      
      
    <!-- Script Section -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    
    <script type="text/javascript" src="js/pnotify.custom.min.js"></script>
    <script type="text/javascript">
        
        <%
            if(request.getAttribute("error")!=null)
            {
                    %>
                        $(function(){
                                PNotify.prototype.options.styling = "bootstrap3";
                                    var notice = new PNotify({
                                    title: 'Success',
                                    text: "Username/ Password is wrong",
                                    type: 'error',
                                    buttons: {
                                        closer: false,
                                        sticker: false
                                    }
                                });
                                notice.get().click(function() {
                                    window.location.href = "login.jsp";
                                    notice.remove();
                                });
                        });
                        <%
                }
%>
            
    </script>
  </body>
</html>
