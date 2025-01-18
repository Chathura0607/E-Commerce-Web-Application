<%--
  Created by IntelliJ IDEA.
  User: chath
  Date: 1/18/2025
  Time: 12:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Product Management</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .table-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .sidebar {
            height: 100vh;
            background-color: #343a40;
            color: white;
            padding-top: 20px;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            transition: all 0.3s;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 30px 15px;
            display: block;
        }
        .sidebar a:hover {
            background-color: #575757;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }
        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }
            .content {
                margin-left: 0;
            }
        }
        .sidebar.active {
            display: block;
            position: fixed;
            left: 0;
            width: 250px;
        }
        .navbar-toggler {
            display: block;
        }
    </style>
</head>

<body>
<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <h4 class="text-center">Admin Dashboard</h4>
    <ul class="list-unstyled">
        <li><a href="#">Product Management</a></li>
        <li><a href="categoryManage.jsp">Category Management</a></li>
        <li><a href="orderManage.jsp">Order Management</a></li>
        <li><a href="userManage.jsp">User Management</a></li>
    </ul>
</div>

<!-- Content Area -->
<div class="content">
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <button
                    class="navbar-toggler"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarNav"
                    aria-controls="navbarNav"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                    onclick="toggleSidebar()"
            >
                <span class="navbar-toggler-icon"></span>
                <!-- Hamburger icon -->
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav d-flex justify-content-between w-100">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Product Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="category_management.html"
                        >Category Management</a
                        >
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="order_management.html"
                        >Order Management</a
                        >
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="user_management.html"
                        >User Management</a
                        >
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Category Management -->
    <div id="categories" class="table-container">
        <h2>Category Management</h2>
        <button
                class="btn btn-primary mb-3"
                data-bs-toggle="modal"
                data-bs-target="#addCategoryModal"
        >
            Add Category
        </button>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>Electronics</td>
                <td>Devices and gadgets</td>
                <td>
                    <button
                            class="btn btn-sm btn-warning"
                            data-bs-toggle="modal"
                            data-bs-target="#editCategoryModal"
                    >
                        Edit
                    </button>
                    <button class="btn btn-sm btn-danger">Delete</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Category Modal -->
<div
        class="modal fade"
        id="addCategoryModal"
        tabindex="-1"
        aria-labelledby="addCategoryModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCategoryModalLabel">Add Category</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="categoryName" class="form-label"
                        >Category Name</label
                        >
                        <input
                                type="text"
                                class="form-control"
                                id="categoryName"
                                required
                        />
                    </div>
                    <div class="mb-3">
                        <label for="categoryDescription" class="form-label"
                        >Description</label
                        >
                        <textarea
                                class="form-control"
                                id="categoryDescription"
                                rows="3"
                                required
                        ></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button
                        type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal"
                >
                    Close
                </button>
                <button type="submit" class="btn btn-primary">Save Category</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Category Modal -->
<div
        class="modal fade"
        id="editCategoryModal"
        tabindex="-1"
        aria-labelledby="editCategoryModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCategoryModalLabel">
                    Edit Category
                </h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="editCategoryName" class="form-label"
                        >Category Name</label
                        >
                        <input
                                type="text"
                                class="form-control"
                                id="editCategoryName"
                                value="Electronics"
                                required
                        />
                    </div>
                    <div class="mb-3">
                        <label for="editCategoryDescription" class="form-label"
                        >Description</label
                        >
                        <textarea
                                class="form-control"
                                id="editCategoryDescription"
                                rows="3"
                                required
                        >
Devices and gadgets</textarea
                        >
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button
                        type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal"
                >
                    Close
                </button>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </div>
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

