<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Form Submission</title>
</head>
<body>
<%
    // Database setup - normally you would hide these details in an external configuration file
    String dbURL = "jdbc:mysql://localhost:3306/FlightBooking";
    String dbUser = "root";
    String dbPass = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Load the database driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Create SQL Query
        String sql = "INSERT INTO contacts (name, email, message) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, message);

        // Execute Update
        int rows = pstmt.executeUpdate();
        if(rows > 0) {
            out.println("<p>Record inserted successfully!</p>");
        }
    } catch(Exception e) {
        e.printStackTrace();
        out.println("<p>Error saving the data: " + e.getMessage() + "</p>");
    } finally {
        if (pstmt != null) { try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); } }
        if (conn != null) { try { conn.close(); } catch (SQLException e) { e.printStackTrace(); } }
    }
%>
    <p><a href="welcome.jsp">Back to Home</a></p>
</body>
</html>
