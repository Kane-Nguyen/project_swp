<%@page import="java.util.ArrayList"%>
<%@page import="model.product"%>
<%@page import="model.productDescription"%>
<%@page import="dao.productDescriptionDAO"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Accordion with Images and Delete Button</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">


    </head>
    <style>
        /* Base styles for the modal */
        .pdp-compare-modal .pdp-compare-modal-box {
            display: none; /* Initially hidden */
            position: fixed; /* Fixed at the bottom of the page */
            bottom: 0;
            right: 0;
            width: 100%; /* Full width */
            background: #fff;
            border-top: 1px solid #e5e5e5;
            box-shadow: 0 -2px 10px rgba(0,0,0,.12);
            z-index: 1000000000;
            max-width: 1050px; /* Max width or adjust as necessary */
            margin: auto; /* Center if max-width is less than 100% */
            left: 50%;
            transform: translateX(-50%);
            width: auto;
            max-width: 1050px;
            height: 300px;
        }

        /* Responsive styles for mobile devices */
        @media (max-width: 767px) {
            .pdp-compare-modal .pdp-compare-modal-box {
                width: 100%; /* Full width on mobile */
                height: 100px;
                max-width: none; /* No max-width on mobile */
                left: 0; /* Align to the left edge */
                transform: none; /* No translation needed */
                margin: 0; /* No margins */
            }
        }

        /* Styles when the modal content is expanded */
        .pdp-compare-modal.active .pdp-compare-modal-box {
            display: block; /* Show the modal */
        }

        /* Styles for the compare-content container */
        .compare-content {
            display: flex; /* Use flexbox for layout */
            flex-wrap: wrap; /* Allow wrapping */
            justify-content: center; /* Center items horizontally */
            align-items: center; /* Center items vertically */
            height: 164px; /* Default height */
            transition: height 0.3s ease; /* Animate height changes */
        }

        /* Collapsed state of compare-content */
        .compare-content.collapsed {
            height: 36px; /* Height when collapsed */
        }

        /* Responsive behavior */
        @media (max-width: 767px) {
            .compare-content {
                flex-direction: row; /* Keep items in a row, but allow wrapping */
                height: auto; /* Height adjusts to content */
            }

            .compare-content .container {
                flex: 1 1 50%; /* Each container takes up half the width */
                max-width: 50%; /* Ensure max width does not exceed 50% */
            }
        }

        /* Styles for the container */
        .container {
            padding: 15px; /* Padding inside the container */
            box-sizing: border-box; /* Include padding in the width and height */
            max-width: 100%; /* Full width by default */
        }

        /* Styles for the row */
        .row {
            width: 100%; /* Full width */
        }

        /* Styles for the accordion items */
        .compare-container .accordion-item {
            text-align: center; /* Center text */
            padding: 10px; /* Padding around items */
            box-sizing: border-box; /* Include padding and border in the box's dimensions */
        }

    </style>
    <body>
        <%

            String productId2 = (String) session.getAttribute("productId2");

            String productId = request.getParameter("id");
            String productName2 = (String) session.getAttribute("productName");
            productDescriptionDAO pdModel = new productDescriptionDAO();
            List<product> p = pdModel.getProduct();
            // lấy giữ liệu nhanh bằng stream().filter
            String imageUrl1 = p.stream().filter(elem -> elem.getProduct_id() == Integer.parseInt(productId)).findFirst().map(product::getImage_url).orElse("");
            String imageUrl2 = "";
            if (productId2 != null) {
                 imageUrl2 = p.stream().filter(elem -> elem.getProduct_id() == Integer.parseInt(productId2)).findFirst().map(product::getImage_url).orElse("");
            }

            String productName = p.stream()
                    .filter(elem -> elem.getProduct_id() == Integer.parseInt(productId))
                    .findFirst()
                    .map(product::getProduct_name)
                    .orElse("");
        %>
        <!-- Nút để mở modal -->
        <button id="open-modal" class="btn btn-primary">So sánh sản phẩm</button>
        <div class="container">
            <div class="modal fade" id="productListModal" tabindex="-1" aria-labelledby="productListModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg"> <!-- Sử dụng modal-lg để tăng kích thước modal nếu cần -->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="productListModalLabel">Chọn Sản Phẩm</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="row">
                            <% for (product prod : p) {
                                    if (prod.getProduct_id() != Integer.parseInt(productId)) {
                            %>
                            <div class="col-md-4 text-center">
                                <img src="<%= prod.getImage_url()%>" alt="Product Image" class="img-fluid">
                                <p><%= prod.getProduct_name()%></p>
                                <button  class="btn btn-primary selectProductButton" id="<%= prod.getProduct_id()%>" >So sánh</button>
                            </div>
                            <% }
                                }%>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    </div>
                </div>

            </div>
        </div>
        <!-- Modal -->
        <div id="compare-modal" class="pdp-compare-modal">
            <div class="pdp-compare-modal-box">
                <!-- Nội dung modal của bạn ở đây -->
                <div class="compare-header d-flex justify-content-end">
                    <!-- Header của modal -->
                    <button id="close-modal" class="btn btn-secondary">Thu gọn</button>
                </div>
                <div class="compare-content">
                    <div class="compare-container-inner">
                        <div class="row">
                            <div class="col-4" ">
                                <a>
                                    <img src="<%= imageUrl1%>" alt="Product Image 1" style="width:150px; height: 150px"/>
                                    <p><%= productName%></p>
                                </a>
                            </div>
                            <% if (productId2 != null) {%>
                            <div class="col-4" data-toggle="modal" data-target="#productListModal">
                                <a>
                                    <img src="<%= imageUrl2%>" alt="Product Image 2" id="productImage" style="width:150px; height: 150px"/>
                                    <p id="productName"><%= productName2%></p>
                                </a>
                            </div>
                            <% } else { %>
                            <div class=col-4" data-toggle="modal" data-target="#productListModal">
                                <a>
                                    <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:31:31/q:90/plain/https://cellphones.com.vn/media/icon/add-to-compare-icon.png" alt="Product Image 2" id="productImage" style="width:150px; height: 150px"/>
                                    <p id="productName">Chọn Sản Phẩm 2</p>
                                </a>
                            </div>
                            <% }%>

                            <div class="col-4" id="placeholderForProduct2">
                                <form action="compareProducts.jsp" >
                                    <input type="hidden"  name="productId" value="<%= productId%>">
                                    <input type="hidden" id="productID2" name="productId2" value="">
                                    <button type="submit" class="btn btn-primary" >
                                        So sánh sản phẩm
                                    </button>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script type="text/javascript">
            function updateProductInfo(productId2) {
                $.ajax({
                    type: "POST",
                    url: "update", // Đảm bảo đường dẫn này đúng
                    data: {productId2: productId2},
                    dataType: 'json', // Thêm dòng này để chỉ định kiểu dữ liệu trả về
                    success: function (products) {
                        // Giả sử server trả về một mảng các sản phẩm và bạn muốn xử lý sản phẩm đầu tiên
                        if (products.length > 0) {
                            var product = products[0]; // Lấy sản phẩm đầu tiên từ mảng
                            $("#productImage").attr("src", product.image_url);
                            $("#productName").text(product.product_name);
                            $("#productID2").val(product.product_id);
                            console.log(products);
                            console.log(product.image_url);
                            console.log(product.product_name);
                            console.log(product.product_id);
                        }
                    },
                    error: function () {
                        alert("Có lỗi xảy ra khi lấy thông tin sản phẩm");
                    }
                });
            }

            // Sử dụng phương thức này để gắn vào sự kiện click của nút chọn sản phẩm
            $(".selectProductButton").click(function () {
                var productId2 = $(this).attr("id");
                updateProductInfo(productId2);
            });

            document.getElementById('open-modal').addEventListener('click', function () {
                document.getElementById('compare-modal').classList.add('active');
                // Ẩn nút open-modal khi modal được mở
                this.style.display = 'none';
            });

            document.getElementById('close-modal').addEventListener('click', function () {
                document.getElementById('compare-modal').classList.remove('active');
                // Hiển thị lại nút open-modal khi modal được đóng
                document.getElementById('open-modal').style.display = 'inline-block'; // Hoặc 'block', tùy vào layout của bạn
            });
        </script>
    </body>
</html>
