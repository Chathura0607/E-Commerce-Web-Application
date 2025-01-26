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
    <div class="ecommerce-text login">E-COMMERCE APPLICATION</div>

    <div id="login-form" class="form-box Login">
        <h2>Login</h2>
        <form action="user-login" method="post">
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
        <h2>Register</h2>
        <form action="user-register" method="post">
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

            <input type="hidden" name="role" value="Customer"/>

            <input type="hidden" name="status" value="Active"/>

            <button type="submit" class="btn">Register</button>
            <p class="regi-link">
                Already have an account? <a href="#" onclick="showLogin()">Login</a>
            </p>
        </form>
    </div>
</div>

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
