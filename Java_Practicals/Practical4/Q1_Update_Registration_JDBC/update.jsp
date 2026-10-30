<%@ page import="java.sql.*" %>
<%
    String firstname = request.getParameter("firstname");
    String lastname = request.getParameter("lastname");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String city = request.getParameter("city");
    String country = request.getParameter("country");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/jspdb", "root", "root");

        String sql = "UPDATE registration SET firstname=?, lastname=?, password=?, city=?, country=? WHERE username=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, firstname);
        ps.setString(2, lastname);
        ps.setString(3, password);
        ps.setString(4, city);
        ps.setString(5, country);
        ps.setString(6, username);

        int result = ps.executeUpdate();
        if (result > 0) {
            out.println("<h2>Registration Updated Successfully!</h2>");
        } else {
            out.println("<h2>Username Not Found!</h2>");
        }
        con.close();
    } catch (Exception e) {
        out.println("<h3>Error: " + e + "</h3>");
    }
%>
