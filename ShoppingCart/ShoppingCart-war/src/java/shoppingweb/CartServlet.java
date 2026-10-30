package shoppingweb;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import shopping.CartBean;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    @EJB
    private CartBean cartBean;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        HttpSession session =
                request.getSession();

        
        session.setAttribute(
                "cartBean",
                cartBean
        );

        if ("add".equals(action)) {

            int productId =
                    Integer.parseInt(
                            request.getParameter(
                                    "productId"));

            int quantity =
                    Integer.parseInt(
                            request.getParameter(
                                    "quantity"));

            cartBean.addToCart(
                    productId,
                    quantity
            );

        } else if ("delete".equals(action)) {

            int productId =
                    Integer.parseInt(
                            request.getParameter(
                                    "productId"));

            cartBean.deleteItem(productId);

        } else if ("clear".equals(action)) {

            cartBean.clearCart();
        }

        response.sendRedirect("index.jsp");
    }
}