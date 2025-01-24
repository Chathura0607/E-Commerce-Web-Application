<%@ page import="lk.ijse.ecommercewebapplication.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>User Management</title>
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
        <li><a href="${pageContext.request.contextPath}/order-manage">Order Management</a></li>
        <li><a href="${pageContext.request.contextPath}/user-manage">User Management</a></li>
        <li class="d-flex align-items-center justify-content-center">
            <!-- Logout Button -->
            <form action="${pageContext.request.contextPath}/logout" method="post" class="d-flex">
                <button type="submit" class="btn btn-outline-light logout">Logout</button>
            </form>
        </li>
    </ul>
</div>

<!-- Main Content -->
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/order-manage">Order
                        Management</a></li>
                    <li class="nav-item"><a class="nav-link active"
                                            href="${pageContext.request.contextPath}/user-manage">User Management</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Display Alert if any -->
    <%
        String alertMessage = (String) request.getAttribute("alertMessage");
        if (alertMessage != null) {
    %>
    <script>
        alert("<%= alertMessage %>");
    </script>
    <%
        }
    %>

    <!-- Table for User Management -->
    <div id="users" class="table-container">
        <h2>User Management</h2>
        <%
            List<UserDTO> userDataList = (List<UserDTO>) request.getAttribute("users");

            if (userDataList != null && !userDataList.isEmpty()) {
        %>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (UserDTO user : userDataList) {
            %>
            <tr>
                <td><%= user.getId() %>
                </td>
                <td><%= user.getName() %>
                </td>
                <td><%= user.getEmail() %>
                </td>
                <td><%= user.getRole() %>
                </td>
                <td><%= user.getStatus() %>
                </td>
                <td>
                    <%
                        if ("Active".equals(user.getStatus())) {
                    %>
                    <a href="<%= request.getContextPath() %>/user-manage?action=deactivate&email=<%= user.getEmail() %>"
                       class="btn btn-sm btn-warning">Deactivate</a>
                    <%
                    } else {
                    %>
                    <a href="<%= request.getContextPath() %>/user-manage?action=activate&email=<%= user.getEmail() %>"
                       class="btn btn-sm btn-success">Activate</a>
                    <%
                        }
                    %>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <p>No users available to display.</p>
        <%
            }
        %>
    </div>
</div>

<!-- Sidebar toggle script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSidebar() {
        var sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("active");
    }
</script>
</body>
</html>
