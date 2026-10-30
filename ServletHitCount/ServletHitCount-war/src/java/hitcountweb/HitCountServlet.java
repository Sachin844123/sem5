package hitcountweb;

import hitcount.HitCountBean;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HitCountServlet")
public class HitCountServlet extends HttpServlet {

    @EJB
    private HitCountBean hitCountBean;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int count = hitCountBean.incrementHitCount();

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet Hit Count</title>");
        out.println("</head>");

        out.println("<body>");

        out.println("<h2>Servlet Hit Count</h2>");

        out.println("<p>Servlet was accessed successfully.</p>");

        out.println("<h3>Total Hits: " + count + "</h3>");

        out.println("<br>");

        out.println("<a href='index.html'>Back to Home</a>");

        out.println("</body>");
        out.println("</html>");
    }
}