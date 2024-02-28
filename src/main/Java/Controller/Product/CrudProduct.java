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
import java.sql.SQLException;
import java.util.Base64;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.Product;
import model.image;
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
                case "add":
                {
                    try {
                        addProduct(request, response);
                    } catch (SQLException ex) {
                        Logger.getLogger(CrudProduct.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                    break;

                case "edit":
                    editProduct(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                    break;
            }
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException {

    try {
        // Extract product information
        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String productBranch = request.getParameter("productBranch");

        // Handle main image
        Part mainImagePart = request.getPart("image");
        String mainImageBase64 = convertImageToBase64((Part) mainImagePart.getInputStream());

        // Create product
        ProductDAO productDAO = new ProductDAO();
        int productId = productDAO.createProduct(productName, productPrice, mainImageBase64, stockQuantity, categoryId, productBranch);

        // Check if product is created
        if (productId == -1) {
            response.getWriter().println("Failed to add product.");
            return;
        }

        // Handle additional images
        Collection<Part> additionalImageParts = request.getParts().stream()
            .filter(part -> "additionalImages".equals(part.getName()) && part.getSize() > 0)
            .collect(Collectors.toList());

        imageDAO imageDAO = new imageDAO();
        for (Part imagePart : additionalImageParts) {
            String imageBase64 = convertImageToBase64((Part) imagePart.getInputStream());
            image img = new image();
            img.setProduct_id(productId);
            img.setImage_url(imageBase64);
            imageDAO.addImage(img);
        }

        response.sendRedirect("showProducts.jsp"); // Redirect on success

    } catch (NumberFormatException e) {
        response.getWriter().println("Error in number format: " + e.getMessage());
    } catch (NullPointerException | ServletException e) {
        response.getWriter().println("Error processing form: " + e.getMessage());
    } catch (IOException e) {
        response.getWriter().println("IO Error: " + e.getMessage());
    }
}


    private void editProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            double productPrice = Double.parseDouble(request.getParameter("productPrice"));
            Part imagePart = request.getPart("image");
            String imageUrl;

            if (imagePart != null && imagePart.getSize() > 0) {
                imageUrl = convertImageToBase64(imagePart); // Convert new image to base64

            } else {
                ProductDAO productDAO = new ProductDAO();
                Product existingProduct = productDAO.getProductById(productId);
                imageUrl = existingProduct.getImage_url(); // Keep existing image

            }

            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productBranch = request.getParameter("productBranch");

            ProductDAO productDAO = new ProductDAO();
            boolean success = productDAO.editProduct(productId, productName, productPrice, imageUrl, stockQuantity, categoryId, productBranch);

            if (success) {
                response.sendRedirect("showProducts.jsp"); // Redirect to the product list page

            } else {
                response.getWriter().println("Failed to edit product."); // Display error message

            }
        } catch (NumberFormatException e) {

            response.getWriter().println("Number format error: " + e.getMessage());
        } catch (Exception e) {

            response.getWriter().println("An error occurred: " + e.getMessage());
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
