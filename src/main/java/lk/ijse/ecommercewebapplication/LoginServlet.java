package lk.ijse.ecommercewebapplication;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommercewebapplication.dto.UserDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

//package lk.ijse.ecommercewebapplication;
//
//import jakarta.annotation.Resource;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import lk.ijse.ecommercewebapplication.dto.UserDTO;
//
//import javax.sql.DataSource;
//import java.io.IOException;
//import java.security.MessageDigest;
//import java.security.NoSuchAlgorithmException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.Base64;
//
//@WebServlet(name = "CustomerLoginServlet", value = "/user-login")
//public class LoginServlet extends HttpServlet {
//
//    @Resource(name = "java:comp/env/jdbc/pool")
//    private DataSource dataSource;
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String email = req.getParameter("email");
//        String password = req.getParameter("password");
//
//        UserDTO userDTO = new UserDTO();
//        userDTO.setEmail(email);
//        userDTO.setPassword(password);
//
//        // Hash the entered password
//        String hashedPassword = hashPassword(password);
//
//        try (Connection connection = dataSource.getConnection()) {
//            String sql = "SELECT * FROM users WHERE email = ?";
//            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
//                preparedStatement.setString(1, userDTO.getEmail());
//
//                try (ResultSet resultSet = preparedStatement.executeQuery()) {
//                    if (resultSet.next()) {
//                        // Email found, now check if hashed password matches
//                        String storedPassword = resultSet.getString("password");
//                        String status = resultSet.getString("status");
//                        String role = resultSet.getString("role");
//
//                        if (storedPassword.equals(hashedPassword)) {
//                            if (!"Customer".equalsIgnoreCase(role)) {
//                                req.setAttribute("message", "Login Failed! Only customers are allowed to log in.");
//                                req.getRequestDispatcher("index.jsp").forward(req, resp);
//                                return;
//                            }
//
//                            if ("Active".equalsIgnoreCase(status)) {
//                                userDTO.setName(resultSet.getString("name"));
//                                userDTO.setRole(role);
//                                req.getSession().setAttribute("user", userDTO);
//
//                                req.setAttribute("message", "Login Success! Welcome, Customer.");
//                                req.getRequestDispatcher("products.jsp").forward(req, resp);
//                            } else {
//                                req.setAttribute("message", "Login Failed! Your account is not active.");
//                                req.getRequestDispatcher("index.jsp").forward(req, resp);
//                            }
//                        } else {
//                            req.setAttribute("message", "Login Failed! Incorrect password.");
//                            req.getRequestDispatcher("index.jsp").forward(req, resp);
//                        }
//                    } else {
//                        req.setAttribute("message", "Login Failed! Email not found.");
//                        req.getRequestDispatcher("index.jsp").forward(req, resp);
//                    }
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            req.setAttribute("message", "An error occurred: " + e.getMessage());
//            req.getRequestDispatcher("index.jsp").forward(req, resp);
//        }
//    }
//
//    private String hashPassword(String password) {
//        try {
//            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
//            byte[] hashedBytes = messageDigest.digest(password.getBytes());
//            return Base64.getEncoder().encodeToString(hashedBytes);
//        } catch (NoSuchAlgorithmException e) {
//            e.printStackTrace();
//            return null;
//        }
//    }
//}
//
@WebServlet(name = "CustomerLoginServlet", value = "/user-login")
public class LoginServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDTO userDTO = new UserDTO();
        userDTO.setEmail(email);
        userDTO.setPassword(password);

        // Hash the entered password
        String hashedPassword = hashPassword(password);

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT user_id, name, email, password, role, status FROM users WHERE email = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, userDTO.getEmail());

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        // Extract data from the database
                        String storedPassword = resultSet.getString("password");
                        String status = resultSet.getString("status");
                        String role = resultSet.getString("role");

                        // Check if passwords match
                        if (storedPassword.equals(hashedPassword)) {
                            // Check if the role is Customer
                            if (!"Customer".equalsIgnoreCase(role)) {
                                req.setAttribute("message", "Login Failed! Only customers are allowed to log in.");
                                req.getRequestDispatcher("index.jsp").forward(req, resp);
                                return;
                            }

                            // Check if the account is active
                            if ("Active".equalsIgnoreCase(status)) {
                                // Populate the UserDTO with database values
                                userDTO.setId(resultSet.getInt("user_id")); // FIX: Set the user ID here
                                userDTO.setName(resultSet.getString("name"));
                                userDTO.setRole(role);
                                userDTO.setStatus(status);

                                // Store the user in the session
                                req.getSession().setAttribute("user", userDTO);

                                req.setAttribute("message", "Login Success! Welcome, Customer.");
                                req.getRequestDispatcher("products.jsp").forward(req, resp);
                            } else {
                                req.setAttribute("message", "Login Failed! Your account is not active.");
                                req.getRequestDispatcher("index.jsp").forward(req, resp);
                            }
                        } else {
                            req.setAttribute("message", "Login Failed! Incorrect password.");
                            req.getRequestDispatcher("index.jsp").forward(req, resp);
                        }
                    } else {
                        req.setAttribute("message", "Login Failed! Email not found.");
                        req.getRequestDispatcher("index.jsp").forward(req, resp);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("message", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = messageDigest.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
