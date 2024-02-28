<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Image to Slider</title>
        <style>
        .error-message {
            color: red;
        }
    </style>
    </head>
    <body>
        <form action="ImageServlet" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="action" value="add">
            <input type="hidden" id="product_id" name="product_id" value="1"><br>
            <label for="images">Select images:</label>
            <input type="file" id="images" name="images[]" multiple accept=".jpg, .jpeg, .png"><br>
            <input type="submit" value="Add Image">
        </form>
        <div id="error-message" class="error-message"></div>
    </body>
</html>
