<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
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
                <a class="nav-link" aria-current="page" href="users.jsp">Users</a>
                <a class="nav-link" href="displaybooking.jsp">Bookings</a>
                <a class="nav-link active" href="#">Contact List</a>
                 <a class="nav-link" href="welcome.html">LogOut</a>
            </div>
        </div>
    </div>
</nav>

    <h2 style="margin-top: 5%;">Contact List</h2>
    <table class="table table-striped">
    <thead class="table-dark">
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Message</th>
        </tr>
    </thead>
    <tbody>
        <% 
            // Database setup
            String dbURL = "jdbc:mysql://localhost:3306/FlightBooking";
            String dbUser = "root";
            String dbPass = "root";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Load the database driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

                // Create SQL Query
                String sql = "SELECT * FROM contacts";
                pstmt = conn.prepareStatement(sql);

                // Execute Query
                rs = pstmt.executeQuery();

                // Iterate through the result set and display data
                while(rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String message = rs.getString("message");

                    out.println("<tr>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + message + "</td>");
                    out.println("</tr>");
                }
            } catch(Exception e) {
                e.printStackTrace();
                out.println("<tr><td colspan='3'>Error retrieving data: " + e.getMessage() + "</td></tr>");
            } finally {
                // Close resources
                if (rs != null) { try { rs.close(); } catch (SQLException e) { e.printStackTrace(); } }
                if (pstmt != null) { try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); } }
                if (conn != null) { try { conn.close(); } catch (SQLException e) { e.printStackTrace(); } }
            }
        %>
    </tbody>
</table>

  
</body>
</html>
