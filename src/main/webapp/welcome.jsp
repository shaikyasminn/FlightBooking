<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Our Flight Booking System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
       body { font-family: 'Arial', sans-serif; padding-top: 70px; background-color: ;}
        .navbar { background-color: black; position: fixed; width: 100%; z-index: 1000; }
        .nav-link { color: #fff !important; }
        .nav-link:hover { background-color: #007bff; border-radius: 5px; }
        .form-section, .content-section { padding: 40px 0; }
        .footer { background-color: #f8f9fa; color: #666; text-align: center; padding: 20px 0; margin-top: 40px; }
        .table-container { margin-top: 20px; max-width: 90%; margin: auto; }
        .table { width: 100%; border-collapse: collapse; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        tr:hover { background-color: #f5f5f5; }
        .btn-book { color: #fff; background-color: #007bff; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer; }
    
   #services {
    background-color: #eef2ff; /* Soft blue background */
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
    margin-top: 40px;
}



    .service-item {
        text-align: center;
        margin-top: 20px;
        padding: 10px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .service-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    .service-item i {
        color: #0056b3; /* Primary theme color */
        margin-bottom: 15px;
    }
    .service-title {
        color: #0056b3;
        font-size: 1.5rem;
    }
    .service-item p {
        font-size: 0.9rem;
        color: #666;
    }
    .container {
        max-width: 1200px; /* Adjust container width as needed */
    }
    
   #about {
    background: #eef2ff;  /* Subtle gradient background */
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1); /* Soft shadow for a pop-out effect */
    margin-top: 20px; /* Adds some spacing from the top */
}

#about h2 {
    color: #0056b3; /* Primary color for headings */
    font-size: 2rem; /* Slightly larger size for heading */
    margin-bottom: 20px; /* Space below the heading */
}

#about p {
    font-size: 1rem; /* Appropriate size for readability */
    line-height: 1.6; /* Improves readability */
    color: #333; /* Darker text color for better contrast */
    margin-bottom: 15px; /* Space between paragraphs */
}

.img-fluid {
    max-width: 100%; /* Ensures the image is responsive */
    height: auto; /* Maintains aspect ratio */
    border-radius: 8px; /* Rounded corners for the image */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Shadow to make the image stand out */
    margin-top: 20px; /* Space above the image */
}

#contact {
    background: #eef2ff;  /* Subtle gradient background */
    padding: 50px 0; /* Larger padding for better focus */
    border-radius: 8px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* Soft shadow for depth */
}

.text-center {
    text-align: center;
}

.form-group label {
    display: block;
    text-align: left;
    margin-top: 10px;
    color: #333;
    font-weight: bold;
}

.form-control {
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    width: 100%; /* Ensures full width within column */
    box-shadow: inset 0 1px 3px rgba(0,0,0,0.1); /* Inner shadow for depth */
}

.btn-primary {
    background-color: #0056b3;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    width: 100%;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    cursor: pointer;
}

.btn-primary:hover {
    background-color: #004185;
}

#contact p {
    margin-bottom: 20px;
    color: #666;
}
.footer {
    background-color: #2C3E50;
    color: #fff;
    padding: 20px 0;
    font-size: 14px;
    line-height: 1.5;
}

.footer h5 {
    color: #f8f9fa;
    margin-bottom: 15px;
}

.footer ul {
    padding: 0;
}

.footer ul li a {
    color: #bdc3c7;
    text-decoration: none;
    transition: color 0.3s;
}

.footer ul li a:hover {
    color: #ecf0f1;
}

.footer a {
    color: #bdc3c7;
    padding: 0 10px;
    font-size: 20px;
    transition: color 0.3s;
}

.footer a:hover {
    color: #ecf0f1;
}

.footer p.text-center {
    margin-top: 20px;
    color: #95a5a6;
}

/* Font Awesome Icons */
.linked-icons {
    padding-right: 10px;
}

.booking-section {
    background: #eef2ff; /* Gradient background */
    padding: 20px;
    border-radius: 10px;
    color: white; /* Ensures text is visible on the darker background */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Adds depth with a shadow */
}

.booking-section h2 {
    margin-bottom: 20px;
}

.form-section {
    background: rgba(255, 255, 255, 0.8); /* Light semi-transparent background for form */
    padding: 20px;
    border-radius: 8px;
}

.form-control, .btn {
    margin-top: 10px;
}

.btn-primary {
    background-color: #0056b3;
    border: none;
}

.form-label {
    color: #2c3e50; /* Dark color for contrast against light form background */
}
.navbar-brand img {
    height: 40px;  /* Adjust based on your navbar height */
    width: auto;  /* Maintain aspect ratio */
    vertical-align: middle;  /* Aligns the image vertically centered */
}




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
                        <a class="nav-link active" aria-current="page" href="#home">Home</a>
                    </li>
                   
                    <li class="nav-item">
                        <a class="nav-link" href="myaccount.jsp">My Account</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#services">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="welcome.html">Log Out</a>
                    </li>
                </ul>
                <span class="navbar-text">
                    Welcome, <%= session.getAttribute("username") %>!
                </span>
            </div>
        </div>
    </nav>

 <section class="welcome-section d-flex justify-content-center align-items-center text-center" id="home">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-white">    
                        <p class="lead">"Traveling – it leaves you speechless, then turns you into a storyteller."</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    


<%!
    class Flight {
        int flightId;
        String departureCity;
        String destinationCity;
        String departureTime;
        int price;

        Flight(int flightId, String departureCity, String destinationCity, String departureTime, int price) {
            this.flightId = flightId;
            this.departureCity = departureCity;
            this.destinationCity = destinationCity;
            this.departureTime = departureTime;
            this.price = price;
        }

        public int getFlightId() { return flightId; }
        public String getDepartureCity() { return departureCity; }
        public String getDestinationCity() { return destinationCity; }
        public String getDepartureTime() { return departureTime; }
        public int getPrice() { return price; }
    }

    ArrayList<Flight> getAllFlights() throws ClassNotFoundException, SQLException {
        ArrayList<Flight> flights = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightBooking", "root", "root");
            String query = "SELECT flight_id, departure_city, destination_city, departure_time, price FROM flights";
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                flights.add(new Flight(
                    rs.getInt("flight_id"),
                    rs.getString("departure_city"),
                    rs.getString("destination_city"),
                    rs.getString("departure_time"),
                    rs.getInt("price")
                ));
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
        return flights;
    }

    ArrayList<Flight> getFilteredFlights(String route) throws ClassNotFoundException, SQLException {
        ArrayList<Flight> filteredFlights = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightBooking", "root", "root");
            String sql = "SELECT * FROM flights WHERE CONCAT(departure_city, ' to ', destination_city) = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, route);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                filteredFlights.add(new Flight(
                    rs.getInt("flight_id"),
                    rs.getString("departure_city"),
                    rs.getString("destination_city"),
                    rs.getString("departure_time"),
                    rs.getInt("price")
                ));
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
        return filteredFlights;
    }
%>
   

   <div class="container mt-5 booking-section" id="booking">
    <h2 style="text-align: center;color: #0056b3;">Book Your Flight</h2>
    <form method="post" class="form-section">
        <div class="mb-3">
            <label for="route" class="form-label">Select Route</label>
            <select class="form-control" id="route" name="route">
                <option selected disabled>Select Route</option>
                <% 
                try {
                    ArrayList<Flight> flights = getAllFlights();
                    for (Flight flight : flights) {
                        out.println("<option value='" + flight.getDepartureCity() + " to " + flight.getDestinationCity() + "'>" + flight.getDepartureCity() + " to " + flight.getDestinationCity() + "</option>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </select>
        </div>
        <div class="mb-3">
            <label for="departure_date" class="form-label">Departure Date</label>
            <input type="date" class="form-control" id="departure_date" name="departure_date">
        </div>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>
</div>
<% 
if ("post".equalsIgnoreCase(request.getMethod())) {
    String selectedRoute = request.getParameter("route");
    String selectedDate = request.getParameter("departure_date");
    if (selectedRoute != null && selectedDate != null) {
        try {
            ArrayList<Flight> resultFlights = getFilteredFlights(selectedRoute);
            if (!resultFlights.isEmpty()) {
%>
<div class="table-container">
    <h2>Available Flights for <%= selectedRoute %> on <%= selectedDate %>:</h2>
    <table class="table table-bordered table-hover">
        <thead class="thead-dark">
            <tr>
                <th>Flight ID</th>
                <th>Departure City</th>
                <th>Destination City</th>
                <th>Departure Time</th>
                <th>Price</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <% 
        for (Flight flight : resultFlights) {
        %>
            <tr>
                <td><%= flight.getFlightId() %></td>
                <td><%= flight.getDepartureCity() %></td>
                <td><%= flight.getDestinationCity() %></td>
                <td><%= flight.getDepartureTime() %> on <%= selectedDate %></td>
                <td><%= flight.getPrice() %></td>
                <td>
                    <form action="bookingform.jsp" method="post">
                        <input type="hidden" name="flightId" value="<%= flight.getFlightId() %>">
                        <input type="hidden" name="departureCity" value="<%= flight.getDepartureCity() %>">
                        <input type="hidden" name="destinationCity" value="<%= flight.getDestinationCity() %>">
                        <input type="hidden" name="departureTime" value="<%= flight.getDepartureTime() %>">
                        <input type="hidden" name="price" value="<%= flight.getPrice() %>">
                        <input type="hidden" name="departureDate" value="<%= selectedDate %>">
                        <button type="submit" class="btn btn-success btn-book">Book</button>
                    </form>
                </td>
            </tr>
        <%
        }
        %>
        </tbody>
    </table>
</div>
<% 
            } else {
                out.println("<p>No flights available for the selected route on " + selectedDate + ".</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error retrieving flight information. Please try again later.</p>");
        }
    }
}
%>
            <!-- Modal -->
           
       </div>
      
   
    
   <div class="container mt-5" id="services">
    <center><h2 style="color: #0056b3;">Our Services</h2></center>
    
    <div class="row">
        <div class="col-md-4 service-item">
            <i class="fas fa-plane-departure fa-3x"></i>
            <h3 class="service-title">Flight Booking</h3>
            <p>Book flights easily with our user-friendly interface, offering the best rates and quick confirmation.</p>
        </div>
        <div class="col-md-4 service-item">
            <i class="fas fa-bed fa-3x"></i>
            <h3 class="service-title">Hotel Booking</h3>
            <p>Reserve your hotel room through our platform and enjoy special discounts for bundled flight and hotel bookings.</p>
        </div>
        <div class="col-md-4 service-item">
            <i class="fas fa-car fa-3x"></i>
            <h3 class="service-title">Car Rentals</h3>
            <p>Find the best car rental deals at your destination, with options for pick-up at the airport upon arrival.</p>
        </div>
    </div>
</div>


    
   <div class="container mt-5" id="about">
    <h2>About Us</h2>
    <p>Founded in 2010, FlightBooker has grown to become one of the most trusted names in the travel industry. We specialize in offering a seamless online booking experience coupled with expert personalized service. Our mission is to simplify the travel planning process while providing the best value options to our customers worldwide.</p>
    <p>At FlightBooker, we believe travel is about experiences and creating memories that last a lifetime. That's why we partner with numerous airlines and travel providers to ensure our customers have access to a wide range of travel services and deals. Whether you're planning a quick weekend getaway or a month-long adventure across continents, our team is here to support you every step of the way.</p>
    <p>Our commitment to service excellence and continuous innovation in technology drives us forward. Join us in exploring the world at your fingertips.</p>
    <img src="https://img.freepik.com/premium-photo/airplane-taking-off-from-airport_37416-74.jpg" class="img-fluid" alt="Team at FlightBooker">
</div>


    
   <div class="container mt-5" id="contact">
    <div class="text-center">
        <h2>Contact Us</h2>
        <p>For inquiries or further information, please reach out to us through the form below. Our support team is ready to help you 24/7.</p>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <form action="contact.jsp" method="POST">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="message">Message:</label>
                    <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary mt-2">Send Message</button>
            </form>
        </div>
    </div>
</div>



    <div class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h5>About FlightBooker</h5>
                <ul class="list-unstyled">
                    <li><a href="#about">About Us</a></li>
                    <li><a href="#services">Services</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>Legal</h5>
                <ul class="list-unstyled">
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>Follow Us</h5>
                <a href="http://www.facebook.com"><i class="fab fa-facebook-f"></i></a>
                <a href="http://www.twitter.com"><i class="fab fa-twitter"></i></a>
                <a href="http://www.instagram.com"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
        <p class="text-center">&copy; 2024 FlightBooker. All Rights Reserved.</p>
    </div>
</div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    

</body>
</html>
