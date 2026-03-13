<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Booking Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Arial', sans-serif; padding-top: 20px; }
        .container { max-width: 800px; margin: auto; }
        .header { background-color: #f8f9fa; padding: 10px; text-align: center; }
        .btn-add { margin-top: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Book Your Flight</h1>
        </div>
	        <form action="booking.jsp" method="post">
	        <input type="hidden" name="flightId" value="<%= request.getParameter("flightId") %>">
	            <input type="hidden" name="departureCity" value="<%= request.getParameter("departureCity") %>">
	            <input type="hidden" name="destinationCity" value="<%= request.getParameter("destinationCity") %>">
	            <input type="hidden" name="departureTime" value="<%= request.getParameter("departureTime") %>">
	            <input type="hidden" name="pricePerPassenger" value="<%= request.getParameter("price") %>">
	            
	             <div class="form-group">
	                <label>Flight Id:</label>
	                <input type="text" class="form-control" name="filghtId" value="<%= request.getParameter("flightId") %>" readonly>
	            </div>
	            
	            
	           
	            <div class="form-group">
	                <label>Departure Date:</label>
	                <input type="text" class="form-control" name="departureDate" value="<%= request.getParameter("departureDate") %>" readonly>
	            </div>
	            
	             <div class="form-group">
                    <label>Username:</label>
                    <input type="text" class="form-control" name="username" placeholder="must enter login username" required>
                </div>
           
            <div id="passengerDetails">
                <div class="form-group">
                    <label>Passenger Name:</label>
                    <input type="text" class="form-control" name="passengerName" required>
                </div>
                <div class="form-group">
                    <label>Passenger Age:</label>
                    <input type="number" class="form-control" name="passengerAge" required>
                </div>
                <div class="form-group">
                    <label>Contact Number:</label>
                    <input type="text" class="form-control" name="passengerContact" required>
                </div>
            </div>
            <button type="button" onclick="addPassenger()" class="btn btn-secondary btn-add">Add Another Passenger</button>
            <div class="form-group">
                <label>Total Price: </label>
                <input type="hidden" id="totalPrice" name="totalPrice" value="<%= request.getParameter("price") %>">
                <span id="priceDisplay"><%= request.getParameter("price") %></span>
            </div>
            <button type="submit" class="btn btn-primary">Submit Booking</button>
        </form>
    </div>
    <script>
        let basePrice = parseFloat(document.getElementsByName("pricePerPassenger")[0].value);
        function addPassenger() {
            let container = document.getElementById("passengerDetails");
            let template = `<div class="form-group">
                                <label>Passenger Name:</label>
                                <input type="text" class="form-control" name="passengerName" required>
                            </div>
                            <div class="form-group">
                                <label>Passenger Age:</label>
                                <input type="number" class="form-control" name="passengerAge" required>
                            </div>
                            <div class="form-group">
                                <label>Contact Number:</label>
                                <input type="text" class="form-control" name="passengerContact" required>
                            </div>`;
            container.insertAdjacentHTML('beforeend', template);
            updateTotalPrice();
        }

        function updateTotalPrice() {
            let count = document.querySelectorAll('#passengerDetails > div').length / 3; // Each passenger has 3 divs
            let totalPrice = basePrice * count;
            document.getElementById("totalPrice").value = totalPrice.toFixed(2);
            document.getElementById("priceDisplay").textContent = totalPrice.toFixed(2);
        }
    </script>
</body>
</html>
