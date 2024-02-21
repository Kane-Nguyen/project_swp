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

    <% 
        // Lấy danh sách các hình ảnh từ cơ sở dữ liệu và hiển thị chúng
        try {
            imageDAO dao = new imageDAO();
            List<image> images = dao.getImgList();
            for (image img : images) {
                out.println("<div>");
                out.println("Product ID: " + img.getProduct_id() + "<br>");
                out.println("<img src=\"data:image/png;base64," + img.getImage_url() + "\" alt=\"Product Image\" style=\"width:200px;height:auto;\"/><br>");
                
                out.println("<form action='DeleteServlet' method='post'>");
                out.println("<input type='hidden' name='image_id' value='" + img.getImage_id() + "'/>");
                out.println("<input type='submit' value='Delete'/>");
                out.println("</form>");

                out.println("</div><br>");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>

    <a href="ImageUpload.jsp">Return to Upload Page</a>
</body>
</html>
