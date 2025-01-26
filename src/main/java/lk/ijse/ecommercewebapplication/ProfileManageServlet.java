package lk.ijse.ecommercewebapplication;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.ecommercewebapplication.dto.UserDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet(name = "ProfileManageServlet", value = "/profile")
public class ProfileManageServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String alertMessage = null;
        // Retrieve input data from the request
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        HttpSession session = req.getSession(false);
        UserDTO currentUser = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (currentUser == null) {
            alertMessage = "You must be logged in to update your profile.";
            req.setAttribute("alertMessage", alertMessage);
            req.getRequestDispatcher("index.jsp").forward(req, resp);
            return;
        }

        // Validate user_id
        if (currentUser.getId() <= 0) {
            alertMessage = "Unable to update profile due to invalid user ID.";
            req.setAttribute("alertMessage", alertMessage);
            req.getRequestDispatcher("profile.jsp").forward(req, resp);
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            alertMessage = "Passwords do not match. Please try again.";
            req.setAttribute("alertMessage", alertMessage);
            req.getRequestDispatcher("profile.jsp").forward(req, resp);
            return;
        }

        // Update user profile in the database
        try (Connection connection = dataSource.getConnection()) {
            String updateSQL = "UPDATE users SET name = ?, email = ?, password = ? WHERE user_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(updateSQL)) {
                preparedStatement.setString(1, name);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, hashPassword(password)); // Hash the password
                preparedStatement.setInt(4, currentUser.getId());

                int rowsUpdated = preparedStatement.executeUpdate();

                if (rowsUpdated > 0) {
                    currentUser.setName(name);
                    currentUser.setEmail(email);
                    session.setAttribute("user", currentUser);
                    alertMessage = "Profile updated successfully.";
                } else {
                    alertMessage = "Failed to update profile. Please try again.";
                }
            }
        } catch (SQLException e) {
            alertMessage = "An error occurred while updating your profile. Please try again later.";
        }

        // Set the alert message to be displayed in a JavaScript alert box
        req.setAttribute("alertMessage", alertMessage);
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }

    private String hashPassword(String password) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = messageDigest.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }
}
