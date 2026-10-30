<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>Login</title>
    </head>

    <body>

        <h1>User Login</h1>

        <form method="post">

            Username:
            <input type="text" name="username">
            <br><br>

            Password:
            <input type="password" name="password">
            <br><br>

            <input type="submit" value="Login">

        </form>

        <br>

        <a href="register.jsp">New User? Register</a>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {

                String username = request.getParameter("username");
                String password = request.getParameter("password");

                try {

                    Class.forName("com.mysql.cj.jdbc.Driver");

                    String sql = "SELECT * FROM register WHERE username = ? AND password = ?";

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

                        ps.setString(1, username);
                        ps.setString(2, password);

                        java.sql.ResultSet rs =
                                ps.executeQuery();

                        if (rs.next()) {

                            session.setAttribute(
                                "username", username
                            );

                            response.sendRedirect(
                                "welcome.jsp"
                            );

                        } else {

                            out.println(
                                "<h3>Invalid Username or Password</h3>"
                            );
                        }
                    }

                } catch (Exception e) {

                    out.println(
                        "<h3>Error: "
                        + e.getMessage()
                        + "</h3>"
                    );
                }
            }
        %>

    </body>
</html>