package Controller.Product;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.imageDAO;
import model.Product;
import model.image;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.Category;

@WebServlet(name = "createProduct", urlPatterns = {"/createProduct"})
@MultipartConfig
public class createProduct extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(createProduct.class.getName());
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/createProductPage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("loginPage.jsp");
            return;
        }
        String productId = request.getParameter("productId"); // Use this for edits, generate for new products
        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String productBranch = request.getParameter("productBranch");

        String imageUrl = handleMainImage(request.getPart("image"), productId);

        ProductDAO productDAO = new ProductDAO();
        boolean success;
        if (productId == null || productId.isEmpty()) {
            // Create new product scenario
            int newProductId = productDAO.createProduct(productName, userId, productPrice, imageUrl, stockQuantity, categoryId, productBranch);
            success = newProductId > 0;
            productId = String.valueOf(newProductId); // Set productId for additional images handling
        } else {
            // Edit existing product scenario
            success = productDAO.editProduct(productId, productName, productPrice, imageUrl, stockQuantity, categoryId, productBranch);
        }

        if (!success) {
            LOGGER.warning("Failed to process product");
            response.sendRedirect("error.jsp");
            return;
        }

        handleAdditionalImages(request, productId);
        response.sendRedirect("CrudProduct"); // Or another appropriate URL
    }

    private String handleMainImage(Part imagePart, String productId) throws IOException {
        if (imagePart != null && imagePart.getSize() > 0) {
            return convertPartToBase64(imagePart);
        } else if (productId != null && !productId.isEmpty()) {
            ProductDAO productDAO = new ProductDAO();
            Product existingProduct = productDAO.getProductById(Integer.parseInt(productId));
            if (existingProduct != null) {
                return existingProduct.getImage_url(); // Use existing image if new one isn't provided
            }
        }
        return null; // No image provided and/or product not found
    }

    private void handleAdditionalImages(HttpServletRequest request, String productId) throws IOException, ServletException {
        Collection<Part> additionalImageParts = request.getParts().stream()
                .filter(part -> "additionalImages".equals(part.getName()) && part.getSize() > 0)
                .collect(Collectors.toList());

        imageDAO imageDao = new imageDAO();
        for (Part part : additionalImageParts) {
            String imageBase64 = convertPartToBase64(part);
            // Adjusted to match your image model class constructor
            image img = new image(Integer.parseInt(productId), imageBase64);
            try {
                imageDao.addImage(img); // Assuming this method exists and adds the image to your database
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "Error adding additional image to database", ex);
            }
        }
    }

    private String convertPartToBase64(Part part) throws IOException {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        try (InputStream input = part.getInputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }
        return Base64.getEncoder().encodeToString(output.toByteArray());
    }
    
}
