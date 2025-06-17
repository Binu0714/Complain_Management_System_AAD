package org.example.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.Dao.UserDao;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/signin")
public class SignInServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            ResultSet resultSet = new UserDao(this.dataSource).signIn(username, password);

            if (resultSet.next()) {
                String user_id = resultSet.getString("user_id");

                HttpSession httpSession = req.getSession();
                httpSession.setAttribute("user_id", user_id);

                String role  = resultSet.getString("role");
                req.getSession().setAttribute("username", username);

                if ("ADMIN".equals(role)) {
                    System.out.println("admin page");
                    resp.sendRedirect(req.getContextPath() + "/admin");
                } else {
                    System.out.println("employee page");
                    resp.sendRedirect(req.getContextPath() + "/employee");
                }

            }else {
                req.getRequestDispatcher("View/signIn.jsp?error=true").forward(req, resp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            req.getRequestDispatcher("View/signIn.jsp?error=true").forward(req, resp);
        }
    }
}
