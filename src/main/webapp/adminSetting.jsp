<%-- 
    Document   : adminSetting
    Created on : Mar 6, 2024, 9:40:21 PM
    Author     : Asus
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="./styles/toolbarAdmin.css" rel="stylesheet"/>
        <link href="./styles/adminSettingCSS.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div>
            <div class="left-content">
                <h2 class="title-admin">EndureTale S</h2>
                <ul class="list-controller">
                    <% if(session.getAttribute("UserRole").equals("admin")){ %>
                    <a href="/dashboard" class="none-decoration"><li class="item-controller">Bảng điều khiển</li></a>
                            <%}%>
                    <a href="/order" class="none-decoration"> <li class="item-controller">Quản lí đơn hàng</li></a>
                    <a href="/CrudProduct" class="none-decoration"> <li class="item-controller">Quản lí sản phẩm</li></a>
                            <% if(session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/AdminUser" class="none-decoration">  <li class="item-controller ">Quản lí người dùng</li></a>
                            <% }
                          if(session.getAttribute("UserRole").equals("admin")) { %>
                    <li class="item-controller active">Quản lí cài đặt</li>
                        <%}%>
                    <a href="/" class="none-decoration"> <li class="item-controller">Quay về trang chủ</li></a>
                </ul>
            </div>
            <div class="right-content">
                <h1> Quản lí cài đặt</h1>
                <br>

                <div>
                    <div>
                        <p>Logo website :</p> <img src="data:image/jpeg;base64,${requestScope.imagelogo}" alt="Image" style="width: 100px; height: auto;">
                    </div>
                    <div>  <a href="editLogo.jsp?id=2" class="btn btn-primary">Edit</a></div>
                </div>
                <div>
                    <p>Danh sách slider :</p>
                    <c:forEach items="${images}" var="img">
                                <img src="data:image/jpeg;base64,${img.image_url}" alt="Image" style="width: 100px; height: auto; margin-bottom: 8px;margin-top: 8px;">
                                <div class="d-flex" style="gap:4px;">
                                <form action="admin-setting" method="post" >
                                    <input type="hidden" name="image_id" value="${img.image_id}">
                                    <input type="submit" value="Delete" class="btn btn-danger" onclick="return confirm('Are you sure?');">
                                </form>
                                    <a href="EditSlider.jsp?id=${img.image_id}" class="btn btn-warning">Edit</a>
                                    </div>
                    </c:forEach>
                                    <div>
                                        <a href="/AddSlider.jsp" alt="add-slider" class="btn btn-primary" style="margin-top: 20px;">Thêm slider</a>
                                    </div>
                       

                </div>
            </div>
    </body>
</html>