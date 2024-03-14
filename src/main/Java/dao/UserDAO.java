package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import model.User;

public class UserDAO {

    // Method to retrieve all users from the database
    public List<User> getAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement statement = conn.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                User user = new User(
                        resultSet.getInt("user_id"),
                        resultSet.getString("full_name"),
                        resultSet.getDate("birth_date"),
                        resultSet.getString("phone_number"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("address"),
                        resultSet.getDate("Date_Added"), // Use getTimestamp for DATETIME type
                        resultSet.getString("user_role")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error occurred during the getAll operation: " + e.getMessage());
        }

        return users;
    }

    public boolean comparePassword(String email, String oldpassword) {
        String password = null;
        String sql = "SELECT password FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement statement = conn.prepareStatement(sql);) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    password = resultSet.getString("password");
                    System.out.println("p "+ password);
                    System.out.println("oldp "+ oldpassword);
                    if(password.equals(oldpassword)){
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
          
        }

        return false;
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement statement = conn.prepareStatement(sql);) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    user = new User(
                            resultSet.getInt("user_id"),
                            resultSet.getString("full_name"),
                            resultSet.getDate("birth_date"),
                            resultSet.getString("phone_number"),
                            resultSet.getString("email"),
                            resultSet.getString("password"),
                            resultSet.getString("address"),
                            resultSet.getDate("Date_Added"),
                            resultSet.getString("user_role")
                    );
                }
            }
        } catch (SQLException e) {
            // Handle exceptions properly in your application

        }

        return user;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET full_name = ?, birth_date = ?, phone_number = ?, email = ?, address = ? , password=? WHERE user_id = ?;";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement statement = conn.prepareStatement(sql);) {
            statement.setString(1, user.getFullName());
            statement.setDate(2, user.getBirthDate());
            statement.setString(3, user.getPhoneNumber());
            statement.setString(4, user.getEmail());
            statement.setString(5, user.getAddress());
            statement.setString(6, user.getPassword());
            statement.setInt(7, user.getUserId());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Error occurred during the update User operation: " + e.getMessage());
            return false;
        }

    }

    public boolean editInfo(User user, String email) {
        String sql = "UPDATE Users SET full_name = ?, birth_date = ?, phone_number = ?, address = ? WHERE email = ?;";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement statement = conn.prepareStatement(sql);) {
            statement.setString(1, user.getFullName());
            statement.setDate(2, user.getBirthDate());
            statement.setString(3, user.getPhoneNumber());
            statement.setString(4, user.getAddress());
            statement.setString(5, email);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Error occurred during the update User operation: " + e.getMessage());
            return false;
        }

    }

    public boolean deleteUser(int userId) {
        try (Connection conn = DBConnection.getConnection()) {
            deleteFromTable(conn, "cart", "user_id", userId);
            deleteFromTable(conn, "replycomments", "user_id", userId);
            deleteFromTable(conn, "feedbacks", "user_id", userId);
            deleteFromTable(conn, "orders", "user_id", userId);
            deleteFromTable(conn, "users", "user_id", userId);

            return true;
        } catch (SQLException e) {
            System.err.println("Error occurred during the delete user operation: " + e.getMessage());
            return false;
        }
    }

    private void deleteFromTable(Connection conn, String tableName, String columnName, int value) throws SQLException {
        String deleteSQL = "DELETE FROM " + tableName + " WHERE " + columnName + " = ?";
        try (PreparedStatement deleteStatement = conn.prepareStatement(deleteSQL)) {
            deleteStatement.setInt(1, value);
            deleteStatement.executeUpdate();
        }
    }

    public boolean insertUser(User user) {
        String sql = "INSERT INTO Users (full_name, birth_date,  phone_number, email, password,  address, user_role) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement statement = conn.prepareStatement(sql);) {
            statement.setString(1, user.getFullName());
            statement.setDate(2, user.getBirthDate());
            statement.setString(3, user.getPhoneNumber());
            statement.setString(4, user.getEmail());
            statement.setString(5, user.getPassword());
            statement.setString(6, user.getAddress());
            statement.setString(7, user.getUserRole());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Error occurred during the getAll operation: " + e.getMessage());
            return false;
        }

    }

    public boolean emailExists(String email) {
        String sql = "SELECT 1 FROM Users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement statement = conn.prepareStatement(sql);) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                // If resultSet has an entry, it means the email exists in the database
                return resultSet.next();
            }
        } catch (SQLException e) {
            // Handle exceptions properly in your application
            e.printStackTrace();
        }
        // Return false if the email does not exist or an exception occurs
        return false;
    }

    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE Users SET password = ? WHERE email = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, newPassword);
            statement.setString(2, email);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {

            e.printStackTrace();
        }

        return false;
    }

    public static void main(String[] args) {
        UserDAO u = new UserDAO();
        List<User> t = u.getAll();
        for (int i = 0; i < t.size(); i++) {
            System.out.println(t.get(i).getUserId());
        }
    }
}