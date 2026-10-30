package ejb;

import javax.ejb.Stateless;

@Stateless
public class RoomReservationBean {
    public double calculateAmount(String room, int days) {
        double rate = 0;
        if (room.equals("Single")) {
            rate = 1000;
        } else if (room.equals("Double")) {
            rate = 1800;
        } else if (room.equals("Deluxe")) {
            rate = 2500;
        }
        return rate * days;
    }
}
