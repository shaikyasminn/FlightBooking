<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Form</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
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
            width: 300px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        div {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        input[type="text"],
        input[type="password"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box; /* Adds padding inside the box */
        }
        input[type="submit"] {
            background-color: #5c67f2;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }
        input[type="submit"]:hover {
            background-color: #4a54e1;
        }
    </style>
    <script type="text/javascript">
        function handleLogin(result, message) {
            if (result === "success") {
                window.location = "welcome.jsp"; // Redirect to a welcome page
            } else {
                alert(message); // Show an error message
                window.location = "login.jsp"; // Redirect back to the login form
            }
        }
    </script>
</head>
<body>
    <h1>Login</h1>
   <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/FlightBooking";
        String dbUsername = "root";
        String dbPassword = "root";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish the database connection
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);
            
            // Prepare the SQL statement to retrieve user data
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            // Execute the SQL statement
            rs = stmt.executeQuery();
            if (rs.next()) {
                // Login successful
                session.setAttribute("username", username);
                response.sendRedirect("welcome.jsp");
            } else {
                // Login failed
                out.println("<script>");
                out.println("showAlert('Invalid username or password. Please try again.');");
                out.println("</script>");
            }
        } catch (Exception e) {
            // Handle any errors
            out.println("<h2>Error</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
        } finally {
            // Close the database resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                // Handle database closure errors
                out.println("<h2>Error</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
            }
        }
    %>
    <form action="login.jsp" method="post">
        <div>
            <label>Username:</label>
            <input type="text" name="username" required>
        </div>
        <div>
            <label>Password:</label>
            <input type="password" name="password" required>
        </div>
        <div>
            <input type="submit" value="Login">
        </div>
    </form>
</body>
</html>
