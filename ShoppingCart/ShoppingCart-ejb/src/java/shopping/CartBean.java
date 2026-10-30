package shopping;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateful;

@Stateful
public class CartBean {

    private List<CartItem> cartItems =
            new ArrayList<CartItem>();

    private Connection getConnection() throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/shopping"
                + "?useSSL=false"
                + "&allowPublicKeyRetrieval=true",
                "root",
                "password"
        );
    }

    public String addToCart(int productId, int quantity) {

        String sql =
                "SELECT product_name, price "
                + "FROM products "
                + "WHERE product_id = ?";

        try {

            Connection con = getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String productName =
                        rs.getString("product_name");

                double price =
                        rs.getDouble("price");

                CartItem item =
                        new CartItem(
                                productId,
                                productName,
                                price,
                                quantity
                        );

                cartItems.add(item);

                String insert =
                        "INSERT INTO cart "
                        + "(product_id, product_name, "
                        + "price, quantity) "
                        + "VALUES (?, ?, ?, ?)";

                PreparedStatement insertPs =
                        con.prepareStatement(insert);

                insertPs.setInt(1, productId);
                insertPs.setString(2, productName);
                insertPs.setDouble(3, price);
                insertPs.setInt(4, quantity);

                insertPs.executeUpdate();

                insertPs.close();
                ps.close();
                rs.close();
                con.close();

                return productName
                        + " added to cart.";

            } else {

                ps.close();
                rs.close();
                con.close();

                return "Product not found.";
            }

        } catch (Exception e) {

            return "Error: " + e.getMessage();
        }
    }

    public List<CartItem> getCartItems() {

        return cartItems;
    }

    public double getTotal() {

        double total = 0;

        for (CartItem item : cartItems) {

            total += item.getSubtotal();
        }

        return total;
    }

    public void deleteItem(int productId) {

        for (int i = 0;
                i < cartItems.size();
                i++) {

            if (cartItems.get(i)
                    .getProductId() == productId) {

                cartItems.remove(i);
                break;
            }
        }

        try {

            Connection con = getConnection();

            String sql =
                    "DELETE FROM cart "
                    + "WHERE product_id = ? "
                    + "LIMIT 1";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, productId);

            ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    public void clearCart() {

        cartItems.clear();

        try {

            Connection con = getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                            "DELETE FROM cart");

            ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}