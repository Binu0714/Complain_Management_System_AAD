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
  <title>Complaint Management System - Sign Up</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .signup-container {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      padding: 40px;
      width: 100%;
      max-width: 450px;
      position: relative;
      overflow: hidden;
    }

    .signup-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, #667eea, #764ba2);
    }

    .logo-section {
      text-align: center;
      margin-bottom: 30px;
    }

    .logo {
      width: 80px;
      height: 80px;
      background: linear-gradient(135deg, #667eea, #764ba2);
      border-radius: 50%;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 15px;
      box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
    }

    .logo::before {
      content: '📋';
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
      border-color: #667eea;
      background: #fff;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      transform: translateY(-1px);
    }

    .form-input::placeholder {
      color: #adb5bd;
    }

    .form-select {
      width: 100%;
      padding: 15px 20px;
      border: 2px solid #e1e8ed;
      border-radius: 12px;
      font-size: 16px;
      transition: all 0.3s ease;
      background: #f8f9fa;
      cursor: pointer;
    }

    .form-select:focus {
      outline: none;
      border-color: #667eea;
      background: #fff;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      transform: translateY(-1px);
    }



    .signup-btn {
      width: 100%;
      background: linear-gradient(135deg, #667eea, #764ba2);
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

    .signup-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
    }

    .signup-btn:active {
      transform: translateY(0);
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

    .signin-section {
      text-align: center;
      background: #f8f9fa;
      padding: 20px;
      border-radius: 12px;
      margin-top: 20px;
    }

    .signin-text {
      color: #666;
      font-size: 14px;
      margin-bottom: 10px;
    }

    .signin-btn-link {
      background: transparent;
      color: #667eea;
      border: 2px solid #667eea;
      padding: 12px 30px;
      border-radius: 8px;
      font-size: 14px;
      font-weight: 600;
      text-decoration: none;
      display: inline-block;
      transition: all 0.3s ease;
    }

    .signin-btn-link:hover {
      background: #667eea;
      color: white;
      transform: translateY(-1px);
    }

    .message {
      padding: 10px 15px;
      border-radius: 8px;
      margin-bottom: 20px;
      font-size: 14px;
      font-weight: 500;
    }

    .error-message {
      color: #dc3545;
      font-size: 12px;
      margin-top: 5px;
      display: none;
    }

    @media (max-width: 480px) {
      .signup-container {
        padding: 30px 20px;
        margin: 10px;
      }

      .system-title {
        font-size: 20px;
      }

      .role-selection {
        flex-direction: column;
        gap: 10px;
      }
    }
  </style>
</head>
<body>
<div class="signup-container">
  <div class="logo-section">
    <div class="logo"></div>
    <h1 class="system-title">Complaint Management</h1>
    <p class="system-subtitle">Create Your Account</p>
  </div>

  <%
    String error = request.getParameter("error");
    if ("true".equals(error)) {
  %>
  <div class="message" style="color: red; background: #f8d7da; border: 1px solid #f5c6cb;">Registration failed. Please try again.</div>
  <%
    }
    String exists = request.getParameter("exists");
    if ("true".equals(exists)) {
  %>
  <div class="message" style="color: red; background: #f8d7da; border: 1px solid #f5c6cb;">Username already exists. Please choose a different username.</div>
  <%
    }
  %>

  <form id="signupForm" action="${pageContext.request.contextPath}/signUp" method="POST">
    <div class="form-group">
      <label for="full_name" class="form-label">Full Name</label>
      <input
              type="text"
              id="full_name"
              name="full_name"
              class="form-input"
              placeholder="Enter your full name"
              required
      >
    </div>

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

    <div class="form-group">
      <label for="role" class="form-label">Select Role</label>
      <select
              id="role"
              name="role"
              class="form-select"
              required
      >
        <option value="">Choose your role...</option>
        <option value="employee">👤 Employee</option>
        <option value="admin">👑 Admin</option>
      </select>
    </div>

    <button type="submit" class="signup-btn">
      Create Account
    </button>
  </form>

  <div class="divider">
    <span>Already have an account?</span>
  </div>

  <div class="signin-section">
    <p class="signin-text">Sign in to your existing account</p>
    <a href="signIn.jsp" class="signin-btn-link">
      Sign In
    </a>
  </div>
</div>
</body>
</html>