<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String role = (String) session.getAttribute("UserRole");
if(role == null || !role.trim().equals("Admin")){
    response.sendRedirect("404-page.jsp");
    return;}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Danh Mục</title>
    <!-- Bootstrap CSS -->
            <link rel="shortcut icon" href="./img-module/logo.png" type="image/x-icon" />

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Chỉnh Sửa Danh Mục</h2>
    <c:if test="${not empty category}">
        <form action="crudCategory" method="post">
            <input type="hidden" name="action" value="edit" />
            <input type="hidden" name="categoryId" value="${category.categoryId}" />
            
            <div class="form-group">
                <label for="categoryName">Tên Danh Mục</label>
                <input type="text" class="form-control" id="categoryName" name="categoryName" value="${category.categoryName}" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Thay Đổi Danh Mục</button>
            <a href="crudCategory" class="btn btn-secondary ml-2">Quay lại Danh Sách Danh Mục</a>
        </form>
    </c:if>
    <c:if test="${empty category}">
        <p class="text-danger">Danh Mục Không Tìm Thấy</p>
        <a href="crudCategory" class="btn btn-secondary ml-2">Quay lại Danh Sách Danh Mục</a>
    </c:if>
</div>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
