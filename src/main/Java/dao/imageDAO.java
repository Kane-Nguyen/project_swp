package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.image;

public class imageDAO {

    private Connection connection;

    public List<image> getImgList() throws SQLException {
        List<image> list = new ArrayList<>();
        String sql = "SELECT * FROM images";
        try (Connection connection = DBConnection.getConnection(); Statement statement = connection.createStatement(); ResultSet rs = statement.executeQuery(sql)) {

            while (rs.next()) {
                image img = new image(rs.getInt("image_id"), rs.getInt("product_id"), rs.getString("image_url"));
                list.add(img);
            }
        }
        return list;
    }

    public void addImage(image img) throws SQLException {
        String sql = "INSERT INTO images (product_id, image_url) VALUES (?, ?)";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, img.getProduct_id());
            preparedStatement.setString(2, img.getImage_url());
            preparedStatement.executeUpdate();
        }
    }

    public void deleteImage(String productId) throws SQLException {
        String sql = "DELETE FROM images WHERE product_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, productId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // Handle exception
            throw e;
        }
    }

    public void DeleteImageSlider(String imageId) throws SQLException {
        String sql = "DELETE FROM images WHERE image_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, imageId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // Handle exception
            throw e;
        }
    }

    public void updateImage(image img) throws SQLException {
        String sql = "UPDATE images SET product_id = ?, image_url = ? WHERE image_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, img.getProduct_id());
            preparedStatement.setString(2, img.getImage_url());
            preparedStatement.setInt(3, img.getImage_id());
            preparedStatement.executeUpdate();
        }
    }

    public int getImageCountByProductId(int productId) throws SQLException {
        String sql = "SELECT COUNT(*) AS imageCount FROM images WHERE product_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, productId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("imageCount");
                }
            }
        }
        return 0; // Trả về 0 nếu không có ảnh nào hoặc có lỗi xảy ra
    }

    public image getImageById(int id) throws SQLException {
        String sql = "SELECT * FROM images WHERE image_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new image(
                            resultSet.getInt("image_id"),
                            resultSet.getInt("product_id"),
                            resultSet.getString("image_url")
                    );
                }
            }
        }
        return null; // Or handle appropriately if no image is found
    }

    public List<image> getUniqueProductImages() throws SQLException {
        List<image> list = new ArrayList<>();
        // Câu truy vấn để lấy ảnh đầu tiên cho mỗi product_id
        String sql = "SELECT * FROM images WHERE image_id IN (SELECT MIN(image_id) FROM images GROUP BY product_id)";
        try (Connection connection = DBConnection.getConnection(); Statement statement = connection.createStatement(); ResultSet rs = statement.executeQuery(sql)) {

            while (rs.next()) {
                image img = new image(rs.getInt("image_id"), rs.getInt("product_id"), rs.getString("image_url"));
                list.add(img);
            }
        }
        return list;
    }

    public void deleteMultipleImages(List<Integer> imageIds) throws SQLException {
        String sql = "DELETE FROM images WHERE image_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            for (int imageId : imageIds) {
                preparedStatement.setInt(1, imageId);
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch();
        }
    }

    public void deleteImageById(int imageId) throws SQLException {
        String sql = "DELETE FROM images WHERE image_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, imageId);
            preparedStatement.executeUpdate();
        }
    }

}
