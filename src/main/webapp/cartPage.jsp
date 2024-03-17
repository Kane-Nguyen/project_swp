<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.lang.Boolean" %>
<%
if(session.getAttribute("UserRole") == null){
    response.sendRedirect("404-page.jsp");
    return; 
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>JSP Page</title>
            <link href="./styles/headerCSS.css" rel="stylesheet"/>
            <link href="./styles/footerCSS.css" rel="stylesheet"/>
            <link rel="shortcut icon" href="./img-module/logo.png" type="image/x-icon" />

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                 <style>.list-menu{
                display: none;
            }
            @media (max-width: 1200px) {
                .right-content{
                    display: none;
                }
                .wrap-header{
                    display: flex;
                    justify-content: space-between;
                }
                .list-menu{
                    display: block;
                }
            }
        </style>
                </head>
                <body class=" d-flex flex-column justify-content-between min-vh-100">
                    <div class="wrap-content">
                        <div class="container content" style="height:60px;">
                              <div class="container content" style="height:60px;display: flex;justify-content: space-between">
                    <div class="left-content">
                        <a href="/" class="logo-link"> 
                            <img src="data:image/png;base64,${logo.image_url}" alt="logo" class="logo-image"/>
                        </a>
                        <div class="dropdown no-mb">
                            <span class="btn dropdown-toggle btn-white">Danh mục </span>
                            <ul class="dropdown-content">
                                <li><a class="dropdown-item" href="catalogsearchServlet?catetory=1&search=">Điện thoại smart phone</a></li>
                                <li><a class="dropdown-item" href="catalogsearchServlet?catetory=2&search=">Ipad</a></li>
                                <li><a class="dropdown-item" href="catalogsearchServlet?catetory=3&search=">Laptop</a></li>
                                <li><a class="dropdown-item" href="catalogsearchServlet?catetory=4&search=">PC</a></li>
                            </ul>
                        </div>
                        <div class="search">
                            <form action="catalogsearchServlet" style="margin: 0px;">
                                <input name="search" class="search-input" placeholder="Tìm kiếm..."/>
                                <input name="page" value="1" type="hidden"/>
                                <button class="search-btn" style="top: 4px;">
                                    <svg height="20px" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" width="20px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M344.5,298c15-23.6,23.8-51.6,23.8-81.7c0-84.1-68.1-152.3-152.1-152.3C132.1,64,64,132.2,64,216.3  c0,84.1,68.1,152.3,152.1,152.3c30.5,0,58.9-9,82.7-24.4l6.9-4.8L414.3,448l33.7-34.3L339.5,305.1L344.5,298z M301.4,131.2  c22.7,22.7,35.2,52.9,35.2,85c0,32.1-12.5,62.3-35.2,85c-22.7,22.7-52.9,35.2-85,35.2c-32.1,0-62.3-12.5-85-35.2  c-22.7-22.7-35.2-52.9-35.2-85c0-32.1,12.5-62.3,35.2-85c22.7-22.7,52.9-35.2,85-35.2C248.5,96,278.7,108.5,301.4,131.2z"/></svg>
                                </button>
                            </form>
                        </div>
                    </div>
                    <!-- Mobile -->
                    <div class="dropdown list-menu">
                        <span class="btn dropdown-toggle btn-white">Menu</span>
                        <ul class="dropdown-content" style="padding: 0px;">
                            <li class="btn-white btn white-space-nowrap no-mb w-100 border-bottom">  <a href="/orderHistory" class="text-decoration-none text-decoration-none text-dark">Tra cứu đơn hàng</a></li>
                                <%
               if(session.getAttribute("UserRole") != null && session.getAttribute("UserRole").equals("admin")){
                                %>
                            <li class="btn-danger btn white-space-nowrap no-mb w-100 border-bottom"><a href="/dashboard" class="text-decoration-none text-decoration-none text-dark">Quản Lý</a></li>

                            <% } else if (session.getAttribute("UserRole") != null && session.getAttribute("UserRole").equals("seller")) {  
                            
                            %>
                            <li class="btn-danger btn white-space-nowrap no-mb w-100 border-bottom"><a href="/order" class="text-decoration-none text-decoration-none text-dark">Quản Lý</a></li>
                                <% }

                                     if(session.getAttribute("UserRole") == null){
                                %>
                            <li class="btn-white btn white-space-nowrap no-mb w-100 border-bottom"> <a href="/login" class="text-decoration-none text-decoration-none text-dark">Đăng nhập</a></li>
                                <% }
                                %>
                            <li class="btn-white btn white-space-nowrap no-mb w-100 border-bottom"> <a href="/cart" class="text-decoration-none text-decoration-none text-dark">Giỏ hàng</a></li>
                                <% 
                                if(session.getAttribute("UserRole") != null){
                                %>
                            <li class="btn-white btn white-space-nowrap no-mb w-100 border-bottom"><a href="/logout" class="text-decoration-none text-decoration-none text-dark">Đăng Xuất</a></li>
                                <% }
 
                                if(session.getAttribute("UserRole") != null){
                                %>
                            <li class="btn-white btn white-space-nowrap no-mb w-100 border-bottom"><a href="/editUser" class="text-decoration-none text-decoration-none text-dark">Hồ Sơ</a></li>
                                <% }
                                %>
                        </ul>
                    </div>
                    <!-- Desktop -->
                    <div class="right-content">
                        <!-- Example single danger button -->

                        <a href="/orderHistory" class="btn-white btn white-space-nowrap no-mb">Tra cứu đơn hàng</a>
                        <%
                if(session.getAttribute("UserRole") != null && session.getAttribute("UserRole").equals("admin")){
                        %>
                        <a href="/dashboard"><button class="btn-danger btn white-space-nowrap">Quản Lý</button></a>
                        <% } else if (session.getAttribute("UserRole") != null && session.getAttribute("UserRole").equals("seller")) {  
                            
                        %>
                        <li class="btn-danger btn white-space-nowrap no-mb"><a href="/order" class="text-decoration-none text-decoration-none text-dark">Quản Lý</a></li>
                            <% }
     if(session.getAttribute("UserRole") == null){
                            %>
                        <a href="/login"><button class="btn-white btn white-space-nowrap">Đăng nhập</button></a>
                        <% }
                    
    if(session.getAttribute("UserRole") != null){
                        %>
                        <a href="/cart"><button class="btn-white btn white-space-nowrap">Giỏ hàng</button></a>
                        <% }
                    
    if(session.getAttribute("UserRole") != null){
                        %>
                        <a href="/logout"><button class="btn-danger btn white-space-nowrap">Đăng Xuất</button></a>
                        <% }
    if(session.getAttribute("UserRole") != null){
                        %>
                        <a href="/editUser"><button class="btn-white btn white-space-nowrap">Hồ Sơ</button></a>
                        <% }
                        %>
                    </div>
                </div>
                        </div>
                        <div style="min-height: 100vh;">
                            <div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="statusModalLabel">Thông Báo</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">

                                            <h5>Vui Lòng Chọn Sản Phẩm Để Thanh Toán</h5>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Tên Sản Phẩm</th>
                                        <th scope="col">Ảnh Sản Phẩm</th>
                                        <th scope="col">Giá Sản Phẩm</th>
                                        <th scope="col">Số Lượng</th>
                                        <th scope="col">Cập Nhật</th>
                                        <th scope="col">Xóa</th>
                                        <th scope="col">Chọn Để Mua</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cart" items="${cartList}" varStatus="i">
                                        <tr>

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
                                                    <input type="hidden" name="method" value="updateQuantity"/>
                                                    <input type="hidden" name="id" value="${cart.cart_id}"/>
                                                    <input type="number" name="newQuantity" value="" required=""/>
                                                    <button type="submit" class="btn btn-danger">Cập Nhật Số Lượng</button>
                                                </form>
                                            </td>


                                            <td>
                                                <form action="cart" method="post">
                                                    <input type="hidden" name="method" value="delete"/>
                                                    <input type="hidden" name="id" value="${cart.cart_id}"/>
                                                    <button type="submit" class="btn btn-danger">Xóa sản phẩm</button>
                                                </form>
                                            </td>
                                            <td>
                                                <input  form="purchaseForm" style="height: 20px;width: 20px;border-radius: 50%;" type="checkbox" name="selectedProducts" value="${cart.product_id}" onclick="checkAllSelected()">

                                            </td>
                                        </tr>

                                    </c:forEach>


                                </tbody>

                            </table>
                            <form id="purchaseForm" action="orderPayment" method="post">  
                                <input type="hidden" name="method" value="cart">
                                    <span> <input type="checkbox" id="selectAll" style="height: 20px;width: 20px;border-radius: 50%;" onclick="toggleSelectAll(this)"> Chọn Tất Cả </span><br>
                                        <button type="submit" class="btn btn-primary">Mua sản phẩm</button>
                                        </form>
                                        </div>
                                        <div>
                                            <div class=" mt-5 py-3 footer">
                                                <div class="ml-5 mt-5 ft1"> <h3 class="text-white">EndureTale S</h3>
                                                    <h3 class="text-white">CÔNG TY TNHH ENDURETALES</h3>
                                                    <p class="text-white">Mã số thuế : 92828823</p>
                                                    <p class="text-white">Địa chỉ : tòa nhà số 5, đường Nguyễn Văn Cừ nối dài, phường An Khánh, quận Ninh Kiều, Cần Thơ.s</p>
                                                    <h5 class="text-white">Kết nối với chúng tôi</h5>
                                                    <div class="d-flex" style="gap:10px;"><input type="mail" placeholder="Nhập email của bạn..." style="    border-radius: 4px; height: 32px;
                                                                                                 border: none;
                                                                                                 outline: none;"> <button class="btn-primary btn">Xac Nhan</button></div></div>

                                                <div style="width: 30%;" class="mt-5 ft2 items-center"> 
                                                    <a href="/supportUser" class="btn btn-success text-white">Lấy thông tin hổ trợ người dùng</a>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                        <script>
                                            // This function is triggered when the "Select All" checkbox changes state.
                                            function toggleSelectAll(source) {
                                                var checkboxes = document.getElementsByName('selectedProducts');
                                                for (var i = 0, n = checkboxes.length; i < n; i++) {
                                                    checkboxes[i].checked = source.checked;
                                                }
                                            }

                                            // This function checks if all individual checkboxes are checked and updates the "Select All" checkbox.
                                            function checkAllSelected() {
                                                var allCheckboxes = document.getElementsByName('selectedProducts');
                                                var selectAllCheckbox = document.getElementById('selectAll');
                                                // Check if the number of checked boxes is equal to the total number of checkboxes.
                                                var allChecked = Array.from(allCheckboxes).every(checkbox => checkbox.checked);
                                                selectAllCheckbox.checked = allChecked;

                                                // If not all boxes are checked, also ensure the selectAllCheckbox is not in an indeterminate state
                                                var anyChecked = Array.from(allCheckboxes).some(checkbox => checkbox.checked);
                                                selectAllCheckbox.indeterminate = anyChecked && !allChecked;
                                            }

                                            $(document).ready(function () {
                                                // Function to get the value of a query parameter by name
                                                function getQueryParamByName(name, url = window.location.href) {
                                                    name = name.replace(/[\[\]]/g, '\\$&');
                                                    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                                                            results = regex.exec(url);
                                                    if (!results)
                                                        return null;
                                                    if (!results[2])
                                                        return '';
                                                    return decodeURIComponent(results[2].replace(/\+/g, ' '));
                                                }

                                                // Check the 'status' query parameter and set modal content
                                                var status = getQueryParamByName('error');
                                                if (status === 'noProductSelected') {
                                                    console.log(status);
                                                    var statusModal = new bootstrap.Modal(document.getElementById('statusModal'), {
                                                        keyboard: false
                                                    });
                                                    statusModal.show();
                                                }
                                            });
                                        </script>
                                        </body>
                                        </html>