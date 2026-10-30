package reservation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.ejb.Stateless;

@Stateless
public class ReservationBean {

    public String reserveRoom(String username,
                              String contact,
                              String roomType) {

        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement update = null;
        PreparedStatement insert = null;
        ResultSet rs = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hotel?useSSL=false&allowPublicKeyRetrieval=true",
                "root",
                "password"
            );

            String sql =
                "SELECT room_no FROM rooms "
                + "WHERE room_type = ? "
                + "AND status = 'Available' "
                + "LIMIT 1";

            ps = con.prepareStatement(sql);

            ps.setString(1, roomType);

            rs = ps.executeQuery();

            if (!rs.next()) {

                return "Sorry, "
                        + roomType
                        + " room is not available.";

            }

            int roomNo = rs.getInt("room_no");

            String updateSql =
                "UPDATE rooms SET status = 'Booked' "
                + "WHERE room_no = ?";

            update = con.prepareStatement(updateSql);

            update.setInt(1, roomNo);

            int result = update.executeUpdate();

            if (result > 0) {

                String insertSql =
                    "INSERT INTO reservation "
                    + "(username, contact, room_no, room_type) "
                    + "VALUES (?, ?, ?, ?)";

                insert = con.prepareStatement(insertSql);

                insert.setString(1, username);
                insert.setString(2, contact);
                insert.setInt(3, roomNo);
                insert.setString(4, roomType);

                insert.executeUpdate();

                return "Room No. "
                        + roomNo
                        + " is booked for "
                        + username
                        + ".";

            } else {

                return "Sorry, room is not available.";

            }

        } catch (Exception e) {

            return "ERROR: " + e.toString();

        } finally {

            try {

                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (update != null)
                    update.close();

                if (insert != null)
                    insert.close();

                if (con != null)
                    con.close();

            } catch (Exception e) {
            }
        }
    }
}