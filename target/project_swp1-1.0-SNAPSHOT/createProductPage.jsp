<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Product</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <body>

        <h2>Create Product</h2>

        <form action="CrudProduct" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
            <input type="hidden" name="action" value="add">

            <label for="productId">Product ID:</label><br>
            <input type="text" id="productId" name="productId" required><br>

            <label for="productName">Product Name:</label><br>
            <input type="text" id="productName" name="productName" required><br>

            <label for="productPrice">Product Price:</label><br>
            <input type="number" id="productPrice" name="productPrice" min="0.01" step="0.01" required><br>

            <label for="imageUrl">Image URL:</label><br>
            <input type="file" name="images[]" id="imageInput" required onchange="previewImages()">
            <div id="imagePreview"></div>

            <label for="stockQuantity">Stock Quantity:</label><br>
            <input type="number" id="stockQuantity" name="stockQuantity" min="1" step="1" required><br>

            <label for="categoryId">Category ID:</label><br>
            <input type="number" id="categoryId" name="categoryId" min="1" step="1" required><br>

            <label for="productBranch">Product Branch:</label><br>
            <input type="text" id="productBranch" name="productBranch" required><br>

            <button type="submit">Add Product</button>
        </form>
        <!-- Message area for displaying validation errors -->
        <div id="validationMessage" style="color:red; margin-bottom:10px;"></div>


    </body>
    <script>
        function validateForm() {
            var validationMessage = document.getElementById("validationMessage");
            validationMessage.textContent = ""; // Clear previous messages  

            var productId = document.getElementById("productId").value.trim();
            var productName = document.getElementById("productName").value.trim();
            var productPrice = parseFloat(document.getElementById("productPrice").value.trim());
            var imageUrl = document.getElementById("imageUrl").value.trim();
            var stockQuantity = parseInt(document.getElementById("stockQuantity").value.trim(), 10);
            var categoryId = parseInt(document.getElementById("categoryId").value.trim(), 10);
            var productBranch = document.getElementById("productBranch").value.trim();

            if (isNaN(productPrice) || productPrice <= 0) {
                validationMessage.textContent = "Product price must be a positive number.";
                return false;
            }

            if (isNaN(stockQuantity) || stockQuantity <= 0 || !Number.isInteger(stockQuantity) ||
                    isNaN(categoryId) || categoryId <= 0 || !Number.isInteger(categoryId)) {
                validationMessage.textContent = "Stock quantity and category ID must be positive integers.";
                return false;
            }
            // Additional validation for other fields can be added here

            return true;
        }

        function previewImages() {
            let imageInput = document.getElementById('imageInput');
            let imagePreview = document.getElementById('imagePreview');
            imagePreview.innerHTML = '';

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
                    deleteBtn.className = 'delete-btn'; // Apply CSS class
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

        function removeFile(fileToRemove) {
            let imageInput = document.getElementById('imageInput');
            let dt = new DataTransfer();
            Array.from(imageInput.files).forEach(file => {
                if (file !== fileToRemove) {
                    dt.items.add(file);
                }
            });
            imageInput.files = dt.files;
        }


    </script>
</html>
