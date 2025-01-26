<%--
  Created by IntelliJ IDEA.
  User: chath
  Date: 1/22/2025
  Time: 8:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>E-commerce Login & Registration</title>
    <link href="styles/login.css" type="text/css" rel="stylesheet">
</head>

<body>
<div class="container">
    <div class="ecommerce-text login">ADMIN E-COMMERCE APPLICATION</div>

    <div id="login-form" class="form-box Login">
        <h2>Admin Login</h2>
        <form action="admin-login" method="post">
            <div class="input-box">
                <input type="email" id="login-email" name="email" required/>
                <label for="login-email">Email</label>
            </div>
            <div class="input-box">
                <input type="password" id="login-password" name="password" required/>
                <label for="login-password">Password</label>
            </div>
            <button type="submit" class="btn">Login</button>
            <p class="regi-link">
                Don't have an account? <a href="#" onclick="showRegister()">Register</a>
            </p>
        </form>
    </div>

    <div id="register-form" class="form-box Register">
        <h2>Admin Register</h2>
        <form action="admin-register" method="post">
            <div class="input-box">
                <input type="text" id="register-name" name="name" required/>
                <label for="register-name">Full Name</label>
            </div>
            <div class="input-box">
                <input type="email" id="register-email" name="email" required/>
                <label for="register-email">Email</label>
            </div>
            <div class="input-box">
                <input type="password" id="register-password" name="password" required/>
                <label for="register-password">Password</label>
            </div>

            <div class="input-box">
                <select id="register-role" name="role" required>
                    <option value="Customer" selected>Customer</option>
                    <option value="Admin">Admin</option>
                </select>
                <label for="register-role">Role</label>
            </div>

            <input type="hidden" name="status" value="Active"/>

            <button type="submit" class="btn">Register</button>
            <p class="regi-link">
                Already have an account? <a href="#" onclick="showLogin()">Login</a>
            </p>
        </form>
    </div>
</div>

<%-- Check if there is a message set by the servlet and display an alert --%>
<%
    String message = (String) request.getAttribute("message");
    if (message != null) {
%>
<script type="text/javascript">
    alert("<%= message %>");
</script>
<%
    }
%>

<script>
    function showRegister() {
        const container = document.querySelector(".container");
        const body = document.body;
        container.classList.add("active");
        // body.style.backgroundColor = "#ff6347";
    }

    function showLogin() {
        const container = document.querySelector(".container");
        const body = document.body;
        container.classList.remove("active");
        // body.style.backgroundColor = "#28a745";
    }
</script>
</body>
</html>
