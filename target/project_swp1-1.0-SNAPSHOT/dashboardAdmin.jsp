<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String role = (String) session.getAttribute("UserRole");
if(role == null || !role.trim().equals("admin")){
    response.sendRedirect("/page404");
    return;}    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
                <link rel="shortcut icon" href="./img-module/logo.png" type="image/x-icon" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="./styles/toolbarAdmin.css" rel="stylesheet"/>
        <link href="./styles/dashboardCSS.css" rel="stylesheet"/>
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="./styles/adminCSSProducts.css" rel="stylesheet"/>
        <link href="./styles/toolbarAdmin.css" rel="stylesheet"/>


    </head>
    <body>
        <div class="wrap-content">
            <div class="left-content">
                <h2 class="title-admin">EndureTale S</h2>
                <ul class="list-controller">
                    <% if(  session.getAttribute("UserRole").equals("admin")) { %>
                    <li class="item-controller active"> Bảng điều khiển</li>
                        <%}%>
                    <a href="/order" class="none-decoration"> <li class="item-controller">Quản lí đơn hàng</li></a>
                    <a href="/CrudProduct" class="none-decoration"> <li class="item-controller">Quản lí sản phẩm</li></a>
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
                <h2 class="title">Bảng điều khiển</h2>
                <div class="content">
                    <div class="content-detail">
                        <div class="box-content yellow">  <h1 class="text-content yellow-text">Tổng số lượng đơn hàng <span>${totalNumberOfOrders}</span> </h1></div>
                        <div class="box-content red"> <h1 class="text-content red-text">Tổng số lượng sản phẩm <span>${totalNumberOfProducts}</span></h1></div>
                        <div class="box-content green"> <h1 class="text-content green-text">Tổng số lượt click vào tất cả sản phẩm<span>${totalProductCount}</span> </h1></div>
                    </div>
                    <div class="content-detail">
                        <div class="box-content green"> <h1 class="text-content green-text">Tổng số lượng tổng stock<span>${totalStockQuantityOfProducts}</span> </h1></div>
                        <div class="box-content blue"><h1 class="text-content blue-text">Tổng số lượng người dùng<span>${totalUsersNumber}</span></h1></div>
                        
                    </div>

                </div>
                <div class="mt-5">
                    <table class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>ID</th>
                                <th>Product Name</th>
                                <th>Price</th>
                                <th>Image</th>
                                <th>Click</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${listProduct}" varStatus="status">
                                <tr>
                                    <th>${product.product_id}</th>
                                    <td>${product.product_name}</td>
                                    <td><span class="newPrice text-danger"><fmt:formatNumber value="${product.product_price}"/> VNĐ</span></td>
                                    <td>
                                        <img src="data:image/png;base64,${product.image_url}" alt="Product Image" style="width: 100px; height: auto;"/>
                                    </td>
                                    <td>${product.product_count}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="mt-5">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center gap-3">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link bg-primary text-white" href="?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${noOfPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link bg-primary text-white" href="?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < noOfPages}">
                                    <li class="page-item">
                                        <a class="page-link bg-primary text-white" href="?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>

            </div>
        </div>
    </body>
</html>