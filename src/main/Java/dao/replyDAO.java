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
import model.Reply;

/**
 *
 * @author THANHVINH
 */
public class replyDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public String insertComment(int feedbackId, int userId, String replyText) {
        String sql = "INSERT INTO replycomments (feedback_id, user_id, reply_text, date_replied) VALUES (?, ?, ?, NOW())";
        String text = "";
        try {
            connection = DBConnection.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, feedbackId);
            preparedStatement.setInt(2, userId);
            preparedStatement.setString(3, replyText);

            preparedStatement.executeUpdate();
            text = "Comment inserted successfully!";

        } catch (SQLException e) {
            System.out.println("false");
        }
        return text;
    }

    public List<Reply> selectRepliesByFeedback(int feedbackId) throws SQLException {
        List<Reply> replyList = new ArrayList<>();
        String sql = "SELECT * FROM replycomments WHERE feedback_id = ?";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, feedbackId);
            ResultSet resultSet = st.executeQuery();

            while (resultSet.next()) {
                int replyId = resultSet.getInt("reply_id");
                int userId = resultSet.getInt("user_id");
                String replyText = resultSet.getString("reply_text");
                Date dateReplied = resultSet.getDate("date_replied");

                // Tạo đối tượng Reply và thêm vào danh sách
                Reply reply = new Reply(replyId, feedbackId, userId, replyText, dateReplied);
                replyList.add(reply);
            }

            resultSet.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        } finally {
            connection.close();
        }

        return replyList;
    }

    public List<Reply> getALL() throws SQLException {
        List<Reply> replyList = new ArrayList<>();
        String sql = "SELECT * FROM replycomments";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet resultSet = st.executeQuery();

            while (resultSet.next()) {
                int replyId = resultSet.getInt("reply_id");
                int feedback_id = resultSet.getInt("feedback_id");
                int userId = resultSet.getInt("user_id");
                String replyText = resultSet.getString("reply_text");
                Date dateReplied = resultSet.getDate("date_replied");

                // Tạo đối tượng Reply và thêm vào danh sách
                Reply reply = new Reply(replyId, feedback_id, userId, replyText, dateReplied);
                replyList.add(reply);
            }

            resultSet.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        } finally {
            connection.close();
        }

        return replyList;
    }

    public List<Reply> selectRepliesByUser(int userId) throws SQLException {
        List<Reply> replyList = new ArrayList<>();
        String sql = "SELECT name FROM replycomments WHERE user_id = ?";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet resultSet = st.executeQuery();

            while (resultSet.next()) {
                int replyId = resultSet.getInt("reply_id");
                int feedbackId = resultSet.getInt("feedback_id");
                String replyText = resultSet.getString("reply_text");
                Date dateReplied = resultSet.getDate("date_replied");

                // Tạo đối tượng Reply và thêm vào danh sách
                Reply reply = new Reply(replyId, feedbackId, userId, replyText, dateReplied);
                replyList.add(reply);
            }

            resultSet.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        } finally {
            connection.close();
        }

        return replyList;
    }

    public static void main(String[] args) throws SQLException {
        replyDAO rd = new replyDAO();
        feedbackDAO fd = new feedbackDAO();
        List<Feedback> f = fd.selectFeedbacksByProduct(4);

        for (int i = 0; i < f.size(); i++) {
            List<Reply> r = rd.selectRepliesByFeedback(f.get(i).getFeedbackId());
            System.out.println("nguoi viet: " + f.get(i).getComments());
            if (!r.isEmpty()) {
                for (int j = 0; j < r.size(); j++) {
                    System.out.println("admin rep: " + r.get(j).getReplyText());
                }
            }

        }
    }

}
