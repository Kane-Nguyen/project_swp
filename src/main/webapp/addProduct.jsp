<%-- 
    Document   : addProduct
    Created on : Feb 1, 2024, 9:14:41 AM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add New Product</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h2>Add New Product</h2>
        <div id="success-alert" class="alert alert-success" style="display:none;">
            Sản phẩm đã được thêm thành công!
        </div>

        <!-- Form for adding a new product -->
        <form action="createProducts" method="POST">
            <p>
                <label for="product_id">Product ID:</label>
                <input type="text" name="product_id" id="product_id" required>
            </p>
            <p>
                <label for="product_name">Product Name:</label>
                <input type="text" name="product_name" id="product_name" required>
            </p>
            <p>
                <label for="product_price">Product Price:</label>
                <input type="number" step="0.01" name="product_price" id="product_price" required>
            </p>
            <p>
                <label for="image_url">Image URL:</label>
                <input type="text" name="image_url" id="image_url">
            </p>
            <p>
                <label for="stock_quantity">Stock Quantity:</label>
                <input type="number" name="stock_quantity" id="stock_quantity" required>
            </p>
            <p>
                <label for="category_id">Category ID:</label>
                <input type="number" name="category_id" id="category_id" required>
            </p>
            <p>
                <label for="product_branch">Product Branch:</label>
                <input type="text" name="product_branch" id="product_branch">
            </p>
            <p>
                <input type="submit" value="Add Product">
            </p>
        </form>
        

        <a href="showProducts.jsp">Back to Product List</a>
        
        <script>
            window.onload = function() {
                const urlParams = new URLSearchParams(window.location.search);
                const success = urlParams.get('success');

                if(success === "true") {
                    document.getElementById('success-alert').style.display = 'block';
                }
            };
        </script>
    </body>
</html>

