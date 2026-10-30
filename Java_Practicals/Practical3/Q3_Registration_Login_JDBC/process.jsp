<%@ page import="java.sql.*" %>
<%
    String action = request.getParameter("action");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/jspdb", "root", "root");

    if ("register".equals(action)) {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String city = request.getParameter("city");
        String country = request.getParameter("country");

        PreparedStatement ps = con.prepareStatement(
                "INSERT INTO register VALUES (?, ?, ?, ?, ?)");
        ps.setString(1, name);
        ps.setString(2, username);
        ps.setString(3, password);
        ps.setString(4, city);
        ps.setString(5, country);
        ps.executeUpdate();

        out.println("<h2>Registration Successful!</h2>");
        out.println("<a href='login.jsp'>Login Here</a>");
    } else if ("login".equals(action)) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM register WHERE username=? AND password=?");
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            out.println("<h2>Login Successful!</h2>");
            out.println("<h3>Welcome " + rs.getString("name") + "</h3>");
        } else {
            out.println("<h2>Invalid Username or Password!</h2>");
            out.println("<a href='login.jsp'>Try Again</a>");
        }
    }
    con.close();
%>
