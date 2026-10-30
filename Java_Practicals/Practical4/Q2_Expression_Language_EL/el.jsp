<%@ page contentType="text/html" %>
<html>
<head>
    <title>Expression Language Demo</title>
</head>
<body>
    <h2>JSP Expression Language Demo</h2>
    <%
        String name = "Ayush";
        int age = 20;
        request.setAttribute("name", name);
        request.setAttribute("age", age);
    %>
    Name: ${name}<br><br>
    Age: ${age}<br><br>
    Addition: ${10 + 20}<br><br>
    Multiplication: ${10 * 5}<br><br>
    Comparison: ${10 > 5}
</body>
</html>
