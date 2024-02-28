<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Categories</title>
</head>
<body>
    <h2>Category List</h2>
    <c:forEach items="${categories}" var="category">
        <p>${category.categoryName}</p>
        <!-- Add buttons or links for edit and delete -->
    </c:forEach>

    <!-- Form to add new category -->
    <form action="CrudCategory" method="post">
        <input type="hidden" name="action" value="create">
        <input type="text" name="categoryName" placeholder="Enter category name">
        <input type="submit" value="Add Category">
    </form>
</body>
</html>
