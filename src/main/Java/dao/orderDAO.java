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
import model.Product;
import model.orderDetail;
import model.orderStatus;

public class orderDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

   

    public List<Order> getOrderList() {
        String sql = "select * from Orders";
        List<Order> list = new ArrayList();

        try {
            this.connection = DBConnection.getConnection();
            this.statement = this.connection.createStatement();
            this.rs = this.statement.executeQuery(sql);

            while (this.rs.next()) {
                Order o = new Order(this.rs.getInt("order_id"), this.rs.getInt("user_id"), this.rs.getString("delivery_address"), this.rs.getString("phone_number"), this.rs.getString("recipient_name"), this.rs.getString("payment_method"), this.rs.getInt("status_order_id"), this.rs.getDate("time_buy"));
                list.add(o);
            }

            this.connection.close();
        } catch (SQLException var6) {
            try {
                this.connection.close();
            } catch (SQLException var5) {
                var5.printStackTrace();
            }

            var6.printStackTrace();
        }

        return list;
    }

    public List<Order> getOrderListById(int userID) {
        String sql = "select * from Orders WHERE user_id = ?";
        List<Order> list = new ArrayList();

        try {
            this.connection = DBConnection.getConnection();
            PreparedStatement st = this.connection.prepareStatement(sql);
            st.setInt(1, userID);
            this.rs = st.executeQuery();

            while (this.rs.next()) {
                Order o = new Order(this.rs.getInt("order_id"), this.rs.getInt("user_id"), this.rs.getString("delivery_address"), this.rs.getString("phone_number"), this.rs.getString("recipient_name"), this.rs.getString("payment_method"), this.rs.getInt("status_order_id"), this.rs.getDate("time_buy"));
                list.add(o);
            }

            this.connection.close();
        } catch (SQLException var7) {
            try {
                this.connection.close();
            } catch (SQLException var6) {
                var6.printStackTrace();
            }

            var7.printStackTrace();
        }

        return list;
    }

    public List<Product> getProductsByOrderId(int orderId) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.product_id, p.user_id, p.product_name, p.product_price, p.image_url, "
                + "p.stock_quantity, p.category_id, p.product_branch, p.date_added, p.product_count "
                + "FROM products p "
                + "INNER JOIN orderdetail od ON p.product_id = od.product_id "
                + "WHERE od.order_id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement st = connection.prepareStatement(sql)) {

            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getInt("user_id"),
                        rs.getString("product_name"),
                        rs.getDouble("product_price"),
                        rs.getString("image_url"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id"),
                        rs.getString("product_branch"),
                        rs.getDate("date_added"),
                        rs.getInt("product_count"));
                products.add(product);
            }
        }

        return products;
    }

    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.* FROM orders o "
                + "INNER JOIN orderdetail od ON o.order_id = od.order_id "
                + "INNER JOIN products p ON od.product_id = p.product_id "
                + "WHERE p.user_id = ? "
                + "GROUP BY o.order_id";
         Connection conn = DBConnection.getConnection();
        try ( PreparedStatement st = conn.prepareStatement(sql)) {

            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getString("delivery_address"),
                        rs.getString("phone_number"),
                        rs.getString("recipient_name"),
                        rs.getString("payment_method"),
                        rs.getInt("status_order_id"),
                        rs.getDate("time_buy"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<orderStatus> getOrderStatus() {
        String sql = "select * from order_status";
        List<orderStatus> list = new ArrayList();

        try {
            this.connection = DBConnection.getConnection();
            this.statement = this.connection.createStatement();
            this.rs = this.statement.executeQuery(sql);

            while (this.rs.next()) {
                orderStatus o = new orderStatus(this.rs.getInt("status_order_id"), this.rs.getString("status_order_name"));
                list.add(o);
            }

            this.connection.close();
        } catch (SQLException var6) {
            try {
                this.connection.close();
            } catch (SQLException var5) {
                var5.printStackTrace();
            }

            var6.printStackTrace();
        }

        return list;
    }

    public int insertOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, delivery_address, phone_number, recipient_name, payment_method,status_order_id) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            Connection conn = DBConnection.getConnection();

            int var7;
            try {
                PreparedStatement statement = conn.prepareStatement(sql, 1);

                try {
                    statement.setInt(1, order.getUserID());
                    statement.setString(2, order.getDeliveryAddress());
                    statement.setString(3, order.getPhoneNumber());
                    statement.setString(4, order.getRecipientName());
                    statement.setString(5, order.getPaymentMethod());
                    statement.setInt(6, order.getStatus_order_id());
                    int affectedRows = statement.executeUpdate();
                    if (affectedRows == 0) {
                        throw new SQLException("Creating order failed, no rows affected.");
                    }

                    ResultSet generatedKeys = statement.getGeneratedKeys();

                    try {
                        if (!generatedKeys.next()) {
                            throw new SQLException("Creating order failed, no ID obtained.");
                        }

                        var7 = generatedKeys.getInt(1);
                    } catch (Throwable var12) {
                        if (generatedKeys != null) {
                            try {
                                generatedKeys.close();
                            } catch (Throwable var11) {
                                var12.addSuppressed(var11);
                            }
                        }

                        throw var12;
                    }

                    if (generatedKeys != null) {
                        generatedKeys.close();
                    }
                } catch (Throwable var13) {
                    if (statement != null) {
                        try {
                            statement.close();
                        } catch (Throwable var10) {
                            var13.addSuppressed(var10);
                        }
                    }

                    throw var13;
                }

                if (statement != null) {
                    statement.close();
                }
            } catch (Throwable var14) {
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (Throwable var9) {
                        var14.addSuppressed(var9);
                    }
                }

                throw var14;
            }

            if (conn != null) {
                conn.close();
            }

            return var7;
        } catch (SQLException var15) {
            System.err.println("Error occurred during the insertOrder operation: " + var15.getMessage());
            return -1;
        }
    }

    public List<Order> getOrderByUserID(int id) {
        Order order = null;
        String sql = "SELECT o.*, os.status_order_name FROM Orders o JOIN order_status os ON o.status_order_id = os.status_order_id WHERE user_id = ?";
        List<Order> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {
                order = new Order(this.rs.getInt("order_id"), this.rs.getInt("user_id"), this.rs.getString("delivery_address"), this.rs.getString("phone_number"), this.rs.getString("recipient_name"), this.rs.getString("payment_method"), this.rs.getInt("status_order_id"), this.rs.getDate("time_buy"));
                list.add(order);
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
            this.connection = DBConnection.getConnection();
            PreparedStatement st = this.connection.prepareStatement(sql);
            st.setInt(1, orderId);
            this.rs = st.executeQuery();
            if (this.rs.next()) {
                order = new Order(this.rs.getInt("order_id"), this.rs.getInt("user_id"), this.rs.getString("delivery_address"), this.rs.getString("phone_number"), this.rs.getString("recipient_name"), this.rs.getString("payment_method"), this.rs.getInt("status_order_id"), this.rs.getDate("time_buy"));
            }
        } catch (SQLException var5) {
            System.out.println("SQL Error: " + var5.getMessage());
        }

        return order;
    }

    public boolean updateOrder(int orderId, String address, String phoneNumber, String receiver, int statuId) throws SQLException {
        boolean orderUpdated = false;
        String sql = "UPDATE Orders SET delivery_address = ?, phone_number = ?, recipient_name = ?, status_order_id=? WHERE order_id = ?;";
        this.connection = DBConnection.getConnection();

        try {
            PreparedStatement st = this.connection.prepareStatement(sql);
            st.setString(1, address);
            st.setString(2, phoneNumber);
            st.setString(3, receiver);
            st.setInt(4, statuId);
            st.setInt(5, orderId);
            orderUpdated = st.executeUpdate() > 0;
            return orderUpdated;
        } catch (SQLException var9) {
            System.out.println("SQL Error: " + var9.getMessage());
            return false;
        }
    }

    public boolean createOrder(int userId, String address, String phoneNumber, String receiver, String paymentMethod, Date createOrderDay) throws SQLException {
        boolean orderCreated = false;
        String sql = "INSERT INTO Orders (userId, address, phoneNumber, receiver, paymentMethod,createOrderDay) VALUES (?, ?, ?, ?, ?, ?);";
        this.connection = DBConnection.getConnection();

        try {
            PreparedStatement st = this.connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, address);
            st.setString(3, phoneNumber);
            st.setString(4, receiver);
            st.setString(5, paymentMethod);
            Date sqlCreateOrderDay = new Date(createOrderDay.getTime());
            st.setDate(6, sqlCreateOrderDay);
            orderCreated = st.executeUpdate() > 0;
            return orderCreated;
        } catch (SQLException var11) {
            System.out.println("SQL Error: " + var11.getMessage());
            return false;
        }
    }

    public boolean deleteOrder(int orderId) throws SQLException {
        boolean orderDeleted = false;
        String sqlDeleteOrderDetails = "DELETE FROM orderdetail WHERE order_id = ?;";
        String sqlDeleteOrder = "DELETE FROM orders WHERE order_id = ?;";
        Connection connection = null;

        boolean var7;
        try {
            try {
                connection = DBConnection.getConnection();
                connection.setAutoCommit(false);
                PreparedStatement st1 = connection.prepareStatement(sqlDeleteOrderDetails);

                try {
                    st1.setInt(1, orderId);
                    st1.executeUpdate();
                } catch (Throwable var26) {
                    if (st1 != null) {
                        try {
                            st1.close();
                        } catch (Throwable var24) {
                            var26.addSuppressed(var24);
                        }
                    }

                    throw var26;
                }

                if (st1 != null) {
                    st1.close();
                }

                st1 = connection.prepareStatement(sqlDeleteOrder);

                try {
                    st1.setInt(1, orderId);
                    orderDeleted = st1.executeUpdate() > 0;
                } catch (Throwable var25) {
                    if (st1 != null) {
                        try {
                            st1.close();
                        } catch (Throwable var23) {
                            var25.addSuppressed(var23);
                        }
                    }

                    throw var25;
                }
                if (st1 != null) {
                    st1.close();
                }

                connection.commit();
                return orderDeleted;
            } catch (SQLException var27) {
                System.out.println("SQL Error: " + var27.getMessage());
                if (connection != null) {
                    try {
                        connection.rollback();
                    } catch (SQLException var22) {
                        System.out.println("SQL Error during rollback: " + var22.getMessage());
                    }
                }
            }

            var7 = false;
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                } catch (SQLException var21) {
                    System.out.println("SQL Error while setting auto commit back to true: " + var21.getMessage());
                }
            }

        }

        return var7;
    }

    public List<Product> getListProductsBySellerId(int SellerId) {
        String sql = "SELECT * FROM products where user_id = ?";
        List<Product> list = new ArrayList();

        try {
            this.connection = DBConnection.getConnection();
            PreparedStatement st = this.connection.prepareStatement(sql);
            st.setInt(1, SellerId);
            this.rs = st.executeQuery();

            while (this.rs.next()) {
                Product p = new Product(this.rs.getInt("product_id"), this.rs.getInt("user_id"), this.rs.getString("product_name"), this.rs.getDouble("product_price"), this.rs.getString("image_url"), this.rs.getInt("stock_quantity"), this.rs.getInt("category_id"), this.rs.getString("product_branch"), this.rs.getDate("date_added"), this.rs.getInt("product_count"));
                list.add(p);
            }

            this.connection.close();
        } catch (SQLException var7) {
            try {
                this.connection.close();
            } catch (SQLException var6) {
                var6.printStackTrace();
            }

            var7.printStackTrace();
        }

        return list;
    }

    public List<orderDetail> getListOrdersByProductId(int productId) {
        String sql = "SELECT * FROM orderdetail where product_id = ?";
        List<orderDetail> list = new ArrayList();

        try {
            this.connection = DBConnection.getConnection();
            PreparedStatement st = this.connection.prepareStatement(sql);
            st.setInt(1, productId);
            this.rs = st.executeQuery();

            while (this.rs.next()) {
                orderDetail o = new orderDetail(this.rs.getInt("record_id"), this.rs.getInt("quantity"), this.rs.getInt("order_id"), this.rs.getInt("product_id"));
                list.add(o);
            }

            this.connection.close();
        } catch (SQLException var7) {
            try {
                this.connection.close();
            } catch (SQLException var6) {
                var6.printStackTrace();
            }

            var7.printStackTrace();
        }

      return list;
   }

   
    public static void main(String[] args) throws SQLException {
         orderDAO odDAO = new orderDAO();
        List<Order> lo = odDAO.getOrdersByUserId(2);
        for (int i = 0; i < lo.size(); i++) {
            System.out.println(lo.get(i).getUserID());
        }

    }
}
