package registration;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        // Get data from HTML form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String country = request.getParameter("country");

        try {

            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/college",
                    "root",
                    "password"
            );

            // SQL query
            String sql = "INSERT INTO registration (username, password, email, country) VALUES (?, ?, ?, ?)";

            // Create PreparedStatement
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, country);

            // Execute query
            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<h2>Registration Successful</h2>");
            } else {
                out.println("<h2>Registration Failed</h2>");
            }

            ps.close();
            con.close();

        } catch (Exception e) {

            out.println("<h2>Error: " + e.getMessage() + "</h2>");

        }
    }
}