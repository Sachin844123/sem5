package ejb;

import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateful;

@Stateful
public class ShoppingCartBean {
    private List<String> cart = new ArrayList<String>();
    private double total = 0;

    public void addItem(String product, int quantity) {
        cart.add(product + " x " + quantity);
        if (product.equals("Laptop")) {
            total += 50000 * quantity;
        } else if (product.equals("Mobile")) {
            total += 20000 * quantity;
        } else if (product.equals("Headphones")) {
            total += 2000 * quantity;
        } else if (product.equals("Keyboard")) {
            total += 1500 * quantity;
        }
    }

    public List<String> getCart() {
        return cart;
    }

    public double getTotal() {
        return total;
    }
}
