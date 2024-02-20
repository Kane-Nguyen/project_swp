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
import model.Products;

/**
 *
 * @author Lenovo
 */
public class ProductsDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public List<Products> getAll() {
        List<Products> list = new ArrayList<>();
        String sql = "select * from products";
        try {
            connection = MysqlConnect.getConnection();
            PreparedStatement st = connection.prepareStatement(sql); // Use PreparedStatement instead of Statement
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products(
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

    public boolean createProduct(String productId, String productName, double productPrice, String imageUrl, int stockQuantity, int categoryId, String productBranch) {
        String sql = "INSERT INTO products (product_id, product_name, product_price, image_url, stock_quantity, category_id, product_branch) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = MysqlConnect.getConnection(); PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            st.setString(2, productName);
            st.setDouble(3, productPrice);
            st.setString(4, imageUrl);
            st.setInt(5, stockQuantity);
            st.setInt(6, categoryId);
            st.setString(7, productBranch);

            int affectedRows = st.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean editProduct(String productId, String productName, double productPrice, String imageUrl, int stockQuantity, int categoryId, String productBranch) {
        String sql = "UPDATE products SET product_name = ?, product_price = ?, image_url = ?, stock_quantity = ?, category_id = ?, product_branch = ? WHERE product_id = ?";
        try (Connection connection = MysqlConnect.getConnection(); PreparedStatement st = connection.prepareStatement(sql)) {
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

    public Products getProductById(String productId) {
        Products product = null;
        String sql = "SELECT * FROM products WHERE product_id = ?";

        try (Connection connection = MysqlConnect.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, productId);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                product = new Products();
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
        String deleteFromCartSql = "DELETE FROM cart WHERE product_id = ?";
        String deleteFromImagesSql = "DELETE FROM images WHERE product_id = ?";
        String deleteFromProductDescriptionSql = "DELETE FROM productdescription WHERE product_id = ?";
        String deleteFromInventoryTransactionsSql = "DELETE FROM inventory_transactions WHERE product_id = ?";
        String deleteFromFeedbacksSql = "DELETE FROM feedbacks WHERE product_id = ?";
        String deleteFromProductsSql = "DELETE FROM products WHERE product_id = ?";

        try (Connection connection = MysqlConnect.getConnection()) {
            // Disable auto-commit to start the transaction
            connection.setAutoCommit(false);

            // Delete from dependent tables first
            deleteFromTable(connection, deleteFromCartSql, productId);
            deleteFromTable(connection, deleteFromImagesSql, productId);
            deleteFromTable(connection, deleteFromProductDescriptionSql, productId);
            deleteFromTable(connection, deleteFromInventoryTransactionsSql, productId);
            deleteFromTable(connection, deleteFromFeedbacksSql, productId);

            // Finally, delete from products table
            deleteFromTable(connection, deleteFromProductsSql, productId);

            // Commit the transaction
            connection.commit();

            return true;
        } catch (SQLException e) {
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

    public List<Products> searchProducts(String keyword) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE product_name LIKE ?";

        try (Connection connection = MysqlConnect.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, "%" + keyword + "%");
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Products p = new Products(
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

    public static void main(String[] args) {
        ProductsDAO p = new ProductsDAO();
        List<Products> lp = p.getAll();
        System.out.println(lp.get(0).getProduct_branch());
        p.editProduct("123", "Ok", 9, "ok", 9, 9, "Iphone");
        p.deleteProduct("a");
    }

}
