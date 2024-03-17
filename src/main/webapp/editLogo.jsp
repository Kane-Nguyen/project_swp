
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String role = (String) session.getAttribute("UserRole");
if(role == null || !role.trim().equals("Admin")){
    response.sendRedirect("404-page.jsp");
    return;}
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Image</title>
    
</head>
<body>

            <form action="editLogoServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="2">
                <label for="image">New Image:</label>
                <input type="file" name="image" id="image" accept=".jpg, .jpeg, .png" required>
                <br><br>
                <input type="submit" value="Update Image">
            </form>

    <br>
    <a href="imageList.jsp">Back to Image List</a>
</body>
</html>