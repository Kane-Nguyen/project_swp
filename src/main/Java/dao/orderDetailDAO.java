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
import model.orderDetail;

public class orderDetailDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public List<orderDetail> getOrderDetailListBy() {
        String sql = "select * from orderdetail";
        List<orderDetail> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                orderDetail o = new orderDetail(rs.getInt("record_id"), rs.getInt("quantity"), rs.getInt("order_id"), rs.getInt("product_id")
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

    public List<orderDetail> getOrderDetailListByUserId(int userId) {
        String sql = "SELECT od.* FROM orderdetail od JOIN products o ON od.product_id = o.product_id WHERE o.user_id= ?";
        List<orderDetail> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId); // Set the user_id parameter
            rs = st.executeQuery();
            while (rs.next()) {
                orderDetail o = new orderDetail(rs.getInt("record_id"),
                        rs.getInt("quantity"),
                        rs.getInt("order_id"),
                        rs.getInt("product_id"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public boolean insertOrderDetail(orderDetail OrderDetail) {
        String sql = "INSERT INTO orderdetail(quantity, order_id, product_id) VALUES (?, ?, ?) ";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, OrderDetail.getQuantity());
            statement.setInt(2, OrderDetail.getOrder_id());
            statement.setInt(3, OrderDetail.getProduct_id());

            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Error occurred during the insertOrder operation: " + e.getMessage());
            return false;
        }
    }

    public static void main(String[] args) {
        orderDetailDAO od = new orderDetailDAO();
        List<orderDetail> l = od.getOrderDetailListByUserId(1);
        for (int i = 0; i < 10; i++) {
            System.out.println(l.get(i).getProduct_id());
        }
    }
}
