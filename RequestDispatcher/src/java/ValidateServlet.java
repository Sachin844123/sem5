
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/ValidateServlet")
public class ValidateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String password = request.getParameter("password");

        if (password.equals("Servlet")) {

            // Forward to WelcomeServlet
            RequestDispatcher rd =
                    request.getRequestDispatcher("WelcomeServlet");

            rd.forward(request, response);

        } else {

            // Display error message
            response.setContentType("text/html");

            PrintWriter out = response.getWriter();

            out.println("<h3>Invalid Password!</h3>");
            out.println("<a href='index.html'>Try Again</a>");
        }
    }
}