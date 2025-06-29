package org.example.Model;

public class UserModel {
    private String username;
    private String password;
    private String full_name;
    private String role;

    public UserModel(String username, String password, String full_name, String role) {
        this.username = username;
        this.password = password;
        this.full_name = full_name;
        this.role = role;
    }

    public UserModel(){

    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
