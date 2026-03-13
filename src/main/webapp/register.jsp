<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        form {
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        h1 {
            color: #333;
        }
        div {
            margin-bottom: 10px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box; /* Adds padding inside the box */
        }
        input[type="submit"] {
            background-color: #5c67f2;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #4a54e1;
        }
    </style>
    <script type="text/javascript">
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
    <h1>Register</h1>
    <% 
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean redirect = false;

        if (username != null && email != null && password != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightBooking", "root", "root");
                
                // Check if username or email already exists
                String checkQuery = "SELECT username, email FROM Users WHERE username = ? OR email = ?";
                pstmt = conn.prepareStatement(checkQuery);
                pstmt.setString(1, username);
                pstmt.setString(2, email);
                rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    if (username.equals(rs.getString("username"))) {
                        out.println("<script type='text/javascript'>showAlert('Username already in use. Please choose another username.');</script>");
                    } else if (email.equals(rs.getString("email"))) {
                        out.println("<script type='text/javascript'>showAlert('Email already in use. Please choose another email.');</script>");
                    }
                } else {
                    rs.close(); // Close the initial result set
                    pstmt.close(); // Close the initial prepared statement

                    // Proceed with registration
                    String insertQuery = "INSERT INTO Users (username, email, password) VALUES (?, ?, ?)";
                    pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setString(1, username);
                    pstmt.setString(2, email);
                    pstmt.setString(3, password);
                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        redirect = true;
                    } else {
                        out.println("<script type='text/javascript'>showAlert('Registration failed!');</script>");
                    }
                }
            } catch (Exception e) {
                out.println("<script type='text/javascript'>showAlert('Error: " + e.getMessage() + "');</script>");
            } finally {
                if (rs != null) { rs.close(); }
                if (pstmt != null) { pstmt.close(); }
                if (conn != null) { conn.close(); }
                if (redirect) {
                    response.sendRedirect("login.jsp");
                    return;
                }
            }
        }
    %>
    <form action="register.jsp" method="post">
        <div>
            <label>Username:</label>
            <input type="text" name="username" required>
        </div>
        <div>
            <label>Email:</label>
            <input type="email" name="email" required>
        </div>
        <div>
            <label>Password:</label>
            <input type="password" name="password" required>
        </div>
        <div>
            <input type="submit" value="Register">
        </div>
    </form>
</body>
</html>
