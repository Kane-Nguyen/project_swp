<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <style>
        .input-field {
            margin-bottom: 10px;
        }
        .input-field label {
            display: block;
        }
    </style>
</head>
<body>
    <h2>Edit Product</h2>
    <%
        String productId = request.getParameter("productId");
        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductById(productId);
        if (product != null) {
    %>
        <form action="CrudProduct" method="post">
            <input type="hidden" name="action" value="edit"> <!-- Action to add product -->
            <div class="input-field">
                <label for="product_id">Product ID:</label>
                <input type="text" name="product_id" id="product_id" value="<%= product.getProduct_id() %>" readonly>
            </div>
            <div class="input-field">
                <label for="product_name">Product Name:</label>
                <input type="text" name="product_name" id="product_name" value="<%= product.getProduct_name() %>">
            </div>
            <div class="input-field">
                <label for="product_price">Price:</label>
                <input type="number" step="0.01" name="product_price" id="product_price" value="<%= product.getProduct_price() %>">
            </div>
            <div class="input-field">
                <label for="image_url">Image URL:</label>
                <input type="file" name="image_url" id="image_url" value="<%= product.getImage_url() %>">
            </div>
            <div class="input-field">
                <label for="stock_quantity">Stock Quantity:</label>
                <input type="number" name="stock_quantity" id="stock_quantity" value="<%= product.getStock_quantity() %>">
            </div>
            <div class="input-field">
                <label for="category_id">Category ID:</label>
                <input type="number" name="category_id" id="category_id" value="<%= product.getCategory_id() %>">
            </div>
            <div class="input-field">
                <label for="product_branch">Branch:</label>
                <input type="text" name="product_branch" id="product_branch" value="<%= product.getProduct_branch() %>">
            </div>
            <input type="submit" value="Update Product">
        </form>
    <% 
        } else {
            out.println("<p>Product not found!</p>");
        }
    %>
</body>
</html>
