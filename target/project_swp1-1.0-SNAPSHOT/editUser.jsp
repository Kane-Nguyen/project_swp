<%-- 
    Document   : editUser
    Created on : Mar 7, 2024, 8:01:34 AM
    Author     : tranq
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <title>Thay Đổi Thông Tin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <link href="./styles/headerCSS.css" rel="stylesheet"/>
        <link href="./styles/home2.css" rel="stylesheet"/>
        <link href="./styles/editUser.css" rel="stylesheet"/>
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
    <body class=" d-flex flex-column min-vh-100" style="height: 100%;
          margin: 0;">
        <div class="wrap-content ">
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
                        <li class="btn-danger btn white-space-nowrap no-mb w-100 border-bottom"><a href="/dashboard" class="text-decoration-none text-decoration-none text-dark">Management</a></li>

                        <% } else if (session.getAttribute("UserRole") != null && session.getAttribute("UserRole").equals("seller")) {  
                            
                        %>
                        <li class="btn-danger btn white-space-nowrap no-mb w-100 border-bottom"><a href="/order" class="text-decoration-none text-decoration-none text-dark">Management</a></li>
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
                    <li class="btn-danger btn white-space-nowrap no-mb"><a href="/order" class="text-decoration-none text-decoration-none text-dark">Management</a></li>
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

            <div class="d-flex justify-content-center w-100 mt-5 ">
                <form action="editUser" method="post" class="form" id="userInformationForm">
                    <c:set var="user" value="${User}" scope="request" />
                    <div class="form-row">
                        <div class="form-group">
                            <label for="inputEmail4">Họ Và Tên</label>
                            <input type="text" class="form-control" id="" placeholder="Nhập Họ Và Tên"  name="fullName" required value="${user.fullName}">
                        </div>
                        <div class="form-group ">
                            <label for="inputPassword4">Ngày Sinh</label>
                            <input type="date"  id="datePicker" name="birthDate" required value="${user.birthDate}" class="form-control" >
                        </div>

                        <div class="form-group">
                            <label for="inputAddress">Số Điện Thoại</label>
                            <input name="phoneNumber" required value="${user.phoneNumber}" class="form-control" id="inputAddress" placeholder="Nhập Số Điện Thoại">
                        </div>
                        <div class="form-group ">
                            <label for="inputAddress2">Địa Chỉ</label>
                            <input type="text" name="address" required value="${user.address}" class="form-control" id="inputAddress2" placeholder="Nhập Địa Chỉ">
                        </div>
                        <h3 class="text-danger fs-5 mt-4" id="errorMessages"></h3>
                    </div>
                    <input type="hidden" name="feature" value="info"/> 
                    <button type="submit" class="w-100 mt-3 btn btn-primary">Lưu</button>
                </form>

            </div>
            <div class="d-flex justify-content-center w-100 mt-2">
                <button data-bs-toggle="modal" data-bs-target="#addUser" id="exampleModal" class="form btn btn-dark">Đổi Mật Khẩu</button>
            </div>
            <div class="modal fade" id="addUser" tabindex="-1" aria-labelledby="addUser" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addUser">Đổi Mật Khẩu</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h5 id="errorMessages" class="text-danger"></h5>
                            <form id="userInformationForm1" action="editUser" method="post" class="container mt-3">
                                <div class="mb-3 input-group">
                                    <input type="password" class="form-control" name="oldpassword" id="newPassword" required placeholder="Nhập Mật Khẩu Cũ" value="" />
                                    <span class="input-group-text">
                                        <i class="fas fa-eye togglePasswordVisibility"></i>
                                    </span>
                                </div>
                                <div class="mb-3 input-group">
                                    <input type="password" class="form-control" name="password" id="newPassword" required placeholder="Nhập Mật Khẩu Mới" value="" />
                                    <span class="input-group-text">
                                        <i class="fas fa-eye togglePasswordVisibility"></i>
                                    </span>
                                </div>


                                <div class="mb-3 input-group">
                                    <input type="password" class="form-control" name="Repassword" id="reNewPassword" required placeholder="Nhập Lại Mật Khẩu Mới" value="" />
                                    <span class="input-group-text">
                                        <i class="fas fa-eye togglePasswordVisibility"></i>
                                    </span>
                                </div>
                                <input type="hidden" name="feature" value="pass"/>
                                <h3 class="text-danger" id="errorMessages1"></h3>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <input type="submit" class="btn btn-primary" value="Lưu" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <div class=" mt-5 py-3 footer">
                    <div class="ml-5 mt-5 ft1"> <h3 class="text-white">EndureTale S</h3>
                        <h3 class="text-white">CÔNG TY TNHH ENDURETALES</h3>
                        <p class="text-white">Mã số thuế : 92828823</p>
                        <p class="text-white">Địa chỉ : tòa nhà số 5, đường Nguyễn Văn Cừ nối dài, phường An Khánh, quận Ninh Kiều, Cần Thơ.s</p>
                        <h5 class="text-white">Kết nối với chúng tôi</h5>
                        <div class="d-flex justify-content-between"><ion-icon name="mail-outline"></ion-icon> <input type="mail" placeholder="Nhập email của bạn..."> <button>Xac Nhan</button></div></div>

                    <div style="width: 30%;" class="mt-5 ft2 items-center"> 
                        <div> <a href="#" class="text-decoration-none text-white">Mua hàng và thanh toán Online </a> <br>
                            <a href="#"class="text-decoration-none text-white">Mua hàng trả góp Online</a><br>
                            <a href="#"class="text-decoration-none text-white">Chính sách giao hàng</a><br>
                            <a href="#"class="text-decoration-none text-white"> Tra điểm Smember</a><br>
                            <a href="#"class="text-decoration-none text-white">Xem ưu đãi Smember</a><br>
                            <a href="#"class="text-decoration-none text-white">Tra thông tin bảo hành</a><br>
                            <a href="#"class="text-decoration-none text-white">Tra cứu hoá đơn điện tử</a><br>
                            <a href="#"class="text-decoration-none text-white"> Thông tin hoá đơn mua hàng</a><br>
                            <a href="#"class="text-decoration-none text-white">Trung tâm bảo hành chính hãng</a><br>
                            <a href="#"class="text-decoration-none text-white">Quy định về việc sao lưu dữ liệu</a><br></div>
                    </div>

                    <div style="width: 30%;" class="mr-5 mt-5 ft3"> 
                        <div>
                            <a href="#" class="text-decoration-none text-white"> Khách hàng doanh nghiệp (B2B) </a> <br>
                            <a href="#"class="text-decoration-none text-white">Ưu đãi thanh toán</a><br>
                            <a href="#"class="text-decoration-none text-white">Quy chế hoạt động</a><br>
                            <a href="#"class="text-decoration-none text-white"> Chính sách Bảo hành</a><br>
                            <a href="#"class="text-decoration-none text-white">Liên hệ hợp tác kinh doanh</a><br>
                            <a href="#"class="text-decoration-none text-white">Tuyển dụng</a><br>
                            <a href="#"class="text-decoration-none text-white">  Dịch vụ bảo hành điện thoại</a><br>
                            <a href="#"class="text-decoration-none text-white"> Dịch vụ bảo hành mở rộng</a><br></div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $("#userInformationForm").submit(function (event) {
                    var phoneNumber = $("input[name='phoneNumber']").val();
                    var phoneNumberRegex = /^\d{10}$/;
                    var errorMessage = '';
                    if (!phoneNumberRegex.test(phoneNumber)) {
                        errorMessage += "Phone number must be 10 digits and start by 0.<br>";
                    }


                    if (errorMessage.length > 0) {
                        $("#errorMessages").html(errorMessage);
                        event.preventDefault();
                    } else {
                        $("#errorMessages").html('');
                    }
                });

                $("#userInformationForm1").submit(function (event) {
                    var password = $("input[name='password']").val();
                    var Repassword = $("input[name='Repassword']").val();
                    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]{8,}$/;
                    var errorMessage = '';
                    if (!passwordRegex.test(password)) {
                        errorMessage += "Password must be at least 8 characters long, including uppercase, lowercase, and numbers.";
                    }
                    if (password !== Repassword) {
                        errorMessage += "Password and Repassword not equals";

                    }

                    if (errorMessage.length > 0) {
                        $("#errorMessages1").html(errorMessage);
                        event.preventDefault();
                    } else {
                        $("#errorMessages1").html('');
                    }
                });

                var today = new Date();
                var date = '2012-12-31';
                document.getElementById('datePicker').setAttribute("max", date);


                $(".togglePasswordVisibility").click(function () {
                    // Determine which input field is associated with the clicked icon
                    var inputField = $(this).parent().prev("input");
                    if (inputField.attr("type") === "password") {
                        inputField.attr("type", "text");
                        $(this).removeClass("fa-eye").addClass("fa-eye-slash");
                    } else {
                        inputField.attr("type", "password");
                        $(this).removeClass("fa-eye-slash").addClass("fa-eye");
                    }
                });





            });
        </script>


    </body>
</html>