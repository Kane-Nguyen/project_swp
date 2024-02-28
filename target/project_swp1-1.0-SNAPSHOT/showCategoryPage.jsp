<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Categories</title>
</head>
<body>
    <h2>Category List</h2>
    
    <h3>Add New Category</h3>
    <form action="crudCategory" method="post">
        <input type="hidden" name="action" value="add" />
        <label for="categoryName">Category Name:</label>
        <input type="text" id="categoryName" name="categoryName" required>
        <input type="submit" value="Add Category">
    </form>
    <table>
        <tr>
            <th>Category Name</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="category" items="${categories}">
            <tr>
                <td>${category.categoryName}</td>
                <td>
                    <a href="crudCategory?action=editForm&categoryId=${category.categoryId}">Edit</a>

                    <form action="crudCategory" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="categoryId" value="${category.categoryId}" />
                        <input type="submit" value="Delete" onclick="return confirm('Are you sure?')" />
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
