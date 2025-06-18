package org.example.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.Dao.AdminDao;
import org.example.Model.AdminEmployeeModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        AdminDao adminDao = new AdminDao(this.dataSource);

        if ("update_complains".equals(action)) {
            int complainId = Integer.parseInt(req.getParameter("complain_id"));
            String title = req.getParameter("complaintTitle");
            String description = req.getParameter("description");
            String status = req.getParameter("status");
            System.out.println("Status received from form: " + status);
            String remark = req.getParameter("remark");
            int user_id = Integer.parseInt(req.getParameter("user_id"));
            String created_at = req.getParameter("created_at");

            AdminEmployeeModel adminEmployeeModel = new AdminEmployeeModel();

            adminEmployeeModel.setComplain_id(complainId);
            adminEmployeeModel.setTitle(title);
            adminEmployeeModel.setDescription(description);
            adminEmployeeModel.setUser_id(user_id);
            adminEmployeeModel.setStatus(status);
            adminEmployeeModel.setRemark(remark);
            adminEmployeeModel.setCreated_at(created_at);

            int result = 0;

            try {
                System.out.println("wada...");
                result = adminDao.updateComplains(adminEmployeeModel);

                if (result > 0) {
                    req.getSession().setAttribute("complaintMessage", "success");
                    req.getSession().setAttribute("complaintMessageText", "Complaint Updated Successfully!");
                }else {
                    req.getSession().setAttribute("complaintMessage", "error");
                    req.getSession().setAttribute("complaintMessageText", "Update failed. Please try again.");
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } else if ("delete_complains".equals(action)) {
            int complainId = Integer.parseInt(req.getParameter("complain_id"));
            int result = 0;

            try {
                result = adminDao.deleteComplains(complainId);

                if (result > 0){
                    req.getSession().setAttribute("complaintMessage", "success");
                    req.getSession().setAttribute("complaintMessageText", "Complaint Deleted Successfully!");
                }else {
                    req.getSession().setAttribute("complaintMessage", "error");
                    req.getSession().setAttribute("complaintMessageText", "Failed to Delete. Please try again.");
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        resp.sendRedirect("admin");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            AdminDao adminDao = new AdminDao(dataSource);

            List<AdminEmployeeModel> complains = adminDao.getAllComplains();
            req.setAttribute("complains", complains);

            int totalComplains = complains.size();
            int pendingCount = adminDao.getCountByStatus("Pending");
            int inProgressCount = adminDao.getCountByStatus("In_Progress");
            int resolvedCount = adminDao.getCountByStatus("Resolved");
            int totalUsers = adminDao.getTotalUsers();

            req.setAttribute("total",totalComplains);
            req.setAttribute("pending", pendingCount);
            req.setAttribute("progress", inProgressCount);
            req.setAttribute("resolved", resolvedCount);
            req.setAttribute("users",totalUsers);


            req.getRequestDispatcher("View/AdminDashboard.jsp").forward(req, resp);
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
