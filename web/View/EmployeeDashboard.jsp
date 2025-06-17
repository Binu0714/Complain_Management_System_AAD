<%@ page import="java.util.List" %>
<%@ page import="org.example.Model.AdminEmployeeModel" %>
<%--
  Created by IntelliJ IDEA.
  User: Umesh Induwara
  Date: 6/16/2025
  Time: 5:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard - Complaint Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            min-height: 100vh;
            color: #333;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem 2rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Ccircle cx='30' cy='30' r='4'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            opacity: 0.3;
        }

        .header-content {
            position: relative;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 2;
        }

        .header-title {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .header h1 {
            font-size: 2rem;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            background: linear-gradient(45deg, #ffffff, #e3f2fd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logout-btn {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.2);
            padding: 0.6rem 1.8rem;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .logout-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .logout-btn:hover::before {
            left: 100%;
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            border-color: rgba(255, 255, 255, 0.4);
        }

        .dashboard-container {
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .stats-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 3rem;
            flex-wrap: wrap;
        }

        .stat-card {
            background: white;
            padding: 2rem 1.5rem;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            min-width: 200px;
            text-align: center;
            border: 1px solid #f0f0f0;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--card-gradient);
        }

        .stat-card::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, var(--card-color-light) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .stat-card:hover::after {
            opacity: 0.05;
        }

        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        }

        .stat-card.total {
            --card-color: #e74c3c;
            --card-color-light: #ec7063;
            --card-gradient: linear-gradient(90deg, #e74c3c, #ec7063);
        }

        .stat-card.pending {
            --card-color: #f39c12;
            --card-color-light: #f5b041;
            --card-gradient: linear-gradient(90deg, #f39c12, #f5b041);
        }

        .stat-card.resolved {
            --card-color: #27ae60;
            --card-color-light: #58d68d;
            --card-gradient: linear-gradient(90deg, #27ae60, #58d68d);
        }

        .stat-card.progress {
            --card-color: #3498db;
            --card-color-light: #5dade2;
            --card-gradient: linear-gradient(90deg, #3498db, #5dade2);
        }

        .stat-number {
            font-size: 2.8rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            color: var(--card-color);
            position: relative;
            z-index: 2;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            z-index: 2;
        }

        .content-section {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            border: 1px solid #f0f0f0;
        }

        .section-title {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: #333;
            border-bottom: 3px solid #667eea;
            padding-bottom: 0.5rem;
            font-weight: 700;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: #667eea;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            flex-wrap: wrap;
            margin-bottom: 2rem;
        }

        .btn {
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-add {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
        }

        .btn-add:hover {
            background: linear-gradient(135deg, #2ecc71, #58d68d);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.3);
        }

        .btn-update {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        .btn-update:hover {
            background: linear-gradient(135deg, #2980b9, #21618c);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.3);
        }

        .btn-delete {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.3);
        }

        .btn-clear {
            background: linear-gradient(135deg, #95a5a6, #7f8c8d);
            color: white;
        }

        .btn-clear:hover {
            background: linear-gradient(135deg, #7f8c8d, #6c7b7d);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(149, 165, 166, 0.3);
        }

        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.08);
        }

        .complaints-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
        }

        .complaints-table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 1px;
        }

        .complaints-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            vertical-align: top;
        }

        .complaints-table tr:hover {
            background: #f8f9fa;
        }

        .status-badge {
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .status-pending {
            background: #fef9e7;
            color: #f39c12;
            border: 1px solid #f39c12;
        }

        .status-resolved {
            background: #eafaf1;
            color: #27ae60;
            border: 1px solid #27ae60;
        }

        .status-progress {
            background: #e8f4fd;
            color: #3498db;
            border: 1px solid #3498db;
        }

        .action-btn {
            background: none;
            border: none;
            color: #667eea;
            cursor: pointer;
            font-size: 0.9rem;
            padding: 0.3rem 0.5rem;
            border-radius: 4px;
            transition: all 0.3s ease;
            margin-right: 0.5rem;
        }

        .action-btn:hover {
            background: #667eea;
            color: white;
        }

        .description-cell {
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        @media (max-width: 1200px) {
            .stats-container {
                gap: 1rem;
            }

            .stat-card {
                min-width: 180px;
                padding: 1.5rem 1rem;
            }
        }

        @media (max-width: 768px) {
            .dashboard-container {
                padding: 1rem;
            }

            .header {
                padding: 1rem;
            }

            .header-content {
                flex-direction: column;
                gap: 1rem;
            }

            .stats-container {
                flex-direction: column;
                align-items: center;
            }

            .stat-card {
                min-width: 250px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .button-group {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 200px;
                justify-content: center;
            }

            .complaints-table {
                font-size: 0.8rem;
            }

            .complaints-table th,
            .complaints-table td {
                padding: 0.5rem;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="header-title">
            <h1>Employee Dashboard</h1>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            Logout
        </a>
    </div>
</div>

<div class="dashboard-container">
    <!-- Statistics Cards -->
    <div class="stats-container">
        <div class="stat-card total">
            <div class="stat-number" id="totalComplaints">12</div>
            <div class="stat-label">My Total Complaints</div>
        </div>
        <div class="stat-card pending">
            <div class="stat-number" id="pendingComplaints">5</div>
            <div class="stat-label">Pending</div>
        </div>
        <div class="stat-card progress">
            <div class="stat-number" id="progressComplaints">4</div>
            <div class="stat-label">In Progress</div>
        </div>
        <div class="stat-card resolved">
            <div class="stat-number" id="resolvedComplaints">3</div>
            <div class="stat-label">Resolved</div>
        </div>
    </div>

    <!-- Complaint Form -->
    <div class="content-section">
        <h2 class="section-title">Submit New Complaint</h2>
        <form id="complaintForm" action="${pageContext.request.contextPath}/employee" method="post">

            <input type="hidden" id="complaint_id" name="complaint_id">

            <div class="form-group">
                <label for="complaintTitle" class="form-label">Complaint Title</label>
                <input type="text" id="complaintTitle" name="complaintTitle" class="form-input" placeholder="Enter your complaint title" required>
            </div>

            <div class="form-group">
                <label for="complaintDescription" class="form-label">Complaint Description</label>
                <textarea id="complaintDescription" name="complaintDescription" class="form-textarea" placeholder="Describe your complaint in detail..." required></textarea>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-add" name="action" value="add_complains">Add Complaint</button>
                <button type="submit" id="updateBtn" class="btn btn-update" name="action" value="update_complains" disabled>Update</button>
                <button type="submit" id="deleteBtn" class="btn btn-delete" name="action" value="delete_complains" disabled>Delete</button>
                <button type="button" class="btn btn-clear" onclick="clearForm()">Clear Form</button>
            </div>
        </form>
    </div>

    <!-- Complaints Table -->
    <div class="content-section">
        <h2 class="section-title">My Complaints</h2>
        <div class="table-container">
            <table class="complaints-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>User_ID</th>
                    <th>Admin Remark</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Date Created</th>
                    <th>Date Updated</th>
                </tr>
                </thead>
                <tbody id="complaintsTableBody">
                <%
                    List<AdminEmployeeModel> complaintList = (List<AdminEmployeeModel>) request.getAttribute("complains");
                    if (complaintList != null && !complaintList.isEmpty()) {
                        for (AdminEmployeeModel c : complaintList) {
                %>
                <tr onclick="selectComplaint('<%= c.getComplain_id() %>', '<%= c.getTitle().replace("'", "\\'") %>', '<%= c.getDescription().replace("'", "\\'") %>')">
                    <td><%= c.getComplain_id() %></td>
                    <td><%= c.getUser_id() %></td>
                    <td><%= c.getRemark() %></td>
                    <td><%= c.getTitle() %></td>
                    <td><%= c.getDescription() %></td>
                    <td>
                        <span class="status status-<%= c.getStatus().toLowerCase().replace(" ", "-") %>">
                            <%= c.getStatus() %>
                        </span>
                    </td>
                    <td><%= c.getCreated_at() %></td>
                    <td><%= c.getUpdated_at() %></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="8" class="no-data">No complaints found.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function selectComplains(id,title,description) {
        document.getElementById('complaint_id').value = id;
        document.getElementById('title').value = title;
        document.getElementById('description').value = description;
        document.getElementById('updateBtn').disabled = false;
        document.getElementById('deleteBtn').disabled = false;

        document.querySelector('.form-section').scrollIntoView({ behavior: 'smooth' });
    }
</script>
</body>
</html>