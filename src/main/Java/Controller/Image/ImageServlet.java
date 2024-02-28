package Controller.Image;

import dao.imageDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;

import java.util.Base64;
import java.util.Collection;


import java.util.stream.Collectors;
import model.image;
import org.apache.commons.io.IOUtils;

@MultipartConfig
public class ImageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("product_id");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            handleMissingParameter(response, "Product ID is missing");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            handleInvalidParameter(response, "Invalid Product ID format");
            return;
        }

        Collection<Part> imageParts = request.getParts().stream()
                .filter(part -> "images[]".equals(part.getName()) && part.getSize() > 0)
                .collect(Collectors.toList());

        if (imageParts.isEmpty()) {
            handleMissingParameter(response, "No images provided");
            return;
        }

        imageDAO dao = new imageDAO();

        for (Part imagePart : imageParts) {
            try (InputStream inputStream = imagePart.getInputStream()) {
                String contentType = imagePart.getContentType();
                if (!isValidImageType(contentType)) {
                    handleInvalidImageType(response);
                    return;
                }

                if (imagePart.getSize() > 10485760) { // 10 MB limit
                    throw new ServletException("File size exceeds maximum limit (10 MB)");
                }

                String imageBase64 = convertImageToBase64(inputStream);

                image img = new image();
                img.setProduct_id(productId);
                img.setImage_url(imageBase64);
                dao.addImage(img);
            } catch (Exception e) {
                handleError(response, e.getMessage());
                return;
            }
        }

        response.sendRedirect("CRUDSlider.jsp");
    }

    private String convertImageToBase64(InputStream inputStream) throws IOException {
        byte[] imageBytes = IOUtils.toByteArray(inputStream);
        return Base64.getEncoder().encodeToString(imageBytes);
    }

    private void handleInvalidParameter(HttpServletResponse response, String message) throws IOException {
        appendErrorMessage(response, message);
    }

    private void handleMissingParameter(HttpServletResponse response, String message) throws IOException {
        appendErrorMessage(response, message);
    }

    private void handleInvalidImageType(HttpServletResponse response) throws IOException {
        appendErrorMessage(response, "Only PNG and JPG image types are accepted.");
    }

    private void handleError(HttpServletResponse response, String errorMessage) throws IOException {
        appendErrorMessage(response, "Error processing the image upload: " + errorMessage);
    }

    private void appendErrorMessage(HttpServletResponse response, String errorMessage) throws IOException {
        response.setContentType("text/html");
        response.getWriter().println("<script>document.getElementById('error-message').innerHTML += '<p style=\"color: red;\">"+ errorMessage +"</p>';</script>");
    }


    private boolean isValidImageType(String contentType) {
        return contentType.equals("image/jpeg") || contentType.equals("image/png");
    }
}
