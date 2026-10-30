
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/VisitCounterServlet")
public class VisitCounterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        int count = 0;

        // Get existing cookies
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {

            for (Cookie cookie : cookies) {

                if (cookie.getName().equals("visitCount")) {
                    count = Integer.parseInt(cookie.getValue());
                }
            }
        }

        // Increase count
        count++;

        // Create cookie
        Cookie visitCookie =
                new Cookie("visitCount", String.valueOf(count));

        // Cookie expires after 1 day
        visitCookie.setMaxAge(24 * 60 * 60);

        // Add cookie to response
        response.addCookie(visitCookie);

        // Display result
        out.println("<html>");
        out.println("<body>");

        out.println("<h2>Cookie Visit Counter</h2>");
        out.println("<h3>You have visited this Servlet "
                + count + " time(s).</h3>");

        out.println("</body>");
        out.println("</html>");
    }
}