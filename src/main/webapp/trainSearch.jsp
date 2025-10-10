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
    <title>TripSync | Search Trains</title>
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

        .container h2 {
            color: #0d47a1;
            font-size: 28px;
            margin-bottom: 25px;
            text-align: center;
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

        .train-card {
            border: 1px solid #e0e0e0;
            padding: 25px;
            margin: 15px 0;
            border-radius: 12px;
            background: #f9fcff;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.05);
        }

        .train-card h3 {
            margin: 0;
            color: #004aad;
        }

        .train-card p {
            margin: 8px 0;
            color: #333;
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
    <h2>Search Trains</h2>
    
    <form action="TrainServlet" method="post" class="search-form">
        <input type="hidden" name="action" value="search">
        <input type="text" name="source" placeholder="From" required>
        <input type="text" name="destination" placeholder="To" required>
        <input type="date" name="date" required>
        <button type="submit">Search</button>
    </form>

<%
    List<Map<String, String>> trains = (List<Map<String, String>>) request.getAttribute("trains");
    if (trains != null && !trains.isEmpty()) {
%>
    <div class="results-section">
        <h3>Available Trains</h3>
<%
        for (Map<String, String> train : trains) {
%>
        <div class="train-card">
            <h3><%= train.get("name") %></h3>
            <p><strong>From:</strong> <%= train.get("source") %> → <strong>To:</strong> <%= train.get("destination") %></p>
            <p><strong>Date:</strong> <%= train.get("date") %></p>
            <p class="total-amount"><strong>Price:</strong> ₹<%= train.get("price") %></p>
            
            <form action="TrainServlet" method="post" class="booking-form">
                <input type="hidden" name="action" value="book">
                <input type="hidden" name="train_id" value="<%= train.get("id") %>">
                <input type="text" name="passenger_name" placeholder="Passenger Name" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="text" name="phone" placeholder="Phone" required>
                <input type="hidden" name="amount" value="<%= train.get("price") %>">
                <button type="submit">Book This Train</button>
            </form>
        </div>
<%
        }
%>
    </div>
<%
    } else if (request.getAttribute("trains") != null) {
%>
    <p style="text-align:center; color:#888;">No trains found for the selected route and date.</p>
<%
    }
%>
</div>


</body>
</html>
