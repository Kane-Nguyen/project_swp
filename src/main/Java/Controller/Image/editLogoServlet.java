/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Image;

import dao.imageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.image;

/**
 *
 * @author Asus
 */
@WebServlet(name = "editLogoServlet", urlPatterns = {"/editLogoServlet"})
@MultipartConfig
public class editLogoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        request.setAttribute("id", id);
        request.getRequestDispatcher("/adminSetting.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int product_id = 2; // This might be dynamic based on your requirements
        Part filePart = request.getPart("image");
        String imageBase64 = convertImageToBase64(filePart);

        imageDAO dao = new imageDAO();
        image img = new image();
        img.setProduct_id(product_id);
        img.setImage_url(imageBase64); // Assuming image_url holds the Base64 string

        try {
            dao.updateLogo(img);
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

}
