<%-- 
    Document   : createOrderPage
    Created on : Feb 1, 2024, 7:17:20 PM
    Author     : khaye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        
        <h1>Create Order Page</h1>
        <form method="POST" action="CRUDOrderController">
            <div class="form-group p-2">
                <label for="userId">ID Người Dùng</label>
                <input type="text" name="userId" class="form-control w-75" id="userId" placeholder="Nhập ID Người dùng">
            </div>
              <div class="form-group p-2">
                <label for="address">Địa chỉ</label>
                <input type="text" name="address"  class="form-control w-75" id="address" placeholder="Nhập Địa chỉ">
            </div>
            <div class="form-group p-2">
                <label for="phoneNumber">Số điện thoại</label>
                <input type="text" name="phoneNumber"  class="form-control w-75" id="phoneNumber" placeholder="Nhập Số điện thoại">
            </div>
            <div class="form-group p-2">
                <label for="receiver">Tên người nhận</label>
                <input type="text" name="receiver"  class="form-control w-75" id="receiver" placeholder="Nhập Tên người nhận">
            </div>
             <div class="form-group p-2">
                <label for="paymentMethod">Phương Thức Thanh Toán</label>
                <input type="text" name="paymentMethod"  class="form-control w-75" id="paymentMethod" placeholder="Nhập Phương Thức Thanh Toán">
            </div>
             <div class="form-group p-2">
                <label for="price">Giá</label>
                <input type="text" name="price" class="form-control w-75" id="price" placeholder="Nhập Giá">
            </div>
             <div class="form-group p-2">
                <label for="createOrderDay">Ngày tạo đơn </label>
                <input type="date" name="createOrderDay" class="form-control w-75" id="createOrderDay" placeholder="Nhập Giá">
            </div>
            <button type="submit" class="btn btn-primary m-2">Tạo đơn hàng</button>
            <input type="hidden" id="method" name="method" value="create"/>
        </form>
                
           
            
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>
