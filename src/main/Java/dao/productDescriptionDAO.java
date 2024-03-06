package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.image;
import model.Product;
import model.productDescription;

public class productDescriptionDAO {

   private Connection connection;
    private Statement statement;
    private ResultSet rs;



    public List<productDescription> getAllProductDescription() {
        List<productDescription> pDescriptions = new ArrayList<>();
        String sql = "select * from productdescription";
        try {
            PreparedStatement pstmt = connection.prepareStatement(sql);
            rs = pstmt.executeQuery();
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

    public List<Product> getProduct() {
        List<Product> listU = new ArrayList<>();
        String sql = "select * from products";
        try {
             connection = DBConnection.getConnection();
            PreparedStatement sta = connection.prepareStatement(sql); // Use PreparedStatement instead of Statement
            ResultSet rsu = sta.executeQuery();
            while (rsu.next()) {
                Product p = new Product(
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
        } 
        return listU;
    }

    public List<Product> getIMG(String id1, String id2) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * from products WHERE product_id IN (?, ?);";
        try {
             connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql); // Use PreparedStatement instead of Statement
            st.setString(1, id1);
            st.setString(2, id2);
            rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product(
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

    public List<productDescription> getProductDescription() {
        List<productDescription> ProductDescription = new ArrayList<>();
        String sql = "select * from productdescription";
        try {
             connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql); // Use PreparedStatement instead of Statement
            rs = st.executeQuery();
            while (rs.next()) {
                productDescription description = new productDescription(
                        rs.getInt("description_id"), rs.getString("size_display"), rs.getString("chipset"),
                        rs.getString("battery"), rs.getString("osystem"), rs.getString("camera"), rs.getString("sim"), rs.getInt("product_id"));
                ProductDescription.add(description);
            }
        } catch (SQLException e) {
        } 
        return ProductDescription;
    }

    public List<image> getImagesByProductId(int productId) {
        List<image> images = new ArrayList<>();
        String sql = "SELECT * FROM images WHERE product_id = ?";
        try {
             connection = DBConnection.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int imageId = resultSet.getInt("image_id");
                String imageUrl = resultSet.getString("image_url");
                image image = new image(imageId, productId, imageUrl);
                images.add(image);
            }
        } catch (SQLException e) {

        } 
        return images;
    }

    public static void main(String[] args) throws SQLException {
        productDescriptionDAO pdModel = new productDescriptionDAO();
        List<image> l = pdModel.getImagesByProductId(2);
        for (image object : l) {
            System.out.println(object.getImage_url());
        }
    }
}
