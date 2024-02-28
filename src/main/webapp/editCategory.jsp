<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Category</title>
    <!-- Add any necessary CSS or JS references here -->
</head>
<body>
    <h2>Edit Category</h2>
    <%
        Category category = (Category) request.getAttribute("category");
        if (category != null) {
    %>
        <form action="crudCategory" method="post">
            <input type="hidden" name="action" value="edit" />
            <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>" />

            <label for="categoryName">Category Name:</label>
            <input type="text" id="categoryName" name="categoryName" value="<%= category.getCategoryName() %>" required>

            <input type="submit" value="Update Category">
        </form>
    <%
        } else {
    %>
        <p>Category not found.</p>
    <%
        }
    %>
    <a href="crudCategory">Back to Category List</a>
</body>
</html>
