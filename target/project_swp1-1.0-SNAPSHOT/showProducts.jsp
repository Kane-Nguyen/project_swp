<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product List</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            img {
                width: 100px; /* Adjust as necessary */
                height: auto;
            }
        </style>
    </head>
    <body>

        <div class="container mt-4">
            <h2 class="mb-3">Product List</h2>
            <a href="createProductPage.jsp" class="btn btn-primary mb-3">Add Product</a>

            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Image</th>
                        <th>Stock Quantity</th>
                        <th>Category ID</th>
                        <th>Branch</th>
                        <th>Date Added</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Product> productList = new dao.ProductDAO().getAll();
                        for (Product product : productList) {
                            String base64Image = product.getImage_url();
                            String imageDataURL = "data:image/png;base64," + base64Image; // Assuming PNG format
                            NumberFormat formatter = NumberFormat.getNumberInstance(Locale.forLanguageTag("vi-VN")); // Vietnamese locale
                            String formattedPrice = formatter.format(product.getProduct_price());
                    %>
                    <tr>
                        <td><%= product.getProduct_id() %></td>
                        <td><%= product.getProduct_name() %></td>
                        <td><%= formattedPrice %> VNĐ</td>
                        <td><img src="<%= imageDataURL %>" alt="Product Image"/></td>
                        <td><%= product.getStock_quantity() %></td>
                        <td><%= product.getCategory_id() %></td>
                        <td><%= product.getProduct_branch() %></td>
                        <td><%= product.getDateAdded() %></td>
                        <td>
                            <a href="editProductPage.jsp?productId=<%= product.getProduct_id() %>" class="btn btn-sm btn-success">Edit</a>
                        </td>

                        <td>
                            <form action="CrudProduct" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="product_id" value="<%= product.getProduct_id() %>">
                                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this product?')">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Bootstrap JS and Popper.js (Optional, for components like modals, dropdowns, etc.) -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>z
    </body>
</html>
