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
import model.ProductImage;
import model.image;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author Asus
 */
public class ProductImageDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public ProductImage getProductDetails(String productId) {
        String sql = "SELECT p.*, i.image_url as additional_image_url "
                + "FROM products p "
                + "LEFT JOIN images i ON p.product_id = i.product_id "
                + "WHERE p.product_id = ?";

        ProductImage productDetails = null;
        List<String> imageUrls = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, productId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                boolean isFirstRow = true;

                while (resultSet.next()) {
                    if (isFirstRow) {
                        productDetails = new ProductImage(
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
// Trong lớp ProductDAO

public List<image> getAdditionalImages(String productId) {
    List<image> additionalImages = new ArrayList<>();
    String sql = "SELECT * FROM images WHERE product_id = ?";
    try (Connection connection = DBConnection.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

        preparedStatement.setString(1, productId);
        ResultSet rs = preparedStatement.executeQuery();

        while (rs.next()) {
            image img = new image(
                rs.getInt("image_id"),
                rs.getInt("product_id"),
                rs.getString("image_url")
            );
            additionalImages.add(img);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return additionalImages;
}


    private String convertImageToBase64(InputStream inputStream) throws IOException {
        byte[] imageBytes = IOUtils.toByteArray(inputStream);
        return Base64.getEncoder().encodeToString(imageBytes);
    }

}
