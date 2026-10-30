<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    String eno = request.getParameter("eno");
    String name = request.getParameter("name");
    String age = request.getParameter("age");
    String desg = request.getParameter("desg");
    String salary = request.getParameter("salary");

    String message = "";

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");

        String sql = "UPDATE employee SET name = ?, age = ?, desg = ?, salary = ? WHERE eno = ?";

        try (
            java.sql.Connection con =
                java.sql.DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/college",
                    "root",
                    "password"
                );

            java.sql.PreparedStatement ps =
                con.prepareStatement(sql)
        ) {

            ps.setString(1, name);
            ps.setInt(2, Integer.parseInt(age));
            ps.setString(3, desg);
            ps.setDouble(4, Double.parseDouble(salary));
            ps.setInt(5, Integer.parseInt(eno));

            int result = ps.executeUpdate();

            if (result > 0) {
                message = "Employee details updated successfully.";
            } else {
                message = "Employee with Eno " + eno + " not found.";
            }
        }

    } catch (Exception e) {

        message = "Error: " + e.getMessage();
    }

    request.setAttribute("message", message);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Result</title>
</head>

<body>

    <h2>Update Employee</h2>

    <c:if test="${not empty message}">

        <h3>${message}</h3>

    </c:if>

    <br>

    <a href="index.html">Back</a>

</body>
</html>