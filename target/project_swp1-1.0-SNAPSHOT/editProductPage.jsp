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
                    <input type="file" class="form-control-file" id="additionalImages" name="additionalImages" multiple accept=".jpg, .jpeg, .png">
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
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>
                
                <p id="selectedImageCount">Selected images: 0</p>

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