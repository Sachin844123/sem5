package p1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.ejb.Stateless;

@Stateless
public class VisitorStat implements VisitorStatRemote {
    private Connection con;
    private Statement smt;

    @PostConstruct
    public void connect() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/mydb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                    "root", "root");
            System.out.println("MYSQL CONNECTION SUCCESSFUL");
        } catch (Exception e) {
            System.out.println("MYSQL CONNECTION FAILED");
            e.printStackTrace();
        }
    }

    @PreDestroy
    public void disconnect() {
        try {
            if (con != null) {
                con.close();
                System.out.println("MYSQL CONNECTION CLOSED");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int addvisitor(String host) {
        int count = 0;
        try {
            if (con == null) {
                System.out.println("DATABASE CONNECTION IS NULL");
                return 0;
            }
            smt = con.createStatement();
            String q = "INSERT INTO userstat(dt, hostname, visits) "
                    + "VALUES(NOW(), '" + host + "', 1) "
                    + "ON DUPLICATE KEY UPDATE visits = visits + 1";
            smt.executeUpdate(q);
            q = "SELECT visits FROM userstat WHERE hostname = '" + host + "'";
            java.sql.ResultSet rs = smt.executeQuery(q);
            if (rs.next()) {
                count = rs.getInt("visits");
            }
            System.out.println("VISITOR COUNT: " + count);
        } catch (Exception e) {
            System.out.println("INSERT FAILED");
            e.printStackTrace();
        }
        return count;
    }
}
