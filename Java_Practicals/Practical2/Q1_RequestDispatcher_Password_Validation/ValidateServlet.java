import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ValidateServlet")
public class ValidateServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String pwd = request.getParameter("password");
        RequestDispatcher rd;
        if (pwd.equals("servlet")) {
            rd = request.getRequestDispatcher("WelcomeServlet");
            rd.forward(request, response);
        } else {
            out.println("<h3 style='color:red'>Invalid Password!</h3>");
            rd = request.getRequestDispatcher("index.html");
            rd.include(request, response);
        }
    }
}
