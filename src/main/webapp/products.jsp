<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.product" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.productDescriptionDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <div>
        <%
            productDescriptionDAO pdModel = new productDescriptionDAO();
            List<product> p = pdModel.getProduct();
            for (product product : p) {
        %>
        <form action="dataToHomeFromDetail"  id="hiddenForm">
            <input type="hidden" name="productId" value="<%= product.getProduct_id()%>">
            <input type="image" src="<%= product.getImage_url()%>" style="width: 50%; height: 100%;" onclick="submitForm()">
        </form>
        <%
            }
        %>
    </div>

    <script>
        function submitForm() {
            document.getElementById("hiddenForm").submit();
        }
    </script>
</body>
</html>
