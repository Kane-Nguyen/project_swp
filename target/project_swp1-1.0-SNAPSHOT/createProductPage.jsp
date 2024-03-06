<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="dao.CategoryDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Create and Upload Product</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <!-- Custom Styles -->
        <style>
            .img-preview-container {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px;
            }

            .img-preview {
                position: relative;
                width: 100px;
                height: 100px;
            }

            .img-preview img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .delete-btn {
                position: absolute;
                top: 0;
                right: 0;
                background-color: transparent;
                border: none;
                color: red;
                font-size: 20px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2>Create New Product with Images</h2>
            <form action="createProduct" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="productName">Product Name:</label>
                    <input type="text" class="form-control" id="productName" name="productName" placeholder="Enter product name" required>
                </div>

                <div class="form-group">
                    <label for="productPrice">Product Price:</label>
                    <input type="text" class="form-control" id="productPrice" name="productPrice" placeholder="Enter product price" required>
                    <p class="text-danger" id="priceError"></p>
                </div>

                <div class="form-group">
                    <label for="stockQuantity">Stock Quantity:</label>
                    <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" placeholder="Enter quantity" min="1" step="1" required>
                    <p class="text-danger" id="quantityError"></p>
                </div>

                <div class="form-group">
                    <label for="categoryId">Category:</label>
                    <select id="categoryId" class="form-control" name="categoryId" required>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}">${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="productBranch">Product Branch:</label>
                    <input type="text" class="form-control" id="productBranch" placeholder="Enter branch" name="productBranch" required>
                </div>

                <div class="form-group">
                    <label for="image">Product Main Image:</label>
                    <input type="file" class="form-control-file" id="image" name="image" required accept=".jpg, .jpeg, .png">
                </div>

                <div class="form-group">
                    <label for="additionalImages">Product Additional Images:</label>
                    <input type="file" class="form-control-file" id="additionalImages" name="additionalImages" multiple accept=".jpg, .jpeg, .png" onchange="previewImages()">
                    <div id="imagePreview" class="img-preview-container"></div>
                </div>
                <div id="imageLimitMessage" class="alert alert-danger" style="display: none;"></div>


                <button type="submit" class="btn btn-primary">Add Product</button>
            </form>
        </div>

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
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
                                if (parseFloat(quantity) >  maxQ) {
                                    $('#quantityError').text('Please enter a price less than ' +   maxQ);
                                    $(this).val('');
                                    return;
                                }

                                // Nếu không có lỗi, xóa thông báo lỗi
                                $('#priceError').text('');
                            });
                        });
                        function previewImages() {
                            var imageInput = document.getElementById('additionalImages');
                            var imagePreview = document.getElementById('imagePreview');
                            imagePreview.innerHTML = '';

                            if (imageInput.files.length > 5) {
                                $('#imageLimitMessage').text('You can only add up to 5 images.').show();
                                return;
                            } else {
                                $('#imageLimitMessage').hide();
                            }

                            Array.from(imageInput.files).forEach(file => {
                                var reader = new FileReader();
                                reader.onload = function (e) {
                                    var imgContainer = document.createElement('div');
                                    imgContainer.classList.add('img-preview');

                                    var img = new Image();
                                    img.src = e.target.result;
                                    imgContainer.appendChild(img);

                                    var deleteBtn = document.createElement('button');
                                    deleteBtn.innerText = 'X';
                                    deleteBtn.classList.add('delete-btn');
                                    deleteBtn.onclick = function () {
                                        imgContainer.remove();
                                        removeFile(file, imageInput);
                                    };
                                    imgContainer.appendChild(deleteBtn);

                                    imagePreview.appendChild(imgContainer);
                                };
                                reader.readAsDataURL(file);
                            });
                        }

                        function removeFile(fileToRemove, imageInput) {
                            var dt = new DataTransfer();
                            Array.from(imageInput.files).forEach(file => {
                                if (file !== fileToRemove) {
                                    dt.items.add(file);
                                }
                            });
                            imageInput.files = dt.files;
                        }
        </script>
    </body>
</html>
