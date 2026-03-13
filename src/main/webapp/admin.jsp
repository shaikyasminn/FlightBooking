	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
</head>
<body>

<%
    // Hardcoded username and password
    String username = "admin";
    String password = "1234";

    // Check if username and password are correct
    String inputUsername = request.getParameter("username");
    String inputPassword = request.getParameter("password");

    if (inputUsername != null && inputPassword != null && inputUsername.equals(username) && inputPassword.equals(password)) {
        // Successful login, redirect to dashboard.html
        response.sendRedirect("admindashboard.html?username=" + username);
    } else {
        // Invalid credentials, redirect back to login page
        response.sendRedirect("admin.jsp");
    }
%>

</body>
</html>
