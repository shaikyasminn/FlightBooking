
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-5">Edit User</h1>
        <%
            // Get the user ID from the request parameters
            int id = Integer.parseInt(request.getParameter("id"));

            // Connect to the database
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightBooking", "root", "root");
                String sql = "SELECT * FROM users WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();

                // Check if the user exists
                if (rs.next()) {
                    // Set the form values to the user's current information
                    String username = rs.getString("username");
                    String email = rs.getString("email");
                    String password = rs.getString("password");

                    // Display the form
                    %>
                    <form action="updateuser.jsp" method="post">
                        <input type="hidden" name="id" value="<%= id %>">
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input type="text" name="username" value="<%= username %>" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" name="email" value="<%= email %>" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type="password" name="password" value="<%= password %>" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Update User</button>
                    </form>
                    <%
                } else {
                    // Display an error message
                    out.println("Error: User not found.");
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>