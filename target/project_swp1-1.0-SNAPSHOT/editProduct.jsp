<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="dao.ProductsDAO"%>
<%@page import="model.Products"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
</head>
<body>
    <h2>Edit Product</h2>

    <% 
        String productId = request.getParameter("product_id");
        ProductsDAO dao = new ProductsDAO();
        Products product = dao.getProductById(productId);
        if (product != null) {
    %>

    <form action="editProducts" method="POST">
        <input type="hidden" name="product_id" value="<%= product.getProduct_id() %>">

        <p>
            <label>Product Name:</label>
            <input type="text" name="product_name" value="<%= product.getProduct_name() %>" required>
        </p>
        <p>
            <label>Product Price:</label>
            <input type="number" step="0.01" name="product_price" value="<%= product.getProduct_price() %>" required>
        </p>
        <p>
            <label>Image URL:</label>
            <input type="text" name="image_url" value="<%= product.getImage_url() %>">
        </p>
        <p>
            <label>Stock Quantity:</label>
            <input type="number" name="stock_quantity" value="<%= product.getStock_quantity() %>" required>
        </p>
        <p>
            <label>Category</label>
            <input type="number" name="category_id" value="<%= product.getCategory_id() %>" required>
        </p>
        <p>
            <label>Product Branch:</label>
            <input type="text" name="product_branch" value="<%= product.getProduct_branch() %>">
        </p>

        <p>
            <input type="submit" value="Update Product">
        </p>
    </form>

    <% 
        } else {
            out.println("<p>Product not found.</p>");
        }
    %>

    <a href="showProducts.jsp">Back to Product List</a>
</body>
</html>
