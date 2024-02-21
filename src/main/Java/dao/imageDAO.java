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

    private Connection connection; // Ensure appropriate resource management with try-with-resources

    public List<image> getImgList() throws SQLException {
        String sql = "SELECT * FROM images";
        List<image> list = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection(); Statement statement = connection.createStatement(); ResultSet rs = statement.executeQuery(sql)) {
            while (rs.next()) {
                image img = new image(rs.getInt("image_id"), rs.getString("product_id"), rs.getString("image_url"));
                list.add(img);
            }
        } catch (SQLException e) {
            // Handle exception appropriately (log errors, rethrow or handle in the calling method)
            throw e;
        }
        return list;
    }

    public void addImage(image img) throws SQLException {
        String sql = "INSERT INTO images (product_id, image_url) VALUES (?, ?)";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, img.getProduct_id());
            preparedStatement.setString(2, img.getImage_url());
            preparedStatement.executeUpdate();
            System.out.println("Added Image: Product ID - " + img.getProduct_id());
        } catch (SQLException e) {
            // Handle exception appropriately (log errors, rethrow or handle in the calling method)
            throw e;
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

    // Example usage and handling potential exceptions
    public static void main(String[] args) {
        try {
            imageDAO dao = new imageDAO();
            List<image> newImages = new ArrayList<>();
            // ... (add images with validated product IDs and appropriate URLs/paths)

            for (image img : newImages) {
                dao.addImage(img);
            }
        } catch (SQLException e) {
            // Handle exceptions gracefully (log errors, provide informative messages)
            System.err.println("Error: " + e.getMessage());
        }
    }
}
