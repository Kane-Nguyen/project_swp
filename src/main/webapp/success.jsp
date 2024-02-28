<%@ page import="dao.imageDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.image" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <title>Delete Images</title>
</head>
<body>
    <h1>Delete Images</h1>
    <h2>Delete All Images by Product ID</h2>
    <form action="DeleteServlet" method="post">
        <label for="product_id">Product ID:</label>
        <input type="text" id="product_id" name="product_id">
        <input type="submit" value="Delete All Images">
    </form>

    <table border="1">
    <% 
        imageDAO dao = new imageDAO();
        List<image> images = dao.getImgList();
        for (image img : images) {
    %>
            <tr>
                <td>Product ID: <%= img.getProduct_id() %></td>
                <td><img src="data:image/png;base64,<%= img.getImage_url() %>" alt="Product Image" style="width:200px;height:auto;"/></td>
                <td>
                    <a href="EditImage.jsp?id=<%=img.getImage_id()%>">Edit</a>
                </td>
            </tr>
    <% 
        }
    %>
    </table>

    <a href="ImageUpload.jsp">Return to Upload Page</a>
</body>
</html>