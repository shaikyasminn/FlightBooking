<%@ page import="java.sql.*" %>

<%
    // Get the user ID from the request parameters
    int id = Integer.parseInt(request.getParameter("id"));

    // Connect to the database
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightBooking", "root", "root");
        String sql = "DELETE FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            // Redirect the user back to the users page
            response.sendRedirect("users.jsp");
        } else {
            // Display an error message
            out.println("Error: User not found.");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>