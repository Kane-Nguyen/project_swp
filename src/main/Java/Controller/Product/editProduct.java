package Controller.Product;

import dao.ProductDAO;
import dao.imageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.Product;
import model.image;
import org.apache.commons.io.IOUtils;

@WebServlet(name = "editProduct", urlPatterns = {"/editProduct"})
@MultipartConfig
public class editProduct extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(editProduct.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Processing product edit request");

        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productPriceStr = request.getParameter("productPrice");
        String stockQuantityStr = request.getParameter("stockQuantity");
        String categoryIdStr = request.getParameter("categoryId");
        String productBranch = request.getParameter("productBranch");
        Part imagePart = request.getPart("image");

        double productPrice;
        int stockQuantity, categoryId;

        try {
            productPrice = Double.parseDouble(productPriceStr);
            stockQuantity = Integer.parseInt(stockQuantityStr);
            categoryId = Integer.parseInt(categoryIdStr);
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid number format: " + e.getMessage());
            response.sendRedirect("error.jsp");
            return;
        }

        String imageUrl = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            InputStream imageInputStream = imagePart.getInputStream();
            imageUrl = convertImageToBase64(imageInputStream); // Convert new image to base64
        } else {
            ProductDAO productDAO = new ProductDAO();
            Product existingProduct = productDAO.getProductById(productId);
            if (existingProduct != null) {
                imageUrl = existingProduct.getImage_url(); // Keep existing image
            }
        }

        ProductDAO productDAO = new ProductDAO();
        boolean updateSuccess = productDAO.editProduct(productId, productName, productPrice, imageUrl, stockQuantity, categoryId, productBranch);

        if (!updateSuccess) {
            LOGGER.warning("Failed to update product");
            response.sendRedirect("error.jsp");
            return;
        }

        LOGGER.info("Product updated with ID: " + productId);

        Collection<Part> additionalImageParts = request.getParts().stream()
                .filter(part -> "additionalImages".equals(part.getName()) && part.getSize() > 0)
                .collect(Collectors.toList());
        imageDAO imageDao = new imageDAO();
        int existingImageCount = 0;
        try {
            existingImageCount = imageDao.getImageCountByProductId(Integer.parseInt(productId));
        } catch (SQLException ex) {
            Logger.getLogger(editProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        int newImagesCount = additionalImageParts.size();

        if (existingImageCount + newImagesCount > 5) {
            // Redirect or forward request to JSP with error message
            request.setAttribute("error", "Cannot add more than 5 images. Please remove some images to proceed.");
            request.getRequestDispatcher("editProductPage.jsp?productId=" + productId).forward(request, response);
            return; // Stop further execution
        }
        // Xử lý hình ảnh phụ, giả sử bạn có một phương thức trong imageDAO để cập nhật hình ảnh
        Part[] additionalImages = request.getParts().toArray(new Part[0]);
        for (Part part : request.getParts()) {
            if ("additionalImages".equals(part.getName()) && part.getSize() > 0) {
                String imageBase64 = convertImageToBase64(part.getInputStream());
                image img = new image();
                img.setProduct_id(Integer.parseInt(productId));
                img.setImage_url(imageBase64);
                try {
                    imageDao.addImage(img);
                } catch (SQLException ex) {
                    Logger.getLogger(editProduct.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        response.sendRedirect("editProductPage.jsp?productId=" + productId); // Redirect to a product details page
    }

    private String convertImageToBase64(InputStream inputStream) throws IOException {
        byte[] bytes = Base64.getEncoder().encode(IOUtils.toByteArray(inputStream));
        return new String(bytes);
    }
}
