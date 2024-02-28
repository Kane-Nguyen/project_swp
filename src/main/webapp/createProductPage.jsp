<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="dao.CategoryDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Product</title>
</head>
<body>
    <h2>Create New Product</h2>
    <form action="CrudProduct" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="add">
        
        <label for="productName">Product Name:</label><br>
        <input type="text" id="productName" name="productName" required><br>

        <label for="productPrice">Product Price:</label><br>
        <input type="number" id="productPrice" name="productPrice" min="0.01" step="0.01" required><br>

        <label for="image">Product Main Image:</label><br>
        <input type="file" id="image" name="image" required accept=".jpg, .jpeg, .png"><br>
        
        <label for="imageadd">Product Additional Image:</label><br>
        <input type="file" id="imageadd" name="imageadd" multiple accept=".jpg, .jpeg, .png"><br>

        <label for="stockQuantity">Stock Quantity:</label><br>
        <input type="number" id="stockQuantity" name="stockQuantity" min="1" step="1" required><br>

        <label for="categoryId">Category:</label><br>
        <select id="categoryId" name="categoryId" required>
            <% 
                CategoryDAO categoryDAO = new CategoryDAO();
                List<Category> categories = categoryDAO.getAllCategories();
                for (Category category : categories) {
                    out.print("<option value=\"" + category.getCategoryId() + "\">" + category.getCategoryName() + "</option>");
                }
            %>
        </select><br>

        <label for="productBranch">Product Branch:</label><br>
        <input type="text" id="productBranch" name="productBranch" required><br>

        <button type="submit">Add Product</button>
    </form>
</body>
</html>
