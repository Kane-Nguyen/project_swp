<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

            <label for="image">Product Image:</label><br>
            <input type="file" id="image" name="image" required><br>

            <label for="stockQuantity">Stock Quantity:</label><br>
            <input type="number" id="stockQuantity" name="stockQuantity" min="1" step="1" required><br>

            <label for="categoryId">Category:</label><br>
            <select id="categoryId" name="categoryId" required>
                <!-- Example static options, replace with dynamic content -->
                <option value="1">Electronics</option>
                <option value="2">Clothing</option>
                <option value="3">Home & Garden</option>
                <!-- Add more options based on your categories -->
            </select><br>

            <label for="productBranch">Product Branch:</label><br>
            <input type="text" id="productBranch" name="productBranch" required><br>

            <button type="submit">Add Product</button>
        </form>
    </body>
</html>
