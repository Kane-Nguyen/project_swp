<%-- 
    Document   : index
    Created on : Feb 27, 2024, 8:07:44 PM
    Author     : khaye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <link href="./styles/headerCSS.css" rel="stylesheet"/>
        <link href="./styles/home.css" rel="stylesheet"/>
        <link href="./styles/searchpageCSS.css" rel="stylesheet"/>
        <link href="./styles/footerCSS.css" rel="stylesheet"/>
        <script
            type="module"
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
            nomodule
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"
        ></script>
    </head>
    <body>
        <div class="wrap-content" style="   min-height:100%">
            <div class="container content">
                <div class="left-content">
                    <a href="/" class="logo-link"> 
                        <img src="data:image/png;base64,${logo.image_url}" alt="logo" class="logo-image"/>
                    </a>
                    <div class="dropdown no-mb">
                        <span class="btn dropdown-toggle btn-white">Danh mục </span>
                        <ul class="dropdown-content">
                            <li><a class="dropdown-item" href="catalogsearchServlet?catetory=1&search=${result}">Điện thoại smart phone</a></li>
                            <li><a class="dropdown-item" href="catalogsearchServlet?catetory=2&search=${result}">Laptop</a></li>
                            <li><a class="dropdown-item" href="catalogsearchServlet?catetory=3&search=${result}">Ipad</a></li>
                            <li><a class="dropdown-item" href="catalogsearchServlet?catetory=4&search=${result}">PC</a></li>
                        </ul>
                    </div>
                    <div class="search">
                        <form action="catalogsearchServlet">
                            <input name="search" class="search-input" placeholder="Tìm kiếm...">
                            <input name="catetory" value="${caterory}" type="hidden"/>
                            <input name="page" value="1" type="hidden"/>
                            <button class="search-btn">
                                <svg height="20px" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" width="20px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M344.5,298c15-23.6,23.8-51.6,23.8-81.7c0-84.1-68.1-152.3-152.1-152.3C132.1,64,64,132.2,64,216.3  c0,84.1,68.1,152.3,152.1,152.3c30.5,0,58.9-9,82.7-24.4l6.9-4.8L414.3,448l33.7-34.3L339.5,305.1L344.5,298z M301.4,131.2  c22.7,22.7,35.2,52.9,35.2,85c0,32.1-12.5,62.3-35.2,85c-22.7,22.7-52.9,35.2-85,35.2c-32.1,0-62.3-12.5-85-35.2  c-22.7-22.7-35.2-52.9-35.2-85c0-32.1,12.5-62.3,35.2-85c22.7-22.7,52.9-35.2,85-35.2C248.5,96,278.7,108.5,301.4,131.2z"/></svg>
                            </button>
                        </form>
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
                    <a href="/logout"><button class="btn-danger btn white-space-nowrap">LogOut</button></a>
                    <% }
                    %>
                </div>
            </div>
            <div class="container">
                <div  style="margin-top: 20px; display: flex">
                    <form action="catalogsearchServlet" id="PriceForm" class="sort-and-filter">
                        <div>
                            <c:if test="${quantity > 0}">
                                <button type="submit" class="btn btn-primary" name="sort" value="ASC" style="margin-right: 10px">Tăng dần</button>
                                <button type="submit"  class="btn btn-primary" name="sort" value="DESC">Giảm dần</button>
                            </c:if>
                            <input name="search" type="hidden" value="${result}"/>
                            <input name="page" value="${page}" type="hidden"/>
                            <input name="catetory" value="${caterory}" type="hidden"/>
                        </div>
                        <div class="wrap-choose-price">
                            <div style="margin-right: 10px; margin-top:  5px " class="choose-price">Chọn giá:</div>
                            <div class="list-item">
                                <select class="form-select" id="priceSelect" name="price">
                                    <option selected disabled>-- Chọn giá --</option>
                                    <option value="1000000-5000000">1 triệu - 5 triệu </option>
                                    <option value="5000000-10000000">5 triệu  - 10 triệu </option>
                                    <option value="10000000-20000000">10 triệu - 20 triệu </option>
                                    <option value="20000000-30000000">20 triệu - 30 triệu </option>
                                    <option value="30000000-50000000">30 triệu - 50 triệu </option>
                                    <option value="50000000-00000000">50 triệu  -100 triệu </option>
                                </select>
                            </div> 
                        </div>
                    </form>
                </div>
            </div>  
            <c:choose>
                <c:when test="${quantity > 0}">
                    <div class="container mt-5">
                        <div class="card-container">
                            <c:forEach var="product" items="${products}" varStatus="status">
                                <a class="link-detail text-decoration-none text-dark" href="/dataToHomeFromDetail?productId=${product.product_id}">
                                    <div class="card">
                                        <div class="discount-label px-4">-30%</div>
                                        <img
                                            class="m-4 rounded-top"
                                            src="data:image/png;base64,${product.image_url}" alt="Product Image"
                                            class="card-img-top"
                                            alt="..."
                                            />
                                        <div class="card-body">
                                            <h5 class="card-title">${product.product_name}</h5>
                                            <h5 class="card-title">
                                                <span class="newPrice mr-4 text-danger"><fmt:formatNumber value="${product.product_price}"/> VNĐ</span>

                                            </h5>
                                        </div>
                                    </div>  
                                </a>
                            </c:forEach>
                        </div>
                        <div class="mt-5">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center gap-3">
                                    <c:if test="${noOfPages > 1}">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link bg-primary text-white" href="?page=${currentPage - 1}&search=${resutl}&catetory=${caterory}&price=${price}&sort=${sort}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="1" end="${noOfPages}" var="i">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link bg-primary text-white" href="?page=${i}&search=${resutl}&catetory=${caterory}&price=${price}&sort=${sort}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < noOfPages}">
                                            <li class="page-item">
                                                <a class="page-link bg-primary text-white" href="?page=${currentPage + 1}&search=${resutl}&catetory=${caterory}&price=${price}&sort=${sort}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:if>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <h4 style="text-align: center;">Không tìm thấy sản phẩm có kí tự '${result}'</h4>
                </c:otherwise>
            </c:choose>
            <div <c:if test="${quantity == 0}">style="bottom: 0; position: absolute; width: 100%"</c:if>>
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
            </div>
        </div>
    </body>
</html>

</div>
<script>
    document.getElementById("priceSelect").addEventListener("change", function () {
        document.getElementById("PriceForm").submit();
    });

    // Hàm để lấy giá trị của tham số từ URL
    function getUrlParameter(name) {
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(window.location.href);
        if (!results)
            return null;
        if (!results[2])
            return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    document.addEventListener("DOMContentLoaded", function () {
        // Lấy giá trị của tham số "price" từ URL
        var selectedPrice = getUrlParameter("price");

        // Lấy thẻ select
        var priceSelect = document.getElementById("priceSelect");

        // Nếu có giá trị được chọn từ URL, thiết lập giá trị của select bằng giá trị này
        if (selectedPrice) {
            priceSelect.value = selectedPrice;
        }

        // Xử lý sự kiện onchange để tự động gửi biểu mẫu khi người dùng chọn một giá trị khác
        priceSelect.addEventListener("change", function () {
            document.getElementById("PriceForm").submit();
        });
    });
</script>
</body>
</html>
