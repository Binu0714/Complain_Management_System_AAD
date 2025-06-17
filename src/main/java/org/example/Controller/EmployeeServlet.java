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
                    System.out.println("complain added successfully");
                    resp.sendRedirect(req.getContextPath() + "/View/EmployeeDashboard.jsp");
                } else {
                    System.out.println("fail to add complains");
                    resp.sendRedirect(req.getContextPath() + "/View/EmployeeDashboard.jsp?error=true");
                }


            }else if ("update_complains".equals(action)){

            } else if ("delete_complains".equals(action)) {

            }
        }catch (SQLException e){
            throw new ServletException(e);
        }
    }
}
