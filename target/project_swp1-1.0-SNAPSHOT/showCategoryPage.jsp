<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Categories</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding: 20px;
        }
        .table {
            margin-top: 20px;
        }
        .form-inline {
            display: flex;
            align-items: center;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Category List</h2>
        
        <h3>Add New Category</h3>
        <form action="crudCategory" method="post" class="form-inline">
            <input type="hidden" name="action" value="add" />
            <label for="categoryName" class="form-label">Category Name:</label>
            <input type="text" id="categoryName" name="categoryName" required class="form-control">
            <button type="submit" class="btn btn-primary">Add Category</button>
        </form>
        
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Category Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="category" items="${categories}">
                    <tr>
                        <td>${category.categoryName}</td>
                        <td>
                            <a href="crudCategory?action=editForm&categoryId=${category.categoryId}" class="btn btn-sm btn-info">Edit</a>

                            <form action="crudCategory" method="post" style="display:inline;" class="form-inline">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="categoryId" value="${category.categoryId}" />
                                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS and Popper.js (optional) -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
