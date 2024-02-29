//package Controller.Product;
//
//import dao.ProductDAO;
//import dao.imageDAO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.Part;
//import org.apache.commons.io.IOUtils;
//import java.io.IOException;
//import java.io.InputStream;
//import java.sql.SQLException;
//import java.util.Base64;
//import java.util.Collection;
//import java.util.logging.Logger;
//import java.util.stream.Collectors;
//
//@WebServlet(name = "editProduct", urlPatterns = {"/editProduct"})
//public class editProduct extends HttpServlet {
//    private static final Logger LOGGER = Logger.getLogger(editProduct.class.getName());
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        LOGGER.info("Processing product edit request");
//
//        // Parse product details from the request
//        int productId = Integer.parseInt(request.getParameter("productId"));
//        String productName = request.getParameter("productName");
//        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
//        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
//        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
//        String productBranch = request.getParameter("productBranch");
//
//        // Update product details
//        ProductDAO productDAO = new ProductDAO();
//        boolean updateSuccess = productDAO.editProduct(productId, productName, productPrice, productName, stockQuantity, categoryId, productBranch);
//        if (!updateSuccess) {
//            LOGGER.warning("Failed to update product details for product ID: " + productId);
//            response.sendRedirect("editProductError.jsp");
//            return;
//        }
//
//        // Handle adding new additional images
//        Collection<Part> newAdditionalImageParts = request.getParts().stream()
//                .filter(part -> "newAdditionalImages".equals(part.getName()) && part.getSize() > 0)
//                .collect(Collectors.toList());
//
//        imageDAO imageDAO = new imageDAO();
//        for (Part imagePart : newAdditionalImageParts) {
//            String imageBase64 = convertImageToBase64(imagePart.getInputStream());
//            model.image img = new model.image();
//            img.setProduct_id(productId);
//            img.setImage_url(imageBase64);
//            try {
//                imageDAO.addImage(img);
//            } catch (SQLException e) {
//                LOGGER.severe("Error in EditProductServlet: " + e.getMessage());
//                throw new ServletException("Error adding additional image", e);
//            }
//        }
//
//        LOGGER.info("Product updated successfully with ID: " + productId);
//        response.sendRedirect("productDetails.jsp?productId=" + productId);
//    }
//
//    private String convertImageToBase64(InputStream inputStream) throws IOException {
//        byte[] imageBytes = IOUtils.toByteArray(inputStream);
//        return Base64.getEncoder().encodeToString(imageBytes);
//    }
//}
