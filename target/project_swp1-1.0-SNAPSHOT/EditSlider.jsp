<%@page import="model.image" %>
<%@page import="dao.imageDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Slider</title>
</head>
<body>
<%
    // Get the ID parameter from the request
    String id = request.getParameter("id");

    // Create an instance of imageDAO
    imageDAO dao = new imageDAO();

    // Check if the ID parameter exists and is not empty
    if (id != null && !id.isEmpty()) {
        try {
            // Attempt to fetch the image by ID
            image img = dao.getImageById(Integer.parseInt(id));

            // Display the image and form only if the image is retrieved successfully
            %>
            <div>
                <img src="data:image/jpeg;base64,<%=img.getImage_url()%>" alt="Current Image" style="max-width: 500px; height: auto;">
            </div>
            <form action="EditSliderServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= img.getImage_id() %>">
                <input type="hidden" name="product_id" id="product_id" value="1">
                <label for="image">New Image:</label>
                <input type="file" name="image" id="image" accept=".jpg, .jpeg, .png">
                <input type="submit" value="Update Image">
            </form>
            <br>
            <a href="CRUDSlider.jsp">Add Slider</a>
            <%
        } catch (NumberFormatException e) {
            // Handle the exception if the ID cannot be parsed to an integer
            out.println("Invalid image ID format.");
        }
    } else {
        // Handle the case where the ID parameter is missing or empty
        out.println("Missing image ID parameter.");
    }
%>
</body>
</html>
