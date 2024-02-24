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

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from the request
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        String imageUrl = request.getParameter("imageUrl");
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String productBranch = request.getParameter("productBranch");

        // Create a new product
        ProductDAO productDAO = new ProductDAO();
        boolean success = productDAO.createProduct(productId, productName, productPrice, imageUrl, stockQuantity, categoryId, productBranch);

        // Redirect to the product list page
        if (success) {
            response.sendRedirect("showProducts.jsp");
        } else {
            // Handle error
            // You can forward to an error page or display an error message
            response.getWriter().println("Failed to add product.");
        }
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin sản phẩm từ form
        String productId = request.getParameter("product_id");
        String productName = request.getParameter("product_name");
        double productPrice = Double.parseDouble(request.getParameter("product_price"));
        String imageUrl = request.getParameter("images[]");
        int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity"));
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        String productBranch = request.getParameter("product_branch");

        // Tạo đối tượng ProductDAO và cập nhật sản phẩm
        ProductDAO dao = new ProductDAO();
        boolean success = dao.editProduct(productId, productName, productPrice, imageUrl, stockQuantity, categoryId, productBranch);

        // Kiểm tra kết quả và chuyển hướng
        if (success) {
            response.sendRedirect("showProducts.jsp");
        } else {
            // Xử lý trường hợp cập nhật thất bại
            response.sendRedirect("showProducts.jsp"); // Trang thông báo lỗi
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
