<%--
  Created by IntelliJ IDEA.
  User: chath
  Date: 1/18/2025
  Time: 12:24 PM
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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation" onclick="toggleSidebar()">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav d-flex justify-content-between w-100">
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/product-manage">Product Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/category-manage">Category Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/order-manage">Order Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user-manage">User Management</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Product Management Table -->
    <div class="table-container">
        <h2>Product Management</h2>

        <button
                class="btn btn-primary mb-3"
                data-bs-toggle="modal"
                data-bs-target="#addProductModal"
        >
            Add Product
        </button>

        <!-- Add Product Modal -->
        <div
                class="modal fade"
                id="addProductModal"
                tabindex="-1"
                aria-labelledby="addProductModalLabel"
                aria-hidden="true"
        >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">
                            Add Product
                        </h5>
                        <button
                                type="button"
                                class="btn-close"
                                data-bs-dismiss="modal"
                                aria-label="Close"
                        ></button>
                    </div>
                    <div class="modal-body">
                        <form id="addProductForm">
                            <div class="mb-3">
                                <label for="productName" class="form-label"
                                >Product Name</label
                                >
                                <input
                                        type="text"
                                        class="form-control"
                                        id="productName"
                                        placeholder="Enter product name"
                                        required
                                />
                            </div>
                            <div class="mb-3">
                                <label for="productCategory" class="form-label"
                                >Category</label
                                >
                                <input
                                        type="text"
                                        class="form-control"
                                        id="productCategory"
                                        placeholder="Enter category"
                                        required
                                />
                            </div>
                            <div class="mb-3">
                                <label for="productPrice" class="form-label">Price</label>
                                <input
                                        type="number"
                                        class="form-control"
                                        id="productPrice"
                                        placeholder="Enter price"
                                        required
                                />
                            </div>
                            <div class="mb-3">
                                <label for="productStock" class="form-label">Stock</label>
                                <input
                                        type="number"
                                        class="form-control"
                                        id="productStock"
                                        placeholder="Enter stock quantity"
                                        required
                                />
                            </div>
                            <button
                                    type="button"
                                    class="btn btn-secondary"
                                    data-bs-dismiss="modal"
                            >
                                Close
                            </button>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Product Modal -->
        <div
                class="modal fade"
                id="editProductModal"
                tabindex="-1"
                aria-labelledby="editProductModalLabel"
                aria-hidden="true"
        >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editProductModalLabel">
                            Edit Product
                        </h5>
                        <button
                                type="button"
                                class="btn-close"
                                data-bs-dismiss="modal"
                                aria-label="Close"
                        ></button>
                    </div>
                    <div class="modal-body">
                        <form id="editProductForm">
                            <div class="mb-3">
                                <label for="editProductName" class="form-label"
                                >Product Name</label
                                >
                                <input
                                        type="text"
                                        class="form-control"
                                        id="editProductName"
                                        placeholder="Enter product name"
                                        required
                                />
                            </div>
                            <div class="mb-3">
                                <label for="editProductCategory" class="form-label"
                                >Category</label
                                >
                                <input
                                        type="text"
                                        class="form-control"
                                        id="editProductCategory"
                                        placeholder="Enter category"
                                        required
                                />
                            </div>
                            <div class="mb-3">
                                <label for="editProductPrice" class="form-label"
                                >Price</label
                                >
                                <input
                                        type="number"
                                        class="form-control"
                                        id="editProductPrice"
                                        placeholder="Enter price"
                                        required
                                />
                            </div>
                            <div class="mb-3">
                                <label for="editProductStock" class="form-label"
                                >Stock</label
                                >
                                <input
                                        type="number"
                                        class="form-control"
                                        id="editProductStock"
                                        placeholder="Enter stock quantity"
                                        required
                                />
                            </div>
                            <button
                                    type="button"
                                    class="btn btn-secondary"
                                    data-bs-dismiss="modal"
                            >
                                Close
                            </button>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>Smartphone</td>
                <td>Electronics</td>
                <td>$699.99</td>
                <td>25</td>
                <td>
                    <button
                            class="btn btn-sm btn-warning"
                            data-bs-toggle="modal"
                            data-bs-target="#editProductModal"
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

