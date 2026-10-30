<%@ page import="javax.naming.*" %>
<%@ page import="ejb.ShoppingCartBean" %>
<%@ page import="java.util.List" %>
<html>
<body>
    <h2>Shopping Cart</h2>
    <%
        String product = request.getParameter("product");
        String quantityString = request.getParameter("quantity");
        InitialContext context = new InitialContext();
        ShoppingCartBean cart = (ShoppingCartBean) session.getAttribute("cart");
        if (cart == null) {
            cart = (ShoppingCartBean) context.lookup(
                    "java:global/Practical5c/ShoppingCartBean");
            session.setAttribute("cart", cart);
        }
        if (product != null && quantityString != null) {
            int quantity = Integer.parseInt(quantityString);
            cart.addItem(product, quantity);
        }
        List<String> items = cart.getCart();
    %>
    <h3>Items in Cart:</h3>
    <%
        for (String item : items) {
    %>
            <%= item %><br>
    <%
        }
    %>
    <br>
    <b>Total Amount: Rs. <%= cart.getTotal() %></b><br><br>
    <a href="index.html">Continue Shopping</a>
</body>
</html>
