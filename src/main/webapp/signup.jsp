<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up | TripSync</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            background: linear-gradient(135deg, #0077cc, #00c6ff);
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
        .auth-card p {
            margin-top: 15px;
            font-size: 14px;
        }
        .auth-card a {
            color: #0077cc;
            text-decoration: none;
            font-weight: 500;
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
    <div class="auth-card">
        <h2>Create Account</h2>
<form action="UserServlet" method="post">
  <input type="hidden" name="action" value="signup">
  <input type="text" name="name" placeholder="Full Name" required>
  <input type="email" name="email" placeholder="Email" required>
  <input type="text" name="phone" placeholder="Phone" required>
  <input type="password" name="password" placeholder="Password" required>
  <button type="submit">Sign Up</button>
</form>

        <p>Already have an account? <a href="login.jsp">Login</a></p>
    </div>
</body>
</html>
