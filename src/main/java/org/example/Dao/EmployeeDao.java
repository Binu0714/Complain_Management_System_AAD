package org.example.Dao;

import org.example.Model.AdminEmployeeModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EmployeeDao {
    private DataSource dataSource;

    public EmployeeDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public int saveComplains(AdminEmployeeModel adminEmployeeModel) throws SQLException {
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO complaints (user_id,title,description) VALUES (?, ?, ?)");
        preparedStatement.setInt(1, adminEmployeeModel.getUser_id());
        preparedStatement.setString(2, adminEmployeeModel.getTitle());
        preparedStatement.setString(3, adminEmployeeModel.getDescription());
        int result = preparedStatement.executeUpdate();

        if (result > 0) {
            return 1;
        } else {
            return 0;
        }
    }


}
