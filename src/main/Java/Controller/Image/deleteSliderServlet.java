/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Image;

import dao.imageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.image;

/**
 *
 * @author Asus
 */
public class deleteSliderServlet extends HttpServlet {
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    
       
        try {
            imageDAO dao = new imageDAO();
    List<image> images = dao.getImgList(1); // Fetch images from the database
    request.setAttribute("images", images); 
    
           String image = dao.getImageUrlById(2);
            System.out.println(images);
        request.setAttribute("imagelogo", image);
        request.getRequestDispatcher("/adminSetting.jsp").forward(request, response);
        
        
        } catch (SQLException ex) {
            Logger.getLogger(editLogoServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
       try {
             String imageId = request.getParameter("image_id");
            imageDAO dao = new imageDAO();
            dao.DeleteImageSlider(imageId);

            response.sendRedirect("/admin-setting"); // Redirect back to the images page
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting images");
        }
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