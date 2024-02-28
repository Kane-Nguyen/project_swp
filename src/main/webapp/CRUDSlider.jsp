<%@ page import="java.util.List" %>
<%@ page import="model.image" %>
<%@ page import="dao.imageDAO" %>

<!-- EditImageSlider.jsp -->
<!DOCTYPE html>
<html>
<head>
    <title>Edit Slider</title>
    <!-- Add any required CSS styles or scripts -->
</head>
<body>
    <h1>Edit Image Slider</h1>
    <table border="1">
        <tr>
            <th>Image Preview</th>
            <th>Actions</th>
        </tr>
        <%
            imageDAO dao = new imageDAO();
            List<image> images = dao.getImgList(); // Fetch images from the database
        %>
        <% for(image img : images) { %>
        <tr>
            <td>
                <img src="data:image/jpeg;base64,<%=img.getImage_url()%>" alt="Image" style="width: 100px; height: auto;">
            </td>
            <td>
                <form action="DeleteSliderServlet" method="post">
                    <input type="hidden" name="image_id" value="<%= img.getImage_id() %>">
                    <input type="submit" value="Delete" onclick="return confirm('Are you sure?');">
                </form>
                <a href="EditSlider.jsp?id=<%=img.getImage_id()%>">Edit</a>
            </td>
        </tr>
        <% } %>
    </table>
    
</body>
</html>
