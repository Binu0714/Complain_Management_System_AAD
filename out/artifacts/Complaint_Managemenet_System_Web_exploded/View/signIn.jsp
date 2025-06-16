<%--
  Created by IntelliJ IDEA.
  User: Umesh Induwara
  Date: 6/16/2025
  Time: 2:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Management System - Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            background: #ffffff;
            border-radius: 20px;
            box-shadow:
                    0 20px 40px rgba(0, 0, 0, 0.1),
                    0 8px 16px rgba(0, 0, 0, 0.06),
                    inset 0 1px 0 rgba(255, 255, 255, 0.8);
            padding: 40px;
            width: 100%;
            max-width: 420px;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #27ae60, #2ecc71);
        }

        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            box-shadow: 0 10px 20px rgba(39, 174, 96, 0.3);
        }

        .logo::before {
            content: '🛡️';
            font-size: 32px;
        }

        .system-title {
            color: #333;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .system-subtitle {
            color: #666;
            font-size: 14px;
            font-weight: 400;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e8ed;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-input:focus {
            outline: none;
            border-color: #27ae60;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.1);
            transform: translateY(-1px);
        }

        .form-input::placeholder {
            color: #adb5bd;
        }

        .password-field {
            position: relative;
        }

        .signin-btn {
            width: 100%;
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            position: relative;
            overflow: hidden;
        }

        .signin-btn:hover {
            background: linear-gradient(135deg, #229954, #27ae60);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(39, 174, 96, 0.4);
        }

        .signin-btn:active {
            transform: translateY(0);
        }

        .forgot-password {
            text-align: center;
            margin: 20px 0;
        }

        .forgot-password a {
            color: #27ae60;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }

        .forgot-password a:hover {
            text-decoration: underline;
            color: #229954;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
            color: #666;
            font-size: 14px;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #e1e8ed;
        }

        .divider span {
            margin: 0 15px;
        }

        .signup-section {
            text-align: center;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-top: 20px;
        }

        .signup-text {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .error-message {
            color: #dc3545;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }

        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 500;
        }

        .message[style*="green"] {
            background: #eafaf1;
            color: #27ae60;
            border: 1px solid #27ae60;
        }

        .message[style*="red"] {
            background: #ffeaea;
            color: #e74c3c;
            border: 1px solid #e74c3c;
        }

        .signup-btn {
            background: transparent;
            color: #27ae60;
            border: 2px solid #27ae60;
            padding: 12px 30px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .signup-btn:hover {
            background: #27ae60;
            color: white;
            transform: translateY(-1px);
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
                margin: 10px;
            }

            .system-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="logo-section">
        <div class="logo"></div>
        <h1 class="system-title">Complaint Management</h1>
        <p class="system-subtitle">Secure Login Portal</p>
    </div>
    <%
        String success = request.getParameter("success");
        if ("true".equals(success)) {
    %>
    <div class="message" style="color: green;">Successfully signed up! Please login.</div>
    <%
        }
        String error = request.getParameter("error");
        if ("true".equals(error)) {
    %>
    <div class="message" style="color: red;">Invalid username or password.</div>
    <%
        }
    %>

    <form id="loginForm" action="${pageContext.request.contextPath}/signin" method="POST">
        <div class="form-group">
            <label for="username" class="form-label">Username</label>
            <input
                    type="text"
                    id="username"
                    name="username"
                    class="form-input"
                    placeholder="Enter your username"
                    required
            >
        </div>

        <div class="form-group">
            <label for="password" class="form-label">Password</label>
            <input
                    type="password"
                    id="password"
                    name="password"
                    class="form-input"
                    placeholder="Enter your password"
                    required
            >
        </div>

        <button type="submit" class="signin-btn">
            Sign In
        </button>
    </form>

    <div class="divider">
        <span>Don't have an account?</span>
    </div>

    <div class="signup-section" >
        <a href="signUp.jsp" class="signup-btn">
            Create Account
        </a>
    </div>
</div>
</body>
</html>