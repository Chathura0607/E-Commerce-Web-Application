package lk.ijse.ecommercewebapplication;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommercewebapplication.dto.OrderDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderManageServlet", value = "/order-manage")
public class OrderManageServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = dataSource.getConnection()) {
            // Fetch orders and associated user details
            String sql = "SELECT o.order_id, o.total_amount, o.status, o.created_at, u.name AS customer_name " +
                    "FROM orders o " +
                    "INNER JOIN users u ON o.user_id = u.user_id";

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            List<OrderDTO> orders = new ArrayList<>();
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                double totalAmount = rs.getDouble("total_amount");
                String status = rs.getString("status");
                String createdAt = rs.getString("created_at");
                String customerName = rs.getString("customer_name");

                orders.add(new OrderDTO(orderId, customerName, totalAmount, status, createdAt));
            }

            // Pass the order list to the JSP
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/orderManage.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to load orders");
        }
    }
}
