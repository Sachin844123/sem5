package currency;

import javax.ejb.Stateless;

@Stateless
public class CurrencyBean {

    public double convert(double amount,
                          String from,
                          String to) {

        double amountInINR;

        if (from.equals("INR")) {
            amountInINR = amount;
        }
        else if (from.equals("USD")) {
            amountInINR = amount * 83.0;
        }
        else if (from.equals("EUR")) {
            amountInINR = amount * 90.0;
        }
        else if (from.equals("GBP")) {
            amountInINR = amount * 105.0;
        }
        else {
            return 0;
        }

        if (to.equals("INR")) {
            return amountInINR;
        }
        else if (to.equals("USD")) {
            return amountInINR / 83.0;
        }
        else if (to.equals("EUR")) {
            return amountInINR / 90.0;
        }
        else if (to.equals("GBP")) {
            return amountInINR / 105.0;
        }

        return 0;
    }
}