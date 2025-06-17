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

            if (userId == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            int uId = Integer.parseInt(userId);

            if ("add_complains".equals(action)) {
                String title = req.getParameter("complaintTitle");
                String description = req.getParameter("complaintDescription");

                AdminEmployeeModel adminEmployeeModel = new AdminEmployeeModel();
                adminEmployeeModel.setTitle(title);
                adminEmployeeModel.setDescription(description);
                adminEmployeeModel.setUser_id(uId);

                int result = employeeDao.saveComplains(adminEmployeeModel);

                if (result > 0) {
                    System.out.println("Complaint added successfully");
                } else {
                    System.out.println("Failed to add complaint");
                }

            } else if ("update_complains".equals(action)) {


            } else if ("delete_complains".equals(action)) {

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
        if (userId == null) {
            System.out.println("User id is null in session! Redirecting to login.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int uId = Integer.parseInt(userId);

        try {
            List<AdminEmployeeModel> complains = new EmployeeDao(dataSource).getAllComplains(uId);
            req.setAttribute("complains", complains);

            req.getRequestDispatcher("/View/EmployeeDashboard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
