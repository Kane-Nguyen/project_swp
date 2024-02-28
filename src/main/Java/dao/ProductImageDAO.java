/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import model.ProductDetails;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author Asus
 */
public class ProductImageDAO {
    private Connection connection;
    private Statement statement;
    private ResultSet rs;
    
    public ProductDetails getProductDetails(String productId) {
        String sql = "SELECT p.*, i.image_url as additional_image_url " +
                     "FROM products p " +
                     "LEFT JOIN images i ON p.product_id = i.product_id " +
                     "WHERE p.product_id = ?";

        ProductDetails productDetails = null;
        List<String> imageUrls = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection(); 
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, productId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                boolean isFirstRow = true;

                while (resultSet.next()) {
                    if (isFirstRow) {
                        productDetails = new ProductDetails(
                            resultSet.getString("product_id"),
                            resultSet.getString("product_name"),
                            resultSet.getDouble("product_price"),
                            resultSet.getString("image_url"),
                            resultSet.getInt("stock_quantity"),
                            resultSet.getInt("category_id"),
                            resultSet.getString("product_branch"),
                            resultSet.getDate("date_added")
                        );
                        isFirstRow = false;
                    }
                    String additionalImageUrl = resultSet.getString("additional_image_url");
                    if (additionalImageUrl != null && !imageUrls.contains(additionalImageUrl)) {
                        imageUrls.add(additionalImageUrl);
                    }
                }

                if (productDetails != null) {
                    productDetails.setAdditionalImageUrls(imageUrls);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }
        return productDetails;
    }
     public boolean editProduct(ProductDetails productDetails, Part newMainImage, List<Part> newAdditionalImages, List<String> imagesToDelete) throws IOException, SQLException {
        boolean isUpdated = false;
        Connection connection = null;
        PreparedStatement productUpdateStmt = null;
        PreparedStatement imageUpdateStmt = null;

        try {
            connection = DBConnection.getConnection();
            connection.setAutoCommit(false);

            // Update Product Information
            String updateProductSql = "UPDATE products SET product_name = ?, product_price = ?, stock_quantity = ?, category_id = ?, product_branch = ? WHERE product_id = ?";
            productUpdateStmt = connection.prepareStatement(updateProductSql);
            productUpdateStmt.setString(1, productDetails.getProduct_name());
            productUpdateStmt.setDouble(2, productDetails.getProduct_price());
            productUpdateStmt.setInt(3, productDetails.getStock_quantity());
            productUpdateStmt.setInt(4, productDetails.getCategory_id());
            productUpdateStmt.setString(5, productDetails.getProduct_branch());
            productUpdateStmt.setString(6, productDetails.getProduct_id());
            productUpdateStmt.executeUpdate();

            // Update Main Image if provided
            if (newMainImage != null) {
                String mainImageBase64 = convertImageToBase64(newMainImage.getInputStream());
                String updateMainImageSql = "UPDATE products SET image_url = ? WHERE product_id = ?";
                productUpdateStmt = connection.prepareStatement(updateMainImageSql);
                productUpdateStmt.setString(1, mainImageBase64);
                productUpdateStmt.setString(2, productDetails.getProduct_id());
                productUpdateStmt.executeUpdate();
            }

            // Update Additional Images
            if (!newAdditionalImages.isEmpty()) {
                String updateAdditionalImageSql = "INSERT INTO images (product_id, image_url) VALUES (?, ?)";
                imageUpdateStmt = connection.prepareStatement(updateAdditionalImageSql);
                for (Part imagePart : newAdditionalImages) {
                    String imageBase64 = convertImageToBase64(imagePart.getInputStream());
                    imageUpdateStmt.setString(1, productDetails.getProduct_id());
                    imageUpdateStmt.setString(2, imageBase64);
                    imageUpdateStmt.addBatch();
                }
                imageUpdateStmt.executeBatch();
            }

            // Delete specified additional images
            if (!imagesToDelete.isEmpty()) {
                String deleteImageSql = "DELETE FROM images WHERE image_url = ?";
                PreparedStatement deleteStmt = connection.prepareStatement(deleteImageSql);
                for (String imageUrl : imagesToDelete) {
                    deleteStmt.setString(1, imageUrl);
                    deleteStmt.addBatch();
                }
                deleteStmt.executeBatch();
            }

            connection.commit();
            isUpdated = true;
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            // Handle exceptions
        } finally {
            try {
                if (productUpdateStmt != null) productUpdateStmt.close();
                if (imageUpdateStmt != null) imageUpdateStmt.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return isUpdated;
    }

    private String convertImageToBase64(InputStream inputStream) throws IOException {
        byte[] imageBytes = IOUtils.toByteArray(inputStream);
        return Base64.getEncoder().encodeToString(imageBytes);
    }
    

}
