/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Image;

import dao.imageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;
import model.image;

/**
 *
 * @author Asus
 */
@MultipartConfig
public class editSliderServlet extends HttpServlet {
   
    
   
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
        int imageId = Integer.parseInt(request.getParameter("id"));
        int productId = Integer.parseInt(request.getParameter("product_id"));
        Part filePart = request.getPart("image"); 
        String imageBase64 = convertImageToBase64(filePart);

        imageDAO dao = new imageDAO();
        image img = new image(imageId, productId, imageBase64);

        try {
            dao.updateImage(img);
            response.sendRedirect("/admin-setting"); 
        } catch (SQLException e) {
            throw new ServletException("SQL error occurred: " + e.getMessage(), e);
        }
    }

    private String convertImageToBase64(Part filePart) throws IOException {
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                byte[] bytes = inputStream.readAllBytes();
                return Base64.getEncoder().encodeToString(bytes);
            }
        }
        return null; // or handle appropriately
    }
    

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}