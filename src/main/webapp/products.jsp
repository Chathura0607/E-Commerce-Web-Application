<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.ecommercewebapplication.dto.CategoryDTO" %>
<%@ page import="lk.ijse.ecommercewebapplication.dto.ProductDTO" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Browsing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    />
    <style>
        /* Ensure the body takes full height and makes footer stick to bottom */
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        body {
            background-color: #f9f9f9;
            color: #333;
            font-family: 'Arial', sans-serif;
        }

        /* Navbar Styling */
        .navbar {
            background-color: #ffffff;
            border-bottom: 1px solid #e6e6e6;
        }

        .navbar-brand, .nav-link {
            color: #e60012 !important;
            font-weight: 600;
        }

        .navbar-brand:hover, .nav-link:hover {
            color: #d1000f !important;
            text-decoration: underline;
        }

        .btn-primary {
            background-color: #e60012;
            border-color: #d1000f;
            color: white;
        }

        .btn-primary:hover {
            background-color: #d1000f;
            border-color: #b1000c;
        }

        /* Cards Styling */
        .card {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .card-img-top {
            height: 225px; /* Set a fixed height */
            object-fit: cover; /* Ensure image fits well within the container */
        }

        /* Footer Styling */
        footer {
            background-color: #ffffff;
            border-top: 1px solid #e6e6e6;
            padding: 20px 0;
            text-align: center;
            margin-top: auto; /* Ensures footer stays at the bottom */
        }

        footer a {
            color: #e60012;
            text-decoration: none;
            font-weight: 500;
        }

        footer .social-icons a {
            margin: 0 10px;
            color: #e60012;
            font-size: 20px;
        }
    </style>
</head>
<body>
<%
    // Fetching categories and products from request scope
    List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
    List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
    String selectedCategory = request.getParameter("category");
    String sortOrder = request.getParameter("sort");
%>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="products">E-Commerce</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="products">Shop</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="categoryDropdown" data-bs-toggle="dropdown">
                        Categories
                    </a>
                    <ul class="dropdown-menu">
                        <% if (categories != null) {
                            for (CategoryDTO category : categories) { %>
                        <li>
                            <a class="dropdown-item" href="products.jsp?category=<%= category.getId() %>">
                                <%= category.getName() %>
                            </a>
                        </li>
                        <% }
                        } %>
                    </ul>
                </li>
            </ul>
            <form class="d-flex me-2" method="get" action="products.jsp">
                <input class="form-control me-2" type="search" name="search" placeholder="Search for products..."
                       aria-label="Search">
                <button class="btn btn-outline-danger" type="submit">Search</button>
            </form>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
            </ul>
            <button type="button" class="btn btn-primary btn-lg">Logout</button>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="mb-4 mt-5">Browse Products</h2>
    <form method="get" action="products.jsp">
        <div class="row mb-3">
            <div class="col-md-6">
                <select class="form-select" name="category">
                    <option value="">All Categories</option>
                    <% if (categories != null) {
                        for (CategoryDTO category : categories) { %>
                    <option value="<%= category.getId() %>"
                            <%= String.valueOf(category.getId()).equals(selectedCategory) ? "selected" : "" %>>
                        <%= category.getName() %>
                    </option>

                    <% }
                    } %>
                </select>
            </div>
            <div class="col-md-6">
                <select class="form-select" name="sort">
                    <option value="asc" <%= "asc".equals(sortOrder) ? "selected" : "" %>>Price: Low to High</option>
                    <option value="desc" <%= "desc".equals(sortOrder) ? "selected" : "" %>>Price: High to Low</option>
                </select>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Apply Filters</button>
    </form>

    <div class="row">
        <% if (products != null) {
            for (ProductDTO product : products) { %>
        <div class="col-md-4">
            <div class="card mb-3">
                <% if (product.getPhotos() != null && !product.getPhotos().isEmpty()) { %>
                <img src="${pageContext.request.contextPath}/<%= product.getPhotos().get(0).getPhotoUrl() %>"
                     class="card-img-top"
                     alt="<%= product.getName() %>">
                <% } else { %>
                <img src="default-product.jpg" class="card-img-top" alt="<%= product.getName() %>">
                <% } %>
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %>
                    </h5>
                    <p class="card-text">$<%= product.getPrice() %>
                    </p>
                    <button class="btn btn-primary btn-sm">Add to Cart</button>
                </div>
            </div>
        </div>
        <% }
        } %>
    </div>
</div>

<footer>
    <p>&copy; 2025 E-Commerce Store. All Rights Reserved.</p>
    <div class="social-icons">
        <a href="#"><i class="fab fa-facebook"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
        <a href="#"><i class="fab fa-instagram"></i></a>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
