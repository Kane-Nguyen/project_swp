<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product List</title>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th, td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>

        <h2>Product List</h2>
        <a href="createProductPage.jsp">Add Product</a> <!-- Link to Add Product Page -->
        <table>
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
            <% 
                List<Product> productList = new dao.ProductDAO().getAll();
                for (Product product : productList) {
            %>
            <tr>
                <td><%= product.getProduct_id() %></td>
                <td><%= product.getProduct_name() %></td>
                <td><%= product.getProduct_price() %></td>
                <td><%= product.getImage_url() %></td>
                <td><%= product.getStock_quantity() %></td>
                <td><%= product.getCategory_id() %></td>
                <td><%= product.getProduct_branch() %></td>
                <td><%= product.getDateAdded() %></td>
                <td>
                    <a href="editProductPage.jsp?productId=<%= product.getProduct_id() %>">Edit</a>
                </td>
                <td>
                    <form action="CrudProduct" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="product_id" value="<%= product.getProduct_id() %>">
                        <button type="submit" onclick="return confirm('Are you sure you want to delete this product?')">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </body>
    
</html>
