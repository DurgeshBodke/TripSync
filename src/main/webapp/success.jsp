<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmed | TripSync</title>
    <style>
        body {
            font-family: "Poppins", Arial, sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .success-container {
            background: #ffffff;
            text-align: center;
            padding: 50px 60px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            animation: fadeIn 0.8s ease-in-out;
        }

        /* SVG Styles */
        .checkmark {
            width: 140px;
            height: 140px;
            margin: 0 auto 20px;
            display: block;
        }

        .checkmark__circle {
            stroke: #4caf50;
            stroke-width: 4;
            stroke-miterlimit: 10;
            fill: none;
            stroke-dasharray: 283;
            stroke-dashoffset: 283;
            animation: circleAnimation 0.8s ease-in-out forwards;
        }

        .checkmark__check {
            stroke: #4caf50;
            stroke-width: 5;
            stroke-linecap: round;
            stroke-linejoin: round;
            fill: none;
            stroke-dasharray: 48;
            stroke-dashoffset: 48;
            animation: checkAnimation 0.4s ease-out 0.8s forwards;
        }

        h2 {
            color: #222;
            font-size: 28px;
            margin-top: 10px;
        }

        p {
            color: #555;
            margin-top: 10px;
            font-size: 16px;
        }

        a {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 25px;
            background-color: #0077cc;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #005fa3;
        }

        @keyframes circleAnimation {
            to {
                stroke-dashoffset: 0;
            }
        }

        @keyframes checkAnimation {
            to {
                stroke-dashoffset: 0;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="success-container">
        <!-- Fixed SVG (No clipping, perfect circle + check) -->
        <svg class="checkmark" viewBox="0 0 64 64">
            <circle class="checkmark__circle" cx="32" cy="32" r="28"/>
            <path class="checkmark__check" d="M18 34l8 8 20-20"/>
        </svg>

        <h2>Booking Confirmed!</h2>
        <p>Your trip has been successfully booked. Have a great journey ✈️🚆🚌🚖</p>
        <a href="booking.jsp">View All Bookings</a>
    </div>

</body>
</html>
