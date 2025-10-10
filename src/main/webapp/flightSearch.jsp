<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TripSync | Search Flights</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fbff;
            margin: 0;
            padding: 0;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 60px;
            background: white;
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.05);
        }

        header img.logo {
            height: 40px;
        }

        nav a {
            margin: 0 15px;
            text-decoration: none;
            color: #2c3e50;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        nav a.active, nav a:hover {
            color: #007bff;
        }

        .container {
            max-width: 1000px;
            margin: 50px auto;
            background: #ffffff;
            padding: 40px 60px;
            border-radius: 20px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
        }

        h2 {
            color: #0d47a1;
            font-size: 28px;
            text-align: center;
            margin-bottom: 25px;
        }

        .search-form {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 40px;
        }

        .search-form input, .search-form button {
            padding: 10px 15px;
            border-radius: 8px;
            border: 1px solid #dfe6e9;
            font-size: 15px;
            outline: none;
        }

        .search-form button {
            background: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }

        .search-form button:hover {
            background: #0056b3;
        }

        .flight-card {
            border: 1px solid #e0e0e0;
            padding: 25px;
            margin: 20px 0;
            border-radius: 12px;
            background: #f9fcff;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.05);
        }

        .flight-card h3 {
            margin: 0 0 15px;
            text-align: center;
            color: #004aad;
        }

        .seat {
            width: 40px;
            height: 40px;
            line-height: 40px;
            margin: 0 5px;
            text-align: center;
            border-radius: 5px;
            font-weight: bold;
            border: 2px solid #0077cc;
            display: inline-block;
            user-select: none;
        }

        .booking-form input {
            padding: 8px;
            margin: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .booking-form button {
            padding: 8px 15px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .booking-form button:hover {
            background: #0056b3;
        }

        footer {
            text-align: center;
            padding: 20px;
            background: #f1f6fb;
            color: #777;
            margin-top: 50px;
        }

        footer a {
            color: #007bff;
            text-decoration: none;
            margin: 0 5px;
        }

        footer a:hover {
            text-decoration: underline;
        }
     nav a {
            margin-left: 30px;
            text-decoration: none;
            color: #0a4a84;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: #0077cc;
        }
                   body {
        margin: 0;
        font-family: 'Poppins', sans-serif;
        background-image: url('${pageContext.request.contextPath}/images/world.jpg');
        background-size: cover;           /* ensures full-page coverage */
        background-repeat: no-repeat;     /* no tiling */
        background-attachment: fixed;     /* makes it stay still when scrolling */
        background-position: center;      /* centers the image */
        color: #222;
    }

    body::before {
        content: "";
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(255, 255, 255, 0.85); /* light overlay for contrast */
        z-index: -1;
    }
    </style>
</head>
<body>

<header>
<img src="<%= request.getContextPath() %>/images/TripSync.jpg" alt="TripSync Logo" class="logo" width="105px" height="100px">
    <nav>
        <a href="index.jsp">Home</a>
    </nav>
</header>

<div class="container">
    <h2>Search Flights</h2>

    <form action="FlightServlet" method="post" class="search-form">
        <input type="hidden" name="action" value="search">
        <input type="text" name="source" placeholder="From" required>
        <input type="text" name="destination" placeholder="To" required>
        <input type="date" name="date" required>
        <button type="submit">Search</button>
    </form>

<%
List<Map<String, Object>> flights = (List<Map<String, Object>>) request.getAttribute("flights");
if (flights != null && !flights.isEmpty()) {
    for (Map<String, Object> flight : flights) {
        int flightId = (int) flight.get("id");
        String name = (String) flight.get("name");
        String date = (String) flight.get("date");
        String price = (String) flight.get("price");
        String src = (String) flight.get("source");
        String dst = (String) flight.get("destination");
        Set<String> bookedSeats = (Set<String>) flight.get("bookedSeats");
%>

<div class="flight-card">
    <h3>✈ <%= name %> | <%= src %> → <%= dst %> | Date: <%= date %> | ₹<%= price %></h3>

    <div style="margin: 20px auto; text-align:center;">
        <div style="display:inline-block; background:#e8f3ff; padding:15px; border-radius:15px; box-shadow:0 4px 10px rgba(0,0,0,0.1);">
            <div style="height:30px; background:#99ccff; border-radius:8px 8px 0 0; color:white; line-height:30px; font-weight:bold;">
                Cockpit
            </div>

            <%
            String[] seatsPerRow = {"A","B","C","D","E","F"};
            for (int row=1; row<=10; row++) {
            %>
            <div style="display:flex; justify-content:center; margin:5px 0;">
                <% for (int i=0; i<seatsPerRow.length; i++) {
                    String seatNum = row + seatsPerRow[i];
                    boolean booked = bookedSeats.contains(seatNum);
                    String bgColor = booked ? "#ccc" : "#fff";
                    String cursor = booked ? "not-allowed" : "pointer";
                    String margin = (i==2) ? "0 15px" : "0 5px";
                %>
                <div class="seat" data-seat="<%= seatNum %>"
                     style="background-color:<%= bgColor %>; cursor:<%= cursor %>; margin:<%= margin %>;">
                    <%= seatNum %>
                </div>
                <% } %>
            </div>
            <% } %>

            <div style="height:30px; background:#99ccff; border-radius:0 0 8px 8px; color:white; line-height:30px; font-weight:bold;">
                Rear Door
            </div>
        </div>
    </div>

    <form action="FlightServlet" method="post" onsubmit="return validateSeat(this)" class="booking-form" style="text-align:center;">
        <input type="hidden" name="action" value="book">
        <input type="hidden" name="flight_id" value="<%= flightId %>">
        <input type="text" name="passenger_name" placeholder="Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="text" name="phone" placeholder="Phone" required>
        <input type="hidden" name="amount" value="<%= price %>">
        <input type="hidden" class="seat-input" name="seat_number" value="">
        <button type="submit">Book Selected Seat</button>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const cards = document.querySelectorAll('.flight-card');
    cards.forEach(card => {
        const seats = card.querySelectorAll('.seat');
        const seatInput = card.querySelector('.seat-input');
        seats.forEach(seat => {
            if (seat.style.backgroundColor !== 'rgb(204, 204, 204)') {
                seat.addEventListener('click', () => {
                    seats.forEach(s => {
                        if (s.style.backgroundColor !== 'rgb(204, 204, 204)') {
                            s.style.backgroundColor = '#fff';
                            s.style.color = 'black';
                        }
                    });
                    seat.style.backgroundColor = '#ff7f50';
                    seat.style.color = 'white';
                    seatInput.value = seat.dataset.seat;
                });
            }
        });
    });
});

function validateSeat(form) {
    const seat = form.querySelector('input[name="seat_number"]').value;
    if (!seat) {
        alert("Please select a seat before booking!");
        return false;
    }
    return true;
}
</script>

<% } } else if (request.getAttribute("flights") != null) { %>
<p style="text-align:center; color:#888;">No flights found for this route and date.</p>
<% } %>
</div>
</body>
</html>
