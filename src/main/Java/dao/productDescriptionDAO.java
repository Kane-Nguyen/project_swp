package dao;

import connect.MysqlConnect;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.product;
import model.productDescription;

public class productDescriptionDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public productDescriptionDAO() throws SQLException {
        this.connection = MysqlConnect.getConnection();
    }

    public List<productDescription> getAllProductDescription() {
        List<productDescription> pDescriptions = new ArrayList<>();
        String sql = "select * from productdescription";
        try {
            PreparedStatement pstmt = connection.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                productDescription description = new productDescription();
                description.setDescriptionId(rs.getInt("description_id"));
                description.setSizeDisplay(rs.getString("size_display"));
                description.setChipset(rs.getString("chipset"));
                description.setBattery(rs.getString("battery"));
                description.setOsystem(rs.getString("osystem"));
                description.setCamera(rs.getString("camera"));
                description.setProductId(rs.getInt("product_id"));
                description.setSim(rs.getString("sim"));
                pDescriptions.add(description);
            }
        } catch (SQLException e) {
        }
        return pDescriptions;
    }

    public List<product> getProduct() {
        List<product> listU = new ArrayList<>();
        String sql = "select * from products";
        try {
            PreparedStatement sta = connection.prepareStatement(sql); // Use PreparedStatement instead of Statement
            ResultSet rsu = sta.executeQuery();
            while (rsu.next()) {
                product p = new product(
                        rsu.getInt("product_id"),
                        rsu.getString("product_name"),
                        rsu.getDouble("product_price"),
                        rsu.getString("image_url"),
                        rsu.getInt("stock_quantity"),
                        rsu.getInt("category_id"),
                        rsu.getString("product_branch"), // Corrected column name
                        rsu.getDate("date_added")); // Corrected column name
                listU.add(p);
            }
        } catch (SQLException e) {
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close connection inside finally block
                }
            } catch (SQLException e) {
            }
        }
        return listU;
    }

   

    public List<product> getIMG(String id1, String id2) {
        List<product> list = new ArrayList<>();
        String sql = "SELECT * from products WHERE product_id IN (?, ?);";
        try {
            PreparedStatement st = connection.prepareStatement(sql); // Use PreparedStatement instead of Statement
            st.setString(1, id1);
            st.setString(2, id2);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                product p = new product(
                        rs.getInt("product_id"),
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
        }
        return list;
    }

    public List<productDescription> getProductDescription(String id1, String id2) {
        List<productDescription> ProductDescription = new ArrayList<>();
        String sql = "select * from productdescription WHERE product_id IN (?, ?);";
        try {
            PreparedStatement st = connection.prepareStatement(sql); // Use PreparedStatement instead of Statement
            st.setString(1, id1);
            st.setString(2, id2);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                productDescription description = new productDescription(
                        rs.getInt("description_id"), rs.getString("size_display"), rs.getString("chipset"),
                        rs.getString("battery"), rs.getString("osystem"), rs.getString("camera"), rs.getString("sim"), rs.getInt("product_id"));
                ProductDescription.add(description);
            }
        } catch (SQLException e) {
        } finally {
            try {
                if (connection != null) {
                    connection.close(); // Close connection inside finally block
                }
            } catch (SQLException e) {
            }
        }
        return ProductDescription;
    }

    public static void main(String[] args) throws SQLException {
        productDescriptionDAO pdModel = new productDescriptionDAO();
        List<product> pOutId = pdModel.getProduct();
        
        
 
        for (product object : pOutId) {
            System.out.println(object.getImage_url() + " pOutId");
             
        }

    }
}
