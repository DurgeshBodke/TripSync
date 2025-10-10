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

@WebServlet("/TrainServlet")																//changes
public class TrainServlet extends HttpServlet {												//changes
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        try (Connection con = DBConnection.getConnection()) {
            if ("search".equals(action)) {
                String source = req.getParameter("source");
                String destination = req.getParameter("destination");
                String date = req.getParameter("date");

                PreparedStatement ps = con.prepareStatement(
                	    "SELECT * FROM trains WHERE LOWER(TRIM(source)) = LOWER(TRIM(?)) " +
                	    "AND LOWER(TRIM(destination)) = LOWER(TRIM(?)) " +
                	    "AND DATE_FORMAT(date, '%Y-%m-%d') = ?"
                	);

                ps.setString(1, source);
                ps.setString(2, destination);
                ps.setString(3, date);
                ResultSet rs = ps.executeQuery();

                List<Map<String, String>> trains = new ArrayList<>();						//changes
                while (rs.next()) {
                    Map<String, String> train = new HashMap<>();
                    train.put("id", String.valueOf(rs.getInt("id")));
                    train.put("name", rs.getString("train_name"));
                    train.put("source", rs.getString("source"));         // ✅ ADDED
                    train.put("destination", rs.getString("destination")); // ✅ ADDED
                    train.put("price", rs.getString("price"));
                    train.put("date", rs.getString("date"));
                    trains.add(train);
                }

                req.setAttribute("trains", trains);											//changes
                RequestDispatcher rd = req.getRequestDispatcher("trainSearch.jsp");			//changes
                rd.forward(req, res);

            } else if ("book".equals(action)) {
                int trainId = Integer.parseInt(req.getParameter("train_id"));				//changes
                String name = req.getParameter("passenger_name");
                String email = (String) req.getSession().getAttribute("user");
                String phone = req.getParameter("phone");
                String amount = req.getParameter("amount");
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO bookings (booking_type, reference_id, passenger_name, email, phone,amount) VALUES (?, ?, ?, ?, ?,?)");
                ps.setString(1, "train");													//changes
                ps.setInt(2, trainId);
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
