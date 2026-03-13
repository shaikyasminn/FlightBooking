<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>User Data</title>
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
    .table {
        margin-top: 20px;
        width: 95%;
        margin-left: auto;
        margin-right: auto;
    }
    th, td {
        text-align: left;
    }
    .hover-effect:hover {
        background-color: #f8f9fa !important; /* Light grey background on hover */
        cursor: pointer;
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
                <a class="nav-link active" aria-current="page" href="users.jsp">Users</a>
                <a class="nav-link" href="displaybooking.jsp">Bookings</a>
                <a class="nav-link" href="contactList.jsp">Contact List</a>
                 <a class="nav-link" href="welcome.html">LogOut</a>
            </div>
        </div>
    </div>
</nav>


    <div class="container">
        <h1 class="my-4">Users List</h1>
        <table class="table table-striped table-hover table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Password</th> <!-- Password column -->
                    <th>Actions</th> <!-- New column for actions (delete and edit) -->
                </tr>
            </thead>
            <tbody>
                <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightBooking", "root", "root");
                    String sql = "SELECT id, username, email, password FROM users"; // Include the password column in the query
                    pstmt = conn.prepareStatement(sql);
                   rs = pstmt.executeQuery();

                    while (rs.next()) {
                        %>
                        <tr class="hover-effect">
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("username") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("password") %></td> <!-- Displaying the password -->
                            <td>
                                <!-- Add delete button -->
                                <form action="deleteuser.jsp" method="post">
                                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>

                                <!-- Add edit button -->
                                <a href="edituser.jsp?id=<%= rs.getInt("id") %>" class="btn btn-primary btn-sm">Edit</a>
                            </td>
                        </tr>
                        <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>