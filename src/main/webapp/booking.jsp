<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ page import="java.sql.*, com.tripsync.servlet.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Your Bookings | TripSync</title>
    <style>
        body {
            font-family: "Poppins", Arial, sans-serif;
            background-color: #f4f8fc;
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
            margin: 60px auto;
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        h2 {
            color: #0077cc;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .card {
            background: #f9fcff;
            border: 1px solid #dbe8f6;
            border-radius: 12px;
            padding: 20px;
            margin: 15px auto;
            max-width: 750px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: translateY(-3px);
        }

        .card strong {
            font-size: 18px;
            color: #0077cc;
        }

        .card p {
            margin: 8px 0;
            color: #333;
            line-height: 1.4;
        }

        .no-bookings {
            text-align: center;
            color: #555;
            font-size: 16px;
            margin-top: 40px;
        }

        .type-tag {
            display: inline-block;
            background-color: #0077cc;
            color: white;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            color: #777;
            font-size: 13px;
        }

        .footer a {
            color: #0077cc;
            text-decoration: none;
            margin: 0 5px;
        }

        .footer a:hover {
            text-decoration: underline;
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
<img src="<%= request.getContextPath() %>/images/TripSync.jpg" alt="TripSync Logo" class="logo" width="90px" height="100px">
    <nav>
        <a href="index.jsp">Home</a>
    </nav>
</header>

    <div class="container">
        <h2>📘 Your Bookings</h2>

        <%
            boolean hasBookings = false;
            try (Connection con = DBConnection.getConnection()) {
                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM bookings WHERE email = ? ORDER BY booking_date DESC"
                );
                ps.setString(1, user);  // Only show bookings for logged-in user
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    hasBookings = true;
        %>
                    <div class="card">
                        <span class="type-tag"><%= rs.getString("booking_type").toUpperCase() %></span>
                        <p><strong>Booking ID:</strong> <%= rs.getString("reference_id") %></p>
                        <% if (rs.getString("seat_number") != null && !rs.getString("seat_number").isEmpty()) { %>
                            <p><strong>Seat Number:</strong> <%= rs.getString("seat_number") %></p>
                        <% } %>
                        <p><strong>Name:</strong> <%= rs.getString("passenger_name") %></p>
                        <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                        <p><strong>Phone:</strong> <%= rs.getString("phone") %></p>
                        <p><strong>Date of Booking:</strong> <%= rs.getString("booking_date") %></p>
                        <p><strong>Amount:</strong> ₹<%= rs.getString("amount") %></p>
                    </div>
        <%
                }

                if (!hasBookings) {
        %>
                    <p class="no-bookings">🕒 No bookings found. Start by booking a flight, train, bus, or cab!</p>
        <%
                }

            } catch (Exception e) {
        %>
                <p class="no-bookings">⚠️ Error loading bookings: <%= e.getMessage() %></p>
        <%
            }
        %>
    </div>

    <div class="footer">
        &copy; 2025 TripSync. All rights reserved. |
        <a href="terms.jsp">Terms</a> |
        <a href="privacy.jsp">Privacy</a> |
        <a href="contact.jsp">Contact</a>
    </div>

</body>
</html>