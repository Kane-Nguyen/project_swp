package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Product;

public class cartDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public List<Cart> getCartList() {
        String sql = "select * from cart";
        List<Cart> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            statement = connection.createStatement();
            rs = statement.executeQuery(sql);
            while (rs.next()) {
                Cart c = new Cart(rs.getInt("cart_id"), rs.getInt("user_id"), rs.getInt("product_id"), rs.getInt("quantity"));
                list.add(c);
            }

            connection.close();
        } catch (SQLException e) {
            try {
                connection.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }

        return list;
    }

    public Cart getCartByID(int userId) {
        Cart cart = null;
        String sql = "SELECT * FROM cart WHERE user_id = ?";
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            rs = st.executeQuery();
            if (rs.next()) {
                Cart c = new Cart(rs.getInt("cart_id"), rs.getInt("user_id"), rs.getInt("product_id"), rs.getInt("quantity"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        }
        return cart;
    }

    public List<Cart> getCartItemsByUserId(int userId) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE user_id = ?";
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            rs = st.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart(
                        rs.getInt("cart_id"),
                        rs.getInt("user_id"),
                        rs.getInt("product_id"),
                        rs.getInt("quantity")
                );
                cartItems.add(cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public Cart findCartByUserIdAndProductId(int userId, int productId) {
        String sql = "SELECT * FROM Cart WHERE user_id = ? AND product_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Assuming DBConnection is your database connection class
            connection = DBConnection.getConnection(); // Correct way to get a connection
            statement = connection.prepareStatement(sql);

            // Setting parameters for the prepared statement
            statement.setInt(1, userId);
            statement.setInt(2, productId);

            resultSet = statement.executeQuery();

            // Check if the result set has any row
            if (resultSet.next()) {
                Cart cart = new Cart();
                // Assuming Cart has a constructor or setters to set its properties
                // Here, set all the properties of Cart based on your resultSet
                cart.setCart_id(resultSet.getInt("cart_id")); // Example of setting cart ID
                cart.setUser_id(resultSet.getInt("user_id"));
                cart.setProduct_id(resultSet.getInt("product_id"));
                cart.setQuantity(resultSet.getInt("quantity"));
                // Continue setting other properties as needed

                return cart;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Closing resources
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null; // Return null if no cart is found or in case of an exception
    }

    public boolean deleteCart(int cartId) throws SQLException {
        boolean cartDeleted = false;
        String sql = "DELETE FROM cart WHERE cart_id = ?";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cartId);

            cartDeleted = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        } finally {
            connection.close();
        }
        return cartDeleted;
    }

    public boolean insertCart(Cart cart) throws SQLException {
        boolean Cart = false;
        String sql = "INSERT INTO Cart (user_id, product_id, quantity) VALUES (? ,? ,?) ";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cart.getUser_id());
            st.setInt(2, cart.getProduct_id());
            st.setInt(3, cart.getQuantity());
            st.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    public boolean updateCartQuantity(int cartId, int newQuantity) throws SQLException {
        boolean updated = false;
        String deleteCartSql = "DELETE FROM Cart WHERE cart_id = ?";
        String updateCartSql = "UPDATE Cart SET quantity = ? WHERE cart_id = ?";
        String getStockQuantitySql = "SELECT stock_quantity FROM products WHERE product_id = ?";

        connection = DBConnection.getConnection();
        try {
            connection.setAutoCommit(false);

            // Get current quantity in the cart
            PreparedStatement getCartStatement = connection.prepareStatement("SELECT * FROM Cart WHERE cart_id = ?");
            getCartStatement.setInt(1, cartId);
            rs = getCartStatement.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String productId = rs.getString("product_id");

                // Get stock quantity of the product
                PreparedStatement getStockQuantityStatement = connection.prepareStatement(getStockQuantitySql);
                getStockQuantityStatement.setString(1, productId);
                ResultSet stockQuantityResultSet = getStockQuantityStatement.executeQuery();

                if (stockQuantityResultSet.next()) {
                    int stockQuantity = stockQuantityResultSet.getInt("stock_quantity");

                    // Check if the new quantity is within the stock quantity limit
                    if (newQuantity > 0 && newQuantity <= stockQuantity) {
                        // Update cart quantity
                        PreparedStatement updateCartStatement = connection.prepareStatement(updateCartSql);
                        updateCartStatement.setInt(1, newQuantity);
                        updateCartStatement.setInt(2, cartId);

                        updated = updateCartStatement.executeUpdate() > 0;

                        if (updated) {
                            connection.commit();
                        } else {
                            connection.rollback();
                        }
                    } else if (newQuantity <= 0) {
                        // If new quantity is 0 or less, delete the cart
                        PreparedStatement deleteCartStatement = connection.prepareStatement(deleteCartSql);
                        deleteCartStatement.setInt(1, cartId);

                        updated = deleteCartStatement.executeUpdate() > 0;

                        if (updated) {
                            connection.commit();
                        } else {
                            connection.rollback();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            connection.rollback();
            e.printStackTrace();
        } finally {
            connection.setAutoCommit(true);
            connection.close();
        }

        return updated;
    }

}
