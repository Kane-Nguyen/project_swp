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
            <input type="hidden" name="action" value="edit">

            <div class="input-field">
                <label for="productId">Product ID:</label>
                <input type="text" name="productId" id="productId" value="<%= product.getProduct_id() %>" readonly>
            </div>
            <div class="input-field">
                <label for="productName">Product Name:</label>
                <input type="text" name="productName" id="productName" value="<%= product.getProduct_name() %>">
            </div>
            <div class="input-field">
                <label for="productPrice">Price:</label>
                <input type="number" step="0.01" name="productPrice" id="productPrice" value="<%= product.getProduct_price() %>">
            </div>
            <div class="input-field">
                <label for="image">Image URL:</label>
                <input type="text" name="image" id="image" value="<%= product.getImage_url() %>">
            </div>
            <div class="input-field">
                <label for="stockQuantity">Stock Quantity:</label>
                <input type="number" name="stockQuantity" id="stockQuantity" value="<%= product.getStock_quantity() %>">
            </div>
            <div class="input-field">
                <label for="categoryId">Category ID:</label>
                <input type="number" name="categoryId" id="categoryId" value="<%= product.getCategory_id() %>">
            </div>
            <div class="input-field">
                <label for="productBranch">Branch:</label>
                <input type="text" name="productBranch" id="productBranch" value="<%= product.getProduct_branch() %>">
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
