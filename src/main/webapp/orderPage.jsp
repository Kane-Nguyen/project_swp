<%-- 
    Document   : orderPage
    Created on : Feb 1, 2024, 5:26:37 PM
    Author     : khaye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.*"%>
<%@page import="model.Order"%>
<%@page import="dao.orderDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body>
        <h1>Order Pages</h1>
        <a class="btn btn-primary" href="/createorder">Tạo Đơn Hàng</a>
        <table class="table">
            <tr>
                <th scope="col">#</th>
                <th scope="col">First</th>
                <th scope="col">Last</th>
                <th scope="col">Handle</th>
                <th scope="col">Handle</th>
                <th scope="col">Handle</th>
                <th scope="col">Handle</th>
                <th scope="col">Handle</th>
                <th scope="col">Handle</th>
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
                <td>
                    <a class="btn btn-warning" href="/editorder?orderId=<%= order.getOrderID()%>">Edit</a>
                    <form method="POST" action="CRUDOrderController">
                        <input type="hidden" name="orderId" value="<%= order.getOrderID()%>"/>
                        <button type="submit" class="btn btn-danger">Delete</button>
                        <input type="hidden" name="method" value="delete"/>
                    </form>
                </td>
            </tr>
            <% }}%>


        </tbody>
    </table>
    <p class="text-success">${requestScope.resultEdit}</p>
    <p class="text-danger">${requestScope.resultDelete}</p>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
