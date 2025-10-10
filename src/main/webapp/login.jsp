<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login | TripSync</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            margin: 0;
            height: 100vh; /* ensures full height for centering */
            display: flex; /* enables flexbox */
            align-items: center; /* vertical centering */
            justify-content: center; /* horizontal centering */
            font-family: 'Poppins', sans-serif;
            background-image: url('${pageContext.request.contextPath}/images/world.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
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

        .auth-card {
            background: #fff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
            width: 350px;
            text-align: center;
        }

        .auth-card h2 {
            color: #0077cc;
            margin-bottom: 20px;
        }

        .auth-card input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
        }

        .auth-card button {
            width: 95%;
            padding: 12px;
            background: #0077cc;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            margin-top: 10px;
        }

        .auth-card button:hover {
            background: #005fa3;
        }

        .auth-card p {
            margin-top: 15px;
            font-size: 14px;
        }

        .auth-card a {
            color: #0077cc;
            text-decoration: none;
            font-weight: 500;
        }

        .auth-card a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <h2>Welcome Back</h2>
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="login">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <p>Don’t have an account? <a href="signup.jsp">Sign Up</a></p>
    </div>
</body>
</html>
