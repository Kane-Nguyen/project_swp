/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Product;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "CrudProduct", urlPatterns = {"/CrudProduct"})
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
        processRequest(request, response);
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
                    addProduct(request, response);
                    break;
                case "edit":
                    editProduct(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                    // Handle unknown action
                    break;
            }
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            double productPrice = Double.parseDouble(request.getParameter("productPrice"));
            String imageUrl = request.getParameter("image"); // Assuming image upload is handled correctly and returns a URL
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productBranch = request.getParameter("productBranch");

            ProductDAO productDAO = new ProductDAO();
            boolean success = productDAO.createProduct(productId, productName, productPrice, imageUrl, stockQuantity, categoryId, productBranch);

            if (success) {
                response.sendRedirect("showProducts.jsp"); // Redirect to product list page on success
            } else {
                response.getWriter().println("Failed to add product."); // Display error message
            }
        } catch (NumberFormatException e) {
            // Handle number format exceptions for double and integer parsing
            response.getWriter().println("Error in number format: " + e.getMessage());
        } catch (NullPointerException e) {
            // Handle null pointer exceptions, likely due to missing form data
            response.getWriter().println("Missing form data: " + e.getMessage());
        } catch (Exception e) {
            // Handle other exceptions
            response.getWriter().println("An error occurred: " + e.getMessage());
        }
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            double productPrice = Double.parseDouble(request.getParameter("productPrice"));
            String imageUrl = request.getParameter("image");
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productBranch = request.getParameter("productBranch");

            ProductDAO productDAO = new ProductDAO();
            boolean success = productDAO.editProduct(productId, productName, productPrice, imageUrl, stockQuantity, categoryId, productBranch);

            if (success) {
                response.sendRedirect("showProducts.jsp"); // Redirect to a page that shows the product list
            } else {
                response.getWriter().println("Failed to edit product."); // Display error message
            }
        } catch (NumberFormatException e) {
            // Handle number format exceptions
            response.getWriter().println("Number format error: " + e.getMessage());
        } catch (Exception e) {
            // Handle other exceptions
            response.getWriter().println("An error occurred: " + e.getMessage());
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get productId parameter from the request
        String productId = request.getParameter("product_id");

        // Delete the product
        ProductDAO productDAO = new ProductDAO();
        boolean success = productDAO.deleteProduct(productId);

        // Redirect to the product list page
        if (success) {
            response.sendRedirect("showProducts.jsp");
        } else {
            response.getWriter().println("Failed to delete product.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
