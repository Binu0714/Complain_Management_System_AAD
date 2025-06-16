package org.example.Dao;

import org.example.Model.UserModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    private DataSource dataSource;

    public UserDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public ResultSet signIn(String username, String password) throws SQLException {
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);
        ResultSet resultSet = preparedStatement.executeQuery();

        return resultSet;
    }

    public int signUp(UserModel userModel) throws SQLException {
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO users (username, password, role, full_name) VALUES (?, ?, ?, ?)");
        preparedStatement.setString(1, userModel.getUsername());
        preparedStatement.setString(2, userModel.getPassword());
        preparedStatement.setString(3, userModel.getRole());
        preparedStatement.setString(4, userModel.getFull_name());
        int result = preparedStatement.executeUpdate();

        if (result > 0) {
            return 1;
        } else {
            return 0;
        }
    }
}
