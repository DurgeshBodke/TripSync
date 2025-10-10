package com.tripsync.servlet;

import java.io.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.*;
import java.util.*;

@WebServlet("/CabServlet")
public class CabServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        try (Connection con = DBConnection.getConnection()) {
            if ("search".equals(action)) {
                String city = req.getParameter("city");

                PreparedStatement ps = con.prepareStatement("SELECT * FROM cabs WHERE city=?");
                ps.setString(1, city);
                ResultSet rs = ps.executeQuery();

                List<Map<String, String>> cabs = new ArrayList<>();
                while (rs.next()) {
                    Map<String, String> cab = new HashMap<>();
                    cab.put("id", String.valueOf(rs.getInt("id")));
                    cab.put("name", rs.getString("cab_name"));
                    cab.put("price", rs.getString("price_per_km"));
                    cab.put("city", rs.getString("city"));
                    cabs.add(cab);
                }

                req.setAttribute("cabs", cabs);
                RequestDispatcher rd = req.getRequestDispatcher("cabSearch.jsp");
                rd.forward(req, res);

            } else if ("book".equals(action)) {
                int cabId = Integer.parseInt(req.getParameter("cab_id"));
                String name = req.getParameter("passenger_name");
                String email = (String) req.getSession().getAttribute("user");
                String phone = req.getParameter("phone");
                String amount = req.getParameter("amount");

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO bookings (booking_type, reference_id, passenger_name, email, phone, amount) VALUES (?, ?, ?, ?, ?, ?)");
                ps.setString(1, "cab");
                ps.setInt(2, cabId);
                ps.setString(3, name);
                ps.setString(4, email);
                ps.setString(5, phone);
                ps.setString(6, amount);
                ps.executeUpdate();

                res.sendRedirect("success.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
