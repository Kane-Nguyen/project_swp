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
import java.sql.SQLException;
import java.util.Base64;
import java.util.Collection;
import java.util.stream.Collectors;



/**
 *
 * @author Asus
 */

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

        response.sendRedirect("success.jsp");
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
