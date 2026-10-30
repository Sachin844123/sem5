package reservationweb;

import java.io.IOException;
import java.io.PrintWriter;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import reservation.ReservationBean;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {

    @EJB
    private ReservationBean reservationBean;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        String username =
                request.getParameter("username");

        String contact =
                request.getParameter("contact");

        String roomType =
                request.getParameter("roomType");

        String result =
                reservationBean.reserveRoom(
                        username,
                        contact,
                        roomType);

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Reservation Result</title>");
        out.println("</head>");

        out.println("<body>");

        out.println("<h2>Room Reservation System</h2>");

        out.println("<h3>" + result + "</h3>");

        out.println("<br>");

        out.println(
            "<a href='index.html'>Back</a>");

        out.println("</body>");
        out.println("</html>");

        out.close();
    }
}