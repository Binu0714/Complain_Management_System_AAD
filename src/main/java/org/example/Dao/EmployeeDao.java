package org.example.Dao;

import org.example.Model.AdminEmployeeModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    public List<AdminEmployeeModel> getAllComplains(int user_id) throws SQLException {
        List<AdminEmployeeModel> complains = new ArrayList<>();

        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM complaints WHERE user_id = ?")) {

            preparedStatement.setInt(1, user_id);
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
                System.out.println("Session user_id: " + user_id);
                System.out.println("Found complaint: " + complain.getComplain_id());

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return complains;
    }

    public int updateComplains(AdminEmployeeModel adminEmployeeModel) throws SQLException {
        try(Connection connection = dataSource.getConnection();) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE complaints SET title = ?, description = ? WHERE complaint_id = ?");
            preparedStatement.setString(1, adminEmployeeModel.getTitle());
            preparedStatement.setString(2, adminEmployeeModel.getDescription());
            preparedStatement.setInt(3, adminEmployeeModel.getComplain_id());
            int result = preparedStatement.executeUpdate();
            return result;
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean checkStatus(int complain_id) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT status FROM complaints WHERE complaint_id = ?")){
            preparedStatement.setInt(1, complain_id);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String status = resultSet.getString("status");
                return status.equals("RESOLVED");
            }
            return false;

        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
