<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.*"%>
<%@page import="model.Order"%>
<%@page import="dao.orderDAO"%>
<%
String role = (String) session.getAttribute("UserRole");

if(role == null || !role.trim().equals("admin") && !role.trim().equals("seller")){
    response.sendRedirect("404-page.jsp");
    return;
   }    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="./styles/orderPageCSS.css" rel="stylesheet"/>
        <link href="./styles/toolbarAdmin.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="wrap-content">
            <div class="left-content">
                <h2 class="title-admin">EndureTale S</h2>
                <ul class="list-controller">
                    <% if(session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/dashboard" class="none-decoration"><li class="item-controller">Bảng điều khiển</li></a>
                            <%}%>
                    <li class="item-controller active">Quản lí đơn hàng</li>
                    <a href="/CrudProduct" class="none-decoration"><li class="item-controller">Quản lí sản phẩm</li></a>
                            <% if(session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/AdminUser" class="none-decoration"><li class="item-controller">Quản lí người dùng</li></a>
                            <%}
                          if(  session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/admin-setting" class="none-decoration"><li class="item-controller">Quản lí cài đặt</li></a>
                            <%}%>
                    <a href="/" class="none-decoration"> <li class="item-controller">Quay về trang chủ</li></a>
                </ul>
            </div>

            <div class="right-content">
                <%if(request.getParameter("s")!=null){%>
                <h4 class="text-success">Cập Nhật Đơn Hàng Thành Công</h4>
                <%}else if(request.getParameter("d")!=null){%>
                <h4 class="text-success">Xóa Đơn Hàng Thành Công</h4>
                <%}%>
                <table class="table table-responsive">
                    <tr>


                        <th scope="col">Tên Tài Khoản</th>
                        <th scope="col">Tên Người Nhận</th>
                        <th scope="col">Số điện thoại   </th>
                        <th scope="col">Địa Chỉ</th>

                        <th scope="col">Phương Thức Thanh Toán</th>

                        <th scope="col">Trạng Thái</th>
                        <th scope="col">Thời Gian</th>
                        <th scope="col">Sản Phẩm</th>
                        <th scope="col">Tổng Tiền</th>
                        <th scope="col"> </th>
                    </tr>
                    </thead>
                    <tbody>
                        <% if(session.getAttribute("UserRole").equals("seller")) { %>
                        <c:forEach items="${listOrderSeller}" var="listOrder" varStatus="status">
                            <tr>
                                <td>${listOrder.deliveryAddress}</td>
                                <td>${listOrder.phoneNumber}</td>
                                <td>${listOrder.recipientName}</td>
                                <td>${listOrder.paymentMethod}</td>
                                <td>${listOrder.timeBuy}</td>
                            </tr>
                        </c:forEach>
                        <% }else { %>
                        <c:forEach items="${listOrder}" var="listOrder" varStatus="status">
                            <tr>
                        <form action="CRUDOrderController" method="post">
                            <input  name="method" type="hidden" value="edit"/>
                            <input name="orderId" type="hidden" value="${listOrder.orderID}"/>
                            <c:forEach items="${listUser}" var="listUser" varStatus="status">
                                <c:if test="${listUser.userId == listOrder.userID}">
                                    <td>
                                        ${listUser.fullName}
                                    </td>
                                </c:if>
                            </c:forEach>
                            <td>
                                <input class="border-0" type="text" name="receiver"  value="${listOrder.recipientName}"/> 
                            </td>
                            <td>
                                <input  class="border-0" type="text" name="phoneNumber" value="${listOrder.phoneNumber}"/>
                            </td>
                            <td>
                                <input  class="border-0" type="text" name="address"  value="${listOrder.deliveryAddress}"/>  
                            </td>
                            <td>
                                ${listOrder.paymentMethod}
                            </td>
                            <td>
                                <select name="status" class="form-select">
                                    <c:forEach items="${listOrderStatus}" var="listOrderStatus" varStatus="status2">
                                        <c:if test="${listOrder.status_order_id == listOrderStatus.status_order_id}">
                                            <option value="${listOrderStatus.status_order_id}" selected>${listOrderStatus.status_order_name}</option>
                                        </c:if>
                                        <c:if test="${listOrder.status_order_id != listOrderStatus.status_order_id}">
                                            <option value="${listOrderStatus.status_order_id}">${listOrderStatus.status_order_name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>

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
                            <td>
                                <button class="btn btn-primary " type="submit">Sửa</button>
                        </form> 

                        <button type="button" class="btn btn-danger mt-2" data-bs-toggle="modal" data-bs-target="#deleteModal">
                            Xóa
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="createOrderModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="createOrderModalLabel">Xác nhận Xóa</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">

                                        <form id="deleteForm" action="CRUDOrderController" method="post">
                                            <input  name="method" type="hidden" value="delete"/>  
                                            <input  name="orderId" type="hidden" value="${listOrder.orderID}"/>  
                                            <h3 class="text-danger">Bạn Có Chắc Chắn Xóa Không?</h3>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                        <button type="submit" form="deleteForm" class="btn btn-primary">Xóa Đơn hàng</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        </td>
                        </tr>

                    </c:forEach>
                    <% } %>

                    </tbody>
                </table>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>
