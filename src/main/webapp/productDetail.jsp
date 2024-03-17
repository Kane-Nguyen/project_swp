<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" >
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <title>Accordion</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="./styles/headerCSS.css" rel="stylesheet"/>
        <link href="./styles/productDetailCSS.css" rel="stylesheet"/>
        <link href="./styles/footerCSS.css" rel="stylesheet"/>


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
                                        <img src="data:image/png;base64,${o.image_url}" alt="Product Image" class="img-fluid card-img-top" style="width: 100%; height: 70%">
                                        <p class="card-title" ">${o.product_name}</p>
                                        <button  data-dismiss="modal" aria-label="Close" class="btn btn-primary selectProductButton" id="${o.product_id}" >So sánh</button>
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
                                <div class="col-4" style="text-align: center">
                                    <img class="img-fluid" src="data:image/png;base64,${i.image_url}" alt="Product Image 1" style="height: 40%; object-fit: cover"/>
                                    <p class="card-title">${i.product_name}</p>
                                </div>
                            </c:forEach>
                            <% if (productId2 != null) {%>
                            <div class="col-4" data-toggle="modal" data-target="#productListModal" style="text-align: center">
                                <img class="mg-fluid" src="data:image/png;base64,<%= imageUrl2 %>" alt="Product Image 2" id="productImage" style="height: 40%; object-fit: cover">                               
                                <p id="productName" lass="card-title"><%= productName2 %></p>
                            </div>
                            <% } else { %>
                            <div class="col-4" data-toggle="modal" data-target="#productListModal" style="text-align: center">
                                <img class="img-fluid" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:31:31/q:90/plain/https://cellphones.com.vn/media/icon/add-to-compare-icon.png" alt="Product Image 2" id="productImage" style="height: 40%; object-fit: cover"/>
                                <p id="productName" lass="card-title">Chọn Sản Phẩm 2</p>
                            </div>
                            <% }%>

                            <div class="col-4" id="placeholderForProduct2">
                                <form id="compareForm" action="compareProductServlet" >
                                    <input type="hidden"  name="productId" value="${productId}">
                                    <input type="hidden"  name="productId2" id="productId2" value="<%= productId2 %>">
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
        <div class="container content" style="height:60px;">
            <div class="left-content">
                <a href="/" class="logo-link"> 
                    <img src="data:image/png;base64,${logo.image_url}" alt="logo" class="logo-image"/>
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
                    <form action="catalogsearchServlet">
                        <input name="search" class="search-input" placeholder="Tìm kiếm..."/>
                        <input name="page" value="1" type="hidden"/>
                        <button class="search-btn">
                            <svg height="20px" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" width="20px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M344.5,298c15-23.6,23.8-51.6,23.8-81.7c0-84.1-68.1-152.3-152.1-152.3C132.1,64,64,132.2,64,216.3  c0,84.1,68.1,152.3,152.1,152.3c30.5,0,58.9-9,82.7-24.4l6.9-4.8L414.3,448l33.7-34.3L339.5,305.1L344.5,298z M301.4,131.2  c22.7,22.7,35.2,52.9,35.2,85c0,32.1-12.5,62.3-35.2,85c-22.7,22.7-52.9,35.2-85,35.2c-32.1,0-62.3-12.5-85-35.2  c-22.7-22.7-35.2-52.9-35.2-85c0-32.1,12.5-62.3,35.2-85c22.7-22.7,52.9-35.2,85-35.2C248.5,96,278.7,108.5,301.4,131.2z"/></svg>
                        </button>
                    </form>
                </div>
            </div>
            <div class="right-content">
                <a href="orderHistory" class="btn-white btn white-space-nowrap no-mb">Tra cứu đơn hàng</a>
                <%
        if(session.getAttribute("UserRole") != null && session.getAttribute("UserRole").equals("admin")){
                %>
                <a href="/dashboard"><button class="btn-danger btn white-space-nowrap">Management</button></a>
                <% }
if(session.getAttribute("UserRole") == null){
                %>
                <a href="/login"><button class="btn-white btn white-space-nowrap">Đăng nhập</button></a>
                <% }
                    
if(session.getAttribute("UserRole") != null){
                %>
                <a href="/logout"><button class="btn-danger btn white-space-nowrap">LogOut</button></a>
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
                                <div class="tab-pane active" id="pic-1" style="width: 100%; height: 100%">
                                    <img src="data:image/png;base64,${imgWhereId[0].image_url}" >
                                </div>
                                <c:forEach items="${imgWhereId}" var="i" varStatus="loop">
                                    <c:if test="${loop.index > 0}">
                                        <div class="tab-pane" id="pic-${loop.index + 1}">
                                            <img src="data:image/png;base64,${i.image_url}">
                                        </div>
                                    </c:if>
                                </c:forEach>

                            </div>
                            <ul class="preview-thumbnail nav nav-tabs">
                                <c:forEach items="${imgWhereId}" var="i" varStatus="loop">
                                    <li class="active">
                                        <a data-target="#pic-${loop.index + 1}" data-toggle="tab" class="">
                                            <img src="data:image/png;base64,${i.image_url}">
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
                                <h4 class="price ">Giá hiện tại: <span class="text-danger">${priceId}</span></h4>   
                                <form action="addCart" name="frmsanphamchitiet" id="frmsanphamchitiet" method="post">
                                    <input type="hidden" name="method" value="cart"> 
                                    <div class="form-group">
                                        <label for="soluong">Số lượng đặt mua:</label>
                                        <input type="number" class="form-control" id="quantity" name="quantity" min="1">
                                    </div>

                                    <input type="hidden" name="productId" id="productId" value="${productId}">
                                    <div class="action">
                                        <button class="add-to-cart btn btn-primary" id="btnThemVaoGioHang" style="margin-bottom: 5px">Thêm vào giỏ hàng</button>

                                    </div>
                                </form>
                                <form id="BuyNowForm" action="orderPayment" method="post">
                                    <input type="hidden" name="productId" id="productId" value="${productId}">
                                    <input type="hidden" name="quantity" id="quantityForOrder"> 
                                    <input type="hidden" name="method" value="buy"> 
                                    <div class="action">
                                        <button class="add-to-cart btn btn-default" id="buyNow" style="margin-bottom: 5px">Mua Ngay</button>

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
            <div class="card">
                <div>
                    <div clas="commentForm">
                        <form id ="feedback" action="commentServlet" method="POST">
                            <label for="exampleFormControlTextarea1"><h3>Hỏi và đáp</h3></label>
                            <div class="form-group">
                                <input type="hidden" name="productId" class="productId" value="${productId}"/>
                                <textarea name="comment" class="form-control" id="exampleFormControlTextarea1" rows="4" placeholder="Xin mời để lại câu hỏi, CellphoneS sẽ trả lời lại trong 1h, các câu hỏi sau 22h - 8h sẽ được trả lời vào sáng hôm sau
                                          " style="max-width: 92%; margin-right: 10px; box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);  border-radius: 10px; "></textarea>
                                <div>
                                    <button class="btn btn-primary" id="sendFeedbackButton" ><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
                                        <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76z"/>
                                        </svg> Gửi</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="container">
                        <div class="comment-list">
                            <c:forEach items="${feedbackList}" var="f" varStatus="loop">
                                <div class="coment-box">
                                    <div>
                                        <div class="user-comment" >
                                            <div style="display: flex;">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                                                </svg>
                                                <strong class="name" style="margin-left: 5px ">${feedbackNameMap[f.userId]}</strong> 
                                            </div>
                                            <div>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                                                <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"/>
                                                <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0"/>
                                                </svg>
                                                <strong class="user-date" style="margin-left: 5px ">${f.datePosted}</strong>
                                            </div>
                                        </div>
                                        <div class="text-box" style="  margin-left: 20px;"> 
                                            <p>${f.comments}</p>
                                            <a href="#" id="showReplyBtn_${loop.index}">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-quote" viewBox="0 0 16 16">
                                                <path d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105"/>
                                                <path d="M7.066 6.76A1.665 1.665 0 0 0 4 7.668a1.667 1.667 0 0 0 2.561 1.406c-.131.389-.375.804-.777 1.22a.417.417 0 0 0 .6.58c1.486-1.54 1.293-3.214.682-4.112zm4 0A1.665 1.665 0 0 0 8 7.668a1.667 1.667 0 0 0 2.561 1.406c-.131.389-.375.804-.777 1.22a.417.417 0 0 0 .6.58c1.486-1.54 1.293-3.214.682-4.112z"/>
                                                </svg>
                                                trả lời
                                            </a>    
                                        </div>
                                    </div>

                                    <c:forEach items="${repliesGroupedByFeedback[f.feedbackId]}" var="reply" varStatus="outloop">
                                        <div>
                                            <div class="admin-commnet">
                                                <div style="display: flex">
                                                    <strong class="name">${replyNameMap[reply.userId]}</strong>
                                                    <span class="box-info_tag">
                                                        QTV
                                                    </span>

                                                </div>
                                                <div style="display: flex;">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                                                    <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"/>
                                                    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0"/>
                                                    <strong style="margin-left: 5px ">${reply.dateReplied}</strong>
                                                    </svg>
                                                </div>
                                            </div>
                                            <div class="text-box" style="margin-left: 50px"> 
                                                <p>${reply.replyText}</p>
                                                <a href="#" id="showReplyBtn1_${loop.index}">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-quote" viewBox="0 0 16 16">
                                                    <path d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105"/>
                                                    <path d="M7.066 6.76A1.665 1.665 0 0 0 4 7.668a1.667 1.667 0 0 0 2.561 1.406c-.131.389-.375.804-.777 1.22a.417.417 0 0 0 .6.58c1.486-1.54 1.293-3.214.682-4.112zm4 0A1.665 1.665 0 0 0 8 7.668a1.667 1.667 0 0 0 2.561 1.406c-.131.389-.375.804-.777 1.22a.417.417 0 0 0 .6.58c1.486-1.54 1.293-3.214.682-4.112z"/>
                                                    </svg>
                                                    trả lời
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div id="reply_${loop.index}" class="comment-feedback" style="display: none;">
                                    <form action="feedbackServlet" method="POST">
                                        <input type="hidden" name="productId" class="productId" value="${productId}"/> 
                                        <input type="hidden" name="feedbackId" class="feedbackId" value="${f.feedbackId}"/> 
                                        <div class="form-group">
                                            <textarea name = "reply" class="form-control" id="exampleFormControlTextarea1" rows="4" placeholder="Xin mời để lại câu hỏi, CellphoneS sẽ trả lời lại trong 1h, các câu hỏi sau 22h - 8h sẽ được trả lời vào sáng hôm sau
                                                      " style="max-width: 93%; margin-right: 10px; box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);  border-radius: 10px; "></textarea>
                                            <div>
                                                <button class="btn btn-primary"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
                                                    <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76z"/>
                                                    </svg> Gửi</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>                      
        </div>
        <div>
            <div class=" mt-5 py-3 footer">
                <div class="ml-5 mt-5 ft1"> <h3 class="text-white">EndureTale S</h3>
                    <h3 class="text-white">CÔNG TY TNHH ENDURETALES</h3>
                    <p class="text-white">Mã số thuế : 92828823</p>
                    <p class="text-white">Địa chỉ : tòa nhà số 5, đường Nguyễn Văn Cừ nối dài, phường An Khánh, quận Ninh Kiều, Cần Thơ.s</p>
                    <h5 class="text-white">Kết nối với chúng tôi</h5>
                    <div class="d-flex justify-content-between"><ion-icon name="mail-outline"></ion-icon> <input type="mail" placeholder="Nhập email của bạn..."> <button>Xac Nhan</button></div></div>

                <div style="width: 30%;" class="mt-5 ft2 items-center"> 
                    <div> <a href="#" class="text-decoration-none text-white">Mua hàng và thanh toán Online </a> <br>
                        <a href="#"class="text-decoration-none text-white">Mua hàng trả góp Online</a><br>
                        <a href="#"class="text-decoration-none text-white">Chính sách giao hàng</a><br>
                        <a href="#"class="text-decoration-none text-white"> Tra điểm Smember</a><br>
                        <a href="#"class="text-decoration-none text-white">Xem ưu đãi Smember</a><br>
                        <a href="#"class="text-decoration-none text-white">Tra thông tin bảo hành</a><br>
                        <a href="#"class="text-decoration-none text-white">Tra cứu hoá đơn điện tử</a><br>
                        <a href="#"class="text-decoration-none text-white"> Thông tin hoá đơn mua hàng</a><br>
                        <a href="#"class="text-decoration-none text-white">Trung tâm bảo hành chính hãng</a><br>
                        <a href="#"class="text-decoration-none text-white">Quy định về việc sao lưu dữ liệu</a><br></div>
                </div>

                <div style="width: 30%;" class="mr-5 mt-5 ft3"> 
                    <div>
                        <a href="#" class="text-decoration-none text-white"> Khách hàng doanh nghiệp (B2B) </a> <br>
                        <a href="#"class="text-decoration-none text-white">Ưu đãi thanh toán</a><br>
                        <a href="#"class="text-decoration-none text-white">Quy chế hoạt động</a><br>
                        <a href="#"class="text-decoration-none text-white"> Chính sách Bảo hành</a><br>
                        <a href="#"class="text-decoration-none text-white">Liên hệ hợp tác kinh doanh</a><br>
                        <a href="#"class="text-decoration-none text-white">Tuyển dụng</a><br>
                        <a href="#"class="text-decoration-none text-white">  Dịch vụ bảo hành điện thoại</a><br>
                        <a href="#"class="text-decoration-none text-white"> Dịch vụ bảo hành mở rộng</a><br></div>
                </div>
            </div>

            <!-- End block content -->
    </main>
</body>                                     


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
    console.log(<%= productId2 %>);
    var checkFeedback = ${checkFeedback}; // Giả sử checkFeedback là một biến từ JSP
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
                    $("#productImage").attr("src", "data:image/png;base64," + product.image_url);
                    $("#productName").text(product.product_name);
                    $("#productId2").val(product.product_id);

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
        this.style.display = 'non   e';
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

    // ẩm hiện reply
    <c:forEach var="f" items="${feedbackList}" varStatus="loop">
    var noFeedbackModal = new bootstrap.Modal(document.getElementById('feedbackModal'));

    document.querySelectorAll('[id^="showReplyBtn_${loop.index}"], [id^="showReplyBtn1_${loop.index}"]').forEach(function (button) {
        button.addEventListener('click', function (event) {
            event.preventDefault();

            var feedbacksExist = checkFeedback;
            if (!feedbacksExist) {
                noFeedbackModal.show();
            } else {
                var replyBox = document.getElementById('reply_${loop.index}');
                if (replyBox) {
                    if (replyBox.style.display === "none" || replyBox.style.display === "") {
                        replyBox.style.display = "block";
                    } else {
                        replyBox.style.display = "none";
                    }
                }
            }
        });
    });
    </c:forEach>
    // thực hiện check Feedback
    document.getElementById('sendFeedbackButton').addEventListener('click', function (event) {
        if (checkFeedback === false) {
            console.log(checkFeedback);
            // Ngăn chặn hành động mặc định của nút submit nếu checkFeedback là false
            event.preventDefault();
            // Hiển thị modal thông báo
            var feedbackModal = new bootstrap.Modal(document.getElementById('feedbackModal'));
            feedbackModal.show();
        }

    });

</script>
</html>