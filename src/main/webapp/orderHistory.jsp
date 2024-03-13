<%-- 
    Document   : index
    Created on : Feb 27, 2024, 8:07:44 PM
    Author     : khaye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link href="./styles/headerCSS.css" rel="stylesheet"/>
        <link href="./styles/home2.css" rel="stylesheet"/>
        <script
            type="module"
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
            nomodule
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"
        ></script>
    </head>
    <body class=" d-flex flex-column min-vh-100" style="height: 100%;
          margin: 0;">
        <div class="wrap-content ">
            <div class="container content">
                <div class="left-content">
                    <a href="/" class="logo-link"> 

                        <img src="data:image/png;base64,<%=session.getAttribute("logo")%>" alt="logo" class="logo-image"/>
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
                <div class="right-content">
                    <button class="btn-white btn white-space-nowrap no-mb">Tra cứu đơn hàng</button>
                    <%
if(session.getAttribute("UserRole") == null){
                    %>
                    <a href="/login"><button class="btn-white btn white-space-nowrap">Đăng nhập</button></a>
                    <% }
                    %>
                    <%
if(session.getAttribute("UserRole") != null){
                    %>
                    <a href="/logout"><button class="btn-danger btn white-space-nowrap">LogOut</button></a>
                    <% }
                    %>
                </div>
            </div>
        </div>
        <div class="container-fluid mt-5" style="width: 80%; margin: auto;">
            <table class="table table-striped">
                <tr>
                    <th>
                        Tên 
                    </th>
                    <th>
                        Số Điện Thoại 
                    </th>
                    <th>
                        Địa Chỉ
                    </th>
                    <th>
                        Thanh Toán
                    </th>
                    <th>
                        Trạng Thái
                    </th>
                    <th>
                        Thời Gian Mua
                    </th>
                    <th>
                        Sản Phẩm
                    </th>
                    <th>
                        Tổng Tiền
                    </th>
                </tr>
                <c:forEach items="${listOrder}" var="listOrder" varStatus="status">
                    <tr>
                        <td>
                            ${listOrder.recipientName}  
                        </td>
                        <td>
                            ${listOrder.phoneNumber}  
                        </td>
                        <td>
                            ${listOrder.deliveryAddress}  
                        </td>
                        <td>
                            ${listOrder.paymentMethod}  
                        </td>
                        <td>
                            <c:forEach items="${listOrderStatus}" var="listOrderStatus" varStatus="status2">
                                <c:if test="${listOrder.status_order_id == listOrderStatus.status_order_id}">
                                    ${listOrderStatus.status_order_name}
                                </c:if> 
                            </c:forEach>
                        </td>
                        <td>
                            ${listOrder.timeBuy}  
                        </td>
                        <td>
                            <c:forEach items="${ListOrderDetail}" var="ListOrderDetail" varStatus="status3">
                                <c:forEach items="${ListProduct}" var="ListProduct" varStatus="status4">
                                    <c:if test="${ListOrderDetail.order_id == listOrder.orderID}">
                                        <c:if test="${ListProduct.product_id == ListOrderDetail.product_id}">
                                            <c:set var="itemTotal" value="${ListOrderDetail.quantity * ListProduct.product_price}"/>
                                            <c:set var="total" value="${total + itemTotal}"/> <!-- Update total -->
                                            <div class="d-flex">

                                                <div>
                                                    <img src="data:image/png;base64,${ListProduct.image_url}" width="50"/>
                                                </div>
                                                <div>
                                                    ${ListProduct.product_name} <br> Số Lượng: ${ListOrderDetail.quantity} Giá:  <fmt:formatNumber value="${ListProduct.product_price}"/> VNĐ
                                                </div>
                                            </div> <br>
                                        </c:if> 
                                    </c:if> 
                                </c:forEach>
                            </c:forEach>
                        </td>
                        <td>
                            <fmt:formatNumber value="${total}" type="number"/> VNĐ
                            <c:set var="total" value="${0}"/>
                        </td>

                    </tr>
                </c:forEach>

            </table> 
        </div>

        <div>
            <div class=" mt-5 py-3 footerr">
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

    </script>
</body>
</html>