<%@ page import="java.sql.*, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passenger Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif; 
            background-color: #f4f4f4;
            margin-top: 40px;
        }
        .container {
            max-width: 1200px;
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
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .btn-back {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 20px 0;
            transition-duration: 0.4s;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-back:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Passenger Details</h2>
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
                <%
                String bookingId = request.getParameter("bookingId");
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost/FlightBooking", "root", "nani");
                    String sql = "SELECT * FROM passenger WHERE booking_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(bookingId));
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        int passengerId = rs.getInt("passenger_id");
                        String name = rs.getString("name");
                        int age = rs.getInt("age");
                        String contactNumber = rs.getString("contact_number");
                %>
                <tr>
                    <td><%= passengerId %></td>
                    <td><%= name %></td>
                    <td><%= age %></td>
                    <td><%= contactNumber %></td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                    out.println("<p class='alert alert-danger'>Error retrieving data: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ex) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ex) {}
                }
                %>
            </tbody>
        </table>
        <button onclick="window.history.back();" class="btn-back">Go Back</button>
    </div>
</body>
</html>