<%@page import="java.util.List"%>
<%@page import="shopping.CartBean"%>
<%@page import="shopping.CartItem"%>

<%
    CartBean cartBean =
            (CartBean) session.getAttribute("cartBean");

    List<CartItem> cartItems = null;    
    double total = 0;

    if (cartBean != null) {

        cartItems = cartBean.getCartItems();
        total = cartBean.getTotal();
    }
%>

<!DOCTYPE html>

<html>

<head>

    <title>Shopping Cart</title>

</head>

<body>

<h2>Simple Shopping Cart</h2>

<hr>

<h3>Add Product</h3>

<form action="CartServlet" method="post">

    <input type="hidden"
           name="action"
           value="add">

    Product ID:

    <input type="number"
           name="productId"
           required>

    <br><br>

    Quantity:

    <input type="number"
           name="quantity"
           min="1"
           required>

    <br><br>

    <input type="submit"
           value="Add to Cart">

</form>

<hr>

<h3>Available Products</h3>

<table border="1"
       cellpadding="8">

    <tr>

        <th>ID</th>
        <th>Product</th>
        <th>Price</th>

    </tr>

    <tr>

        <td>1</td>
        <td>Laptop</td>
        <td>Rs.50000</td>

    </tr>

    <tr>

        <td>2</td>
        <td>Mobile</td>
        <td>Rs.20000</td>

    </tr>

    <tr>

        <td>3</td>
        <td>Headphones</td>
        <td>Rs.2000</td>

    </tr>

    <tr>

        <td>4</td>
        <td>Keyboard</td>
        <td>Rs.1500</td>

    </tr>

    <tr>

        <td>5</td>
        <td>Mouse</td>
        <td>Rs.800</td>

    </tr>

</table>

<hr>

<h3>Your Cart</h3>

<%
    if (cartItems == null ||
        cartItems.isEmpty()) {
%>

    <p>Cart is empty.</p>

<%
    } else {
%>

<table border="1"
       cellpadding="8">

    <tr>

        <th>Product</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Subtotal</th>
        <th>Action</th>

    </tr>

<%
        for (CartItem item : cartItems) {
%>

    <tr>

        <td>
            <%= item.getProductName() %>
        </td>

        <td>
            Rs.<%= String.format("%.2f",
                    item.getPrice()) %>
        </td>

        <td>
            <%= item.getQuantity() %>
        </td>

        <td>
            Rs.<%= String.format("%.2f",
                    item.getSubtotal()) %>
        </td>

        <td>

            <form action="CartServlet"
                  method="post">

                <input type="hidden"
                       name="action"
                       value="delete">

                <input type="hidden"
                       name="productId"
                       value="<%= item.getProductId() %>">

                <input type="submit"
                       value="Delete">

            </form>

        </td>

    </tr>

<%
        }
%>

</table>

<h3>
    Total: Rs.<%= String.format("%.2f", total) %>
</h3>

<form action="CartServlet"
      method="post">

    <input type="hidden"
           name="action"
           value="clear">

    <input type="submit"
           value="Clear Cart">

</form>

<%
    }
%>

</body>

</html>