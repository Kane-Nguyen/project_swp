package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Order;

public class orderDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public List<Order> getOrderList() {
        String sql = "select * from Orders";
        List<Order> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            statement = connection.createStatement();
            rs = statement.executeQuery(sql);
            while (rs.next()) {
                Order o = new Order(rs.getInt("order_id"), rs.getInt("user_id"), rs.getString("delivery_address"), rs.getString("phone_number"), rs.getString("recipient_name"), rs.getString("payment_method"), rs.getFloat("total_price"), rs.getInt("status_order_id"), rs.getDate("time_buy"));
                list.add(o);
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

    public Order getOrderByID(int orderId) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            rs = st.executeQuery();
            if (rs.next()) {
                order = new Order(rs.getInt("order_id"), rs.getInt("user_id"), rs.getString("delivery_address"), rs.getString("phone_number"), rs.getString("recipient_name"), rs.getString("payment_method"), rs.getFloat("total_price"), rs.getInt("status_order_id"), rs.getDate("time_buy"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        }
        return order;

    }

    /**
     *
     * @param orderId
     * @param userId
     * @param address
     * @param phoneNumber
     * @param receiver
     * @param paymentMethod
     * @param price
     * @param createOrderDay
     * @return
     */
    public boolean updateOrder(int orderId, int userId, String address, String phoneNumber, String receiver, String paymentMethod, float price, Date createOrderDay) throws SQLException {
        boolean orderUpdated = false;
        String sql = "UPDATE Orders SET user_id = ?,  delivery_address = ?, phone_number = ?, recipient_name = ?, payment_method = ?, total_price = ?, time_buy = ? WHERE order_id = ?;";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, address);
            st.setString(3, phoneNumber);
            st.setString(4, receiver);
            st.setString(5, paymentMethod);
            st.setFloat(6, price);
            java.sql.Date sqlCreateOrderDay = new java.sql.Date(createOrderDay.getTime());
            st.setDate(7, sqlCreateOrderDay);
            st.setInt(8, orderId);
            orderUpdated = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
        return orderUpdated;
    }
    public boolean createOrder(int userId, String address, String phoneNumber, String receiver, String paymentMethod, float price, Date createOrderDay) throws SQLException {
        boolean orderCreated = false;
        String sql = "INSERT INTO Orders (userId, address, phoneNumber, receiver, paymentMethod, price, createOrderDay) VALUES (?, ?, ?, ?, ?, ?, ?);";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, address);
            st.setString(3, phoneNumber);
            st.setString(4, receiver);
            st.setString(5, paymentMethod);
            st.setFloat(6, price);
            java.sql.Date sqlCreateOrderDay = new java.sql.Date(createOrderDay.getTime());
            st.setDate(7, sqlCreateOrderDay);
            orderCreated = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
        return orderCreated;
    }

    public boolean deleteOrder(int orderId) throws SQLException {
        boolean orderDeleted = false;
        String sql = "DELETE FROM Orders WHERE order_id = ?;";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);

            orderDeleted = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
        return orderDeleted;
    }

    public static void main(String[] args) {
        orderDAO oDAO = new orderDAO();
        Order result = oDAO.getOrderByID(44);
        System.out.println("result :" + result.getTimeBuy());
    }
}
