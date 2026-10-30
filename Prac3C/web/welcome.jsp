<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String username =
            (String) session.getAttribute("username");

    if (username == null) {

        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>Welcome</title>
    </head>

    <body>

        <h1>Welcome <%= username %></h1>

        <h3>Login Successful!</h3>

        <br>

        <a href="index.jsp">Home</a>

    </body>
</html>