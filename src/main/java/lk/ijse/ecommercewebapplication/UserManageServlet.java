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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserManageServlet", value = "/user-manage")
public class UserManageServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String email = req.getParameter("email");

        String alertMessage = null;

        // Handle user status toggle
        if (action != null && email != null) {
            if ("activate".equalsIgnoreCase(action)) {
                if (toggleUserStatus(email, true)) {
                    alertMessage = "User activated successfully!";
                } else {
                    alertMessage = "Failed to activate the user.";
                }
            } else if ("deactivate".equalsIgnoreCase(action)) {
                if (toggleUserStatus(email, false)) {
                    alertMessage = "User deactivated successfully!";
                } else {
                    alertMessage = "Failed to deactivate the user.";
                }
            }
        }
        req.setAttribute("alertMessage", alertMessage);
        req.setAttribute("users", fetchAllUsers());
        req.getRequestDispatcher("/userManage.jsp").forward(req, resp);


        // Fetch all users and render the response
        List<UserDTO> userList = fetchAllUsers();
        req.setAttribute("users", userList);

        // Display the alert in the browser using JavaScript
        resp.setContentType("text/html;charset=UTF-8");
        resp.getWriter().write("<html><head><title>User Management</title></head><body>");

        if (alertMessage != null) {
            resp.getWriter().write("<script>alert('" + alertMessage + "');</script>");
        }

        req.getRequestDispatcher("/userManage.jsp").forward(req, resp);
        resp.getWriter().write("</body></html>");
    }

    private boolean toggleUserStatus(String email, boolean activate) {
        String newStatus = activate ? "Active" : "Inactive";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement("UPDATE users SET status = ? WHERE email = ?")) {

            statement.setString(1, newStatus);
            statement.setString(2, email);
            int rowsUpdated = statement.executeUpdate();

            return rowsUpdated > 0; // Return true if at least one row is updated
        } catch (SQLException e) {
            log("Error updating user status for email: " + email, e);
            return false;
        }
    }

    private List<UserDTO> fetchAllUsers() {
        List<UserDTO> userList = new ArrayList<>();

        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT user_id, name, email, role, status FROM users");
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                UserDTO userDTO = new UserDTO();
                userDTO.setId(resultSet.getInt("user_id"));
                userDTO.setName(resultSet.getString("name"));
                userDTO.setEmail(resultSet.getString("email"));
                userDTO.setRole(resultSet.getString("role"));
                userDTO.setStatus(resultSet.getString("status"));
                userList.add(userDTO);
            }
        } catch (SQLException e) {
            log("Error fetching users from database", e);
        }

        return userList;
    }
}
