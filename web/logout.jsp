<%-- 
    Document   : logout
    Created on : 25 Mar, 2016, 4:29:40 PM
    Author     : Rushabh
--%>
<% 
            session.invalidate();
        %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META http-equiv="refresh" content="2;URL=login.jsp">
    </head>
    <body>
        logging out.. Please wait!
    </body>
</html>
