package visitorweb;

import java.io.IOException;
import java.io.PrintWriter;
import javax.annotation.Resource;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.JMSContext;
import javax.jms.Queue;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VisitorServlet")
public class VisitorServlet extends HttpServlet {

    @Resource(lookup = "jms/VisitorConnectionFactory")
    private ConnectionFactory connectionFactory;

    @Resource(lookup = "VisitorQueue")
    private Queue visitorQueue;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            JMSContext context =
                    connectionFactory.createContext();

            context.createProducer()
                   .send(visitorQueue, "Visitor");

            context.close();

            response.setContentType("text/html");

            PrintWriter out =
                    response.getWriter();

            out.println("<html>");
            out.println("<head>");
            out.println(
                "<title>Visitor Statistics</title>"
            );
            out.println("</head>");

            out.println("<body>");

            out.println(
                "<h2>Visitor Recorded Successfully</h2>"
            );

            out.println(
                "<p>Your visit has been recorded.</p>"
            );

            out.println(
                "<br>"
            );

            out.println(
                "<a href='index.html'>"
                + "Back to Home"
                + "</a>"
            );

            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {

            response.setContentType("text/html");

            PrintWriter out =
                    response.getWriter();

            out.println("<h2>Error</h2>");

            out.println(
                "<p>" + e.getMessage() + "</p>"
            );
        }
    }
}