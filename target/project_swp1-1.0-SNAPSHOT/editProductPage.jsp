<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="model.image" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="dao.CategoryDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Product</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

            .btn-danger {
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2>Edit Product</h2>
            <% 
                String productId = request.getParameter("productId");
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(productId);
                if (product != null) {
            %>
            <form action="editProduct" method="post" enctype="multipart/form-data">
                <input type="hidden" name="productId" value="<%= productId %>">

                <div class="form-group">
                    <label for="productName">Product Name:</label>
                    <input type="text" class="form-control" id="productName" name="productName" value="<%= product.getProduct_name() %>" required>
                </div>

                <div class="form-group">
                    <label for="productPrice">Product Price:</label>
                    <input type="number" class="form-control" id="productPrice" name="productPrice" value="<%= product.getProduct_price() %>" min="0.01" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="stockQuantity">Stock Quantity:</label>
                    <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" value="<%= product.getStock_quantity() %>" min="1" step="1" required>
                </div>

                <div class="form-group">
                    <label for="categoryId">Category:</label>
                    <select id="categoryId" class="form-control" name="categoryId" required>
                        <% 
                            CategoryDAO categoryDAO = new CategoryDAO();
                            List<Category> categories = categoryDAO.getAllCategories();
                            for (Category category : categories) {
                                out.print("<option value=\"" + category.getCategoryId() + "\">" + category.getCategoryName() + "</option>");
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="productBranch">Product Branch:</label>
                    <input type="text" class="form-control" id="productBranch" name="productBranch" value="<%= product.getProduct_branch() %>" required>
                </div>

                <div class="form-group">
                    <label for="image">Product Main Image:</label>
                    <input type="file" class="form-control-file" id="image" name="image" accept=".jpg, .jpeg, .png">
                </div>

                <div class="form-group">
                    <label for="additionalImages">Product Additional Images:</label>
                    <input type="file" class="form-control-file" id="additionalImages" name="additionalImages" required multiple accept=".jpg, .jpeg, .png" onchange="previewImages()">
                    <div id="imagePreview" class="img-preview-container">
                        <%
                            List<image> additionalImages = productDAO.getAdditionalImages(productId);
                            for (image img : additionalImages) {
                                String imageDataURL = "data:image/png;base64," + img.getImage_url();
                        %>
                        <div class="img-preview">
                            <input type="checkbox" class="image-checkbox" value="<%= img.getImage_id() %>">
                            <img src="<%= imageDataURL %>" alt="Additional Image">
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>

                <button id="deleteSelectedImages" type="button" class="btn btn-warning">Delete Selected Images</button><br>
                
                <button type="submit" class="btn btn-primary">Update Product</button> <br>
                
                <a href="showProducts.jsp" class="btn btn-primary mb-3">Back to list products</a>
            </form>
            <%
                } else {
                    out.println("<p>Product not found!</p>");
                }
            %>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script>
                        $(document).ready(function () {
                            $('#deleteSelectedImages').click(function () {
                                var selectedImageIds = $('.image-checkbox:checked').map(function () {
                                    return $(this).val();
                                }).get();

                                if (selectedImageIds.length > 0) {
                                    $.ajax({
                                        url: '/deleteImage', // Ensure this matches your servlet URL
                                        type: 'POST',
                                        data: {imageIds: selectedImageIds},
                                        traditional: true,
                                        success: function (response) {
                                            if (response.success) {
                                                $('.image-checkbox:checked').closest('.img-preview').remove();
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

                            $('.image-checkbox').change(function () {
                                $(this).closest('.img-preview').toggleClass('selected', this.checked);
                            });

                            $('#additionalImages').change(previewImages); // Bind the previewImages function to the change event of the file input
                        });

                        function previewImages() {
                            var imageInput = document.getElementById('additionalImages');
                            var imagePreview = document.getElementById('imagePreview');

                            // Remove previously added 'new' image previews but keep existing images
                            $('.img-preview.new').remove();

                            Array.from(imageInput.files).forEach(file => {
                                var reader = new FileReader();
                                reader.onload = function (e) {
                                    var imgContainer = document.createElement('div');
                                    imgContainer.classList.add('img-preview', 'new'); // Mark new previews with 'new' class

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

