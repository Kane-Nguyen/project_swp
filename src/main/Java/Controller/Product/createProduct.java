package Controller.Product;

import dao.ProductDAO;
import dao.ProductImageDAO;
import dao.imageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.commons.io.IOUtils;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Collection;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.ProductImage;
import model.image;

@WebServlet(name = "createProduct", urlPatterns = {"/createProduct"})
@MultipartConfig
public class createProduct extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(createProduct.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Processing product upload request");

        String productName = request.getParameter("productName");
        String productPriceStr = request.getParameter("productPrice");
        String stockQuantityStr = request.getParameter("stockQuantity");
        String categoryIdStr = request.getParameter("categoryId");
        String productBranch = request.getParameter("productBranch");

        if (productPriceStr == null || stockQuantityStr == null || categoryIdStr == null) {
            // Handle the case where one or more parameters are missing
            response.sendRedirect("error.jsp"); // Redirect to an error page
            return;
        }

        double productPrice;
        int stockQuantity;
        int categoryId;

        try {
            productPrice = Double.parseDouble(productPriceStr.trim());
            stockQuantity = Integer.parseInt(stockQuantityStr.trim());
            categoryId = Integer.parseInt(categoryIdStr.trim());
        } catch (NumberFormatException e) {
            // Handle the case where the string cannot be parsed to a number
            response.sendRedirect("error.jsp"); // Redirect to an error page
            return;
        }

        // Xử lý hình ảnh chính
        Part mainImagePart = request.getPart("image");
        String mainImageBase64 = convertImageToBase64(mainImagePart.getInputStream());

        // Tạo sản phẩm mới và lấy product_id
        ProductDAO productDAO = new ProductDAO();
        int productId = productDAO.createProduct(productName, productPrice, mainImageBase64, stockQuantity, categoryId, productBranch);

        if (productId == -1) {
            LOGGER.warning("Failed to create product");
            response.sendRedirect("error.jsp");
            return;
        }

        LOGGER.info("Product created with ID: " + productId);

        // Xử lý và lưu hình ảnh phụ
        Collection<Part> additionalImageParts = request.getParts().stream()
                .filter(part -> "additionalImages".equals(part.getName()) && part.getSize() > 0)
                .collect(Collectors.toList());

        imageDAO imageDAO = new imageDAO();
        for (Part imagePart : additionalImageParts) {
            String imageBase64 = convertImageToBase64(imagePart.getInputStream());
            image img = new image();
            img.setProduct_id(productId);
            img.setImage_url(imageBase64);
            try {
                imageDAO.addImage(img);
            } catch (SQLException e) {
                LOGGER.severe("Error in createProduct: " + e.getMessage());
                throw new ServletException("Error saving additional image", e);
            }
        }

        // Lấy thông tin chi tiết sản phẩm
        ProductImageDAO productDetailsDAO = new ProductImageDAO();
        ProductImage productDetails = productDetailsDAO.getProductDetails(String.valueOf(productId));

        if (productDetails != null) {
            request.setAttribute("productDetails", productDetails);
            response.sendRedirect("showProducts.jsp");
        } else {
            response.sendRedirect("productNotFound.jsp");
        }
    }

    private String convertImageToBase64(InputStream inputStream) throws IOException {
        byte[] imageBytes = IOUtils.toByteArray(inputStream);
        return Base64.getEncoder().encodeToString(imageBytes);
    }
}
