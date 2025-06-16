package org.example.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.Dao.UserDao;
import org.example.Model.UserModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/signUp")
public class SignUpServlet  extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String username = req.getParameter("username");
            System.out.println("username : "+username);
            String password = req.getParameter("password");
            System.out.println("password : "+password);
            String role = req.getParameter("role");
            System.out.println("role : "+role);
            String full_name = req.getParameter("full_name");
            System.out.println("name : "+full_name);

            UserModel userModel = new UserModel();
            userModel.setUsername(username);
            userModel.setPassword(password);
            userModel.setRole(role);
            userModel.setFull_name(full_name);

            int result =new UserDao(this.dataSource).signUp(userModel);

            if (result > 0) {
                req.getRequestDispatcher("View/signIn.jsp?success=true").forward(req, resp);
            } else {
                req.getRequestDispatcher("View/signUp.jsp?error=true").forward(req, resp);
            }

        }catch (SQLException e){
            e.printStackTrace();
            req.getRequestDispatcher("View/signUp.jsp?error=true").forward(req, resp);
        }
    }
}
