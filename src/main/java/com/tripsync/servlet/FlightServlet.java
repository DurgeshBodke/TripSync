package com.tripsync.servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;

@WebServlet("/FlightServlet")
public class FlightServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try (Connection con = DBConnection.getConnection()) {

            if ("search".equals(action)) {

                String source = req.getParameter("source");
                String destination = req.getParameter("destination");
                String date = req.getParameter("date");

                // Fixed: case-insensitive, trimmed, and date-matching query
                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM flights WHERE TRIM(LOWER(source)) = TRIM(LOWER(?)) " +
                    "AND TRIM(LOWER(destination)) = TRIM(LOWER(?)) " +
                    "AND DATE(date) = ?"
                );
                ps.setString(1, source);
                ps.setString(2, destination);
                ps.setString(3, date);

                ResultSet rs = ps.executeQuery();
                List<Map<String, Object>> flights = new ArrayList<>();

                while (rs.next()) {
                    Map<String, Object> flight = new HashMap<>();
                    int flightId = rs.getInt("id");
                    flight.put("id", flightId);
                    flight.put("name", rs.getString("flight_name"));
                    flight.put("price", rs.getString("price"));
                    flight.put("date", rs.getString("date"));
                    flight.put("source", rs.getString("source"));
                    flight.put("destination", rs.getString("destination"));

                    // 🔹 Fetch booked seats
                    PreparedStatement psSeats = con.prepareStatement(
                        "SELECT seat_number FROM bookings WHERE reference_id=? AND booking_type='flight'"
                    );
                    psSeats.setInt(1, flightId);
                    ResultSet rsSeats = psSeats.executeQuery();

                    Set<String> bookedSeats = new HashSet<>();
                    while (rsSeats.next()) {
                        bookedSeats.add(rsSeats.getString("seat_number"));
                    }

                    flight.put("bookedSeats", bookedSeats);
                    flights.add(flight);
                }

                req.setAttribute("flights", flights);
                RequestDispatcher rd = req.getRequestDispatcher("flightSearch.jsp");
                rd.forward(req, res);

            } else if ("book".equals(action)) {

                int flightId = Integer.parseInt(req.getParameter("flight_id"));
                String name = req.getParameter("passenger_name");
                String email = (String) req.getSession().getAttribute("user");
                String phone = req.getParameter("phone");
                String amount = req.getParameter("amount");
                String seat = req.getParameter("seat_number");

                if (seat == null || seat.isEmpty()) {
                    res.getWriter().println("<script>alert('Please select a seat before booking!'); history.back();</script>");
                    return;
                }

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO bookings (booking_type, reference_id, passenger_name, email, phone, amount, seat_number) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)"
                );
                ps.setString(1, "flight");
                ps.setInt(2, flightId);
                ps.setString(3, name);
                ps.setString(4, email);
                ps.setString(5, phone);
                ps.setString(6, amount);
                ps.setString(7, seat);
                ps.executeUpdate();

                res.sendRedirect("success.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
