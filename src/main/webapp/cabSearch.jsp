<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search & Book Cabs | TripSync</title>
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
            margin-bottom: 25px;
            font-size: 28px;
        }

        form {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 30px;
        }

        input[type="text"], input[type="email"], input[type="date"] {
            padding: 10px 12px;
            border: 1px solid #d0e4f7;
            border-radius: 8px;
            outline: none;
            font-size: 14px;
        }

        input[type="text"]:focus, input[type="email"]:focus, input[type="date"]:focus {
            border-color: #0077cc;
            box-shadow: 0 0 4px rgba(0, 119, 204, 0.4);
        }

        button {
            background-color: #0077cc;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s ease;
            font-weight: 500;
        }

        button:hover {
            background-color: #005fa3;
        }

        .card {
            background: #f9fcff;
            border: 1px solid #dbe8f6;
            border-radius: 12px;
            padding: 20px;
            margin: 15px auto;
            max-width: 700px;
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
        }

        .booking-form {
            margin-top: 10px;
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            justify-content: center;
        }

        .booking-form input {
            flex: 1 1 200px;
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
    <h2>Search Cabs</h2>

    <form action="CabServlet" method="post">
    <input type="hidden" name="action" value="search">
    <input type="text" name="city" placeholder="Enter City" required>
    <button type="submit">Search</button>
</form>


    <%
        List<Map<String, String>> cabs = (List<Map<String, String>>) request.getAttribute("cabs");
        if (cabs != null && !cabs.isEmpty()) {
            for (Map<String, String> cab : cabs) {
    %>
   <div class="card">
    <p><strong><%= cab.get("name") %></strong></p>
    <p>City: <%= cab.get("city") %></p>
    <p>Price per km: ₹<%= cab.get("price") %></p>

    <form class="booking-form" action="CabServlet" method="post">
        <input type="hidden" name="action" value="book">
        <input type="hidden" name="cab_id" value="<%= cab.get("id") %>">
        <input type="hidden" name="amount" value="<%= cab.get("price") %>">

        <input type="text" name="passenger_name" placeholder="Name" required>
        <input type="text" name="phone" placeholder="Phone" required>

        <button type="submit">Book This Cab</button>
    </form>
</div>

    <%
            }
        } else {
    %>
    <p style="text-align:center; color:#555;">No cabs found. Please search above.</p>
    <%
        }
    %>
</div>
</body>
</html>
