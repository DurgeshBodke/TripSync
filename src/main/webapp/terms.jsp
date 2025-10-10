<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TripSync - Terms & Conditions</title>
    <link rel="stylesheet" href="style.css">
        <style>
        body {
            font-family: "Poppins", Arial, sans-serif;
            background-color: #f4f8fc;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1000px;
            margin: 60px auto;
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        h1 {
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
    <img src="TripSync Logo.png" alt="TripSync Logo" class="logo">
    <nav>
        <a href="index.jsp">Home</a>

    </nav>
</header>


<div class="container">
    <h1>Terms & Conditions</h1>
    <p>Welcome to TripSync! By using our website, you agree to the following terms and conditions. Please read them carefully.</p>

    <h2>1. General</h2>
    <p>TripSync acts as an intermediary between you and travel service providers...</p>

    <h2>2. User Responsibilities</h2>
    <p>Provide accurate information during booking. Misuse may lead to cancellation.</p>

    <h2>3. Payments</h2>
    <p>All transactions are processed securely. TripSync is not liable for third-party payment issues.</p>

    <h2>4. Cancellation & Refunds</h2>
    <p>Cancellation and refund policies depend on the respective travel operators.</p>

    <h2>5. Modifications</h2>
    <p>TripSync reserves the right to update or modify these terms at any time.</p>
</div>

<footer>
    &copy; 2025 TripSync. All rights reserved.
    <div class="footer-links">
        <a href="terms.jsp">Terms & Conditions</a> |
        <a href="privacy.jsp">Privacy Policy</a> |
        <a href="contact.jsp">Contact Us</a>
    </div>
</footer>

</body>
</html>
