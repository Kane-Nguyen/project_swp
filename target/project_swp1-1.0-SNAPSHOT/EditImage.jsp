<%@ page import="model.image" %>
<%@ page import="dao.imageDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Image</title>
    <!-- Add any required CSS styles or scripts -->
</head>
<body>

<%
    String id = request.getParameter("id");
    imageDAO dao = new imageDAO();
    image img = dao.getImageById(Integer.parseInt(id)); // Implement this method in your DAO to fetch image by ID
%>

<h1>Edit Image</h1>

<!-- Display current image -->
<div>
    <img src="data:image/jpeg;base64,<%=img.getImage_url()%>" alt="Current Image" style="max-width: 500px; height: auto;">
</div>

<!-- Edit form -->
<form action="EditServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= img.getImage_id() %>">
    <input type="hiden" name="product_id" id="product_id" value="<%= img.getProduct_id() %>"> 
    <label for="image">New Image:</label>
    <input type="file" name="image" id="image" accept=".jpg, .jpeg, .png">
    <input type="submit" value="Update Image">
</form>
    <br>
     <a href="success.jsp">Edit Slider</a>

</body>
</html>
