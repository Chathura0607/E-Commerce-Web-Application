<%@ page import="lk.ijse.ecommercewebapplication.dto.CategoryDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: chath
  Date: 1/18/2025
  Time: 12:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Category Management</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
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
                    <li class="nav-item"><a class="nav-link active"
                                            href="${pageContext.request.contextPath}/category-manage">Category
                        Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/order-manage">Order
                        Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user-manage">User
                        Management</a></li>
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

    <!-- Category Management -->
    <div id="categories" class="table-container">
        <h2>Category Management</h2>

        <!-- Add Category Button -->
        <button
                class="btn btn-primary mb-3"
                data-bs-toggle="modal"
                data-bs-target="#addCategoryModal">
            Add Category
        </button>

        <!-- Category List -->
        <%
            // Retrieve the category list from the request attribute
            List<CategoryDTO> categoryList = (List<CategoryDTO>) request.getAttribute("categories");

            if (categoryList != null && !categoryList.isEmpty()) {
        %>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Category ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Iterate through the category list and display each category
                for (CategoryDTO category : categoryList) {
            %>
            <tr>
                <td><%= category.getId() %>
                </td>
                <td><%= category.getName() %>
                </td>
                <td><%= category.getDescription() %>
                </td>
                <td>
                    <!-- Edit Button -->
                    <button
                            class="btn btn-sm btn-warning"
                            data-bs-toggle="modal"
                            data-bs-target="#editCategoryModal"
                            onclick="populateEditModal('<%= category.getId() %>', '<%= category.getName() %>', '<%= category.getDescription() %>')">
                        Edit
                    </button>
                    <!-- Delete Button -->
                    <form action="<%= request.getContextPath() %>/category-manage" method="post"
                          style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= category.getId() %>">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
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
        <p>No categories available to display.</p>
        <%
            }
        %>
    </div>

    <!-- Add Category Modal -->
    <div
            class="modal fade"
            id="addCategoryModal"
            tabindex="-1"
            aria-labelledby="addCategoryModalLabel"
            aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addCategoryModalLabel">Add Category</h5>
                    <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close">
                    </button>
                </div>
                <div class="modal-body">
                    <form action="<%= request.getContextPath() %>/category-manage?action=add" method="post">
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">Category Name</label>
                            <input type="text" class="form-control" id="categoryName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="categoryDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="categoryDescription" name="description" rows="3"
                                      required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Category</button>
                        </div>
                    </form>
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
            aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
                    <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close">
                    </button>
                </div>
                <div class="modal-body">
                    <form action="<%= request.getContextPath() %>/category-manage?action=edit" method="post">
                        <!-- Hidden field for Category ID -->
                        <input type="hidden" id="editCategoryId" name="id">
                        <div class="mb-3">
                            <label for="editCategoryName" class="form-label">Category Name</label>
                            <input type="text" class="form-control" id="editCategoryName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="editCategoryDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="editCategoryDescription" name="description" rows="3"
                                      required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
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

<!-- JavaScript to Populate Edit Modal -->
<script>
    function populateEditModal(id, name, description) {
        document.getElementById('editCategoryId').value = id;
        document.getElementById('editCategoryName').value = name;
        document.getElementById('editCategoryDescription').value = description;
    }
</script>
</body>
</html>

