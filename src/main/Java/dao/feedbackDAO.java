/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;


public class feedbackDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public List<Feedback> selectFeedbacksByProduct(int productId) throws SQLException {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * FROM feedbacks WHERE product_id = ?";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            ResultSet resultSet = st.executeQuery();

            while (resultSet.next()) {
                int feedbackId = resultSet.getInt("feedback_id");
                int userId = resultSet.getInt("user_id");
                String comments = resultSet.getString("comments");
                int rating = resultSet.getInt("rating");
                Date datePosted = resultSet.getDate("date_posted");

                // Tạo đối tượng Feedback và thêm vào danh sách
                Feedback feedback = new Feedback(feedbackId, userId, productId, comments, rating, datePosted);
                feedbackList.add(feedback);
            }

            resultSet.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        } finally {
            connection.close();
        }

        return feedbackList;
    }
    

    public boolean insertFeedback(int userId, int productId, String comments, int rating) throws SQLException {
        boolean feedbackInserted = false;
        String sql = "INSERT INTO feedbacks (user_id, product_id, comments, rating, date_posted) VALUES (?, ?, ?, ?, NOW())";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, productId);
            st.setString(3, comments);
            st.setInt(4, rating);
            feedbackInserted = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
        return feedbackInserted;
    }

    public static void main(String[] args) throws SQLException {
        feedbackDAO fd = new feedbackDAO();
        List<Feedback> f = fd.selectFeedbacksByProduct(3);
        for (Feedback feedback : f) {
            System.out.println(feedback.getUserId());
        }
    }
}
