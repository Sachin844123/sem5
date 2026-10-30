<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>JSP Implicit Objects</title>
    </head>

    <body>

        <h1>JSP Implicit Objects</h1>

        <h2>Request Object</h2>

        Request Method:
        <%= request.getMethod() %>
        <br>

        Request URI:
        <%= request.getRequestURI() %>
        <br>

        Server Name:
        <%= request.getServerName() %>
        <br>

        Server Port:
        <%= request.getServerPort() %>


        <h2>Response Object</h2>

        Content Type:
        <%= response.getContentType() %>


        <h2>Out Object</h2>

        <%
            out.println("This message is displayed using out object.");
        %>


        <h2>Session Object</h2>

        Session ID:
        <%= session.getId() %>
        <br>

        Is New Session:
        <%= session.isNew() %>


        <h2>Application Object</h2>

        Context Path:
        <%= application.getContextPath() %>


        <h2>Config Object</h2>

        Servlet Name:
        <%= config.getServletName() %>


        <h2>PageContext Object</h2>

        Page Class:
        <%= pageContext.getPage().getClass().getName() %>


        <h2>Page Object</h2>

        Page Class:
        <%= page.getClass().getName() %>

    </body>
</html>