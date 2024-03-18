<%-- 
    Document   : adminSetting
    Created on : Mar 6, 2024, 9:40:21 PM
    Author     : Asus
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Tùy Chỉnh</title>
        <link href="./styles/toolbarAdmin.css" rel="stylesheet"/>
        <link href="./styles/adminSettingCSS.css" rel="stylesheet"/>
                <link rel="shortcut icon" href="./img-module/logo.png" type="image/x-icon" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
        <style>
            input[type=file]::file-selector-button {
                margin-right: 20px;
                border: none;
                background: #084cdf;
                padding: 10px 20px;
                border-radius: 10px;
                color: #fff;
                cursor: pointer;
                transition: background .2s ease-in-out;
            }

            input[type=file]::file-selector-button:hover {
                background: #0d45a5;
            }
        </style>
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
                    <div> <button type="button" class="btn btn-primary mt-3 mb-3"  data-bs-toggle="modal" data-bs-target="#editLogoModal">
                            Sửa Logo
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="editLogoModal" tabindex="-1" aria-labelledby="createOrderModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="createOrderModalLabel">Sửa Logo</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">

                                        <div class="d-flex" style="gap:4px;">
                                            <form id="EditLogoForm" action="editLogoServlet" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="id" value="2">
                                                <label for="image">Ảnh Mới:</label>
                                                <input type="file" name="image" id="image" accept=".jpg, .jpeg, .png" required>
                                            </form>
                                        </div>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                        <button type="submit" form="EditLogoForm" class="btn btn-primary">Sửa Logo</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <p>Danh sách slider :</p>

                        <c:forEach items="${images}" var="img">

                            <img src="data:image/jpeg;base64,${img.image_url}" alt="Image" style="width: 100px; height: auto; margin-bottom: 8px;margin-top: 8px;">
                            <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editModal">
                                Sửa
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="createOrderModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="createOrderModalLabel">Chỉnh Sửa Slider</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <img src="data:image/jpeg;base64,${img.image_url}" alt="Image" style="width: 100px; height: auto; margin-bottom: 8px;margin-top: 8px;">
                                            <div class="d-flex" style="gap:4px;">
                                                <form id="editForm" action="editSliderServlet" method="post" enctype="multipart/form-data">
                                                    <input type="hidden" name="id" value="${img.image_id}">
                                                    <input type="hidden" name="product_id" id="product_id" value="1">
                                                    <label for="image">Ảnh Mới:</label>
                                                    <input type="file" name="image" id="image" accept=".jpg, .jpeg, .png">
                                                </form>
                                            </div>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <button type="submit" form="editForm" class="btn btn-primary">Sửa</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#DeleteModal">
                                Xóa
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="DeleteModal" tabindex="-1" aria-labelledby="createOrderModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="createOrderModalLabel">Xóa Slider</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <img src="data:image/jpeg;base64,${img.image_url}" alt="Image" style="width: 100px; height: auto; margin-bottom: 8px;margin-top: 8px;">
                                            <div class="d-flex" style="gap:4px;">
                                                <form id="deleteForm" action="admin-setting" method="post" >
                                                    <h3 class="text-danger">Bạn Có Chắc Chắn Xóa Không?</h3>
                                                    <input type="hidden" name="image_id" value="${img.image_id}">

                                                </form>
                                            </div>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <button type="submit" form="deleteForm" class="btn btn-danger">Xóa</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br>

                        </c:forEach>
                        <div>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#AddModal">
                                Thêm Slider
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="AddModal" tabindex="-1" aria-labelledby="createOrderModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="createOrderModalLabel">Thêm Slider</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">

                                            <div class="d-flex" style="gap:4px;">
                                                <form id="addForm" action="addSliderServlet" method="POST" enctype="multipart/form-data">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" id="product_id" name="product_id" value="1"><br>
                                                    <label for="images">Chọn hình ảnh :</label>
                                                    <input type="file" id="images" name="images[]" multiple accept=".jpg, .jpeg, .png"><br>

                                                </form>
                                            </div>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <button type="submit" form="addForm" class="btn btn-primary">Thêm Slider</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div id="error-message" class="error-message"></div>
                    </div>
                </div>
                </body>
                </html>