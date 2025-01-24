package lk.ijse.ecommercewebapplication;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommercewebapplication.dto.CategoryDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CategoryManageServlet", value = "/category-manage")
public class CategoryManageServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categories = new ArrayList<>();
        String alertMessage = (String) req.getSession().getAttribute("alertMessage");
        req.getSession().removeAttribute("alertMessage"); // Remove after showing

        // Fetch categories from the database
        try (Connection connection = dataSource.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT * FROM categories")) {

            while (resultSet.next()) {
                categories.add(new CategoryDTO(
                        resultSet.getInt("category_id"),
                        resultSet.getString("name"),
                        resultSet.getString("description")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.setAttribute("categories", categories);
        req.setAttribute("alertMessage", alertMessage); // Pass alert to JSP
        req.getRequestDispatcher("/categoryManage.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        String alertMessage = null;

        try (Connection connection = dataSource.getConnection()) {
            if ("add".equals(action)) {
                // Add a new category
                String name = req.getParameter("name");
                String description = req.getParameter("description");
                String query = "INSERT INTO categories (name, description) VALUES (?, ?)";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1, name);
                    statement.setString(2, description);
                    statement.executeUpdate();
                    alertMessage = "Category added successfully!";
                }
            } else if ("edit".equals(action)) {
                // Edit an existing category
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                String description = req.getParameter("description");
                String query = "UPDATE categories SET name = ?, description = ? WHERE category_id = ?";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1, name);
                    statement.setString(2, description);
                    statement.setInt(3, id);
                    statement.executeUpdate();
                    alertMessage = "Category updated successfully!";
                }
            } else if ("delete".equals(action)) {
                // Delete a category
                try {
                    int id = Integer.parseInt(req.getParameter("id")); // Ensure this parses correctly
                    String query = "DELETE FROM categories WHERE category_id = ?";
                    System.out.println("Deleting category with ID: " + id); // Log for debugging
                    try (PreparedStatement statement = connection.prepareStatement(query)) {
                        statement.setInt(1, id);
                        int rowsAffected = statement.executeUpdate(); // Check if the row was deleted
                        if (rowsAffected > 0) {
                            alertMessage = "Category deleted successfully!";
                        } else {
                            alertMessage = "Category not found or could not be deleted.";
                        }
                    }
                } catch (NumberFormatException e) {
                    alertMessage = "Invalid category ID.";
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            alertMessage = "An error occurred: " + e.getMessage();
            e.printStackTrace();
        }

        req.getSession().setAttribute("alertMessage", alertMessage); // Store alert message
        resp.sendRedirect(req.getContextPath() + "/category-manage");
    }

}
