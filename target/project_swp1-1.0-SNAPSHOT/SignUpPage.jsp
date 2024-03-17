<%-- 
    Document   : SignUpPage
    Created on : Jan 30, 2024, 12:37:15 PM
    Author     : tranq
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
        <%if(session.getAttribute("UserRole") != null){
    response.sendRedirect("404-page.jsp");
    return; 
}
%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Ký</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
                <link rel="shortcut icon" href="./img-module/logo.png" type="image/x-icon" />

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="./styles/headerCSS.css"/>
        <link rel="stylesheet" href="./styles/signUpCSS.css"/>
    </head> 
    <body>  
        <div class="wrap-content">
            <div class="container content">
               <div class="container content" style="height:60px;">
                <div class="left-content">
                    <a href="/" class="logo-link"> 
                        <img src="data:image/png;base64,${logo.image_url}" alt="logo" class="logo-image"/>
                    </a>
                    <div class="dropdown no-mb">
                        <span class="btn dropdown-toggle btn-white">Danh mục </span>
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
            </div>
                <div class="right-content">
                    <button class="btn-white btn white-space-nowrap no-mb">Tra cứu đơn hàng</button>
                    <a href="/login"><button class="btn-white btn white-space-nowrap">Đăng nhập</button></a>
                </div>
            </div>
        </div>
        <div class="container">
            <h2 class="title-sign-up">Sign Up</h2>

            <% String method = request.getParameter("method");
               String email = (String) session.getAttribute("email");
               
               String error = request.getParameter("error");
            %>


            <h3 id="errorMessages" class="text-danger"></h3>


            <% if (!"infomation".equals(method) && !"enter".equals(method)) { %>
            <form action="SendOtpServlet" method="get">
                <div class="wrap-input-email">
                    <input type="text" name="email" required placeholder="Enter your email" class="input-email"/>
                    
                </div>

                <input type="hidden" name="feature" value="SignUp"/>
                <div class="wrap-submit-btn">
                    <input type="submit" value="Verify OTP" class="btn-submit"/>
                </div>
                <div class="wrap-link-sign-up">
                    <a href="/login" class="sign-up-link">Quay lại đăng nhập</a>
                </div>

            </form>
            <% } %>

            <%-- Form to enter OTP --%>
            <% if ("enter".equals(method)) { %>
            <form action="VerifyOtpServlet" method="post">
                <div class="wrap-input-email">
                    <input type="text" name="otp" required class="input-email" placeholder="Enter OTP Code"/>
                </div>
                <input type="hidden" name="email" value="<%= email %>" />
                <input type="hidden" name="feature" value="SignUp"/>
                <div class="wrap-btn">
                    <input type="submit" value="Verify OTP" class="btn-primary btn"/>
                </div>
            </form>
            <form action="SendOtpServlet" method="get">
                <input type="hidden" name="email" value="<%= email %>" />
                <input type="hidden" name="feature" value="SignUp"/>
                <div class="wrap-btn">
                    <input type="submit" value="Resend OTP" class="btn-primary btn"/>
                </div>
            </form>
            <% } %>

            <%-- Display error messages --%>
            <% if ("exited".equals(error)) { %>
            <h3 class="text-danger">Email Exited</h3>
            <% } else if ("invalidOTP".equals(error)) { %>
            <h3 class="text-danger">OTP invalid or expiry time</h3>
            <% } %>

            <%-- Form to enter user information --%>
            <% if ("infomation".equals(method)) { %>
            <form action="signUp" method="post" class="container mt-10" id="userInformationForm">
                <div class="wrap-input-email">
                    <input class="input-email" type="text" name="fullName" placeholder="Vui Lòng Nhập Tên" required />
                </div>
                <div class="wrap-input-email">
                    <input class="input-email" type="date" name="birthdate" id="datePicker" placeholder="Vui Lòng Nhập Ngày Sinh" max="" required />
                </div>
                <div class="wrap-input-email">
                    <input class="input-email" type="text" name="address" required placeholder="Vui Lòng Nhập Địa Chỉ" />
                </div>
                <div class="wrap-input-email">
                    <input class="input-email" type="number" name="phoneNumber" required placeholder="Vui Lòng Nhập Số Điện Thoại" />
                </div>
                <div class="wrap-input-email">
                    <input class="input-email" type="password" name="password" required placeholder="Vui Lòng Nhập Mật Khẩu" />
                </div>
                <div class="wrap-input-email">
                    <input class="input-email"v type="hidden" name="email" value="<%= email %>" />
                </div>
                <div >
                    <input  type="hidden" name="userRole" value="customer" />
                </div>
                <div class="wrap-submit-btn">
                    <input class="btn-submit" type="submit" value="Sign Up" />
                </div>
                <div class="wrap-link-sign-up">
                    <a href="/login" class="sign-up-link">Quay lại đăng nhập</a>
                </div>
            </form>
            <% } %>
        </div>
        <script>
            $(document).ready(function () {
                $("#userInformationForm").submit(function (event) {
                    var phoneNumber = $("input[name='phoneNumber']").val();
                    var password = $("input[name='password']").val();
                    var phoneNumberRegex = /^\d{10}$/;
                    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]*$/;
                    var errorMessage = '';

                    if (!phoneNumberRegex.test(phoneNumber)) {
                        errorMessage += "Phone number must be 10 digits and start by 0.<br>";
                    }

                    if (!passwordRegex.test(password)) {
                        errorMessage += "Password must be at least 8 characters long, including uppercase, lowercase, and numbers.";
                    }

                    if (errorMessage.length > 0) {
                        $("#errorMessages").html(errorMessage);
                        event.preventDefault(); // Prevent form submission
                    } else {
                        $("#errorMessages").html(''); // Clear error message
                    }
                });
            });

            var today = new Date();
            var date = '2012-12-31';
            document.getElementById('datePicker').setAttribute("max", date);
        </script>

    </body>
</html>