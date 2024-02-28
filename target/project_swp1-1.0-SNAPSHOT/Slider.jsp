<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.image" %>
<%@ page import="dao.imageDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Image Slider</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <style>
            .carousel-item {
                position: relative;
                text-align: center; /* Căn giữa nội dung */
                height: 400px; /* Đặt chiều cao của carousel item */
            }

            .carousel-item img {
                max-height: 100%; /* Kích thước của ảnh */
                max-width: 100%; /* Kích thước của ảnh */
                object-fit: cover; /* Hiển thị ảnh mà không bị biến dạng */
            }

            .carousel-control-prev, .carousel-control-next {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                width: 40px; /* Điều chỉnh kích thước của nút */
                color: #444;
            }

            .carousel-control-prev {
                left: calc(42% - 60px); /* Điều chỉnh vị trí của nút */
            }

            .carousel-control-next {
                right: calc(42% - 60px); /* Điều chỉnh vị trí của nút */
            }
        </style>

    </head>
    <body>
        <div>
            <img src="./logo/anh4.png" width="120" height="80" alt="alt"/>
        </div>
        
        <%
            imageDAO dao = new imageDAO();
            List<image> images = dao.getUniqueProductImages(); // Fetch unique product images
        %>

        <div id="imageCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <% 
                    int displayed = 0;
                    for(image img : images) { 
                        displayed++;
                %>
                <div class="carousel-item <%= displayed == 1 ? "active" : "" %>">
                    <img src="data:image/jpeg;base64,<%= img.getImage_url() %>" alt="Slider Image">
                </div>
                <% 
                    } 
                %>
            </div>
            <a class="carousel-control-prev" href="#imageCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#imageCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <!-- Bootstrap JS và các phụ thuộc -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </body>

</html>
