package com.tripsync.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        try (Connection con = DBConnection.getConnection()) {
            if ("signup".equals(action)) {
                String name = req.getParameter("name");
                String email = req.getParameter("email");
                String phone = req.getParameter("phone");
                String password = req.getParameter("password");

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, password);
                ps.executeUpdate();

                req.getSession().setAttribute("user", email);
                res.sendRedirect("index.jsp");

            } else if ("login".equals(action)) {
                String email = req.getParameter("email");
                String password = req.getParameter("password");

                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM users WHERE email = ? AND password = ?");
                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    req.getSession().setAttribute("user", email);
                    res.sendRedirect("index.jsp");
                } else {
                    res.getWriter().println("<script>alert('Invalid Email or Password!'); window.location='login.jsp';</script>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
