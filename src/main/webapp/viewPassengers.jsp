<%@ page import="java.sql.*, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta viewport="width=device-width, initial-scale=1.0">
    <title>Print Booking and Passenger Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif; 
            background-color: #f4f4f4;
            padding-top: 40px;
        }
        .container {
            max-width: 1000px;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: #ffffff;
        }
        .btn-print {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-print:hover {
            background-color: #0056b3;
        }
        @media print {
            .btn-print {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Booking and Passenger Details</h2>
        <% String bookingId = request.getParameter("bookingId");
           Connection conn = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           try {
               Class.forName("com.mysql.jdbc.Driver");
               conn = DriverManager.getConnection("jdbc:mysql://localhost/FlightBooking", "root", "root");
               String sql = "SELECT * FROM Booking WHERE booking_id = ?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, Integer.parseInt(bookingId));
               rs = pstmt.executeQuery();
               if (rs.next()) {
        %>
        <table class="table">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Flight ID</th>
                    <th>Departure City</th>
                    <th>Destination City</th>
                    <th>Departure Date</th>
                    <th>Departure Time</th>
                    <th>Total Price</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= rs.getInt("booking_id") %></td>
                    <td><%= rs.getString("flight_id") %></td>
                    <td><%= rs.getString("departure_city") %></td>
                    <td><%= rs.getString("destination_city") %></td>
                    <td><%= rs.getString("departure_date") %></td>
                    <td><%= rs.getString("departure_time") %></td>
                    <td>₹<%= rs.getDouble("total_price") %></td>
                </tr>
            </tbody>
        </table>
        <%
               }
               // Fetch passenger details
               sql = "SELECT * FROM Passenger WHERE booking_id = ?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, Integer.parseInt(bookingId));
               rs = pstmt.executeQuery();
        %>
        <h3>Passenger Details</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Passenger ID</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Contact Number</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("passenger_id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getInt("age") %></td>
                    <td><%= rs.getString("contact_number") %></td>
                </tr>
                <% }
                   } catch (Exception e) {
                       out.println("<p class='alert alert-danger'>Error retrieving booking and passenger details: " + e.getMessage() + "</p>");
                       e.printStackTrace();
                   } finally {
                       if (rs != null) try { rs.close(); } catch (SQLException ex) {}
                       if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
                       if (conn != null) try { conn.close(); } catch (SQLException ex) {}
                   }
                %>
            </tbody>
        </table>
        <button onclick="window.print();" class="btn-print">Print Ticket</button>
    </div>
</body>
</html>
