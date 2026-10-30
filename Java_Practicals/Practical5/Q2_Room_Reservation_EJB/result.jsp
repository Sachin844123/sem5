<%@ page import="javax.naming.*" %>
<%@ page import="ejb.RoomReservationBean" %>
<html>
<body>
    <h2>Room Reservation Details</h2>
    <%
        String name = request.getParameter("name");
        String room = request.getParameter("room");
        String checkin = request.getParameter("checkin");
        int guests = Integer.parseInt(request.getParameter("guests"));
        int days = Integer.parseInt(request.getParameter("days"));
        InitialContext context = new InitialContext();
        RoomReservationBean reservation = (RoomReservationBean) context.lookup(
                "java:global/Practical5b/RoomReservationBean");
        double amount = reservation.calculateAmount(room, days);
    %>
    Guest Name: <%= name %><br><br>
    Room Type: <%= room %><br><br>
    Check-in Date: <%= checkin %><br><br>
    Number of Guests: <%= guests %><br><br>
    Number of Days: <%= days %><br><br>
    Total Amount: Rs. <%= amount %><br><br>
    <h3>Room Reserved Successfully!</h3>
</body>
</html>
