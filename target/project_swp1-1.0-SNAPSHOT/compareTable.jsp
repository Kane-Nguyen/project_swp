<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <head>
        <title>How To Create Bootstrap 5 Table For Compare Packages</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
                <link rel="shortcut icon" href="./img-module/logo.png" type="image/x-icon" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <link href="./styles/headerCSS.css" rel="stylesheet"/>
        <link href="./styles/footerCSS.css" rel="stylesheet"/>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://www.markuptag.com/bootstrap/5/css/bootstrap.min.css" />
    </head>
    <style>
        <!-- Custom CSS -->
        .compare-packages table thead th {
            border-bottom: 2px solid #dee2e6;
            vertical-align: middle;
            font-size: 20px;
            color: #ff9800;
        }
        .compare-packages table thead th p {
            font-size: 16px;
            font-weight: 400;
            color: #333;
        }
        .compare-packages table td {
            text-align: center;
        }
        .compare-packages table td:first-child {
            text-align: left;
        }
        .compare-packages table tr:last-child td {
            font-weight: bold;
            line-height: 40px;
            font-size: 20px;
        }
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

    <body>
        <div class="wrap-content" style="   min-height:100%">
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
            <div class="container">
                <div class="row">
                    <div class="col-md-8 offset-md-2 mt-5">
                        <h3 class="bg-light p-2 mb-3">So Sánh Sản Phẩm</h3>
                        <div class="table-responsive compare-packages">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th width="240px">Hình ảnh</th>
                                        <th><img src="data:image/png;base64,${url1}" alt="alt" style="width: 100%"/>
                                        </th>
                                        <th> <img src="data:image/png;base64,${url2}" alt="alt" style="width: 100%"/>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item1" items="${pd1}" varStatus="status">
                                        <c:set var="item2" value="${pd2[status.index]}" />
                                        <!-- Sử dụng item1 và item2 tại đây -->

                                        <tr>
                                            <td>Name</td>
                                            <td>${name1}</td>
                                            <td>${name2}</td>

                                        </tr>
                                        <tr>            
                                            <td>size display</td>

                                            <td>${item1.sizeDisplay}</td>
                                            <td>${item2.sizeDisplay}</td>

                                        </tr>

                                        <tr>
                                            <td>Chip set</td>
                                            <td>${item1.chipset}</td>
                                            <td>${item2.chipset}</td>

                                        </tr>

                                        <tr>
                                            <td>Battery</td>
                                            <td>${item1.battery}</td>
                                            <td>${item2.battery}</td>

                                        </tr>

                                        <tr>
                                            <td>Osystem</td>
                                            <td>${item1.osystem}</td>
                                            <td>${item2.osystem}</td>

                                        </tr>

                                        <tr>
                                            <td>Camera</td>
                                            <td>${item1.camera}</td>
                                            <td>${item2.camera}</td>

                                        </tr>

                                        <tr>
                                            <td>Sim</td>
                                            <td>${item1.sim}</td>
                                            <td>${item2.sim}</td>

                                        </tr>

                                    </c:forEach>
                                    <tr>
                                        <td>Total Prices</td>
                                        <td><fmt:formatNumber value="${price1}"/> VND<br />
                                <form id="BuyNowForm" action="orderPayment" method="post">
                                    <input type="hidden" name="productId" id="productId" value="${productId}">
                                    <input type="hidden" name="1" id="quantityForOrder"> 
                                    <input type="hidden" name="method" value="buy"> 
                                    <button class="btn btn-warning">Mua ngay</button>
                                </form>
                                </td>
                                <td><fmt:formatNumber value="${price2}"/> VND<br />
                                <form id="BuyNowForm" action="orderPayment" method="post">
                                    <input type="hidden" name="productId" id="productId" value="${productId2}">
                                    <input type="hidden" name="1" id="quantityForOrder"> 
                                    <input type="hidden" name="method" value="buy"> 
                                    <button class="btn btn-warning">Mua ngay</button>
                                </form>
                                </td>

                                </tr>
                                </tbody>
                            </table>
                        </div>

                        <form action="dataToHomeFromDetail">
                            <input type="hidden" name="productId" value="${productId}">
                            <button class="btn btn-primary" >Back</button>
                        </form>
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
        <!-- Bootstrap JS -->
        <script src="https://www.markuptag.com/bootstrap/5/js/bootstrap.bundle.min.js"></script>
    </body>
</html>