<%--
  Created by IntelliJ IDEA.
  User: chath
  Date: 1/21/2025
  Time: 7:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placement</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    />
    <style>
        /* Body and Background */
        body {
            background-color: #f9f9f9;
            color: #333;
            font-family: 'Arial', sans-serif;
        }

        /* Navbar */
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

        .dropdown-item {
            color: #d1000f;
        }

        .btn-outline-danger {
            border-color: #e60012;
            color: #e60012;
        }

        .btn-outline-danger:hover {
            background-color: #e60012;
            color: #ffffff;
        }

        /* Buttons */
        .btn-primary {
            background-color: #e60012;
            border-color: #d1000f;
            color: white;
        }

        .btn-primary:hover {
            background-color: #d1000f;
            border-color: #b1000c;
        }

        .btn-danger {
            background-color: #ff4747;
            border-color: #d13636;
        }

        .btn-danger:hover {
            background-color: #d13636;
        }

        .container {
            margin-top: 100px;
        }

        /* Cards */
        .card {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            color: #333;
            border-radius: 8px;
            transition: transform 0.3s ease, box-shadow 0.3s ease, border 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e60012;
        }

        .card h5 {
            font-weight: 600;
        }

        .card img {
            border-radius: 8px 8px 0 0;
            height: 200px;
            object-fit: cover;
        }

        /* Footer */
        footer {
            background-color: #ffffff;
            color: #333;
            border-top: 1px solid #e6e6e6;
            padding: 20px 0;
            text-align: center;
        }

        footer a {
            color: #e60012;
            text-decoration: none;
            font-weight: 500;
        }

        footer a:hover {
            color: #d1000f;
            text-decoration: underline;
        }

        footer .social-icons a {
            margin: 0 10px;
            color: #e60012;
            font-size: 20px;
        }

        footer .social-icons a:hover {
            color: #d1000f;
        }

        /* Inputs */
        .form-control {
            background-color: #ffffff;
            border: 1px solid #ced4da;
            color: #333;
            border-radius: 5px;
            font-size: 0.9rem;
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: #e60012;
            color: #333;
            box-shadow: none;
        }

        /* Animations */
        .btn, .nav-link {
            transition: all 0.3s ease;
        }

        /* Typography */
        h2, h5 {
            font-weight: 600;
        }

        .card-title {
            font-size: 1.2rem;
        }

        .card-text {
            font-size: 0.95rem;
        }

        /* Responsive Layout */
        @media (max-width: 768px) {
            .card {
                margin-bottom: 20px;
            }

            .card-body {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">E-Commerce</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="product_list.jsp">Shop</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="categoryDropdown" data-bs-toggle="dropdown">
                        Categories
                    </a>
                    <ul class="dropdown-menu" style="background-color: #ffffff;">
                        <li><a class="dropdown-item" href="category.jsp?category=electronics">Electronics</a></li>
                        <li><a class="dropdown-item" href="category.jsp?category=clothing">Clothing</a></li>
                        <li><a class="dropdown-item" href="category.jsp?category=home-kitchen">Home & Kitchen</a></li>
                    </ul>
                </li>
            </ul>
            <form class="d-flex me-2">
                <input class="form-control me-2" type="search" placeholder="Search for products..." aria-label="Search">
                <button class="btn btn-outline-danger" type="submit">Search</button>
            </form>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="user_profile.jsp">Profile</a></li>
            </ul>
            <button type="button" class="btn btn-primary btn-lg">Logout</button>
        </div>
    </div>
</nav>

<!-- Order Placement Content -->
<div class="container mb-5">
    <h2>Order Placement</h2>
    <div class="card">
        <div class="card-body">
            <form>
                <div class="mb-3">
                    <label for="address" class="form-label">Shipping Address</label>
                    <textarea class="form-control" id="address" rows="3" placeholder="Enter your shipping address"></textarea>
                </div>
                <div class="mb-3">
                    <label for="payment" class="form-label">Payment Method</label>
                    <select class="form-select" id="payment">
                        <option value="credit">Credit Card</option>
                        <option value="paypal">PayPal</option>
                        <option value="cod">Cash on Delivery</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Place Order</button>
            </form>
        </div>
    </div>
</div>

<footer>
    <p>&copy; 2025 E-Commerce Store. All Rights Reserved.</p>
    <p>Follow us on</p>
    <div class="social-icons">
        <a href="https://www.facebook.com" target="_blank"><i class="fa-brands fa-facebook"></i></a>
        <a href="https://www.twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
        <a href="https://www.instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
    </div>
</footer>

<!-- FontAwesome for Social Icons -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

