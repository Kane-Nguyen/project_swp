<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String role = (String) session.getAttribute("UserRole");
if(role == null || !role.trim().equals("admin")){
   response.sendRedirect("404-page.jsp");
    return;}    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product List</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link href="./styles/adminCSSProducts.css" rel="stylesheet"/>
        <link href="./styles/toolbarAdmin.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="wrap-content">
            
            <div class="left-content">
                <h2 class="title-admin">EndureTale S</h2>
                <ul class="list-controller">
                    <% if(  session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/dashboard"  class="none-decoration"><li class="item-controller">Bảng điều khiển</li></a>
                            <%}%>
                    <a href="/order" class="none-decoration"> <li class="item-controller">Quản lí đơn hàng</li></a>
                    <li class="item-controller active">Quản lí sản phẩm</li>
                        <% if(session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/AdminUser" class="none-decoration"><li class="item-controller">Quản lí người dùng</li></a>
                         <%}
                          if(  session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/admin-setting" class="none-decoration"><li class="item-controller">Quản lí cài đặt</li></a>
                            <%}%>
                     <a href="/" class="none-decoration"> <li class="item-controller">Quay về trang chủ</li></a>
                </ul>
            </div>
            <div class="right-content">
                <h2 class="mb-3">Product List</h2>
                <a href="createProduct" class="btn btn-primary mb-3">Add Product</a>

                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Product ID</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Image</th>
                            <th>Stock Quantity</th>
                            <th>Category ID</th>



                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="product">
                            <tr>
                                <td>${product.product_id}</td>
                                <td>${product.product_name}</td>
                                <td><fmt:formatNumber value="${product.product_price}"/> VNĐ</td>
                                <td><img class="image-products" src="data:image/png;base64,${product.image_url}" alt="Product Image"/></td>
                                <td>${product.stock_quantity}</td>
                                <td>${product.category_id}</td>





                                <td>
                                    <a href="editProduct?productId=${product.product_id}" class="btn btn-sm btn-success">Edit</a>
                                    <form action="CrudProduct" method="post">
                                        <input type="hidden" name="product_id" value="${product.product_id}">
                                        <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this product?')">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- Bootstrap JS and Popper.js (Optional, for components like modals, dropdowns, etc.) -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>