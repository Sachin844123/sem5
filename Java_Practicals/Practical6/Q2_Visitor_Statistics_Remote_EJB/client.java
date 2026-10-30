package p1;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/client")
public class client extends HttpServlet {
    @EJB
    VisitorStatRemote vs;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String host = request.getRemoteAddr();
        int visits = vs.addvisitor(host);

        out.println("<html><body>");
        out.println("<h2>Visitor Statistics</h2>");
        out.println("<p>Visitor Host: " + host + "</p>");
        out.println("<p>Number of Visits: " + visits + "</p>");
        out.println("</body></html>");
    }
}
