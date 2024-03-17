<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Create New Product</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            /* CSS for image previews */
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
                border: 1px solid #ddd;
                margin: 5px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .img-preview img {
                max-width: 100%;
                max-height: 100%;
                object-fit: cover;
            }
            .delete-btn {
                position: absolute;
                top: -10px;
                right: -10px;
                border: none;
                background: red;
                color: white;
                border-radius: 50%;
                padding: 0 5px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2>Create New Product</h2>
            <form id="createProductForm" action="createProduct" method="post" enctype="multipart/form-data">
                <!-- Product Name -->
                <div class="form-group">
                    <label for="productName">Product Name:</label>
                    <input type="text" class="form-control" id="productName" name="productName" required>
                </div>

                <!-- Product Price -->
                <div class="form-group">
                    <label for="productPrice">Product Price:</label>
                    <input type="text" class="form-control" id="productPrice" name="productPrice" required>
                    <span id="priceError" class="text-danger"></span> <!-- Error message placeholder -->
                </div>

                <!-- Stock Quantity -->
                <div class="form-group">
                    <label for="stockQuantity">Stock Quantity:</label>
                    <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" min="1" step="1" required>
                    <span id="quantityError" class="text-danger"></span> <!-- Error message placeholder -->
                </div>

                <!-- Category Selection -->
                <div class="form-group">
                    <label for="categoryId">Category:</label>
                    <select id="categoryId" class="form-control" name="categoryId" required>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}">${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="productBranch">Branch:</label>
                    <input type="text" class="form-control" id="productBranch" name="productBranch" required>
                </div>

                <!-- Main Image Upload -->
                <div class="form-group">
                    <label for="image">Product Main Image:</label>
                    <input type="file" class="form-control-file" id="mainImage" name="image" accept=".jpg, .jpeg, .png" required>
                    <div id="mainImagePreview" class="img-preview-container"></div> <!-- Image preview container -->
                </div>

                <!-- Additional Images Upload -->
                <div class="form-group">
                    <label for="additionalImages">Product Additional Images:</label>
                    <input type="file" class="form-control-file" id="additionalImages" name="additionalImages" multiple accept=".jpg, .jpeg, .png">
                    <div id="additionalImagesPreview" class="img-preview-container"></div> <!-- Image preview container -->
                    <span id="imageLimitMessage" class="text-danger"></span> <!-- Image limit message placeholder -->
                </div>

                <button type="submit" class="btn btn-primary">Create Product</button>
            </form>
        </div>

        <!-- Include jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

        <!-- Custom JavaScript -->
        <script>
            $(document).ready(function () {
                $('#productPrice').on('input', function () {
                    // Check if the input value is a valid number
                    var price = $(this).val();
                    if (isNaN(price)) {
                        $('#priceError').text('Please enter a valid number');
                        $(this).val(''); // Clear non-numeric value
                        return;
                    }

                    // Check if the input value exceeds the maximum limit (e.g., 100000000)
                    var maxPrice = 100000000;
                    if (parseFloat(price) > maxPrice) {
                        $('#priceError').text('Please enter a price less than ' + maxPrice);
                        $(this).val('');
                        return;
                    }

                    // Clear error message if no errors
                    $('#priceError').text('');
                });

                $('#stockQuantity').on('input', function () {
                    // Check if the input value is a valid number
                    var quantity = $(this).val();
                    if (isNaN(quantity)) {
                        $('#quantityError').text('Please enter a valid number');
                        $(this).val(''); // Clear non-numeric value
                        return;
                    }

                    // Check if the input value exceeds the maximum limit (e.g., 10000)
                    var maxQ = 10000;
                    if (parseFloat(quantity) > maxQ) {
                        $('#quantityError').text('Please enter a quantity less than ' + maxQ);
                        $(this).val('');
                        return;
                    }

                    // Clear error message if no errors
                    $('#quantityError').text('');
                });

                $('#additionalImages').change(function () {
                    previewImages();
                });

                function previewImages() {
                    var imageInput = document.getElementById('additionalImages');
                    var imagePreview = document.getElementById('additionalImagesPreview');
                    imagePreview.innerHTML = '';

                    $('#createProductForm').submit(function (e) {
                        // Check the number of additional images
                        var additionalImagesCount = $('#additionalImages')[0].files.length;

                        // If there are more than 5 additional images, prevent form submission
                        if (additionalImagesCount > 5) {
                            e.preventDefault(); // Prevent form submission
                            $('#imageLimitMessage').text('You can only add up to 5 images.').show();
                        } else {
                            $('#imageLimitMessage').hide(); // Hide the error message if within the limit
                        }
                    });

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
            });
        </script>
    </body>
</html>
