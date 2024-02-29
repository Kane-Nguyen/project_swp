<%-- 
    Document   : productDetail
    Created on : Feb 29, 2024, 12:45:51 AM
    Author     : THANHVINH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi" class="h-100">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Nền tảng - Kiến thức cơ bản về WEB | Bảng tin</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!-- Font awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    </head> 
    <style>
        img {
            max-width: 100%;
        }

        .preview {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column;
        }

        @media screen and (max-width: 996px) {
            .preview {
                margin-bottom: 20px;
            }
        }

        .preview-pic {
            -webkit-box-flex: 1;
            -webkit-flex-grow: 1;
            -ms-flex-positive: 1;
            flex-grow: 1;
            max-height: 300px;
        }

        .preview-thumbnail.nav-tabs {
            border: none;
            margin-top: 15px;
        }

        .preview-thumbnail.nav-tabs li {
            width: 18%;
            margin-right: 2.5%;
        }

        .preview-thumbnail.nav-tabs li img {
            max-width: 100%;
            display: block;
        }

        .preview-thumbnail.nav-tabs li a {
            padding: 0;
            margin: 0;
        }

        .preview-thumbnail.nav-tabs li:last-of-type {
            margin-right: 0;
        }

        .tab-content {
            overflow: hidden;
        }

        .tab-content img {
            width: 100%;
            -webkit-animation-name: opacity;
            animation-name: opacity;
            -webkit-animation-duration: .3s;
            animation-duration: .3s;
        }

        .card {
            background: #eee;
            padding: 3em;
            line-height: 1.5em;
        }

        @media screen and (min-width: 997px) {
            .wrapper {
                display: -webkit-box;
                display: -webkit-flex;
                display: -ms-flexbox;
                display: flex;
            }
        }

        .details {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column;
        }

        .colors {
            -webkit-box-flex: 1;
            -webkit-flex-grow: 1;
            -ms-flex-positive: 1;
            flex-grow: 1;
        }

        .product-title,
        .price,
        .sizes,
        .colors {
            text-transform: UPPERCASE;
            font-weight: bold;
        }

        .checked,
        .price span {
            color: #ff9f1a;
        }

        .product-title,
        .rating,
        .product-description,
        .price,
        .vote,
        .sizes {
            margin-bottom: 15px;
        }

        .product-title {
            margin-top: 0;
        }

        .size {
            margin-right: 10px;
        }

        .size:first-of-type {
            margin-left: 40px;
        }

        .color {
            display: inline-block;
            vertical-align: middle;
            margin-right: 10px;
            height: 2em;
            width: 2em;
            border-radius: 2px;
        }

        .color:first-of-type {
            margin-left: 20px;
        }

        .add-to-cart,
        .like {
            background: #ff9f1a;
            padding: 1.2em 1.5em;
            border: none;
            text-transform: UPPERCASE;
            font-weight: bold;
            color: #fff;
            -webkit-transition: background .3s ease;
            transition: background .3s ease;
        }

        .add-to-cart:hover,
        .like:hover {
            background: #b36800;
            color: #fff;
        }

        .not-available {
            text-align: center;
            line-height: 2em;
        }

        .not-available:before {
            font-family: fontawesome;
            content: "\f00d";
            color: #fff;
        }

        .orange {
            background: #ff9f1a;
        }

        .green {
            background: #85ad00;
        }

        .blue {
            background: #0076ad;
        }

        .tooltip-inner {
            padding: 1.3em;
        }

        @-webkit-keyframes opacity {
            0% {
                opacity: 0;
                -webkit-transform: scale(3);
                transform: scale(3);
            }

            100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1);
            }
        }

        @keyframes opacity {
            0% {
                opacity: 0;
                -webkit-transform: scale(3);
                transform: scale(3);
            }

            100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1);
            }
        }
    </style>
    <body>
        <!-- header -->
        <nav class="navbar navbar-expand-md navbar-dark sticky-top bg-dark">
            <div class="container">
                <a class="navbar-brand" href="https://nentang.vn">Nền tảng</a>
                <div class="navbar-collapse collapse" id="navbarCollapse">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="../index.html">Trang chủ <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="https://nentang.vn">Quản trị</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="products.html">Sản phẩm</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="about.html">Giới thiệu</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="contact.html">Liên hệ</a>
                        </li>
                    </ul>
                    <form class="form-inline mt-2 mt-md-0" method="get" action="search.html">
                        <input class="form-control mr-sm-2" type="text" placeholder="Tìm kiếm" aria-label="Search"
                               name="keyword_tensanpham">
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Tìm kiếm</button>
                    </form>
                </div>
                <ul class="navbar-nav px-3">
                    <li class="nav-item text-nowrap">
                        <a class="nav-link" href="cart.html">Giỏ hàng</a>
                    </li>
                    <li class="nav-item text-nowrap">
                        <!-- Nếu chưa đăng nhập thì hiển thị nút Đăng nhập -->
                        <a class="nav-link" href="login.html">Đăng nhập</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- end header -->

        <main role="main">
            <!-- Block content - Đục lỗ trên giao diện bố cục chung, đặt tên là `content` -->
            <div class="container mt-4">
                <div id="thongbao" class="alert alert-danger d-none face" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>

                <div class="card">
                    <div class="container-fliud">
                        <form name="frmsanphamchitiet" id="frmsanphamchitiet" method="post"
                              action="/php/twig/frontend/giohang/themvaogiohang">
                            <input type="hidden" name="sp_ma" id="sp_ma" value="5">
                            <input type="hidden" name="sp_ten" id="sp_ten" value="Samsung Galaxy Tab 10.1 3G 16G">
                            <input type="hidden" name="sp_gia" id="sp_gia" value="10990000.00">
                            <input type="hidden" name="hinhdaidien" id="hinhdaidien" value="samsung-galaxy-tab-10.jpg">

                            <div class="wrapper row">
                                <div class="preview col-md-6">
                                    <div class="preview-pic tab-content">
                                        <div class="tab-pane" id="pic-1">
                                            <img src="../assets/img/product/samsung-galaxy-tab-10.jpg">
                                        </div>
                                        <div class="tab-pane" id="pic-2">
                                            <img src="../assets/img/product/samsung-galaxy-tab.jpg">
                                        </div>
                                        <div class="tab-pane active" id="pic-3">
                                            <img src="../assets/img/product/samsung-galaxy-tab-4.jpg">
                                        </div>
                                    </div>
                                    <ul class="preview-thumbnail nav nav-tabs">
                                        <li class="active">
                                            <a data-target="#pic-1" data-toggle="tab" class="">
                                                <img src="../assets/img/product/samsung-galaxy-tab-10.jpg">
                                            </a>
                                        </li>
                                        <li class="">
                                            <a data-target="#pic-2" data-toggle="tab" class="">
                                                <img src="../assets/img/product/samsung-galaxy-tab.jpg">
                                            </a>
                                        </li>
                                        <li class="">
                                            <a data-target="#pic-3" data-toggle="tab" class="active">
                                                <img src="../assets/img/product/samsung-galaxy-tab-4.jpg">
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="details col-md-6">
                                    <h3 class="product-title">Samsung Galaxy Tab 10.1 3G 16G</h3>
                                    <div class="rating">
                                        <div class="stars">
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star"></span>
                                            <span class="fa fa-star"></span>
                                        </div>
                                        <span class="review-no">999 reviews</span>
                                    </div>
                                    <p class="product-description">Màn hình 10.1 inch cảm ứng đa điểm</p>
                                    <small class="text-muted">Giá cũ: <s><span>10,990,000.00 vnđ</span></s></small>
                                    <h4 class="price">Giá hiện tại: <span>10,990,000.00 vnđ</span></h4>
                                    <p class="vote"><strong>100%</strong> hàng <strong>Chất lượng</strong>, đảm bảo
                                        <strong>Uy
                                            tín</strong>!</p>
                                    <h5 class="sizes">sizes:
                                        <span class="size" data-toggle="tooltip" title="cỡ Nhỏ">s</span>
                                        <span class="size" data-toggle="tooltip" title="cỡ Trung bình">m</span>
                                        <span class="size" data-toggle="tooltip" title="cỡ Lớn">l</span>
                                        <span class="size" data-toggle="tooltip" title="cỡ Đại">xl</span>
                                    </h5>
                                    <h5 class="colors">colors:
                                        <span class="color orange not-available" data-toggle="tooltip"
                                              title="Hết hàng"></span>
                                        <span class="color green"></span>
                                        <span class="color blue"></span>
                                    </h5>
                                    <div class="form-group">
                                        <label for="soluong">Số lượng đặt mua:</label>
                                        <input type="number" class="form-control" id="soluong" name="soluong">
                                    </div>
                                    <div class="action">
                                        <a class="add-to-cart btn btn-default" id="btnThemVaoGioHang">Thêm vào giỏ hàng</a>
                                        <a class="like btn btn-default" href="#"><span class="fa fa-heart"></span></a>
                                    </div>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>

                <div class="card">
                    <div class="container-fluid">
                        <h3>Thông tin chi tiết về Sản phẩm</h3>
                        <div class="row">
                            <div class="col">
                                Vi xử lý Dual-core 1 Cortex-A9 tốc độ 1GHz
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End block content -->
        </main>

        <!-- footer -->
        <footer class="footer mt-auto py-3">
            <div class="container">
                <span>Bản quyền © bởi <a href="https://nentang.vn">Nền Tảng</a> - <script>document.write(new Date().getFullYear());</script>.</span>
                <span class="text-muted">Hành trang tới Tương lai</span>

                <p class="float-right">
                    <a href="#">Về đầu trang</a>
                </p>
            </div>
        </footer>
        <!-- end footer -->

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="../vendor/jquery/jquery.min.js"></script>
        <script src="../vendor/popperjs/popper.min.js"></script>
        <script src="../vendor/bootstrap/js/bootstrap.min.js"></script>

        <!-- Custom script - Các file js do mình tự viết -->


    </body>
    <script >

    </script>

</html>
