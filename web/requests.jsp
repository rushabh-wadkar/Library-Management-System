<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%
    String str = (String)session.getAttribute("user");
    if(!str.equalsIgnoreCase("admin"))
    {
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }
%>



<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Libro - A library Management System</title>
    <link rel="icon" type="image/png" href="images/icon.png" />
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/stylish.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
  </head>
  <style>
      .glyphicon:hover {
          color: red;
          
      }
      .mytab {
          margin: auto;
          padding-left: 4%;
          padding-right: 5%;
          background-color: white;
      }
  </style>
  <body style="font-family: OpenSans;">
    
      
      <!--  Navigation Bar-->
      <nav class="navbar navbar-default " style="outline: none; border: none; background-color: white;border-radius: 0; box-shadow: 1px 1px 15px rgba(0,0,0,0.2);padding: 10px;">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Libro - LMS</a>
            <p class="navbar-text">Signed in as &nbsp;<span class="glyphicon glyphicon glyphicon-user" data-toggle="tooltip" data-placement="bottom" title="Admin" aria-hidden="true"></span> Admin</p>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

            <ul class="nav navbar-nav navbar-right">
              
              <li><a href=""> <span class="glyphicon glyphicon-bell" data-toggle="tooltip" data-placement="bottom" title="Notifications" aria-hidden="true"></span> </a></li>
              
              <li><a href="logout.jsp"> <span class="glyphicon glyphicon-off" data-toggle="tooltip" data-placement="bottom" title="LogOut" aria-hidden="true"></span> </a></li>
            </ul>
          </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
      </nav>
      
      
      <!-- End of Navigation bar -->
      <div class="row">
          <div class="col-md-10">
              <div class="jumbotron" style="background-color: rgba(229,229,229,0.3); box-shadow: 1px 1px 20px rgba(0,0,0,0.2);margin-left: 2%;">
                  <center><h3 style="margin-top: -1%;">Book Issue Requests Section!</h3></center>
                  <hr style="border-color: white; border-width: 10px;">
                  <div class="container" style="margin-left: 7%;">
                        <div class="row">
                            <form class="form-inline" action="validate_requests" method="POST">
                                
                                <% 
                                    int count = 0;
                                    String query = "SELECT * FROM ROOT.\"Transact\" WHERE STATUS='NA'";
                                    Connection con = null;
                                    try
                                    {
                                        con = DriverManager.getConnection("jdbc:derby://localhost:1527/library", "root", "root");
                                        Statement st = con.createStatement();
                                        ResultSet rs = st.executeQuery(query);
                                        while(rs.next())
                                        {
                                            String name = rs.getString("USERNAME");
                                            String temp1 = rs.getString("BOOKNAME");
                                            String ukey = rs.getString("UKEY");
                                            String temp2[] = temp1.split(":");
                                            String bname = temp2[0];
                                            String pubname = temp2[1];
                                        
                                %>
                                <div class="col-md-3" style="margin-left: 2%; margin-bottom: 1%; margin-top: 1%;background-color: white;pading:5px; border-radius: 10px; box-shadow: 1px 1px 20px rgba(0,0,0,0.2)">
                                    <div class="header" style="padding: 15px;">
                                        <center><strong><em><%= name %></em></strong></center>
                                    </div>
                                    <hr style="margin-top: 0px; margin-bottom:5px;">
                                    <div class="desc">
                                        <center>Book Name : <%= bname %></center>
                                        <center>Publisher Name : <%= pubname %></center>
                                        <hr style="margin-top: 5px; margin-bottom:10px;">
                                        <center>
                                            <div class="form-group">
                                                <button type="submit" name="req" class="btn btn-success" value="GRANT#<%= ukey %>">
                                                    Grant
                                                </button>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" name="req" class="btn btn-danger" value="REVOKE#<%= ukey %>">
                                                    Revoke
                                                </button>
                                            </div>
                                        </center>
                                        <br>
                                    </div>
                                </div>
                                <%
                                            }
                                    }
                                    catch(Exception e)
                                    {
                                        out.println(e);
                                    }
                                    finally
                                    {
                                        con.close();
                                    }
                                %>
                            </form>
                        </div>
                  </div>
                            
                            
              </div>
          </div>
          <div class="col-md-2">
              <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="dashboard.jsp"> <span class="glyphicon glyphicon glyphicon-home" aria-hidden="true"></span> DashBoard</a></li>
                <li role="presentation"><a href="message.jsp"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> Messages</a></li>
                <li role="presentation" class="active"><a href="requests.jsp"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> &nbsp;Book Requests</a></li>
                <li role="presentation"><a href="register.jsp"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Registration</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Library<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li><a href="addBooks.jsp"> <span class="glyphicon glyphicon glyphicon-pencil" aria-hidden="true"></span> Add Books</a></li>
                      <li><a href="removeBooks.jsp"> <span class="glyphicon glyphicon glyphicon-trash" aria-hidden="true"></span> Remove Books</a></li>
                      <li><a href="modifyBooks.jsp"> <span class="glyphicon glyphicon glyphicon-edit" aria-hidden="true"></span> Modify Books</a></li>
                      <li role="separator" class="divider"></li>
                      <li><a href="viewBooks.jsp"> <span class="glyphicon glyphicon glyphicon-eye-open" aria-hidden="true"></span> View Books</a></li>
                    </ul>
                </li>
              </ul>
          </div>
      </div>
                            
                            
       <div class="row">
          <div class="col-md-10">
              <div class="jumbotron" style="background-color: rgba(229,229,229,0.3); box-shadow: 1px 1px 20px rgba(0,0,0,0.2);margin-left: 2%;">
                  <center><h3 style="margin-top: -1%;">Book Return Requests Section!</h3></center>
                  <hr style="border-color: white; border-width: 10px;">
                  <div class="container" style="margin-left: 7%;">
                        <div class="row">
                            
                            <form class="form-inline" action="validate_requests" method="POST">
                                
                                <% 
                                    String query1 = "SELECT * FROM ROOT.\"RETURN_TRANSACTION\"";
                                    
                                    try
                                    {
                                        con = DriverManager.getConnection("jdbc:derby://localhost:1527/library", "root", "root");
                                        Statement st = con.createStatement();
                                        ResultSet rs = st.executeQuery(query1);
                                        while(rs.next())
                                        {
                                            String name = rs.getString("USERNAME");
                                            String temp1 = rs.getString("BOOKNAME");
                                            String ukey = rs.getString("UKEY");
                                            String temp2[] = temp1.split(":");
                                            String bname = temp2[0];
                                            String pubname = temp2[1];
                                        
                                %>
                                <div class="col-md-3" style="margin-left: 2%; margin-bottom: 1%; margin-top: 1%;background-color: white;pading:5px; border-radius: 10px; box-shadow: 1px 1px 20px rgba(0,0,0,0.2)">
                                    <div class="header" style="padding: 15px;">
                                        <center><strong><em><%= name %></em></strong></center>
                                    </div>
                                    <hr style="margin-top: 0px; margin-bottom:5px;">
                                    <div class="desc">
                                        <center>Book Name : <%= bname %></center>
                                        <center>Publisher Name : <%= pubname %></center>
                                        <hr style="margin-top: 5px; margin-bottom:10px;">
                                        <center>
                                            <div class="form-group">
                                                <button type="submit" name="req" class="btn btn-info" value="RETURN#<%= ukey %>">
                                                    Return Book!
                                                </button>
                                            </div>
                                        </center>
                                        <br>
                                    </div>
                                </div>
                                <%
                                            }
                                    }
                                    catch(Exception e)
                                    {
                                        out.println(e);
                                    }
                                    finally
                                    {
                                        con.close();
                                    }
                                %>
                            </form>
                        </div>
                  </div>
              </div>           
                            
                  
                  <hr style="border-color: white; border-width: 10px;">
                  <center><h5>Copyright&copy; 2016 : Developed By Rushabh Wadkar.</h5></center>
              </div>
          </div>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    
    
    <script>
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
          })
    </script>
    
    
  </body>
</html>