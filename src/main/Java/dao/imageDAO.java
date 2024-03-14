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

    public List<image> getImgList(int productId) {
        List<image> list = new ArrayList<>();
        // Modify your SQL query to filter by product_id
        String sql = "SELECT * FROM images WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // Set the product_id parameter in the query
            preparedStatement.setInt(1, productId);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    image img = new image(rs.getInt("image_id"), rs.getInt("product_id"), rs.getString("image_url"));
                    list.add(img);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
            // Consider handling the exception more gracefully depending on your application's requirements
        }
        return list;
    }

    public String getImageUrlById(int imageId) throws SQLException {
        String imageUrl = null; // Giữ URL của hình ảnh, ban đầu là null
        String sql = "SELECT image_url FROM images WHERE product_id = ?"; // Câu lệnh SQL với điều kiện

        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, imageId); // Thiết lập giá trị cho tham số trong câu lệnh SQL
            ResultSet rs = preparedStatement.executeQuery(); // Thực thi câu lệnh và nhận kết quả

            if (rs.next()) {
                imageUrl = rs.getString("image_url"); // Lấy URL hình ảnh
            }
        }
        return imageUrl; // Trả về URL, hoặc null nếu không tìm thấy
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
        // Giả sử img chứa image_id, product_id, và image_url (đã được convert thành base64)
        String sql = "UPDATE images SET image_url = ?, product_id = ? WHERE image_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, img.getImage_url());
            preparedStatement.setInt(2, img.getProduct_id());
            preparedStatement.setInt(3, img.getImage_id());

            preparedStatement.executeUpdate();
        }
    }
    
    public void updateLogo(image img) throws SQLException {
        // Giả sử img chứa image_id, product_id, và image_url (đã được convert thành base64)
        String sql = "UPDATE images SET image_url = ?, product_id = ? WHERE product_id = 2";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, img.getImage_url());
            preparedStatement.setInt(2, img.getProduct_id());

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
    public image getImageByProductId(int id) throws SQLException {
        String sql = "SELECT * FROM images WHERE product_id = ?";
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
        String sql = "DELETE FROM images WHERE product_id = ?";
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

    public static void main(String[] args) throws SQLException {
        imageDAO u = new imageDAO();
        image sao = u.getImageById(2);
        System.out.println(sao.getProduct_id());
    }

}