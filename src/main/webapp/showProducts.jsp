<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Products" %>
<%@ page import="dao.ProductsDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product List</title>
    </head>
    <body>
        <h2>Product List</h2>

        <%
            ProductsDAO p = new ProductsDAO();
            List<Products> productList = p.getAll();
            if (productList != null && !productList.isEmpty()) {
        %>

        <a href="addProduct.jsp"><button type="button">Add New Product</button></a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Image</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Category</th>
                    <th>Branch</th>
                    <th>Date</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <% for (Products product : productList) { %>
                <tr>
                    <td><%= product.getProduct_id() %></td>
                    <td><%= product.getProduct_name() %></td>
                    <td><%= product.getImage_url() %></td>
                    <td><%= product.getProduct_price() %></td>
                    <td><%= product.getStock_quantity() %></td>
                    <td><%= product.getCategory_id() %></td>
                    <td><%= product.getProduct_branch() %></td>
                    <td><%= product.getDateAdded() %></td>

                    <td>
                        <a href="editProduct.jsp?product_id=<%= product.getProduct_id() %>">Edit</a>
                    </td>
                    <td>
                        <form action="deleteProducts" method="post">
                            <input type="hidden" name="productId" value="<%= product.getProduct_id() %>" />
                            <input type="submit" value="Delete" onclick="return confirm('Are you sure?');" />
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% 
            } else { 
        %>
        <p>No products found.</p>
        <% 
            } 
        %>
    </body>
</html>
