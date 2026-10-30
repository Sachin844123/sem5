
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/SessionServlet")
public class SessionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        // Create or get existing session
        HttpSession session = request.getSession();

        // Check whether user has visited before
        if (session.getAttribute("visited") == null) {

            session.setAttribute("visited", true);

            out.println("<h2>Welcome!</h2>");
            out.println("<p>You are visiting this page for the first time.</p>");

        } else {

            out.println("<h2>Welcome Back!</h2>");
            out.println("<p>You have visited this page earlier.</p>");
        }

        out.println("<br>");
        out.println("<a href='index.html'>Back</a>");
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("destroy".equals(action)) {

            // Get current session
            HttpSession session = request.getSession(false);

            if (session != null) {

                // Destroy session
                session.invalidate();
            }

            response.setContentType("text/html");

            PrintWriter out = response.getWriter();

            out.println("<h2>Session Destroyed</h2>");
            out.println("<p>Your session has been destroyed.</p>");
            out.println("<a href='index.html'>Go Back</a>");
        }
    }
}