/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Product;

import dao.ProductDAO;
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
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "CrudProduct", urlPatterns = {"/CrudProduct"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class CrudProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CrudProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CrudProduct at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAll();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("showProducts").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {

                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                    break;
            }
        }
    }

    

    private String convertImageToBase64(Part imagePart) throws IOException {
        if (!isValidImageType(imagePart.getContentType())) {
            throw new IOException("Invalid image type.");
        }
        InputStream inputStream = imagePart.getInputStream();
        byte[] bytes = IOUtils.toByteArray(inputStream);
        return Base64.getEncoder().encodeToString(bytes);
    }

    private boolean isValidImageType(String contentType) {
        return contentType.equals("image/jpeg") || contentType.equals("image/png");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get productId parameter from the request
            String productId = request.getParameter("product_id");

            // Delete the product
            ProductDAO productDAO = new ProductDAO();
            boolean success = productDAO.deleteProduct(productId);

            // Redirect to the product list page or handle failure
            if (success) {
                response.sendRedirect("showProducts.jsp");
            } else {
                response.getWriter().println("Failed to delete product.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("Number format error: " + e.getMessage());
        } catch (Exception e) {
            response.getWriter().println("An error occurred in deleteProduct: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
