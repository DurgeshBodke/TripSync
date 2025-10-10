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

@WebServlet("/BusServlet")																//changes
public class BusServlet extends HttpServlet {												//changes
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        try (Connection con = DBConnection.getConnection()) {
            if ("search".equals(action)) {
                String source = req.getParameter("source");
                String destination = req.getParameter("destination");
                String date = req.getParameter("date");

                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM buses WHERE TRIM(LOWER(source)) = TRIM(LOWER(?)) " +
                        "AND TRIM(LOWER(destination)) = TRIM(LOWER(?)) " +
                        "AND DATE(date) = ?"
                    );
                ps.setString(1, source);
                ps.setString(2, destination);
                ps.setString(3, date);
                ResultSet rs = ps.executeQuery();

                List<Map<String, String>> buses = new ArrayList<>();						//changes
                while (rs.next()) {
                    Map<String, String> bus = new HashMap<>();							//changes
                    bus.put("id", String.valueOf(rs.getInt("id")));						//changes
                    bus.put("name", rs.getString("bus_name"));							//changes
                    bus.put("price", rs.getString("price"));								//changes
                    bus.put("date", rs.getString("date"));								//changes
                    buses.add(bus);														//changes
                }

                req.setAttribute("buses", buses);											//changes
                RequestDispatcher rd = req.getRequestDispatcher("busSearch.jsp");			//changes
                rd.forward(req, res);

            } else if ("book".equals(action)) {
                int busId = Integer.parseInt(req.getParameter("bus_id"));				//changes
                String name = req.getParameter("passenger_name");
                String email = (String) req.getSession().getAttribute("user");
                String phone = req.getParameter("phone");
                String amount = req.getParameter("amount");
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO bookings (booking_type, reference_id, passenger_name, email, phone,amount) VALUES (?, ?, ?, ?, ?,?)");
                ps.setString(1, "bus");													//changes
                ps.setInt(2, busId);
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
