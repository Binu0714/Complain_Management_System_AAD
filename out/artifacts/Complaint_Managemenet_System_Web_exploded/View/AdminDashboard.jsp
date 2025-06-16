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
    <title>Admin Dashboard - Complaint Management System</title>
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
            color: #333;
        }

        .header {
            background: #27ae60;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            font-size: 1.8rem;
            font-weight: 700;
        }

        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .dashboard-container {
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border-left: 4px solid;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card.total { border-left-color: #27ae60; }
        .stat-card.pending { border-left-color: #f39c12; }
        .stat-card.resolved { border-left-color: #27ae60; }
        .stat-card.progress { border-left-color: #27ae60; }
        .stat-card.users { border-left-color: #27ae60; }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .content-section {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.4rem;
            margin-bottom: 1.5rem;
            color: #333;
            border-bottom: 2px solid #27ae60;
            padding-bottom: 0.5rem;
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
            padding: 0.75rem;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: #27ae60;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.1);
        }

        .form-textarea {
            resize: vertical;
            min-height: 80px;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-bottom: 2rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .btn-save {
            background: #27ae60;
            color: white;
        }

        .btn-save:hover {
            background: #229954;
            transform: translateY(-1px);
        }

        .btn-update {
            background: #27ae60;
            color: white;
        }

        .btn-update:hover {
            background: #229954;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: #e74c3c;
            color: white;
        }

        .btn-delete:hover {
            background: #c0392b;
            transform: translateY(-1px);
        }

        .btn-clear {
            background: #95a5a6;
            color: white;
        }

        .btn-clear:hover {
            background: #7f8c8d;
            transform: translateY(-1px);
        }

        .table-container {
            overflow-x: auto;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        .complaints-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }

        .complaints-table th {
            background: #27ae60;
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
            background: #e8f5e8;
            color: #27ae60;
            border: 1px solid #27ae60;
        }

        .action-btn {
            background: none;
            border: none;
            color: #27ae60;
            cursor: pointer;
            font-size: 0.9rem;
            padding: 0.3rem 0.5rem;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            background: #27ae60;
            color: white;
        }

        .description-cell {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        @media (max-width: 768px) {
            .dashboard-container {
                padding: 1rem;
            }

            .header {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .button-group {
                flex-direction: column;
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
    <h1>🛡️ Admin Dashboard</h1>
    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
        🚪 Logout
    </a>
</div>

<div class="dashboard-container">
    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card total">
            <div class="stat-number" id="totalComplaints">156</div>
            <div class="stat-label">Total Complaints</div>
        </div>
        <div class="stat-card pending">
            <div class="stat-number" id="pendingComplaints">42</div>
            <div class="stat-label">Pending Complaints</div>
        </div>
        <div class="stat-card resolved">
            <div class="stat-number" id="resolvedComplaints">89</div>
            <div class="stat-label">Resolved Complaints</div>
        </div>
        <div class="stat-card progress">
            <div class="stat-number" id="progressComplaints">25</div>
            <div class="stat-label">In Progress</div>
        </div>
        <div class="stat-card users">
            <div class="stat-number" id="totalUsers">78</div>
            <div class="stat-label">Total Users</div>
        </div>
    </div>

    <!-- Complaint Management Form -->
    <div class="content-section">
        <h2 class="section-title">Complaint Management</h2>
        <form id="complaintForm">
            <div class="form-grid">
                <div class="form-group">
                    <label for="userId" class="form-label">User ID</label>
                    <input type="text" id="userId" name="userId" class="form-input" placeholder="Enter User ID" required>
                </div>
                <div class="form-group">
                    <label for="complaintTitle" class="form-label">Complaint Title</label>
                    <input type="text" id="complaintTitle" name="complaintTitle" class="form-input" placeholder="Enter complaint title" required>
                </div>
            </div>

            <div class="form-group">
                <label for="description" class="form-label">Description</label>
                <textarea id="description" name="description" class="form-textarea" placeholder="Enter detailed description" required></textarea>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="remark" class="form-label">Remark</label>
                    <input type="text" id="remark" name="remark" class="form-input" placeholder="Enter admin remark">
                </div>
                <div class="form-group">
                    <label for="status" class="form-label">Status</label>
                    <select id="status" name="status" class="form-select" required>
                        <option value="">Select Status</option>
                        <option value="pending">Pending</option>
                        <option value="progress">In Progress</option>
                        <option value="resolved">Resolved</option>
                    </select>
                </div>
            </div>

            <div class="button-group">
                <button type="button" class="btn btn-save" onclick="saveComplaint()">💾 Save</button>
                <button type="button" class="btn btn-update" onclick="updateComplaint()">✏️ Update</button>
                <button type="button" class="btn btn-delete" onclick="deleteComplaint()">🗑️ Delete</button>
                <button type="button" class="btn btn-clear" onclick="clearForm()">🔄 Clear</button>
            </div>
        </form>
    </div>

    <!-- Complaints Table -->
    <div class="content-section">
        <h2 class="section-title">All Complaints</h2>
        <div class="table-container">
            <table class="complaints-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Remark</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="complaintsTableBody">
                <tr>
                    <td>1</td>
                    <td>USR001</td>
                    <td>Login Issue</td>
                    <td class="description-cell">Unable to login to the system with correct credentials</td>
                    <td>Password reset required</td>
                    <td><span class="status-badge status-resolved">Resolved</span></td>
                    <td>2025-06-15</td>
                    <td>
                        <button class="action-btn" onclick="editComplaint(1)">✏️ Edit</button>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>USR002</td>
                    <td>System Error</td>
                    <td class="description-cell">Getting 500 error when trying to submit forms</td>
                    <td>Under investigation</td>
                    <td><span class="status-badge status-progress">In Progress</span></td>
                    <td>2025-06-16</td>
                    <td>
                        <button class="action-btn" onclick="editComplaint(2)">✏️ Edit</button>
                    </td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>USR003</td>
                    <td>Feature Request</td>
                    <td class="description-cell">Need export functionality for reports</td>
                    <td>-</td>
                    <td><span class="status-badge status-pending">Pending</span></td>
                    <td>2025-06-16</td>
                    <td>
                        <button class="action-btn" onclick="editComplaint(3)">✏️ Edit</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>