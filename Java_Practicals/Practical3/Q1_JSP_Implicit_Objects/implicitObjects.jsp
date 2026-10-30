<%@ page import="java.util.*" %>
<html>
<head>
    <title>JSP Implicit Objects Demo</title>
</head>
<body>
    <h2>Use of Request Object</h2>
    <p>Client Locale: <%= request.getLocale().toString() %></p>

    <h2>Use of Out Object</h2>
    <% out.println("This message is printed using the implicit out object.<br>"); %>

    <h2>Use of Config Object</h2>
    <p>Servlet Name: <%= config.getServletName() %></p>

    <h2>Use of Application Object</h2>
    <p>Server Info: <%= application.getServerInfo() %></p>

    <h2>Use of Page Object</h2>
    <p>Page Class Name: <%= page.getClass().getName() %></p>

    <h2>Use of Session Object</h2>
    <p>Session Creation Time: <%= new Date(session.getCreationTime()) %></p>
</body>
</html>
