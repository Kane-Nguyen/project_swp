<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.CategoryDAO" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html>
<head>
    <title>Category List</title>
</head>
<body>
    <h2>Category List</h2>
    <%
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategories();
    %>
    <table border="1">
        <tr>
            <th>Category ID</th>
            <th>Category Name</th>
            <th>Action</th>
        </tr>
        <%
            for (Category category : categories) {
        %>
        <tr>
            <td><%= category.getCategoryId() %></td>
            <td><%= category.getCategoryName() %></td>
            <td>
                <form action="CategoryServlet" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
