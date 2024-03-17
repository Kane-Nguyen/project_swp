<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chỉnh Sửa Sản Phẩm</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            .img-preview-container {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px;
            }
            .img-container img {
                width: 100px; /* hoặc bất kỳ kích thước nào bạn muốn */
                height: 100px; /* hoặc bất kỳ kích thước nào bạn muốn */
                object-fit: cover; /* để hình ảnh không bị méo */
            }
            .img-preview {
                position: relative;
                width: 100px;
                height: 100px;
                border: 2px solid transparent;
            }

            .img-preview img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .img-preview.selected {
                border-color: blue;
            }

            .delete-image-btn {
                position: absolute;
                top: 0;
                right: 0;
                cursor: pointer;
                color: red;
                font-size: 20px;
                background-color: white;
                border-radius: 50%;
            }

            .btn-danger {
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2>Edit Product</h2>
            <c:set var="productId" value="${param.productId}" scope="request"/>
            <c:if test="${not empty product}">
                <form action="editProduct" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="productId" value="${productId}">

                    <!-- Product Name -->
                    <div class="form-group">
                        <label for="productName">Tên Sẩn Phẩm:</label>
                        <input type="text" class="form-control" id="productName" name="productName" value="${product.product_name}" required>
                    </div>

                    <!-- Product Price -->
                    <div class="form-group">
                        <label for="productPrice">Giá Sản Phẩm:</label>
                        <input type="text" class="form-control" id="productPrice" name="productPrice" value="${product.product_price}" required>
                        <p class="text-danger" id="priceError"></p>
                    </div>

                    <!-- Stock Quantity -->
                    <div class="form-group">
                        <label for="stockQuantity">Tồn Kho: </label>
                        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" value="${product.stock_quantity}" min="1" step="1" required>
                        <p class="text-danger" id="quantityError"></p>
                    </div>

                    <!-- Category Selection -->
                    <div class="form-group">
                        <label for="categoryId">Danh Muc:</label>
                        <select id="categoryId" class="form-control" name="categoryId" required>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.categoryId}" ${category.categoryId == product.category_id ? 'selected' : ''}>${category.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Product Branch -->
                    <div class="form-group">
                        <label for="productBranch">Thương Hiệu:</label>
                        <input type="text" class="form-control" id="productBranch" name="productBranch" value="${product.product_branch}" required>
                    </div>

                    <!-- Main Image Upload -->
                    <div class="form-group">
                        <label for="image">Ảnh Chính:</label>
                        <input type="file" class="form-control-file" id="image" name="image" accept=".jpg, .jpeg, .png">
                    </div>

                    <!-- Additional Images Upload -->
                    <div class="form-group">
                        <label for="additionalImages">Ảnh Chi Tiết:</label>
                        <input type="file" class="form-control-file" id="additionalImages" name="additionalImages" multiple accept=".jpg, .jpeg, .png">
                        <div id="imagePreview" class="img-preview-container">
                            <c:forEach var="img" items="${additionalImages}">
                                <div class="img-preview">
                                    <input type="checkbox" class="image-checkbox" value="${img.image_id}">
                                    <img src="data:image/png;base64,${img.image_url}" alt="Additional Image">
                                </div>


                            </c:forEach>
                        </div>
                    </div>
                    <c:if test="${not empty sessionScope.imageError}">
                        <div class="alert alert-danger" role="alert">
                            ${sessionScope.imageError}
                        </div>
                        <%-- Remove the error message from the session after displaying it --%>
                        <%
                            session.removeAttribute("imageError");
                        %>
                    </c:if>



                    <p id="selectedImageCount">Selected images: 0</p>

                    <button id="deleteSelectedImages" type="button" class="btn btn-warning">Delete Selected Images</button><br>

                    <button type="submit" class="btn btn-primary">Update Product</button> <br>

                    <a href="CrudProduct" class="btn btn-primary mb-3">Back to list products</a>
                </form>
            </c:if>
            <c:if test="${empty product}">
                <p>Product not found!</p>
            </c:if>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script>
            window.addEventListener('DOMContentLoaded', (event) => {
                formatPriceInput();
            });

            function formatPriceInput() {
                var priceInput = document.getElementById('productPrice');
                if (!priceInput.value)
                    return; // Skip if value is empty

                // Convert to number to remove scientific notation, then to string
                var price = parseFloat(priceInput.value).toString();

                // Check if price is an integer (no decimal part) and handle accordingly
                if (price.indexOf('.') !== -1) {
                    // If there is a decimal part, ensure it does not end with '.00'
                    price = parseFloat(price).toFixed(2);
                    if (price.endsWith('.00')) {
                        price = price.substring(0, price.length - 3);
                    }
                }

                priceInput.value = price;
            }

            $(document).ready(function () {
                $('#productPrice').on('input', function () {
                    // Kiểm tra xem giá trị nhập vào có phải là số không
                    var price = $(this).val();
                    if (isNaN(price)) {
                        $('#priceError').text('Please enter a valid number');
                        $(this).val(''); // Xóa giá trị không phải số
                        return;
                    }

                    // Kiểm tra giá trị nhập vào có vượt quá mức giới hạn không (ví dụ: 100000000)
                    var maxPrice = 100000000;
                    if (parseFloat(price) > maxPrice) {
                        $('#priceError').text('Please enter a price less than ' + maxPrice);
                        $(this).val('');
                        return;
                    }

                    // Nếu không có lỗi, xóa thông báo lỗi
                    $('#priceError').text('');
                });
            });
            $(document).ready(function () {
                $('#stockQuantity').on('input', function () {
                    // Kiểm tra xem giá trị nhập vào có phải là số không
                    var quantity = $(this).val();
                    if (isNaN(quantity)) {
                        $('#quantityError').text('Please enter a valid number');
                        $(this).val(''); // Xóa giá trị không phải số
                        return;
                    }

                    // Kiểm tra giá trị nhập vào có vượt quá mức giới hạn không (ví dụ: 100000000)
                    var maxQ = 10000;
                    if (parseFloat(quantity) > maxQ) {
                        $('#quantityError').text('Please enter a price less than ' + maxQ);
                        $(this).val('');
                        return;
                    }

                    // Nếu không có lỗi, xóa thông báo lỗi
                    $('#priceError').text('');
                });
            });
            $(document).ready(function () {
                // Cập nhật số lượng hình ảnh được chọn
                function updateSelectedCount() {
                    var count = $('.image-checkbox:checked').length;
                    $('#selectedImageCount').text('Selected images: ' + count);
                }

                // Xử lý sự kiện khi thay đổi checkbox của hình ảnh
                $('.image-checkbox').change(function () {
                    $(this).closest('.img-preview').toggleClass('selected', this.checked);
                    updateSelectedCount();
                });

                // Xử lý sự kiện khi nhấn nút xóa hình ảnh (dấu "X") cho hình ảnh đã thêm
                $(document).on('click', '.delete-image-btn', function () {
                    $(this).closest('.img-preview').remove();
                    updateSelectedCount();
                });

                function previewImages() {
                    let imageInput = document.getElementById('additionalImages'); // Đảm bảo ID này khớp với input của bạn
                    let imagePreview = document.getElementById('imagePreview'); // Đảm bảo ID này khớp với container preview của bạn
                    imagePreview.innerHTML = ''; // Bạn có thể muốn giữ nguyên các hình ảnh đã thêm trước đó

                    Array.from(imageInput.files).forEach(file => {
                        let reader = new FileReader();
                        reader.onload = function (e) {
                            let imgContainer = document.createElement('div');
                            imgContainer.classList.add('img-container');

                            let img = new DocumentFragment().appendChild(document.createElement('img'));
                            img.src = e.target.result;
                            imgContainer.appendChild(img);

                            let deleteBtn = document.createElement('button');
                            deleteBtn.innerHTML = '✖'; // Red X icon
                            deleteBtn.className = 'delete-btn';
                            deleteBtn.onclick = function () {
                                imgContainer.remove();
                                removeFile(file);
                            };
                            imgContainer.appendChild(deleteBtn);

                            imagePreview.appendChild(imgContainer);
                        };
                        reader.readAsDataURL(file);
                    });
                }



                // Hàm xóa file khỏi danh sách input
                function removeFile(fileToRemove) {
                    let imageInput = document.getElementById('additionalImages'); // Đảm bảo ID này khớp với input của bạn
                    let dt = new DataTransfer();
                    Array.from(imageInput.files).forEach(file => {
                        if (file !== fileToRemove) {
                            dt.items.add(file);
                        }
                    });
                    imageInput.files = dt.files;
                }

                // Gắn hàm previewImages vào sự kiện thay đổi của input file
                $('#additionalImages').change(function () {
                    previewImages();
                });

                // Xử lý sự kiện khi nhấn nút 'Xóa hình ảnh được chọn'
                $('#deleteSelectedImages').click(function () {
                    var selectedImageIds = $('.image-checkbox:checked').map(function () {
                        return $(this).val();
                    }).get();

                    if (selectedImageIds.length > 0) {
                        // Gửi yêu cầu AJAX để xóa hình ảnh
                        $.ajax({
                            url: '/deleteImage', // Đảm bảo URL này khớp với servlet của bạn
                            type: 'POST',
                            data: {imageIds: selectedImageIds},
                            traditional: true,
                            success: function (response) {
                                if (response.success) {
                                    $('.image-checkbox:checked').closest('.img-preview').remove();
                                    updateSelectedCount();
                                    alert("Selected images deleted successfully.");
                                } else {
                                    alert("Error deleting images.");
                                }
                            },
                            error: function () {
                                alert("Error processing your request.");
                            }
                        });
                    } else {
                        alert("No images selected for deletion.");
                    }
                });
            });
        </script>

    </body>
</html>