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
            img.current-image {
                max-width: 200px; /* Adjust as necessary */
                max-height: 200px; /* Adjust as necessary */
                margin-top: 10px;
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
                // Assuming the image URL is a direct link to the image
                // If it's a base64 string, prepend "data:image/png;base64," to the string
                String imageUrl = product.getImage_url(); 
                // Adjust MIME type and encoding prefix as needed if using base64
                String imageDataURL = imageUrl.startsWith("data:") ? imageUrl : "data:image/png;base64," + imageUrl;
        %>
        <form action="CrudProduct" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="productId" value="<%= product.getProduct_id() %>">

            <div class="input-field">
                <label for="productName">Product Name:</label>
                <input type="text" name="productName" id="productName" value="<%= product.getProduct_name() %>">
            </div>

            <div class="input-field">
                <label for="productPrice">Price:</label>
                <input type="number" step="0.01" name="productPrice" id="productPrice" value="<%= product.getProduct_price() %>">
            </div>

            <div class="input-field">
                <label for="image">Product Image:</label>
                <input type="file" name="image" id="image">
                <img src="<%= imageDataURL %>" class="current-image" alt="Current Product Image">
            </div>

            <div class="input-field">
                <label for="stockQuantity">Stock Quantity:</label>
                <input type="number" name="stockQuantity" id="stockQuantity" value="<%= product.getStock_quantity() %>">
            </div>

            <label for="categoryId">Category:</label><br>
            <select id="categoryId" name="categoryId" required>
                <!-- Example static options, replace with dynamic content -->
                <option value="1" <%= product.getCategory_id() == 1 ? "selected" : "" %>>Electronics</option>
                <option value="2" <%= product.getCategory_id() == 2 ? "selected" : "" %>>Clothing</option>
                <option value="3" <%= product.getCategory_id() == 3 ? "selected" : "" %>>Home & Garden</option>
                <!-- Add more options based on your categories -->
            </select><br>

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
