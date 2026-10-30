import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VisitCounter")
public class VisitCounter extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        int visitCount = 1;
        Cookie[] cookies = request.getCookies();
        boolean cookieFound = false;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("visitCount")) {
                    visitCount = Integer.parseInt(cookie.getValue());
                    visitCount++;
                    cookie.setValue(String.valueOf(visitCount));
                    response.addCookie(cookie);
                    cookieFound = true;
                    break;
                }
            }
        }

        if (!cookieFound) {
            Cookie visitCookie = new Cookie("visitCount", String.valueOf(visitCount));
            visitCookie.setMaxAge(60 * 60 * 24 * 30);
            response.addCookie(visitCookie);
        }

        out.println("<html><body>");
        out.println("<h2>Servlet Visit Counter Using Cookies</h2>");
        out.println("<p>You have visited this servlet <b>" + visitCount + "</b> time(s).</p>");
        out.println("</body></html>");
    }
}
