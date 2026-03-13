<%@page import="java.sql.*"%>
<%
    String resultMessage = "";
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/FlightBooking", "root", "root");

        // Start transaction
        conn.setAutoCommit(false);

        // Delete from Passengers first
        String sqlDeletePassengers = "DELETE FROM passenger WHERE booking_id = ?";
        pstmt = conn.prepareStatement(sqlDeletePassengers);
        pstmt.setInt(1, bookingId);
        pstmt.executeUpdate();

        // Then delete from Booking
        String sqlDeleteBooking = "DELETE FROM Booking WHERE booking_id = ?";
        pstmt = conn.prepareStatement(sqlDeleteBooking);
        pstmt.setInt(1, bookingId);
        int affectedRows = pstmt.executeUpdate();

        if (affectedRows > 0) {
            resultMessage = "Booking and related passengers deleted successfully.";
        } else {
            resultMessage = "No booking found with ID: " + bookingId;
        }

        // Commit transaction
        conn.commit();
    } catch (SQLException e) {
        resultMessage = "SQL Error: " + e.getMessage();
        // Attempt to rollback transaction
        if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
    } catch (ClassNotFoundException e) {
        resultMessage = "JDBC Driver not found: " + e.getMessage();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ex) {}
    }
    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(resultMessage);
%>
