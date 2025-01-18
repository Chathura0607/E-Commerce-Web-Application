package lk.ijse.ecommercewebapplication;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet(name = "RegisterServlet", value = "/user-register")
public class RegisterServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve form parameters
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        String status = req.getParameter("status");

        // Hash the password
        String hashedPassword = hashPassword(password);
        if (hashedPassword == null) {
            req.setAttribute("message", "Failed to hash the password. Please try again.");
            req.getRequestDispatcher("index.jsp").forward(req, resp);
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            // SQL query to insert a new user into the database
            String sql = "INSERT INTO users (name, email, password, role, status) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, name);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, hashedPassword);
                preparedStatement.setString(4, role);
                preparedStatement.setString(5, status);

                // Execute the query
                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    req.setAttribute("message", "Registration successful! You can now log in.");
                } else {
                    req.setAttribute("message", "Registration failed. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("message", "An error occurred: " + e.getMessage());
        }

        req.getRequestDispatcher("index.jsp").forward(req, resp);
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
