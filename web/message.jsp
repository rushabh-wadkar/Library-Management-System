<%
    String str = (String)session.getAttribute("user");
    if(!str.equalsIgnoreCase("admin"))
    {
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }
%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
    
    <link href="css/pnotify.custom.min.css" media="all" rel="stylesheet" type="text/css" />
    
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css"/>
 

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
  <style>
      .glyphicon:hover {
          color: red;
          
      }
  </style>
  </head>
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
                  <center><h3 style="margin-top: -1%;"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> Push Messages</h3></center>
                  <hr style="border-color: white;">
                  <div class="form_div">
                      <div class="container">
                          <div class="row">
                              <div class="col-md-6 col-md-offset-3" style="background-color: white; padding: 50px; border:none; outline: none;">
                                  <form action="message_push" method="POST">
                                    <div class="form-group">
                                      <label for="title">Title</label>
                                          <input type="text" class="form-control" autocomplete="off" required id="title" name="title" placeholder="Enter Title for Message">
                                    </div>
                                    <div class="form-group">
                                        <label for="msg_text">Message Body</label>
                                        <textarea class="form-control" rows="5" id="body_txt" name="body" required autocomplete="off" placeholder="Enter the message."></textarea>
                                    </div>
                                      <center><input type="submit" class="btn btn-default" value="Push"></center>
                                  </form>
                              </div>
                          </div>
                          <hr style="border-color: white;">
                          <center><p>Previous Messages Pushed</p></center>
                          <hr style="border-color: white;"> 
                          <div class="row">
                              <div class="col-md-12" style="background-color: white; padding: 50px; border:none; outline: none;">
                                  <table id="example" class="hover" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th class="col-md-1">Sr. No</th>
                                            <th class="col-md-8">Message</th>
                                            <th class="col-md-2">Time</th>
                                        </tr>
                                    </thead>
                                    <tbody style="font-size: 12px;">
                                        <%
                                            Connection con= null;
                                            try
                                            {
                                                con = DriverManager.getConnection("jdbc:derby://localhost:1527/library", "root", "root");
                                                String query = "SELECT * FROM MESSAGE ORDER BY 'sr' DESC";
                                                Statement st = con.createStatement();
                                                ResultSet rs = st.executeQuery(query);
                                                while(rs.next())
                                                {
                                                    %>
                                                    <tr>
                                                        <td><center><%= rs.getInt("sr") %></center></td>
                                  <td><span style="font-size: 13px;"><strong><em><%= rs.getString("TITLE") %></em></strong></span> : <%= rs.getString("MSG_TEXT") %></td>
                                                        <td><center><%= rs.getString("TIMEDAY") %></center></td>
                                                    </tr>
                                                    <%
                                                }
                                            }
                                            catch(Exception e)
                                            {
                                                out.println(e);
                                            }finally{
                                                con.close();
                                            }
                                            
                                        %>
                                    </tbody>
                                </table>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
                
                
          <div class="col-md-2">
              <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="dashboard.jsp"> <span class="glyphicon glyphicon glyphicon-home" aria-hidden="true"></span> DashBoard</a></li>
                <li role="presentation" class="active"><a href="message.jsp"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> Messages</a></li>
                <li role="presentation"><a href="requests.jsp"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> &nbsp;Book Requests</a></li>
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
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
 
<script type="text/javascript" src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
   
    <script>
    $(document).ready(function() {
    $('#example').DataTable();
} );
</script>

<script>
        $(function(){
            $('[data-toggle="tooltip"]').tooltip();
          });
    </script>
    
    
    <script type="text/javascript" src="js/pnotify.custom.min.js"></script>
    <script type="text/javascript">
        
        <%
            if(request.getAttribute("status")!=null)
            {
                    %>
                        $(function(){
                                PNotify.prototype.options.styling = "bootstrap3";
                                    var notice = new PNotify({
                                    title: 'Success',
                                    text: 'Successfully pushed to the students.',
                                    type: 'success',
                                    buttons: {
                                        closer: false,
                                        sticker: false
                                    }
                                });
                                notice.get().click(function() {
                                    window.location.href = "message.jsp";
                                    notice.remove();
                                });
                        });
                        <%
                }
                
            
        %>
            
    </script>
  </body>
</html>