<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.lang.Boolean" %>
<%
String role = (String) session.getAttribute("UserRole");
if(role == null || !role.trim().equals("admin")){
    response.sendRedirect("loginPage.jsp");
    return;}    
%>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách người dùng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="./styles/toolbarAdmin.css" rel="stylesheet"/>
        <link href="./styles/adminCSSUser.css" rel="stylesheet"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="wrap-content">
            <div class="left-content">
                <h2 class="title-admin">EndureTale S</h2>
                <ul class="list-controller">
                    <% if(  session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/dashboard" class="none-decoration"><li class="item-controller">Bảng điều khiển</li></a>
                            <%}%>
                    <a href="/order" class="none-decoration"> <li class="item-controller">Quản lí đơn hàng</li></a>
                    <a href="/CrudProduct" class="none-decoration"> <li class="item-controller">Quản lí sản phẩm</li></a>
                            <% if(session.getAttribute("UserRole").equals("admin")) { %>
                    <li class="item-controller active">Quản lí người dùng</li>
                        <%}
                          if(  session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/admin-setting" class="none-decoration"><li class="item-controller">Quản lí cài đặt</li></a>
                            <%}%>
                         <a href="/" class="none-decoration"> <li class="item-controller">Quay về trang chủ</li></a>
                </ul>
            </div>
            <div class="right-content">



                <h2>Danh sách người dùng</h2>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUser">
                    Thêm
                </button>


                <div class="modal fade" id="addUser" tabindex="-1" aria-labelledby="addUser" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addUser">Thêm Người Dùng</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <h5 id="errorMessages" class="text-danger"></h5>
                                <form id="userInformationForm" action="SendOtpServlet" method="get" class="container mt-3">
                                    <input name="feature" value="add" type="hidden" />
                                    <div class="mb-3">
                                        <input type="hidden" class="form-control" name="id" placeholder="Please Enter Full Name" value="" required />
                                    </div>
                                    <div class="mb-3">
                                        <input type="text" class="form-control" name="fullName" placeholder="Vui Lòng Nhập Tên" value="" required />
                                    </div>
                                    <div class="mb-3">
                                        <input type="date" class="form-control" name="birthdate" id="datePicker" placeholder="Vui Lòng Nhập Ngày Sinh" value=""  required />
                                    </div>
                                    <div class="mb-3">
                                        <input type="text" class="form-control" name="address" required placeholder="Vui Lòng Nhập Địa Chỉ" value="" />
                                    </div>
                                    <div class="mb-3">
                                        <input type="number" class="form-control" name="phoneNumber" required placeholder="Vui Lòng Nhập Số Điện Thoại " value="}" />
                                    </div>
                                    <div class="mb-3">
                                        <input type="email" class="form-control" name="email" required placeholder="Vui Lòng Nhập Email" value="" />
                                    </div>
                                    <div class="mb-3">
                                        <input type="password" class="form-control" name="password" required placeholder="Vui Lòng Nhập Password" value="" />
                                    </div>
                                    <div class="mb-3">
                                        <label>Vai trò</label>
                                        <select class="form-select" name="role">
                                            <option value="customer">
                                                Khách Hàng
                                            </option>
                                            <option value="seller">
                                                Người Bán Hàng
                                            </option>
                                        </select>
                                    </div>
                                    


                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                        <input type="submit" class="btn btn-primary" value="SAVE" />
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Nhập Otp</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="VerifyOtpServlet" method="POST">

                                    <input class="form-control" placeholder="Please Enter OTP" name="otp" type="number" value="" required=""/>          
                                    <input name="feature" type="hidden" value="add" required=""/>       


                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" value="Submit" />
                                <a href="/AdminUser" class="btn btn-danger">Cancel</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <table class="table table-hover">
                    <tr>

                        <th>Tên</th>
                        <th>Ngày Sinh</th>
                        <th>Số Điện Thoại</th>
                        <th>Email</th>
                        <th>Địa Chỉ</th>

                        <th>Vai Trò</th>
                        <th></th>
                    </tr>
                    <c:forEach var="user" items="${listUsers}" varStatus="status">
                        <tr>
                            <td>${user.fullName}</td>
                            <td><fmt:formatDate value="${user.birthDate}" pattern="dd/MM/yyyy"/></td>
                            <td>${user.phoneNumber}</td>
                            <td>${user.email}</td>
                            <td>${user.address}</td>

                            <td>${user.userRole}</td>
                            <td>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#signupModal${user.userId}">
                                    Sửa
                                </button>
                                <div class="modal fade" id="signupModal${user.userId}" tabindex="-1" aria-labelledby="signupModalLabel${user.userId}" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="signupModalLabel${user.userId}">Edit User</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <h5 id="errorMessages1" class="text-danger"></h5>
                                                <form id="userInformationForm1" action="AddEditDeleteUser" method="post" class="container mt-3">

                                                    <div class="mb-3">
                                                        <input type="hidden" class="form-control" name="id" placeholder="Please Enter Full Name" value="${user.userId}" required />
                                                    </div>
                                                    <div class="mb-3">
                                                        <input type="text" class="form-control" name="fullName" placeholder="Please Enter Full Name" value="${user.fullName}" required />
                                                    </div>
                                                    <div class="mb-3">
                                                        <input type="date" class="form-control" name="birthdate" id="datePicker1" placeholder="Please Enter Birthdate" value="${user.birthDate}"  required />
                                                    </div>
                                                    <div class="mb-3">
                                                        <input type="text" class="form-control" name="address" required placeholder="Please Enter Address" value="${user.address}" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <input type="number" class="form-control" id="phoneNumber1" name="phoneNumber" required placeholder="Please Enter Phone Number" value="${user.phoneNumber}" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <input type="email" class="form-control" name="email" required placeholder="Please Enter email" value="${user.email}" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <input type="password" class="form-control" id="password1" name="password" required placeholder="Please Enter Password" value="${user.password}" />
                                                    </div>
                                                    <input type="hidden" value="edit" name="method"/>


                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <input type="submit" class="btn btn-primary" value="Lưu" />
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </td>
                            <td>
                                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#DeleteModal${user.userId}">
                                    Xóa
                                </button>

                                <!-- Modal -->
                                <div class="modal fade" id="DeleteModal${user.userId}" tabindex="-1" aria-labelledby="DeleteModalLabel${user.userId}" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="DeleteModalLabel${user.userId}">Delete User</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <h3>Bạn Có Chắc Xóa Người Dùng Này Không</h3>
                                                <form  action="AddEditDeleteUser" method="POST">
                                                    <input type="hidden" value="${user.userId}" name="id"/>
                                                    <input type="hidden" value="delete" name="method"/>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <input type="submit" class="btn btn-danger" value="Delete" />
                                                    </div>

                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                var openModalButton = document.getElementById('openModalButton');
                var myModal = new bootstrap.Modal(document.getElementById('exampleModal'), {
                    keyboard: true
                });


                openModalButton.addEventListener('click', function () {
                    myModal.show();
                });
            });

            document.addEventListener('DOMContentLoaded', (event) => {

                function getQueryParam(param) {
                    const urlParams = new URLSearchParams(window.location.search);
                    return urlParams.get(param);
                }


                if (getQueryParam('method') === 'add') {

                    $('#exampleModal').modal('show');


                }
            });
            $("#userInformationForm").submit(function (event) {
                var phoneNumber = $("input[name='phoneNumber']").val();
                var password = $("input[name='password']").val();
                var phoneNumberRegex = /^\d{10}$/;
                var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]*$/;
                var errorMessage = '';
                console.log(phoneNumber);
                if (!phoneNumberRegex.test(phoneNumber)) {
                    errorMessage += "Phone number must be 10 digits and start by 0.<br>";
                }

                if (!passwordRegex.test(password)) {
                    errorMessage += "Password must be at least 8 characters long, including uppercase, lowercase, and numbers.";
                }

                if (errorMessage.length > 0) {
                    $("#errorMessages1").html(errorMessage);
                    event.preventDefault(); // Prevent form submission
                } else {
                    $("#errorMessages1").html(''); // Clear error message
                }
            });

            $("#userInformationForm1").submit(function (event) {
                var phoneNumber = $("#phoneNumber1").val();
                var password = $("#password1").val();
                var phoneNumberRegex = /^\d{10}$/;
                var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]*$/;
                var errorMessage = '';
                console.log(phoneNumber);
                if (!phoneNumberRegex.test(phoneNumber)) {
                    errorMessage += "Phone number must be 10 digits and start by 0.<br>";
                }

                if (!passwordRegex.test(password)) {
                    errorMessage += "Password must be at least 8 characters long, including uppercase, lowercase, and numbers.";
                }

                if (errorMessage.length > 0) {
                    $("#errorMessages1").html(errorMessage);
                    event.preventDefault(); // Prevent form submission
                } else {
                    $("#errorMessages1").html(''); // Clear error message
                }
            });

            var today = new Date();
            var date = '2012-12-31';
            document.getElementById('datePicker').setAttribute("max", date);
            document.getElementById('datePicker1').setAttribute("max", date);
        </script>

    </body>
</html>
