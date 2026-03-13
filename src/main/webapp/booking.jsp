<%@ page import="java.sql.*, java.util.ArrayList" %>

<%
// Retrieve username from the session
String username = (String) session.getAttribute("username");
if (username == null || username.isEmpty()) {
    out.println("<p>Error: No user is logged in. Please log in to continue.</p>");
    return; // Stop further execution if no user is logged in
}

String departureCity = request.getParameter("departureCity");
String destinationCity = request.getParameter("destinationCity");
String departureDate = request.getParameter("departureDate");
String departureTime = request.getParameter("departureTime");
String totalPriceStr = request.getParameter("totalPrice");
String flightIdStr = request.getParameter("flightId");
double totalPrice = 0;
int flightId = 0;

if (totalPriceStr != null && !totalPriceStr.isEmpty()) {
    try {
        totalPrice = Double.parseDouble(totalPriceStr);
    } catch (NumberFormatException e) {
        out.println("<p>Error: Invalid total price value. " + e.getMessage() + "</p>");
        return; // Stop further execution in case of error
    }
} else {
    out.println("<p>Error: Total price is missing.</p>");
    return; // Stop further execution if total price is not provided
}

if (flightIdStr != null && !flightIdStr.isEmpty()) {
    try {
        flightId = Integer.parseInt(flightIdStr);
    } catch (NumberFormatException e) {
        out.println("<p>Error: Invalid flight ID. " + e.getMessage() + "</p>");
        return; // Stop further execution in case of error
    }
} else {
    out.println("<p>Error: Flight ID is missing.</p>");
    return; // Stop further execution if flight ID is not provided
}

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost/FlightBooking", "root", "root");

    // Insert booking information including username and flight_id
    String sql = "INSERT INTO Booking (username, flight_id, departure_city, destination_city, departure_date, departure_time, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
    pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    pstmt.setString(1, username);
    pstmt.setInt(2, flightId);
    pstmt.setString(3, departureCity);
    pstmt.setString(4, destinationCity);
    pstmt.setString(5, departureDate);
    pstmt.setString(6, departureTime);
    pstmt.setDouble(7, totalPrice);
    pstmt.executeUpdate();
    rs = pstmt.getGeneratedKeys();

    int bookingId = 0;
    if (rs.next()) {
        bookingId = rs.getInt(1);
    }

    // Handling multiple passengers
    String[] passengerNames = request.getParameterValues("passengerName");
    String[] passengerAges = request.getParameterValues("passengerAge");
    String[] passengerContacts = request.getParameterValues("passengerContact");

    if (passengerNames != null) {
        for (int i = 0; i < passengerNames.length; i++) {
            sql = "INSERT INTO Passenger (booking_id, name, age, contact_number) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookingId);
            pstmt.setString(2, passengerNames[i]);
            pstmt.setInt(3, Integer.parseInt(passengerAges[i]));
            pstmt.setString(4, passengerContacts[i]);
            pstmt.executeUpdate();
        }
    }
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
    e.printStackTrace();
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) {}
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    if (conn != null) try { conn.close(); } catch (SQLException e) {}
}
%>

<html>
<head>
    <title>Submission Complete</title>
    <script>
        // Display alert and redirect
        alert("Booking successful!");
        window.location.href = "welcome.jsp";
    </script>
</head>
<body>
</body>
</html>
