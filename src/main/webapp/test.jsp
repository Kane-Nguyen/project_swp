<%@page import="java.util.ArrayList"%>
<%@page import="model.product"%>
<%@page import="model.productDescription"%>
<%@page import="dao.productDescriptionDAO"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Accordion with Images and Delete Button</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="./css/headerCSS.css" rel="stylesheet"/>
        <link href="./css/productDetailCSS.css" rel="stylesheet"/>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="../vendor/bootstrap/css/bootstrap.min.css" type="text/css">
        <!-- Font awesome -->
        <link rel="stylesheet" href="../vendor/font-awesome/css/font-awesome.min.css" type="text/css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>

    </head>
    <style>


    </style>
    <body>
        <%
            
            String productId2= (String) session.getAttribute("productId2");
            String productName2 = (String) session.getAttribute("productName");
            String imageUrl2 = (String) session.getAttribute("productUrl");
            
        %>
        <!-- compareeeeeeeeeeeeeee -->
        <!-- báo lỗi -->
        <div class="modal fade" id="warningModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalLabel">Cảnh báo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn phải chọn sản phẩm để so sánh!
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
        <div
            <!-- bất đầu madal -->
            <div class="modal fade" id="productListModal" tabindex="-1" aria-labelledby="productListModalLabel" aria-hidden="true"  style="z-index: 100000;">
                <div class="modal-dialog modal-lg"> <!-- Sử dụng modal-lg để tăng kích thước modal nếu cần -->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="productListModalLabel">Chọn Sản Phẩm</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row" style="margin-bottom: 5px">
                                <c:forEach items="${listPout}" var="o">
                                    <div class="col-md-4 card" style="background-color: white" >
                                        <img src="${o.image_url}" alt="Product Image" class="img-fluid card-img-top" style="width: 100%; height: 70%">
                                        <p class="card-title" ">${o.product_name}</p>
                                        <button  data-dismiss="modal" aria-label="Close" class="btn btn-primary selectProductButton" id="${o.product_id}%>" >So sánh</button>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- kết thúc Modal -->
            <!-- bất đầu accdi -->
            <div id="compare-modal" class="pdp-compare-modal">
                <div class="pdp-compare-modal-box">
                    <!-- Nội dung modal của bạn ở đây -->
                    <div class="compare-header d-flex justify-content-end">
                        <!-- Header của modal -->
                        <button id="close-modal" class="btn btn-secondary">Thu gọn</button>
                    </div>
                    <div class="compare-content">
                        <div class="row" style="object-fit: cover;">
                            <c:forEach items="${listWhId}" var="i">
                                <div class="col-4" >
                                    <img class="card-img-top img-fluid"src="${i.image_url}" alt="Product Image 1" style="width:100%; height: 50%;"/>
                                    <p class="card-title">${i.product_name}</p>
                                </div>
                            </c:forEach>
                            <% if (productId2 != null) {%>
                            <div class="col-4" data-toggle="modal" data-target="#productListModal">
                                <img class="card-img-top img-fluid" src="<%= imageUrl2 %>" alt="Product Image 2" id="productImage" style="width:100%; height: 50%;">                               
                                <p id="productName" lass="card-title"><%= productName2 %></p>
                            </div>
                            <% } else { %>
                            <div class="col-4" data-toggle="modal" data-target="#productListModal">
                                <img class="card-img-top img-fluid" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:31:31/q:90/plain/https://cellphones.com.vn/media/icon/add-to-compare-icon.png" alt="Product Image 2" id="productImage" style="width:100%; height: 70%;"/>
                                <p id="productName" lass="card-title">Chọn Sản Phẩm 2</p>
                            </div>
                            <% }%>

                            <div class="col-4" id="placeholderForProduct2">
                                <form id="compareForm" action="compareProductServlet" >
                                    <input type="hidden"  name="productId" value="${productId}">
                                    <input type="hidden"  name="productId2" id="productId2" value="<%=productId2%>">
                                    <button type="submit" class="btn btn-primary"  >
                                        So sánh sản phẩm
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- kết thúc accdi -->
    </div>
    <!-- header -->
    <div class="wrap-content">
        <div class="container content">
            <div class="left-content">
                <a href="/" class="logo-link"> 
                    <img src="https://gcs.tripi.vn/public-tripi/tripi-feed/img/474049VKG/logo-tottenham-dep-nhat-3.png" alt="logo" class="logo-image"/>
                </a>
                <div class="dropdown no-mb">
                    <span class="btn dropdown-toggle btn-white">Danh mục </span>
                    <ul class="dropdown-content">

                        <li><a class="dropdown-item" href="#">Điện thoại smart phone</a></li>
                        <li><a class="dropdown-item" href="#">Ipad</a></li>
                        <li><a class="dropdown-item" href="#">Laptop</a></li>
                        <li><a class="dropdown-item" href="#">PC</a></li>

                    </ul>
                </div>
                <div class="search">
                    <input class="search-input" placeholder="Tìm kiếm..."/>
                    <button class="search-btn">
                        <svg height="20px" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" width="20px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M344.5,298c15-23.6,23.8-51.6,23.8-81.7c0-84.1-68.1-152.3-152.1-152.3C132.1,64,64,132.2,64,216.3  c0,84.1,68.1,152.3,152.1,152.3c30.5,0,58.9-9,82.7-24.4l6.9-4.8L414.3,448l33.7-34.3L339.5,305.1L344.5,298z M301.4,131.2  c22.7,22.7,35.2,52.9,35.2,85c0,32.1-12.5,62.3-35.2,85c-22.7,22.7-52.9,35.2-85,35.2c-32.1,0-62.3-12.5-85-35.2  c-22.7-22.7-35.2-52.9-35.2-85c0-32.1,12.5-62.3,35.2-85c22.7-22.7,52.9-35.2,85-35.2C248.5,96,278.7,108.5,301.4,131.2z"/></svg>
                    </button>

                </div>


            </div>
            <div class="right-content">
                <button class="btn-white btn white-space-nowrap no-mb">Tra cứu đơn hàng</button>
                <%
                 if(session.getAttribute("UserRole") == null){
                %>
                <a href="/login"><button class="btn-white btn white-space-nowrap">Đăng nhập</button></a>
                <% }
                %>
                <%
                if(session.getAttribute("UserRole") != null){
                %>
                <a href=" /logout"><button class="btn-danger btn white-space-nowrap">LogOut</button></a>
                <% }
                %>
            </div>
        </div>             
    </div>
    <!--                                                            header                              -->
    <main role="main">
        <!-- Block content - Đục lỗ trên giao diện bố cục chung, đặt tên là `content` -->
        <div class="container mt-4">
            <div class="card">
                <div class="container-fliud">
                    <div class="wrapper row">
                        <div class="preview col-md-6">
                            <div class="preview-pic tab-content">
                                <div class="tab-pane active" id="pic-1">
                                    <img src="${imgWhereId[0].imageUrl}">
                                </div>
                                <c:forEach items="${imgWhereId}" var="i" varStatus="loop">
                                    <c:if test="${loop.index > 0}">
                                        <div class="tab-pane" id="pic-${loop.index + 1}">
                                            <img src="${i.imageUrl}">
                                        </div>
                                    </c:if>
                                </c:forEach>

                            </div>
                            <ul class="preview-thumbnail nav nav-tabs">
                                <c:forEach items="${imgWhereId}" var="i" varStatus="loop">
                                    <li class="active">
                                        <a data-target="#pic-${loop.index + 1}" data-toggle="tab" class="">
                                            <img src="${i.imageUrl}">
                                        </a>
                                    </li>
                                </c:forEach>

                            </ul>
                        </div>
                        <c:forEach items="${listWhId}" var="i">
                            <div class="details col-md-6">

                                <div class="product-title" style="display: flex">
                                    <h3  >${i.product_name}</h3>
                                    <button id="open-modal"  class="btn btn-sm" style="margin-left: 5px; font-size: 12px;background-color: #eee; color: black;  border: 1px solid red;  ">+ So Sánh</button>
                                </div>

                                <p class="product-description">Màn hình 10.1 inch cảm ứng đa điểm</p>

                                <h4 class="price">Giá hiện tại: <span>${priceId} vnđ</span></h4>                               
                                <div class="form-group">
                                    <label for="soluong">Số lượng đặt mua:</label>
                                    <input type="number" class="form-control" id="soluong" name="soluong" min="0">
                                </div>
                                <form name="frmsanphamchitiet" id="frmsanphamchitiet" method="post">
                                    <input type="hidden" name="sp_ma" id="sp_ma" value="5">
                                    <input type="hidden" name="sp_ten" id="sp_ten" value="Samsung Galaxy Tab 10.1 3G 16G">
                                    <input type="hidden" name="sp_gia" id="sp_gia" value="10990000.00">
                                    <input type="hidden" name="hinhdaidien" id="hinhdaidien" value="samsung-galaxy-tab-10.jpg">
                                    <div class="action">
                                        <a class="add-to-cart btn btn-default" id="btnThemVaoGioHang" style="margin-bottom: 5px">Thêm vào giỏ hàng</a>
                                        <a class="like btn btn-default" style="margin-bottom: 5px" >Mua Ngay</a>
                                    </div>
                                </form>
                            </div>
                        </c:forEach>

                    </div>

                </div>
            </div>

            <div class="card">
                <div class="container-fluid">
                    <h3>Thông tin chi tiết về Sản phẩm</h3>
                    <div class="row">
                        <c:forEach  items="${productDescription}" var="i">
                            <div class="col" style="display: flex">
                                <h5>Size display: </h5>   <p>&nbsp;${i.sizeDisplay}</p>
                            </div>
                            <div class="col" style="display: flex">           
                                <h5>Chipset:</h5> <p>&nbsp;${i.chipset}</p>
                            </div>
                            <div class="col" style="display: flex">
                                <h5> battery: </h5> <p>&nbsp;${i.battery}</p>
                            </div>
                            <div class="col" style="display: flex">
                                <h5> Osystem: </h5> <p>&nbsp;${i.osystem}</p>
                            </div>
                            <div class="col" style="display: flex">
                                <h5> Camera: </h5> <p>&nbsp;${i.camera}</p>
                            </div>
                            <div class="col" style="display: flex">
                                <h5>  Sim: </h5> <p>&nbsp; ${i.sim}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <!-- End block content -->
    </main>
</body>                                     


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
                    $("#productId2").val(product.product_id);
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

    document.getElementById('compareForm').addEventListener('submit', function (event) {
        var productId2 = document.getElementById('productId2').value;
        if (!productId2) {
            event.preventDefault(); // Ngăn chặn việc submit form
            var warningModal = new bootstrap.Modal(document.getElementById('warningModal'));
            warningModal.show(); // Hiển thị modal
        }
    });
</script>
</html>
