<%-- 
    Document   : oderPayment
    Created on : Mar 10, 2024, 7:48:17 PM
    Author     : Asus
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.lang.Boolean" %>
<%@ page import="java.time.LocalDate" %>
<%if(session.getAttribute("UserRole") == null){
   response.sendRedirect("404-page.jsp");
    return; 
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <title>Thanh Toán</title>
        <link rel="shortcut icon" href="./img-module/logo.png" type="image/x-icon" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link href="./styles/headerCSS.css" rel="stylesheet"/>
        <link href="./styles/home2.css" rel="stylesheet"/>
        <link href="./styles/footerCSS.css" rel="stylesheet"/>
        <script
            type="module"
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
            nomodule
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"
        ></script>
        <style>
            .list-menu{
                display: none;
            }
            @media (max-width: 992px) {
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
    <body>
        <div class="wrap-content">
            <div class="container content wrap-header" style="height:60px;">
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
                        <form action="catalogsearchServlet">
                            <input name="search" class="search-input" placeholder="Tìm kiếm..."/>
                            <input name="page" value="1" type="hidden"/>
                            <button class="search-btn">
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
            <div class="mt-5 container-fluid d-flex justify-content-around" style="min-height: 100vh">
                <div style="width: 40%">
                    <form id="paymentForm" action="CRUDOrderController" class="row g-3" method="post">

                        <input type="hidden" name="userIdNumber" value="<%= session.getAttribute("userId")%>">
                        <input type="hidden" name="method" value="buy">
                        <div class="col-md-6">
                            <label name="receiver"" class="form-label">họ và tên</label>
                            <input type="text" class="form-control" name="receiver"  required id="inputEmail4">
                        </div>
                        <div class="col-md-6">
                            <label name="phoneNumber" class="form-label">số điện thoại</label>
                            <input type="number" class="form-control"  required name="phoneNumber" id="inputPassword4">
                        </div>
                        <div class="col-12">
                            <label name="address" class="form-label">địa chỉ</label>
                            <input type="text" class="form-control" required name="address" id="inputAddress" placeholder="1234 Main St">
                        </div>
                        <div class="col-12">
                            <input type="hidden" class="form-control" name="createOrderDay" id="createOrderDay" value="<%= LocalDate.now() %>">
                        </div>
                        <div>
                            <h3 class="text-danger" id="errorMessages"></h3>
                        </div>
                        <c:if test="${requestScope.method == 'buyfromCart'}">
                            <c:forEach var="product" items="${ProductList}">
                                <input type="hidden" name="productId" value="${product.product_id}"/>

                                <c:forEach var="cartItem" items="${cartItems}">
                                    <c:if test="${cartItem.product_id == product.product_id}">
                                        <input type="hidden" name="methodBuy" value="cart"/>
                                        <input type="hidden" name="price" value="${product.product_price * cartItem.quantity}"/>
                                        <input type="hidden" name="quantity" value="${cartItem.quantity}"/>
                                        <input type="hidden" name="cartID" value="${cartItem.cart_id}"/>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </c:if>
                        <c:if test="${requestScope.method == 'buy'}">
                            <input type="hidden" name="methodBuy" value="BUY"/>
                            <input type="hidden" name="productId" value="${product.product_id}"/>
                            <input type="hidden" name="quantity" value="${requestScope.quantity}"/>
                            <input type="hidden" name="price" name="price" value="${product.product_price}"/>
                        </c:if>
                        <div class="col-md-4">
                            <label name="paymentMethod" class="form-label">phương thức thanh toán</label>
                            <select name="paymentMethod" id="inputState" class="form-select">
                                <option selected>COD</option>
                                <option>Credit Card</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <button id="pay" type="submit" class="btn btn-primary">Thanh toán</button>
                        </div>


                        <!-- Button trigger modal -->
                        <div class="col-12"> 
                            <button id="modal" type="button" class="btn btn-primary " data-bs-toggle="modal" data-bs-target="#exampleModal">
                                Thanh toán
                            </button>
                        </div>
                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Thanh Toán</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="container">
                                        <div class="modal-body">
                                            <img src="./img-module/qrCode.jpg" alt="alt" class="img-fluid"/>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" id="submitForm" class="btn btn-primary" >Đã Thanh Toán</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>
                </div>
                <div style="width: 40%">
                    <ul class="list-group">
                        <c:if test="${requestScope.method == 'buyfromCart'}">
                            <c:set var="total" value="0"/> <!-- Initialize total -->
                            <c:forEach var="product" items="${ProductList}" varStatus="status">
                                <li class="list-group-item">
                                    <div class="d-flex">
                                        <div>
                                            <img src="data:image/png;base64,${product.image_url}" width="50"/>

                                        </div>
                                        <div>
                                            <h6 class="d-inline">${product.product_name}  </h6>
                                            <br>
                                            <span>Giá: <fmt:formatNumber value="${product.product_price}" type="number"/> VNĐ</span>
                                            <c:forEach var="cartItem" items="${cartItems}" varStatus="status2">
                                                <c:if test="${cartItem.product_id == product.product_id}">
                                                    <br>
                                                    <span class=""> Số lượng: ${cartItem.quantity}</span>
                                                    <c:set var="itemTotal" value="${cartItem.quantity * product.product_price}"/>
                                                    <c:set var="total" value="${total + itemTotal}"/> <!-- Update total -->
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>




                                </li>
                            </c:forEach>
                            <h3 class="mt-3">Tổng Cộng: <fmt:formatNumber value="${total}" type="number"/> VNĐ</h3>
                        </c:if>
                        <c:if test="${requestScope.method == 'buy'}">  
                            <li class="list-group-item">
                                <div class="d-flex">
                                    <div>
                                        <img src="data:image/png;base64 ,${product.image_url}"/> 
                                    </div>
                                    <div>
                                        <h3>${product.product_name}</h3>
                                        <h6> Số Lượng: ${requestScope.quantity}</h6>
                                        <h6><fmt:formatNumber value="${product.product_price}"/> VNĐ
                                    </div>

                                    </h6>
                                </div> </li>
                            </c:if>

                    </ul>

                </div>
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


            <script>
                $(document).ready(function () {
                    function validateForm() {
                        var phoneNumber = $("input[name='phoneNumber']").val();
                        var phoneNumberRegex = /^\d{10}$/;
                        var errorMessage = '';

                        if (!phoneNumberRegex.test(phoneNumber)) {
                            errorMessage += "Số điện thoại phải có 10 chữ số và bắt đầu bằng 0.<br>";
                        }

                        // Thêm các kiểm tra khác nếu cần

                        if (errorMessage.length > 0) {
                            $("#errorMessages").html(errorMessage);
                            return false; // Có lỗi, không cho gửi form
                        } else {
                            $("#errorMessages").html(''); // Không có lỗi
                            return true; // Không có lỗi, cho gửi form
                        }
                    }

                    $('#exampleModal #submitForm').click(function (e) {
                        e.preventDefault(); // Ngăn chặn form tự động gửi

                        if (validateForm()) { // Kiểm tra form
                            $('#paymentForm').submit(); // Nếu không có lỗi, gửi form
                            $('#exampleModal').modal('hide');
                        }
                    });

                    // Đặt sự kiện submit form chính để kiểm tra khi không sử dụng modal
                    $("#paymentForm").submit(function (event) {
                        if (!validateForm()) { // Kiểm tra form
                            event.preventDefault(); // Ngăn chặn gửi form nếu có lỗi
                        }
                    });
                });

                $(document).ready(function () {
                // Function to update button visibility based on the payment method
                function updateButtonVisibility() {
                var paymentMethod = $('#inputState').val();
                        if (paymentMethod === 'Credit Card') {
                // Hide the "Sign in" submit button and show only the modal button for "Credit Card"
                $('form button[id="pay"]').hide();
                        $('form button[id="modal"]').show();
                } else {
                // Show the "Sign in" submit button and hide the modal button for other payment methods
                $('form button[id="pay"]').show();
                        $('form button[id="modal"]').hide();
                }
                }

                // Call updateButtonVisibility on page load to set the correct button visibility
                updateButtonVisibility();
                        // Event when the payment method selection changes
                        $('#inputState').change(function () {
                updateButtonVisibility();
                });
                        // Event when submitting the form
                        $('form').on('submit', function (e) {
                var paymentMethod = $('#inputState').val();
                        if (paymentMethod !== 'Credit Card') {
                // Submit the form if the payment method is not "Credit Card"

                } else {
                // Show the modal if the payment method is "Credit Card"
                e.preventDefault(); // Prevent the form from auto-submitting
                        $('#exampleModal').modal('show');
                }
                });
                        document.addEventListener('DOMContentLoaded', function () {
                        document.querySelector('#exampleModal .btn-primary').addEventListener('click', function (e) {
                        e.preventDefault(); // Ngăn chặn form tự động submit khi nhấp vào nút
                                document.querySelector('#paymentForm').submit(); // Gửi form
                        });
                        })
                ;

            </script>

    </body>
</html>