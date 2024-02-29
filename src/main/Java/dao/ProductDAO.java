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
import model.Product;
import model.image;

/**
 *
 * @author Lenovo
 */
public class ProductDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products";
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getString("product_id"),
                        rs.getString("product_name"),
                        rs.getDouble("product_price"),
                        rs.getString("image_url"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id"),
                        rs.getString("product_branch"), // Corrected column name
                        rs.getDate("date_added")); // Corrected column name
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close connection inside finally block
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public int createProduct(String productName, double productPrice, String imageUrl, int stockQuantity, int categoryId, String productBranch) {
        String sql = "INSERT INTO products (product_name, product_price, image_url, stock_quantity, category_id, product_branch) VALUES (?, ?, ?, ?, ?, ?)";
        int productId = -1;

        try (Connection connection = DBConnection.getConnection(); PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1, productName);
            st.setDouble(2, productPrice);
            st.setString(3, imageUrl);
            st.setInt(4, stockQuantity);
            st.setInt(5, categoryId);
            st.setString(6, productBranch);

            int affectedRows = st.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = st.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        productId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productId;
    }

    public boolean editProduct(String productId, String productName, double productPrice, String imageUrl, int stockQuantity, int categoryId, String productBranch) {
        // Ensure the category exists, or create it

        // SQL statement for updating the product
        String sql = "UPDATE products SET product_name = ?, product_price = ?, image_url = ?, stock_quantity = ?, category_id = ?, product_branch = ? WHERE product_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productName);
            st.setDouble(2, productPrice);
            st.setString(3, imageUrl);
            st.setInt(4, stockQuantity);
            st.setInt(5, categoryId);
            st.setString(6, productBranch);
            st.setString(7, productId);

            int affectedRows = st.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
// Trong lớp ProductDAO
    public List<image> getAdditionalImages(String productId) {
        List<image> additionalImages = new ArrayList<>();
        String sql = "SELECT * FROM images WHERE product_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

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

    public Product getProductById(String productId) {
        Product product = null;
        String sql = "SELECT * FROM products WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, productId);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                product = new Product();
                product.setProduct_id(resultSet.getString("product_id"));
                product.setProduct_name(resultSet.getString("product_name"));
                product.setProduct_price(resultSet.getDouble("product_price"));
                product.setImage_url(resultSet.getString("image_url"));
                product.setStock_quantity(resultSet.getInt("stock_quantity"));
                product.setCategory_id(resultSet.getInt("category_id"));
                product.setProduct_branch(resultSet.getString("product_branch"));
                // Assuming you have a date_added field in your table
                product.setDateAdded(resultSet.getDate("date_added"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    // Delete a product
    public boolean deleteProduct(String productId) {
        // These tables have foreign key references to the products table
        String deleteFromReplyCommentsSql = "DELETE FROM replycomments WHERE feedback_id IN (SELECT feedback_id FROM feedbacks WHERE product_id = ?)";
        String deleteFromCartSql = "DELETE FROM cart WHERE product_id = ?";
        String deleteFromImagesSql = "DELETE FROM images WHERE product_id = ?";
        String deleteFromProductDescriptionSql = "DELETE FROM productdescription WHERE product_id = ?";
        String deleteFromInventoryTransactionsSql = "DELETE FROM inventory_transactions WHERE product_id = ?";
        String deleteFromFeedbacksSql = "DELETE FROM feedbacks WHERE product_id = ?";
        String deleteFromProductsSql = "DELETE FROM products WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection()) {
            // Disable auto-commit to start the transaction
            connection.setAutoCommit(false);

            // Delete from dependent tables first, starting with the ones that have a foreign key reference
            deleteFromTable(connection, deleteFromReplyCommentsSql, productId);  // Delete any related reply comments
            deleteFromTable(connection, deleteFromCartSql, productId);
            deleteFromTable(connection, deleteFromImagesSql, productId);
            deleteFromTable(connection, deleteFromProductDescriptionSql, productId);
            deleteFromTable(connection, deleteFromInventoryTransactionsSql, productId);
            deleteFromTable(connection, deleteFromFeedbacksSql, productId);

            // Finally, delete from the products table
            deleteFromTable(connection, deleteFromProductsSql, productId);

            // Commit the transaction
            connection.commit();

            return true;
        } catch (SQLException e) {
            // If there is an exception, try to rollback the transaction
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        }
    }

    private void deleteFromTable(Connection connection, String sql, String productId) throws SQLException {
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            st.executeUpdate();
        }
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE product_name LIKE ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, "%" + keyword + "%");
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getString("product_id"),
                        rs.getString("product_name"),
                        rs.getDouble("product_price"),
                        rs.getString("image_url"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id"),
                        rs.getString("product_branch"),
                        rs.getDate("date_added"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean productExists(String productId) {
        String sql = "SELECT COUNT(*) FROM products WHERE product_id = ?";
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, productId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int count = resultSet.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        ProductDAO p = new ProductDAO();
        List<Product> lp = p.getAll();
        System.out.println(lp.get(0).getProduct_branch());
        p.createProduct("Iphone", 9, "ok", 7, 6, "Samsusng");
    }

}
