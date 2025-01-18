package lk.ijse.ecommercewebapplication;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/user-login")
public class LoginServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try (Connection connection = dataSource.getConnection()) {
            // SQL query to check if user exists with the given email
            String sql = "SELECT * FROM users WHERE email = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, email);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        // Email found, now check if password matches
                        String storedPassword = resultSet.getString("password");
                        if (storedPassword.equals(password)) {
                            // Password matches, login successful
                            req.getSession().setAttribute("user", resultSet.getString("name"));
                            req.setAttribute("message", "Login Success!");
                            req.getRequestDispatcher("categoryManage.jsp").forward(req, resp);  // Redirect to the login page with success message
                        } else {
                            // Password incorrect
                            req.setAttribute("message", "Login Failed! Incorrect password.");
                            req.getRequestDispatcher("index.jsp").forward(req, resp);  // Redirect back to login page
                        }
                    } else {
                        // Email not found
                        req.setAttribute("message", "Login Failed! Email not found.");
                        req.getRequestDispatcher("index.jsp").forward(req, resp);  // Redirect back to login page
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("message", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }
    }
}
