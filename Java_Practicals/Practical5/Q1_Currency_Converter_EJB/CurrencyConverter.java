package ejb;

import javax.ejb.Stateless;

@Stateless
public class CurrencyConverter {
    public double convert(double amount, String from, String to) {
        if (from.equals("USD") && to.equals("INR")) {
            return amount * 83;
        }
        if (from.equals("INR") && to.equals("USD")) {
            return amount / 83;
        }
        return amount;
    }
}
