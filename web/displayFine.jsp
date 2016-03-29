<% 
    String userName = null;
    String bookName = null;
    String publisherName = null;
    String issueRequest = null;
    String expiryRequest = null;
    int fine = 0;
    if(request.getAttribute("info")!=null)
    {
        String s = (String)request.getAttribute("info");
        
        String temp[] = s.split(":");
        userName = temp[0];
        bookName = temp[1];
        publisherName = temp[2];
        issueRequest = temp[3];
        expiryRequest = temp[4];
        fine = Integer.parseInt(temp[5]);
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

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
      
    <div id="myModal" data-backdrop="static" data-keyboard="false" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title"><center>Return Book Details for <%= userName %></center></h4>
            </div>
            <div class="modal-body">
              <p>Book Name : <%= bookName %></p>
              
              <p>Publisher Name : <%= publisherName %></p>
              
              <p>Expiry Date : <%= expiryRequest %></p>
              
              <p>Return Request Date : <%= issueRequest %></p>
                            
              <p style="color: red; font-size: 15px;">Fine : Rs.<%= fine %></p>
            </div>
            <div class="modal-footer">
                <a href="requests.jsp"> <button type="button" class="btn btn-primary">Return</button> </a>
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div><!-- /.modal -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script>
        $('#myModal').modal('show');
        </script>
  </body>
</html>