import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SessionDemo")
public class SessionDemo extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            out.println("<html><body>");
            out.println("<h2>Session Destroyed Successfully!</h2>");
            out.println("<a href='SessionDemo'>Create New Session</a>");
            out.println("</body></html>");
            return;
        }

        HttpSession session = request.getSession();
        int visitCount;
        if (session.isNew()) {
            visitCount = 1;
            session.setAttribute("count", visitCount);
            out.println("<h2>Welcome! This is your first visit.</h2>");
        } else {
            visitCount = (Integer) session.getAttribute("count");
            visitCount++;
            session.setAttribute("count", visitCount);
            out.println("<h2>Welcome Back!</h2>");
        }

        out.println("<html><body>");
        out.println("<h3>Session ID : " + session.getId() + "</h3>");
        out.println("<h3>Visit Count : " + visitCount + "</h3>");
        out.println("<h3>Is New Session : " + session.isNew() + "</h3>");
        out.println("<br>");
        out.println("<a href='SessionDemo'>Refresh Page</a><br><br>");
        out.println("<a href='SessionDemo?action=logout'>Destroy Session (Logout)</a>");
        out.println("</body></html>");
    }
}
