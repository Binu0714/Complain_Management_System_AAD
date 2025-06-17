package org.example.Dao;

import org.example.Model.AdminEmployeeModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {
    private DataSource dataSource;

    public AdminDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public List<AdminEmployeeModel> getAllComplains() throws SQLException {
        List<AdminEmployeeModel> complains = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()){
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM complaints");
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                AdminEmployeeModel complain = new AdminEmployeeModel();
                complain.setComplain_id(resultSet.getInt("complaint_id"));
                complain.setUser_id(resultSet.getInt("user_id"));
                complain.setTitle(resultSet.getString("title"));
                complain.setDescription(resultSet.getString("description"));
                complain.setStatus(resultSet.getString("status"));
                complain.setCreated_at(resultSet.getString("created_at"));
                complain.setUpdated_at(resultSet.getString("updated_at"));
                complain.setRemark(resultSet.getString("remark"));

                complains.add(complain);
            }
        }
        return complains;
    }

}
