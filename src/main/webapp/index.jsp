<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TripSync - All-in-One Travel Booking</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        /* === Hamburger Icon === */
        .menu-icon {
            position: absolute;
            top: 35px;
            left: 25px;
            cursor: pointer;
            z-index: 1001;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            width: 25px;
            height: 18px;
        }

        .menu-icon div {
            height: 3px;
            background-color: #333;
            border-radius: 2px;
            transition: 0.3s;
        }

        /* === Sidebar Menu === */
        .sidebar {
            position: fixed;
            top: 0;
            left: -260px;
            width: 250px;
            height: 100%;
            background-color: #f8f9fb;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
            z-index: 1000;
            padding-top: 80px;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar a {
            display: block;
            padding: 15px 25px;
            color: #0077cc;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .sidebar a:hover {
            background-color: #0077cc;
            color: white;
        }

        /* === Overlay Background when menu opens === */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.4);
            opacity: 0;
            visibility: hidden;
            transition: 0.3s;
            z-index: 999;
        }

        .overlay.active {
            opacity: 1;
            visibility: visible;
        }

        /* === Logout Styling === */
        .logout-btn {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #d9534f !important;
        }
        .logout-btn svg {
            width: 18px;
            height: 18px;
            fill: #d9534f;
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
    
    .hero-section {
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 60px 100px;
    border-radius: 20px;
    overflow: hidden;
    height: 350px;
    color: #003366;
    text-align: center;
    background: rgba(255, 255, 255, 0.8); /* subtle white overlay */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.hero-section::before {
    content: "";
    position: absolute;
    inset: 0;
    background: url('<%= request.getContextPath() %>/images/travel-banner.jpg') center/cover no-repeat;
    opacity: 0.35; /* faint image behind */
    z-index: 0; /* ensures it stays behind text */
}

.hero-section > * {
    position: relative;
    z-index: 1;
    
}
.hero-section h1, .hero-section p {
    text-shadow: 1px 1px 4px rgba(255, 255, 255, 0.9);
}
    </style>
</head>

<body>

<!-- ===== Hamburger Icon ===== -->
<div class="menu-icon" id="menuToggle">
    <div></div>
    <div></div>
    <div></div>
</div>

<!-- ===== Sidebar Menu ===== -->
<div class="sidebar" id="sidebarMenu">
    <%
        String user = (String) session.getAttribute("user");
        if (user == null) {
    %>
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Login</a>
    <%
        } else {
    %>
        <a href="LogoutServlet" class="logout-btn">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path d="M16 13v-2H7V8l-5 4 5 4v-3zM20 3h-8c-1.1 0-2 .9-2 2v4h2V5h8v14h-8v-4h-2v4c0 1.1.9 2 2 2h8c1.1 
                0 2-.9 2-2V5c0-1.1-.9-2-2-2z"/>
            </svg>
            Logout
        </a>
    <%
        }
    %>
    <a href="contact.jsp">Contact Us</a>
</div>


<div class="overlay" id="menuOverlay"></div>

<!-- ===== Existing Header ===== -->
<header>
<img src="<%= request.getContextPath() %>/images/TripSync.jpg" alt="TripSync Logo" class="logo" width="105px" height="100px">
    <nav>
        <a href="flightSearch.jsp">Flights</a>
        <a href="trainSearch.jsp">Trains</a>
        <a href="busSearch.jsp">Buses</a>
        <a href="cabSearch.jsp">Cabs</a>
        <a href="booking.jsp">Bookings</a>
    </nav>
</header>

<!-- ===== Hero Section ===== -->
<section class="hero-section">
    <div class="hero-text">
        <h1>Seamless Travel Starts with TripSync</h1>
        <p>Plan your entire journey effortlessly — book flights, trains, buses, or cabs in just a few clicks.</p>

        <%
            String userHero = (String) session.getAttribute("user");
            if (userHero == null) {
        %>
            <!-- Show Sign Up button if not logged in -->
            <button onclick="window.location.href='signup.jsp'">Sign Up Free</button>
        <%
            } else {
        %>
            <!-- Show plain 'Book Now' text when logged in -->
            <p style="margin-top: 20px; font-size: 18px; font-weight: 600; color: #003366;">
                Book Now
            </p>
        <%
            }
        %>
    </div>
</section>
<!-- ===== Features Section ===== -->
<section class="features">
    <div class="feature-card">
        <img src="${pageContext.request.contextPath}/images/plane.jpg" alt="Flights">
        <h3>Flights</h3>
        <p>Compare airlines, find deals, and book your next flight instantly with real-time prices.</p>
    </div>
    <div class="feature-card">
        <img src="${pageContext.request.contextPath}/images/train.jpg" alt="Trains">
        <h3>Trains</h3>
        <p>Check IRCTC availability and confirm train bookings without leaving TripSync.</p>
    </div>
    <div class="feature-card">
        <img src="${pageContext.request.contextPath}/images/bus.jpg" alt="Buses">
        <h3>Buses</h3>
        <p>Explore verified intercity and interstate bus operators and travel comfortably.</p>
    </div>
    <div class="feature-card">
        <img src="${pageContext.request.contextPath}/images/cab.jpg" alt="Cabs">
        <h3>Cabs</h3>
        <p>Find affordable and reliable cab options for city and outstation travel.</p>
    </div>
</section>

<!-- ===== Footer ===== -->
<footer>
    &copy; 2025 TripSync. All rights reserved.
    <div class="footer-links">
        <a href="terms.jsp">Terms & Conditions</a> |
        <a href="privacy.jsp">Privacy Policy</a> |
        <a href="contact.jsp">Contact Us</a>
    </div>
</footer>

<script>
    const menuToggle = document.getElementById('menuToggle');
    const sidebarMenu = document.getElementById('sidebarMenu');
    const overlay = document.getElementById('menuOverlay');

    menuToggle.addEventListener('click', () => {
        sidebarMenu.classList.toggle('active');
        overlay.classList.toggle('active');
    });

    overlay.addEventListener('click', () => {
        sidebarMenu.classList.remove('active');
        overlay.classList.remove('active');
    });
</script>

</body>
</html>
