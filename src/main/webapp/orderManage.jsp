<%@ page import="lk.ijse.ecommercewebapplication.dto.OrderDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Order Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="styles/admin_dashboard.css" type="text/css" rel="stylesheet">
</head>

<body>
<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <h4 class="text-center">Admin Dashboard</h4>
    <ul class="list-unstyled">
        <li><a href="${pageContext.request.contextPath}/product-manage">Product Management</a></li>
        <li><a href="${pageContext.request.contextPath}/category-manage">Category Management</a></li>
        <li><a href="${pageContext.request.contextPath}/order-manage" class="active">Order Management</a></li>
        <li><a href="${pageContext.request.contextPath}/user-manage">User Management</a></li>
        <li class="d-flex align-items-center justify-content-center">
            <!-- Logout Button -->
            <form action="${pageContext.request.contextPath}/logout" method="post" class="d-flex">
                <button type="submit" class="btn btn-outline-light logout">Logout</button>
            </form>
        </li>
    </ul>
</div>

<div class="content">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"
                    onclick="toggleSidebar()">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav d-flex justify-content-between w-100">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/product-manage">Product
                        Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/category-manage">Category
                        Management</a></li>
                    <li class="nav-item"><a class="nav-link active"
                                            href="${pageContext.request.contextPath}/order-manage">Order Management</a>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user-manage">User
                        Management</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Order Management -->
    <div class="table-container">
        <h2>Order Management</h2>

        <!-- Order Table -->
        <%
            List<OrderDTO> orders = (List<OrderDTO>) request.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
        %>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Total</th>
                <th>Status</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <% for (OrderDTO order : orders) { %>
            <tr>
                <td><%= order.getOrderId() %>
                </td>
                <td><%= order.getCustomerName() %>
                </td>
                <td>$<%= order.getTotalAmount() %>
                </td>
                <td><%= order.getStatus() %>
                </td>
                <td><%= order.getCreatedAt() %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>No orders available to display.</p>
        <% } %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle sidebar visibility
    function toggleSidebar() {
        var sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("active");
    }
</script>
</body>
</html>
