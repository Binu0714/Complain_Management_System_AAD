package org.example.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.Dao.EmployeeDao;
import org.example.Model.AdminEmployeeModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            EmployeeDao employeeDao = new EmployeeDao(dataSource);
            String userId = (String) req.getSession().getAttribute("user_id");

            if (userId == null || userId.isBlank()) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            int uId;

            try {
                uId = Integer.parseInt(userId);
            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            if ("add_complains".equals(action)) {
                String title = req.getParameter("complaintTitle");
                String description = req.getParameter("complaintDescription");

                AdminEmployeeModel adminEmployeeModel = new AdminEmployeeModel();
                adminEmployeeModel.setTitle(title);
                adminEmployeeModel.setDescription(description);
                adminEmployeeModel.setUser_id(uId);

                int result = employeeDao.saveComplains(adminEmployeeModel);

                if (result > 0) {
                    req.getSession().setAttribute("complaintMessage", "success");
                    req.getSession().setAttribute("complaintMessageText", "Complaint Saved Successfully!");
                } else {
                    req.getSession().setAttribute("complaintMessage", "error");
                    req.getSession().setAttribute("complaintMessageText", "Failed to Save Complain.Please try again.");
                }

            } else if ("update_complains".equals(action)) {
                String complaintIdParam = req.getParameter("complaintId");
                if (complaintIdParam == null || complaintIdParam.isBlank()) {
                    req.getSession().setAttribute("msg", "No complaint selected for update");
                } else {
                    int complainId = Integer.parseInt(complaintIdParam);
                    String title = req.getParameter("complaintTitle");
                    String description = req.getParameter("complaintDescription");

                    AdminEmployeeModel adminEmployeeModel = new AdminEmployeeModel();
                    adminEmployeeModel.setComplain_id(complainId);
                    adminEmployeeModel.setTitle(title);
                    adminEmployeeModel.setDescription(description);
                    adminEmployeeModel.setUser_id(uId);

                    boolean isChecked = employeeDao.checkStatus(complainId);

                    if (isChecked) {
                        req.getSession().setAttribute("msg", "This complaint is already resolved. You can't update it.");
                    } else {
                        int result = employeeDao.updateComplains(adminEmployeeModel);

                        if (result > 0) {
                            req.getSession().setAttribute("complaintMessage", "success");
                            req.getSession().setAttribute("complaintMessageText", "Complaint Updated Successfully!");
                        } else {
                            req.getSession().setAttribute("complaintMessage", "error");
                            req.getSession().setAttribute("complaintMessageText", "Failed to Update Complain.Please try again.");
                        }
                    }
                }

            } else if ("delete_complains".equals(action)) {
                    int complainId = Integer.parseInt(req.getParameter("complaintId"));

                    boolean isChecked = employeeDao.checkStatus(complainId);

                    if (isChecked) {
                        req.getSession().setAttribute("msg", "This complaint already in resolved state.. you can't delete");
                    }else {
                        int result = employeeDao.deleteComplains(complainId);

                        if (result > 0) {
                            req.getSession().setAttribute("complaintMessage", "success");
                            req.getSession().setAttribute("complaintMessageText", "Complaint Deleted Successfully!");
                        } else {
                            req.getSession().setAttribute("complaintMessage", "error");
                            req.getSession().setAttribute("complaintMessageText", "Failed to Delete Complain.Please try again.");
                        }
                    }
            }

            resp.sendRedirect(req.getContextPath() + "/employee");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doGet triggered...");


        String userId = (String) req.getSession().getAttribute("user_id");
        if (userId == null || userId.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int uId;

        try {
            uId = Integer.parseInt(userId);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            List<AdminEmployeeModel> complains = new EmployeeDao(dataSource).getAllComplains(uId);
            req.setAttribute("complains", complains);

            EmployeeDao employeeDao = new EmployeeDao(dataSource);

            int totalComplaints = complains.size();
            int pendingCount = employeeDao.getCountByStatus(uId, "Pending");
            int inProgressCount = employeeDao.getCountByStatus(uId, "In_Progress");
            int resolvedCount = employeeDao.getCountByStatus(uId, "Resolved");

            req.setAttribute("totalComplaints", totalComplaints);
            req.setAttribute("pendingComplaints", pendingCount);
            req.setAttribute("progressComplaints", inProgressCount);
            req.setAttribute("resolvedComplaints", resolvedCount);

            req.getRequestDispatcher("/View/EmployeeDashboard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
