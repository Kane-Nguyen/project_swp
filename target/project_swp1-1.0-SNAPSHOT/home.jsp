<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-card {
            width: 246px;
            margin: auto;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
        }
        .product-card img {
            height: 200px;
            object-fit: contain;
        }
        .product-card .price {
            color: red;
            font-size: 15px;
            font-weight: bold;
        }
        .product-card .discount {
            color: grey;
            font-size: 14px;
            text-decoration: line-through;
            margin-left: 5px;
        }
        .product-card .like {
            color: red;
            float: right;
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <h2 class="text-center">Product Catalog</h2>
    <div class="row justify-content-center">
        <% 
            List<Product> productList = new ProductDAO().getAll();
            for (Product product : productList) {
                String base64Image = product.getImage_url();
                String imageDataURL = "data:image/png;base64," + base64Image; // Adjust if using different image types

                // Formatting the price
                NumberFormat formatter = NumberFormat.getNumberInstance(Locale.forLanguageTag("vi-VN")); // Vietnamese locale for dot as thousand separator
                String formattedPrice = formatter.format(product.getProduct_price());
        %>
        <div class="col-md-4 col-lg-3">
            <div class="product-card mt-3">
                <!-- Place any badges or labels here -->
                <img src="<%= imageDataURL %>" class="card-img-top" alt="<%= product.getProduct_name() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getProduct_name() %></h5>
                    <p class="card-text">
                        <span class="price"><%= formattedPrice %> VNĐ</span>
                    </p>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
