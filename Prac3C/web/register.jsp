<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>Registration</title>
    </head>

    <body>

        <h1>User Registration</h1>

        <form method="post">

            Name:
            <input type="text" name="name">
            <br><br>

            Username:
            <input type="text" name="username">
            <br><br>

            Password:
            <input type="password" name="password">
            <br><br>

            City:
            <input type="text" name="city">
            <br><br>

            Country:
            <input type="text" name="country">
            <br><br>

            <input type="submit" value="Register">

        </form>

        <br>

        <a href="login.jsp">Already Registered? Login</a>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {

                String name = request.getParameter("name");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String city = request.getParameter("city");
                String country = request.getParameter("country");

                try {

                    Class.forName("com.mysql.cj.jdbc.Driver");

                    String sql = "INSERT INTO register (name, username, password, city, country) VALUES (?, ?, ?, ?, ?)";

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
                        ps.setString(2, username);
                        ps.setString(3, password);
                        ps.setString(4, city);
                        ps.setString(5, country);

                        int result = ps.executeUpdate();

                        if (result > 0) {
                            out.println(
                                "<h3>Registration Successful</h3>"
                            );
                        }
                    }

                } catch (Exception e) {

                    out.println(
                        "<h3>Registration Failed: "
                        + e.getMessage()
                        + "</h3>"
                    );
                }
            }
        %>

    </body>
</html>