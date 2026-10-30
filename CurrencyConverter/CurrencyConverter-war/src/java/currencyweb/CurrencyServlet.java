package currencyweb;

import currency.CurrencyBean;   
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CurrencyServlet")
public class CurrencyServlet extends HttpServlet {

    @EJB
    private CurrencyBean currencyBean;

    protected void processRequest(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        try {

            double amount =
                    Double.parseDouble(
                            request.getParameter("amount"));

            String from =
                    request.getParameter("from");

            String to =
                    request.getParameter("to");

            double result =
                    currencyBean.convert(
                            amount,
                            from,
                            to);

            out.println("<html>");
            out.println("<body>");

            out.println("<h2>Currency Conversion Result</h2>");

            out.println("<h3>"
                + amount + " " + from
                + " = "
                + String.format("%.2f", result) + " " + to
                + "</h3>");

            out.println(
                    "<a href='index.html'>Convert Again</a>");

            out.println("</body>");
            out.println("</html>");

        } finally {

            out.close();
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }
}