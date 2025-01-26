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

        UserDTO userDTO = new UserDTO();
        userDTO.setName(name);
        userDTO.setEmail(email);
        userDTO.setPassword(password);
        userDTO.setRole(role);
        userDTO.setStatus(status);

        // Hash the password
        String hashedPassword = hashPassword(userDTO.getPassword());
        if (hashedPassword == null) {
            req.setAttribute("alertMessage", "Failed to hash the password. Please try again.");
            req.getRequestDispatcher("index.jsp").forward(req, resp);
            return;
        }

        // Set the hashed password back into the UserDTO
        userDTO.setPassword(hashedPassword);

        try (Connection connection = dataSource.getConnection()) {
            // SQL query to insert a new user into the database
            String sql = "INSERT INTO users (name, email, password, role, status) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, userDTO.getName());
                preparedStatement.setString(2, userDTO.getEmail());
                preparedStatement.setString(3, userDTO.getPassword());
                preparedStatement.setString(4, userDTO.getRole());
                preparedStatement.setString(5, userDTO.getStatus());

                // Execute the query
                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    req.setAttribute("alertMessage", "Registration successful! You can now log in.");
                } else {
                    req.setAttribute("alertMessage", "Registration failed. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("alertMessage", "An error occurred: " + e.getMessage());
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
