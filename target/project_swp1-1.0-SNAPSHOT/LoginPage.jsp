<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <%if(session.getAttribute("UserRole") != null){
response.sendRedirect("/");
return; 
}%>
    <head>
        <title>LogIn Store</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./styles/loginPageCSS.css"/>
        <link rel="stylesheet" href="./styles/headerCSS.css"/>
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
        <form action="login" method="post" class="container mt-10 form-login">
            <h2 class="title-login">Đăng nhập</h2>
            <div class="form-group wrap-input-login">
                <input type="email" name="email" class="form-control input-email" id="exampleInputEmail1" aria-describedby="emailHelp" value="" placeholder="Enter your email">
            </div>
            <div class="form-group wrap-input-password">
                <input type="password" name="password" class="form-control input-password" id="exampleInputPassword1" value="" placeholder="Enter your password">
            </div>
            <div class="wrap-link-forgot-password">
                <a href="/forgotPassword" class="forgot-password-link white-space-nowrap">Quên mật khẩu?<a/>
            </div>

            <input type="hidden" name="redirect" value="<%= request.getParameter("redirect") %>" />
            <div class="wrap-submit-btn">
                <button type="submit" value="LOGIN" class="btn btn-primary submit-btn">Đăng nhập</button>
            </div>
            <div class="wrap-link-sign-up">
                <p class="sign-up-word">Bạn chưa có tài khoản?</p><a href="/signUp" class="sign-up-link"> Đăng ký ngay</a>
            </div>
        </form>
        <h3 style="color:red; text-align: center;">${requestScope.error}</h3>
        <%
                   String error = request.getParameter("error");
                   if ("invalid".equals(error)) {
        %>
        <p class="check-error " style="color: red; font-weight: 600;">Please,try again enter your email or password.</p>
        <%
            }
        %>
        <script>
            // JavaScript code to toggle password visibility
            document.getElementById("rememberMe").addEventListener("change", function () {
                var passwordInput = document.getElementById("exampleInputPassword1");
                if (this.checked) {
                    passwordInput.type = "text";
                } else {
                    passwordInput.type = "password";
                }
            });
        </script>
    </body>
</html>