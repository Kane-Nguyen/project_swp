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
import model.User;
import model.orderStatus;

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
                Order o = new Order(rs.getInt("order_id"), rs.getInt("user_id"), rs.getString("delivery_address"),
                        rs.getString("phone_number"),
                        rs.getString("recipient_name"),
                        rs.getString("payment_method"),
                        rs.getInt("status_order_id"),
                        rs.getDate("time_buy")
                );
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

    public List<Order> getOrderListById(int userID) {
        String sql = "select * from Orders WHERE user_id = ?";
        List<Order> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userID);
            rs = st.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("order_id"), rs.getInt("user_id"), rs.getString("delivery_address"),
                        rs.getString("phone_number"),
                        rs.getString("recipient_name"),
                        rs.getString("payment_method"),
                        rs.getInt("status_order_id"),
                        rs.getDate("time_buy")
                );
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

    public List<orderStatus> getOrderStatus() {
        String sql = "select * from order_status";
        List<orderStatus> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            statement = connection.createStatement();
            rs = statement.executeQuery(sql);
            while (rs.next()) {
                orderStatus o = new orderStatus(rs.getInt("status_order_id"), rs.getString("status_order_name")
                );
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

    public int insertOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, delivery_address, phone_number, recipient_name, payment_method,status_order_id) VALUES (?,  ?,?, ?, ?, ?, ?)";
        // Sử dụng try-with-resources để đảm bảo các tài nguyên được đóng một cách an toàn.
        try (Connection conn = DBConnection.getConnection(); // Cập nhật statement để lấy khóa được tạo tự động.
                 PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, order.getUserID());
            statement.setInt(2, order.getSellerID());
            statement.setString(3, order.getDeliveryAddress());
            statement.setString(4, order.getPhoneNumber());
            statement.setString(5, order.getRecipientName());
            statement.setString(6, order.getPaymentMethod());
            statement.setInt(7, order.getStatus_order_id());
            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    // Trả về khóa (id) của bản ghi vừa được chèn vào.
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error occurred during the insertOrder operation: " + e.getMessage());
            // Trường hợp xảy ra lỗi, có thể trả về -1 hoặc xử lý theo cách khác phù hợp.
            return -1;
        }
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
                order = new Order(rs.getInt("order_id"), rs.getInt("user_id"), rs.getString("delivery_address"), rs.getString("phone_number"), rs.getString("recipient_name"), rs.getString("payment_method"), rs.getInt("status_order_id"), rs.getDate("time_buy"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        }
        return order;

    }

    /**
     *
     * @param orderId
     * @param address
     * @param phoneNumber
     * @param statuId
     * @param receiver
     * @return
     */
    public boolean updateOrder(int orderId, String address, String phoneNumber, String receiver, int statuId) throws SQLException {
        boolean orderUpdated = false;
        String sql = "UPDATE Orders SET delivery_address = ?, phone_number = ?, recipient_name = ?, status_order_id=? WHERE order_id = ?;";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, address);
            st.setString(2, phoneNumber);
            st.setString(3, receiver);
            st.setInt(4, statuId);
            st.setInt(5, orderId);
            orderUpdated = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
        return orderUpdated;
    }

    public boolean createOrder(int userId, String address, String phoneNumber, String receiver, String paymentMethod, Date createOrderDay) throws SQLException {
        boolean orderCreated = false;
        String sql = "INSERT INTO Orders (userId, address, phoneNumber, receiver, paymentMethod,createOrderDay) VALUES (?, ?, ?, ?, ?, ?);";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, address);
            st.setString(3, phoneNumber);
            st.setString(4, receiver);
            st.setString(5, paymentMethod);

            java.sql.Date sqlCreateOrderDay = new java.sql.Date(createOrderDay.getTime());
            st.setDate(6, sqlCreateOrderDay);
            orderCreated = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
        return orderCreated;
    }

    public boolean deleteOrder(int orderId) throws SQLException  {
        boolean orderDeleted = false;

        String sqlDeleteOrderDetails = "DELETE FROM orderdetail WHERE order_id = ?;";
        String sqlDeleteOrder = "DELETE FROM orders WHERE order_id = ?;";
        Connection connection = null;

        try {
            // Get the database connection
            connection = DBConnection.getConnection();

            // Disable auto-commit mode
            connection.setAutoCommit(false);

            // Prepare and execute the SQL statement for deleting order details
            try (PreparedStatement st = connection.prepareStatement(sqlDeleteOrderDetails)) {
                st.setInt(1, orderId);
                st.executeUpdate();
            }

            // Prepare and execute the SQL statement for deleting the order
            try (PreparedStatement st1 = connection.prepareStatement(sqlDeleteOrder)) {
                st1.setInt(1, orderId);
                // Check if the order was successfully deleted
                orderDeleted = st1.executeUpdate() > 0;
            }

            // Commit the transaction
            connection.commit();
        } catch (SQLException e) {
            // Print the exception to the console
            System.out.println("SQL Error: " + e.getMessage());

            // Attempt to roll back the transaction if an error occurs
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    System.out.println("SQL Error during rollback: " + ex.getMessage());
                }
            }
            return false;
        } finally {
            // Re-enable auto-commit mode
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                } catch (SQLException e) {
                    System.out.println("SQL Error while setting auto commit back to true: " + e.getMessage());
                }
            }
        }
        return orderDeleted;
    }

    public static void main(String[] args) {
        orderDAO od = new orderDAO();
        UserDAO ud = new UserDAO();
        List<Order> lo = od.getOrderList();
        List<User> lu = ud.getAll();
        for (int i = 0; i < lo.size(); i++) {
            for (int j = 0; j < lu.size(); j++) {
                if (lo.get(i).getUserID() == lu.get(j).getUserId()) {
                    System.out.println("dung ");
                }
            }
        }
        System.out.println(lo.get(0).getUserID());
    }
}
