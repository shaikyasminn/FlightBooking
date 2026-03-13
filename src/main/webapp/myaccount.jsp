<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
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
        .profile-info {
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .btn-primary {
            background-color: #007bff;
            color: #fff;
            border: none;
        }
        .btn-danger {
            background-color: #dc3545;
            color: #fff;
            border: none;
        }
        
         .navbar { background-color: black; position: fixed; width: 100%; z-index: 1000; }
    .nav-link { color: #fff !important; }
    .nav-link:hover { background-color: #007bff; border-radius: 5px; }
        
    </style>
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
        <h2>Profile</h2>
        <div class="profile-details">
            <%
                String url = "jdbc:mysql://localhost:3306/FlightBooking";
                String dbUsername = "root";
                String dbPassword = "root";
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUsername, dbPassword);
                    String userQuery = "SELECT * FROM users WHERE username = ?";
                    stmt = conn.prepareStatement(userQuery);
                    stmt.setString(1, (String) session.getAttribute("username"));
                    rs = stmt.executeQuery();
                    if (rs.next()) {
            %>
            <div class="profile-info">
                <p><strong>Username:</strong> <%= rs.getString("username") %></p>
                <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                <!-- Display other user details here -->
            </div>
            <%
                        String username = rs.getString("username");
            %>
            <a href="viewbooking.jsp?username=<%=username%>" class="btn btn-primary">View Booking Details</a> 
            
            <%
                    }
                } catch (Exception e) {
                    out.println("<h2>Error</h2>");
                    out.println("<p>" + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<h2>Error</h2>");
                        out.println("<p>" + e.getMessage() + "</p>");
                    }
                }
            %>   <br> <br>
        </div>
        <a href="welcome.html" class="btn btn-danger">Logout</a>
    </div>
</body>
</html>
