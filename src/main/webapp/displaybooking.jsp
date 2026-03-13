<%@ page import="java.sql.*, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f8;
            padding-top: 60px; /* Adjusted to ensure content is below the navbar */
        }
        .navbar {
            background-color: #333; /* Bootstrap primary color */
        }
        .navbar a.nav-link {
            color: white;
            transition: color 0.3s, background-color 0.3s;
        }
        .navbar a.nav-link:hover, .navbar a.nav-link.active {
            background-color: #0056b3; /* Darker blue on hover */
            border-radius: 5px;
        }
        .container {
            max-width: 1200px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table-hover tbody tr:hover {
            background-color: #f4f4f8;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #e3f2fd;
        }
        .btn-view, .btn-delete {
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn-view {
            background-color: #007bff;
        }
        .btn-delete {
            background-color: #dc3545;
        }
        .btn-view:hover {
            background-color: #0056b3;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">FlightBooking</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-link" href="admindashboard.html">Home</a>
                <a class="nav-link" href="users.jsp">Users</a>
                <a class="nav-link active" aria-current="page" href="">Bookings</a>
                <a class="nav-link" href="contactList.jsp">Contact List</a>
                 <a class="nav-link" href="welcome.html">LogOut</a>
            </div>
        </div>
    </div>
</nav>

<div style="margin-top: 7%;" class="container">
    <h2 class="mb-4 text-center">Booking Details</h2>
    <table class="table table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>FlightId</th>
                <th>Departure City</th>
                <th>Destination City</th>
                <th>Departure Date</th>
                <th>Departure Time</th>
                <th>Total Price</th> <!-- Modified here -->
                <th>Passengers</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/FlightBooking", "root", "root");
                stmt = conn.createStatement();
                String sql = "SELECT * FROM Booking";
                rs = stmt.executeQuery(sql);
                while (rs.next()) {
                    int bookingId = rs.getInt("booking_id");
                    String userName = rs.getString("username");
                    String flightId = rs.getString("flight_id");
                    String departureCity = rs.getString("departure_city");
                    String destinationCity = rs.getString("destination_city");
                    String departureDate = rs.getString("departure_date");
                    String departureTime = rs.getString("departure_time");
                    double totalPrice = rs.getDouble("total_price");
            %>
            <tr>
                <td><%= bookingId %></td>
                <td><%= userName %></td>
                <td><%= flightId %></td>
                <td><%= departureCity %></td>
                <td><%= destinationCity %></td>
                <td><%= departureDate %></td>
                <td><%= departureTime %></td>
                <td><%= String.format("%.2f", totalPrice) %></td> <!-- Modified here -->
                <td><button class="btn btn-primary btn-view" onclick="location.href='adminViewPassengers.jsp?bookingId=<%= bookingId %>';">View</button></td>
                <td><button class="btn btn-danger btn-delete" onclick="deleteBooking(<%= bookingId %>);">Delete</button></td>
            </tr>
            <% 
                }
            } catch (Exception e) {
                out.println("Error retrieving data: " + e.getMessage());
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ex) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ex) {}
                if (conn != null) try { conn.close(); } catch (SQLException ex) {}
            }
            %>
        </tbody>
    </table>
</div>

<script>
function deleteBooking(bookingId) {
    if (confirm("Are you sure you want to delete this booking?")) {
        $.ajax({
            url: 'delete.jsp',
            type: 'POST',
            data: { bookingId: bookingId },
            success: function(response) {
                alert(response);  // Display a success message from the server
                location.reload();  // Reload the page to reflect changes
            },
            error: function() {
                alert('Error deleting booking.');
            }
        });
    }
}
</script>

</body>
</html>
