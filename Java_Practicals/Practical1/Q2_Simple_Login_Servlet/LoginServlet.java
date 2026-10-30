import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Valid credentials
        if (username.equals("admin") && password.equals("12345")) {
            out.println("<html><body>");
            out.println("<h2>Hello Login</h2>");
            out.println("</body></html>");
        } else {
            out.println("<html><body>");
            out.println("<h2>User Failed</h2>");
            out.println("</body></html>");
        }
    }
}
