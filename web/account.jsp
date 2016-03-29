<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
    String str = (String)session.getAttribute("user");
    str = str.toUpperCase();
    if(str.equalsIgnoreCase("admin")||str==null)
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
    <link rel="stylesheet" href="css/circle.css">
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
            <p class="navbar-text">Signed in as &nbsp;<span class="glyphicon glyphicon glyphicon-user" data-toggle="tooltip" data-placement="bottom" title="<%= str %>" aria-hidden="true"></span> <%= str %></p>
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
                  <center><h3 style="margin-top: -1%;">Welcome to the Libro Central Library, <%= str %>!</h3></center>
                  <hr style="border-color: white; border-width: 10px;">
                  <div class="container">
                        <div class="row">
                            <div class="col-md-7" style="background-color: white">
                                <hr>
                                <center><h4>Your Cart</h4></center>
                                <hr>
                                <ul>
                                <%
                                    Connection con= null;
                                      try
                                      {
                                          con = DriverManager.getConnection("jdbc:derby://localhost:1527/library", "root", "root");
                                          String query1 = "SELECT * FROM ROOT.\"Transact\" WHERE STATUS='A' AND USERNAME='"+str+"'";
                                          Statement st1 = con.createStatement();

                                          ResultSet cart = st1.executeQuery(query1);
                                          while(cart.next())
                                          {
                                              String issueDate = cart.getString("ISSUEDATE");
                                              String expiryDate = cart.getString("EXPIRYDATE");
                                              String temp1 = cart.getString("BOOKNAME");
                                              String temp2[] = temp1.split(":");
                                              String bname = temp2[0];
                                              String pubname = temp2[1];
                                              
                                %>
                                <li> Book - <strong><%= bname %> by <%= pubname %></strong><span style="float: right; font-size: 10px;">IssueDate: <strong><%= issueDate %></strong> AND ExpiryDate: <strong><%= expiryDate %></strong></span></li>
                                <%
                                            }
                                      }
                                      catch(Exception e)
                                      {
                                          out.println(e);
                                      }
                                      finally{
                                          con.close();
                                      }
                                %>
                                </ul>
                            </div>
                            <div class="col-md-5" style="border-left: 1px solid #737373; background-color: white">
                                <hr>
                                <center><h4>Notifications Wall</h4></center>
                                
                                <hr>
                                <center><u>Pending Requests</u></center>
                                <ul>
                                <%
                                      try
                                      {
                                          con = DriverManager.getConnection("jdbc:derby://localhost:1527/library", "root", "root");
                                          String query1 = "SELECT * FROM ROOT.\"Transact\" WHERE STATUS='NA'  AND USERNAME='"+str+"'";
                                          Statement st1 = con.createStatement();

                                          ResultSet cart = st1.executeQuery(query1);
                                          while(cart.next())
                                          {
                                              String temp1 = cart.getString("BOOKNAME");
                                              String temp2[] = temp1.split(":");
                                              String bname = temp2[0];
                                              String pubname = temp2[1];
                                              
                                %>
                                <li> Book - <strong><%= bname %> by <%= pubname %></strong> issue request is still pending.</li>
                                <%
                                            }
                                      }
                                      catch(Exception e)
                                      {
                                          out.println(e);
                                      }
                                      finally{
                                          con.close();
                                      }
                                %>
                                </ul>
                                
                                <hr>
                                <center><u>Return Requests</u></center>
                                <ul>
                                <%
                                      try
                                      {
                                          con = DriverManager.getConnection("jdbc:derby://localhost:1527/library", "root", "root");
                                          String query1 = "SELECT * FROM ROOT.\"RETURN_TRANSACTION\" WHERE USERNAME='"+str+"'";
                                          Statement st1 = con.createStatement();

                                          ResultSet cart = st1.executeQuery(query1);
                                          while(cart.next())
                                          {
                                              String temp1 = cart.getString("BOOKNAME");
                                              String temp2[] = temp1.split(":");
                                              String bname = temp2[0];
                                              String pubname = temp2[1];
                                              
                                %>
                                <li> Book - <strong><%= bname %> by <%= pubname %></strong> return request is still pending.</li>
                                <%
                                            }
                                      }
                                      catch(Exception e)
                                      {
                                          out.println(e);
                                      }
                                      finally{
                                          con.close();
                                      }
                                %>
                                </ul>
                            </div>
                        </div>
                  </div>
                  
                  <hr style="border-color: white; border-width: 10px;">
                  <center><h5>Copyright&copy; 2016 : Developed By Rushabh Wadkar.</h5></center>
              </div>
          </div>
          <div class="col-md-2">
              <ul class="nav nav-pills nav-stacked">
                <li role="presentation" class="active"><a href="account.jsp"> <span class="glyphicon glyphicon glyphicon-home" aria-hidden="true"></span> DashBoard</a></li>
                <li role="presentation"><a href="issueBook.jsp"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Issue Book</a></li>
                <li role="presentation"><a href="returnBook.jsp"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> &nbsp;Return Book</a></li>
                
              </ul>
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