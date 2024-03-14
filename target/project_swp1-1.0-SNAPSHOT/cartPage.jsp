<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.lang.Boolean" %>
<%
if(session.getAttribute("UserRole") == null){
    response.sendRedirect("login");
    return; 
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>JSP Page</title>
            <link href="./styles/headerCSS.css" rel="stylesheet"/>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
                </head>
                <body>
                    <div class="wrap-content">
                        <div class="container content" style="height:60px;">
                            <div class="left-content">
                                <a href="/" class="logo-link"> 
                                    <img src="data:image/png;base64,${logo.image_url}" alt="logo" class="logo-image"/>
                                </a>
                                <div class="dropdown no-mb">
                                    <span class="btn dropdown-toggle " style="background-color: #fff;">Danh mục </span>
                                    <ul class="dropdown-content">
                                        <li><a class="dropdown-item" href="#">Điện thoại smart phone</a></li>
                                        <li><a class="dropdown-item" href="#">Ipad</a></li>
                                        <li><a class="dropdown-item" href="#">Laptop</a></li>
                                        <li><a class="dropdown-item" href="#">PC</a></li>
                                    </ul>
                                </div>
                                <div class="search">
                                    <form action="catalogsearchServlet">
                                        <input name="search" class="search-input" placeholder="Tìm kiếm..."/>
                                        <input name="page" value="1" type="hidden"/>
                                        <button class="search-btn">
                                            <svg height="20px" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" width="20px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M344.5,298c15-23.6,23.8-51.6,23.8-81.7c0-84.1-68.1-152.3-152.1-152.3C132.1,64,64,132.2,64,216.3  c0,84.1,68.1,152.3,152.1,152.3c30.5,0,58.9-9,82.7-24.4l6.9-4.8L414.3,448l33.7-34.3L339.5,305.1L344.5,298z M301.4,131.2  c22.7,22.7,35.2,52.9,35.2,85c0,32.1-12.5,62.3-35.2,85c-22.7,22.7-52.9,35.2-85,35.2c-32.1,0-62.3-12.5-85-35.2  c-22.7-22.7-35.2-52.9-35.2-85c0-32.1,12.5-62.3,35.2-85c22.7-22.7,52.9-35.2,85-35.2C248.5,96,278.7,108.5,301.4,131.2z"/></svg>
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="right-content">
                                <a href="/orderHistory" style="background-color: #fff;" class="btn white-space-nowrap no-mb">Tra cứu đơn hàng</a>
                                <%
                        if(session.getAttribute("UserRole") != null && session.getAttribute("UserRole").equals("admin")){
                                %>
                                <a href="/dashboard"><button class="btn-danger btn white-space-nowrap">Management</button></a>
                                <% }
            if(session.getAttribute("UserRole") == null){
                                %>
                                <a href="/login"><button style="background-color: #fff;" class=" btn white-space-nowrap">Đăng nhập</button></a>
                                <% }
                    
            if(session.getAttribute("UserRole") != null){
                                %>
                                <a href="/cart"><button style="background-color: #fff;" class=" btn white-space-nowrap">Giỏ hàng</button></a>
                                <% }
                    
            if(session.getAttribute("UserRole") != null){
                                %>
                                <a href="/logout"><button class="btn-danger btn white-space-nowrap">LogOut</button></a>
                                <% }
                                %>
                            </div>
                        </div>
                        <div>
                            <form action="orderPayment" method="post">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Tên Sản Phẩm</th>
                                            <th scope="col">Ảnh Sản Phẩm</th>
                                            <th scope="col">Giá Sản Phẩm</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Update</th>
                                            <th scope="col">Delete</th>
                                            <th scope="col">Select to Buy</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cart" items="${cartList}" varStatus="i">
                                            <tr>
                                                <input type="hidden" name="method" value="cart">
                                                    <td>${i.count}</td>
                                                    <td>
                                                        <c:forEach var="product" items="${ProductList}" varStatus="status">
                                                            <c:if test="${cart.product_id == product.product_id}">
                                                                ${product.product_name}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="product" items="${ProductList}" varStatus="status">
                                                            <c:if test="${cart.product_id == product.product_id}">
                                                                <img src="data:image/png;base64,${product.image_url}" style="width:100px; height:auto;"/>
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="product" items="${ProductList}" varStatus="status">
                                                            <c:if test="${cart.product_id == product.product_id}">
                                                                <span><fmt:formatNumber value="${product.product_price}"/> VNĐ</span>
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>${cart.quantity}</td>
                                                    <td>
                                                        <form action="cart" method="post">
                                                            <input type="hidden" name="method" value="updateQuantity">
                                                                <input type="hidden" name="cartId" value="${cart.cart_id}">
                                                                    <input type="number" name="newQuantity" min="0" value="${cart.quantity}">
                                                                        <button type="submit" class="btn btn-primary">Update</button>
                                                                        </form>
                                                                        </td>
                                                                        <td>
                                                                            <form action="cart" method="post">
                                                                                <input type="hidden" name="method" value="delete">
                                                                                    <input type="hidden" name="userId" value="${cart.user_id}">
                                                                                        <input type="hidden" name="productId" value="${cart.product_id}">
                                                                                            <input type="hidden" name="cartId" value="${cart.cart_id}">
                                                                                                <div class="d-flex" style="gap:4px;">
                                                                                                <button type="submit" class="btn btn-success">Mua</button>
                                                                                                <button type="submit" class="btn btn-danger">Xóa sản phẩm</button>
                                                                                                </div>
                                                                                                </form>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <input style="height: 20px;width: 20px;border-radius: 50%;" type="checkbox" name="selectedProducts" value="${cart.product_id}">
                                                                                                </td>
                                                                                                </tr>
                                                                                            </c:forEach>


                                                                                            </tbody>

                                                                                            </table>
                                                                                            <span> <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)"> Chọn Tất Cả </span><br>
                                                                                                <button type="submit" class="btn btn-primary">Mua sản phẩm</button>
                                                                                                </form>
                                                                                                </div>
                                                                                                </div>
                                                                                                <script>
                                                                                                    function toggleSelectAll(source) {
                                                                                                        checkboxes = document.getElementsByName('selectedProducts');
                                                                                                        for (var i = 0, n = checkboxes.length; i < n; i++) {
                                                                                                            checkboxes[i].checked = source.checked;
                                                                                                        }
                                                                                                    }
                                                                                                </script>
                                                                                                </body>
                                                                                                </html>