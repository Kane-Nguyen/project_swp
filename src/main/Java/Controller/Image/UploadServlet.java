/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Image;

import dao.imageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.image;
import org.apache.commons.io.IOUtils;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.Collection;
import java.util.stream.Collectors;



/**
 *
 * @author Asus
 */
@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UploadServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UploadServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productId = request.getParameter("product_id");
        if (productId == null || productId.trim().isEmpty()) {
            handleMissingParameter(response, "Product ID is missing");
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
        try {
            String contentType = imagePart.getContentType();
            System.out.println("Content Type: " + contentType);
            if (!isValidImageType(contentType)) {
                handleInvalidImageType(response);
                return;
            }

                if (imagePart.getSize() > 10485760) { // 10 MB limit
                    throw new ServletException("File size exceeds maximum limit (10 MB)");
                }

                String imageBase64 = convertImageToBase64(imagePart);

                image img = new image();
                img.setProduct_id(productId);
                img.setImage_url(imageBase64);
                dao.addImage(img);

            } catch (Exception e) {
                handleError(response, e.getMessage());
                return;
            }
        }

        response.sendRedirect("success.jsp");
    }

    private String convertImageToBase64(Part imagePart) throws IOException {
    String contentType = imagePart.getContentType();

    // Only allow PNG and JPG images
    if (!isValidImageType(contentType)) {
        throw new IOException("Invalid image type: " + contentType);
    }

    // Proceed with conversion if image type is valid
    InputStream inputStream = imagePart.getInputStream();
    byte[] imageBytes = IOUtils.toByteArray(inputStream);
    return Base64.getEncoder().encodeToString(imageBytes);
}

    private void handleMissingParameter(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/plain");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().println("Error: " + message);
    }

    private void handleInvalidImageType(HttpServletResponse response) throws IOException {
        response.setContentType("text/plain");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().println("Error: Only PNG and JPG image types are accepted.");
    }

    private void handleError(HttpServletResponse response, String errorMessage) throws IOException {
        response.setContentType("text/plain");
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().println("Error processing the image upload: " + errorMessage);
    }
    
    private boolean isValidImageType(String contentType) {
    return contentType.equals("image/jpeg") || contentType.equals("image/png");
}



    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Image Upload Servlet";
    }

}
