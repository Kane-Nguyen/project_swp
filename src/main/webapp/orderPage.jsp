<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.*"%>
<%@page import="model.Order"%>
<%@page import="dao.orderDAO"%>
<%
String role = (String) session.getAttribute("UserRole");

if(role == null || !role.trim().equals("admin") && !role.trim().equals("seller")){
    response.sendRedirect("loginPage.jsp");
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
                <a class="btn btn-primary" href="/createorder">Tạo Đơn Hàng</a>
                <table class="table">
                    <tr>
                        <th scope="col">Order ID</th>
                        <th scope="col">User ID</th>
                        <th scope="col">Địa Chỉ</th>
                        <th scope="col">Số điện thoại   </th>
                        <th scope="col">Tên Người Nhận</th>
                        <th scope="col">Phương Thức Thanh Toán</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Thời Gian</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                        <%
                            orderDAO oDAO = new orderDAO();
                            List<Order> orderList = oDAO.getOrderList();
            
                            if (orderList == null || orderList.isEmpty()) {
                                  out.println("<p>Hiện tại không có orders nào từ người dùng.</p>");
                            }else {
                            for(Order order : orderList){
                        %>
                        <tr>
                            <th scope="row"><%= order.getOrderID() %></th>
                            <td><%= order.getUserID() %></td>
                            <td><%= order.getDeliveryAddress() %></td>
                            <td><%= order.getPhoneNumber() %></td>
                            <td><%= order.getRecipientName() %></td>
                            <td><%= order.getPaymentMethod() %></td>
                            <td><%= order.getTotalPrice() %></td>
                            <td><%= order.getTimeBuy() %></td>
                            <td class="handle-delete-edit">
                                <a class="btn btn-warning edit-btn" href="/editorder?orderId=<%= order.getOrderID()%>">Edit</a>
                                <form method="POST" action="CRUDOrderController" >
                                    <input type="hidden" name="orderId" value="<%= order.getOrderID()%>"/>
                                    <button type="submit" class="btn btn-danger delete-btn">Delete</button>
                                    <input type="hidden" name="method" value="delete"/>
                                </form>
                            </td>
                        </tr>
                        <% }}%>


                    </tbody>
                </table>
                <p class="text-success">${requestScope.resultEdit}</p>
                <p class="text-danger">${requestScope.resultDelete}</p>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>
