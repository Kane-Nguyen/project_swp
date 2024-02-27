<%-- 
    Document   : product
    Created on : Jan 31, 2024, 3:54:07 PM
    Author     : THANHVINH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.product"%>  
<%@page import="java.sql.ResultSet"%>
<%@page import="dao.productDescriptionDAO"%>  
<%@page import="java.util.List"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div>
            <%
                productDescriptionDAO pdModel = new productDescriptionDAO();

          
                List<product> p = pdModel.getProduct();
                for (product product : p) {
            %>
            <a href="test.jsp?id=<%= product.getProduct_id()%>">
                <img  src="<%= product.getImage_url()%>" style="width: 50%; height: 100%  ;">
            </a>
            <%
                  
                }%>
        </div>
    </body>
</html>
