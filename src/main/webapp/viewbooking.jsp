<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: #ffffff;
        }
        .btn-view, .btn-delete {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            text-align: center;
            display: inline-block;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn-delete {
            background-color: #dc3545;
        }
        .btn-view:hover, .btn-delete:hover {
            background-color: #0056b3;
        }
        .navbar {
            background-color: black; 
            position: fixed; 
            width: 100%; 
            z-index: 1000;
        }
        .nav-link {
            color: #fff !important;
        }
        .nav-link:hover {
            background-color: #007bff;
            border-radius: 5px;
        }
    </style>
    <script>
    function deleteBooking(bookingId) {
        if (confirm("Are you sure you want to cancel this booking?")) {
            $.ajax({
                url: 'delete.jsp',
                type: 'POST',
                data: { bookingId: bookingId },
                success: function(response) {
                    alert(response); // Alert the response from the server
                    location.reload(); // Reload the page to reflect the changes
                },
                error: function() {
                    alert('Error: Unable to cancel booking.');
                }
            });
        }
    }
    </script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="https://user-images.githubusercontent.com/56977388/178157849-38d2f2c3-1c93-4dac-9577-57f3a752e2cd.png" alt="FlightBooker Logo" style="height: 40px;">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="welcome.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="welcome.jsp">Services</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="welcome.jsp">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="welcome.jsp">Contact Us</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div style="margin-top: 7%;" class="container">
    <h2>Your Booking Details</h2>
    <table>
        <tr>
            <th>Booking ID</th>
            <th>Departure City</th>
            <th>Destination City</th>
            <th>Departure Date</th>
            <th>Departure Time</th>
            <th>Total Price</th>
            <th>Flight Id</th>
            <th>Passengers</th>
            <th>Action</th>
        </tr>
        <%
            String url = "jdbc:mysql://localhost:3306/FlightBooking";
            String dbUsername = "root";
            String dbPassword = "root";
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, dbUsername, dbPassword);
                String query = "SELECT * FROM Booking WHERE username = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, (String) session.getAttribute("username"));
                rs = pstmt.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("booking_id") %></td>
            <td><%= rs.getString("departure_city") %></td>
            <td><%= rs.getString("destination_city") %></td>
            <td><%= rs.getString("departure_date") %></td>
            <td><%= rs.getString("departure_time") %></td>
            <td><%= rs.getDouble("total_price") %></td>
            <td><%= rs.getString("flight_id") %></td>
            <td>
                <a href="viewPassengers.jsp?bookingId=<%= rs.getInt("booking_id") %>" class="btn-view">View Details</a></td>
                <td><button class="btn-delete" onclick="deleteBooking(<%= rs.getInt("booking_id") %>)">Cancel Booking</button>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    out.println("<p>Error: " + ex.getMessage() + "</p>");
                }
            }
        %>
    </table>
</div>
</body>
</html>
