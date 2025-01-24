<%@ page import="lk.ijse.ecommercewebapplication.dto.ProductDTO" %>
<%@ page import="lk.ijse.ecommercewebapplication.dto.ProductPhotoDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.ecommercewebapplication.dto.CategoryDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Product Management</title>
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
                    <li class="nav-item"><a class="nav-link active"
                                            href="${pageContext.request.contextPath}/product-manage">Product
                        Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/category-manage">Category
                        Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/order-manage">Order
                        Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user-manage">User
                        Management</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <%
        String alertMessage = (String) session.getAttribute("alertMessage");
        if (alertMessage != null) {
    %>
    <script type="text/javascript">
        alert('<%= alertMessage %>');
    </script>
    <%
            session.removeAttribute("alertMessage"); // Optional: Remove the message after showing it
        }
    %>

    <div id="products" class="table-container">
        <h2>Product Management</h2>
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addProductModal">
            Add Product
        </button>

        <!-- Product Table -->
        <%
            List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
            List<ProductPhotoDTO> productPhotos = (List<ProductPhotoDTO>) request.getAttribute("productPhotos");
            if (products != null && !products.isEmpty()) {
        %>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Product ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Photos</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (ProductDTO product : products) {
                    // Get the photos for the current product
                    List<String> photoUrls = new ArrayList<>();
                    for (ProductPhotoDTO photo : productPhotos) {
                        if (photo.getProductId() == product.getProductId()) {
                            photoUrls.add(photo.getPhotoUrl());
                        }
                    }
            %>
            <tr>
                <td><%= product.getProductId() %>
                </td>
                <td><%= product.getName() %>
                </td>
                <td><%= product.getCategoryId() %>
                </td>
                <td>$<%= product.getPrice() %>
                </td>
                <td><%= product.getStock() %>
                </td>
                <td>
                    <%
                        if (photoUrls != null && !photoUrls.isEmpty()) {
                            for (String photoUrl : photoUrls) {
                    %>
                    <img src="${pageContext.request.contextPath}/<%= photoUrl %>" alt="Product Image"
                         style="width: 50px; height: 50px; margin-right: 5px;">
                    <%
                            }
                        }
                    %>
                </td>
                <td>
                    <button class="btn btn-warning btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#editProductModal"
                            onclick="populateEditModal('<%= product.getProductId() %>', '<%= product.getName() %>', '<%= product.getCategoryId() %>', '<%= product.getPrice() %>', '<%= product.getStock() %>')">
                        Edit
                    </button>
                    <form action="product-manage" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= product.getProductId() %>">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>No products available to display.</p>
        <% } %>
    </div>

    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Add Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="product-manage?action=add" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="productName" class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="productName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="productCategory" class="form-label">Category</label>
                            <select class="form-select" id="productCategory" name="categoryId" required>
                                <% for (CategoryDTO category : (List<CategoryDTO>) request.getAttribute("categories")) { %>
                                <option value="<%= category.getId() %>"><%= category.getName() %>
                                </option>
                                <% } %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="productPrice" class="form-label">Price</label>
                            <input type="number" step="0.01" class="form-control" id="productPrice" name="price"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="productStock" class="form-label">Stock</label>
                            <input type="number" class="form-control" id="productStock" name="stock" required>
                        </div>
                        <div class="mb-3">
                            <label for="productPhotos" class="form-label">Upload Photos (Max 5)</label>
                            <input type="file" class="form-control" id="productPhotos" name="photos" multiple
                                   accept="image/*">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Product</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Product Modal -->
    <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProductModalLabel">Edit Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="product-manage?action=edit" method="post" enctype="multipart/form-data">
                        <input type="hidden" id="editProductId" name="id">
                        <div class="mb-3">
                            <label for="editProductName" class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="editProductName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="editProductCategory" class="form-label">Category</label>
                            <select class="form-select" id="editProductCategory" name="categoryId" required>
                                <% for (CategoryDTO category : (List<CategoryDTO>) request.getAttribute("categories")) { %>
                                <option value="<%= category.getId() %>"><%= category.getName() %>
                                </option>
                                <% } %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="editProductPrice" class="form-label">Price</label>
                            <input type="number" step="0.01" class="form-control" id="editProductPrice" name="price"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="editProductStock" class="form-label">Stock</label>
                            <input type="number" class="form-control" id="editProductStock" name="stock" required>
                        </div>
                        <div class="mb-3">
                            <label for="editProductPhotos" class="form-label">Upload New Photos</label>
                            <input type="file" class="form-control" id="editProductPhotos" name="photos" multiple
                                   accept="image/*">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle sidebar visibility
    function toggleSidebar() {
        var sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("active");
    }

    function populateEditModal(id, name, categoryId, price, stock) {
        document.getElementById('editProductId').value = id;
        document.getElementById('editProductName').value = name;
        document.getElementById('editProductCategory').value = categoryId;
        document.getElementById('editProductPrice').value = price;
        document.getElementById('editProductStock').value = stock;
    }
</script>
</body>
</html>
