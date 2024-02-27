package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO {

    // Method to create a new category
    public boolean createCategory(String categoryName) {
        // SQL query to insert a new category
        String sql = "INSERT INTO categories (category_name) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, categoryName);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to read all categories
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt("category_id"), rs.getString("category_name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Method to update a category
    public boolean updateCategory(int categoryId, String categoryName) {
        String sql = "UPDATE categories SET category_name = ? WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, categoryName);
            pstmt.setInt(2, categoryId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to delete a category
    public boolean deleteCategory(int categoryId) {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, categoryId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
     public static void main(String[] args) {
        CategoryDAO p = new CategoryDAO();
        List<Category> lp = p.getAllCategories();
        System.out.println(lp.get(0).getCategoryName());
        p.createCategory("okok");
    }
}
