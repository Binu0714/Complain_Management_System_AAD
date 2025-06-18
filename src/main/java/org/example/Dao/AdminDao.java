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

    public int updateComplains(AdminEmployeeModel adminEmployeeModel) throws SQLException {
        try (Connection connection = dataSource.getConnection()){
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE complaints SET user_id = ?, title = ?, description = ?, status = ?, created_at = ?, remark = ? WHERE complaint_id = ?");

            preparedStatement.setInt(1, adminEmployeeModel.getUser_id());
            preparedStatement.setString(2, adminEmployeeModel.getTitle());
            preparedStatement.setString(3, adminEmployeeModel.getDescription());
            preparedStatement.setString(4, adminEmployeeModel.getStatus());
            preparedStatement.setString(5, adminEmployeeModel.getCreated_at());
            preparedStatement.setString(6, adminEmployeeModel.getRemark());
            preparedStatement.setInt(7, adminEmployeeModel.getComplain_id());

            int result = preparedStatement.executeUpdate();
            return result;
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
