<%@ page import="lk.ijse.ecommercewebapplication.dto.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: chath
  Date: 1/21/2025
  Time: 7:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
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

        .btn-outline-light {
            border-color: #e60012;
            color: #e60012;
        }

        .btn-outline-light:hover {
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

        .container {
            margin-top: 100px;
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

        /* Typography */
        h2 {
            font-weight: 600;
            color: #e60012;
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

        /* Animations */
        .btn {
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>
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
                    <ul class="dropdown-menu" style="background-color: #ffffff;">
                        <li><a class="dropdown-item" href="category.jsp?category=electronics">Electronics</a></li>
                        <li><a class="dropdown-item" href="category.jsp?category=clothing">Clothing</a></li>
                        <li><a class="dropdown-item" href="category.jsp?category=home-kitchen">Home & Kitchen</a></li>
                    </ul>
                </li>
            </ul>
            <form class="d-flex me-2">
                <input class="form-control me-2" type="search" placeholder="Search for products..." aria-label="Search">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </form>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
            </ul>
            <button type="button" class="btn btn-primary btn-lg">Logout</button>
        </div>
    </div>
</nav>

<%
    String alertMessage = (String) request.getAttribute("alertMessage");
    if (alertMessage != null) {
%>
<script type="text/javascript">
    alert("<%= alertMessage %>");
</script>
<%
    }
%>

<%
    lk.ijse.ecommercewebapplication.dto.UserDTO user = (lk.ijse.ecommercewebapplication.dto.UserDTO) session.getAttribute("user");
    if (user == null) {
%>
<!-- If user is null, redirect to login or show an error -->
<p>Session expired. Please <a href="index.jsp">log in</a>.</p>
<%
} else {
%>

<div class="container mb-5">
    <h2 class="mb-4 mt-5">Profile Management</h2>
    <form action="profile" method="post">
        <div class="mb-3">
            <label for="profile-name" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="profile-name" name="name" value="<%= user.getName() %>"
                   required>
        </div>
        <div class="mb-3">
            <label for="profile-email" class="form-label">Email</label>
            <input type="email" class="form-control" id="profile-email" name="email" value="<%= user.getEmail() %>"
                   required>
        </div>
        <div class="mb-3">
            <label for="profile-password" class="form-label">Password</label>
            <input type="password" class="form-control" id="profile-password" name="password" required>
        </div>
        <div class="mb-3">
            <label for="confirm-password" class="form-label">Confirm Password</label>
            <input type="password" class="form-control" id="confirm-password" name="confirmPassword" required>
        </div>
        <button type="submit" class="btn btn-primary">Update Profile</button>
    </form>
    <%
        }
    %>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
