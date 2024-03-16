<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%String email = (String) session.getAttribute("email");;%>
<%String method = request.getParameter("method"); %>
<%String emailExit = request.getParameter("emailExit"); 
String error = request.getParameter("error");%>
<html>
    <%if(session.getAttribute("UserRole") != null){
    response.sendRedirect("/");
    return; 
}
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Password Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="./styles/headerCSS.css"/>
        <link rel="stylesheet" href="./styles/forgotPasswordCSS.css"/>
    </head>
    <body>
        <div class="wrap-content">
            <div class="container content">
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
                        <input class="search-input" placeholder="Tìm kiếm..."/>
                        <button class="search-btn">
                            <svg height="20px" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" width="20px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M344.5,298c15-23.6,23.8-51.6,23.8-81.7c0-84.1-68.1-152.3-152.1-152.3C132.1,64,64,132.2,64,216.3  c0,84.1,68.1,152.3,152.1,152.3c30.5,0,58.9-9,82.7-24.4l6.9-4.8L414.3,448l33.7-34.3L339.5,305.1L344.5,298z M301.4,131.2  c22.7,22.7,35.2,52.9,35.2,85c0,32.1-12.5,62.3-35.2,85c-22.7,22.7-52.9,35.2-85,35.2c-32.1,0-62.3-12.5-85-35.2  c-22.7-22.7-35.2-52.9-35.2-85c0-32.1,12.5-62.3,35.2-85c22.7-22.7,52.9-35.2,85-35.2C248.5,96,278.7,108.5,301.4,131.2z"/></svg>
                        </button>

                    </div>


                </div>
                <div class="right-content">
                    <button class="btn-white btn white-space-nowrap no-mb">Tra cứu đơn hàng</button>
                    <a href="/login"><button class="btn-white btn white-space-nowrap">Đăng nhập</button></a>
                </div>
            </div>
        </div>
        <div class="container">
            <h2 class="title-forgot-password">Fogot Password</h2>
            <h3 id="errorMessages" class="text-danger"></h3>
            <%if(!"enterPassword".equals(method)&& !"enter".equals(method)){%>
            <form action="SendOtpServlet" method ="get">
                <div class="wrap-input-gmail">
                    <input class="input-email" type="text" name="email" placeholder="Enter your email" required/>
                </div>

                <input type="hidden" name="feature" value="FGPW" />
                <div class="wrap-submit-btn">
                    <input type="submit" value="Verify OTP" class="submit-btn"/>
                </div>
                <div class="wrap-link-sign-up">
                    <a href="/login" class="sign-up-link">Quay lại đăng nhập</a>
                </div>

            </form>
            <%}%>
            <%                
                         if ("enter".equals(method)) {
            %>

            <form action="VerifyOtpServlet" method="post">
                <div class="wrap-input-gmail">
                    <input class="input-email" type="text" name="otp" required  placeholder="Enter your OTP Code"/>
                </div>
                <div class="wrap-submit-btn">
                    <input class="submit-btn" type="submit" value="Verify OTP" />
                </div>

                <input type="hidden" name="feature" value="FGPW"/>
                <input type= "hidden" name="email" value="<%= email%>" required/>
            </form>

            <% 
                } 
    if("invalidOTP".equals(error)){
            %> <h3 class="text-danger">Otp Invalid</h3>
            <%}
if("enterPassword".equals(method)){%>
            <form action="forgotPassword" method="POST" id="enterPassword">
                <div class="wrap-input-gmail">
                    <input class="input-email" type="password" name="password" placeholder="Enter Your Password" required/>
                </div>
                <div class="wrap-input-gmail">
                    <input class="input-email" type="password" name="Repassword" placeholder="Re-enter your password" required/>
                </div>
                <input type="hidden" name="email" value="<%=email%>"required/>
                <div class="wrap-submit-btn">
                    <input class="submit-btn" type="submit" value="Change Password"/>
                </div>
            </form>
            <%}%> <% 
             if("emailNotExit".equals(error)){%>
            <h3 class="text-danger">Email does not Exit</h3>
            <%}%>
        </div>
        <script>
            $(document).ready(function () {
                $("#enterPassword").submit(function (event) {
                    var password = $("input[name='password']").val();
                    var repassword = $("input[name='Repassword']").val();
                    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]*$/;
                    var errorMessages = '';
                    console.log(password);
                    console.log(repassword);
                    if (!passwordRegex.test(password)) {
                        console.log("Password must be at least 8 characters long, including uppercase, lowercase, and numbers. </br>");
                        errorMessages += "Password must be at least 8 characters long, including uppercase, lowercase, and numbers. </br>";
                        event.preventDefault();
                    }
                    if (password !== repassword) {
                        console.log("Mật khẩu không khớp. Vui lòng nhập lại.");
                        errorMessages += "Mật khẩu không khớp. Vui lòng nhập lại.";
                        event.preventDefault(); // Ngăn chặn form được gửi nếu mật khẩu không khớp
                    }


                    if (errorMessages.length > 0) {
                        $("#errorMessages").html(errorMessages);
                        event.preventDefault(); // Prevent form submission
                    } else {
                        $("#errorMessages").html(''); // Clear error message
                    }
                });
            });

        </script>

    </body>
</html>