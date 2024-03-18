/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Order;

import dao.ProductDAO;
import dao.cartDAO;
import dao.imageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Product;
import model.image;

/**
 *
 * @author tranq
 */
@WebServlet(name = "orderPayment", urlPatterns = {"/orderPayment"})
public class orderPayment extends HttpServlet {

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
            out.println("<title>Servlet orderPayment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet orderPayment at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            // Xử lý trường hợp không có userId (chưa đăng nhập)
            response.sendRedirect("login");
            return;
        }
        response.sendRedirect("cart");
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
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("method").equals("cart")) {
            String[] selectedProducts = request.getParameterValues("selectedProducts");
            List<Product> ProductList = new ArrayList<>();
            ProductDAO p = new ProductDAO();
            cartDAO c = new cartDAO();
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            List<Cart> cartItems = c.getCartItemsByUserId(userId);
            request.setAttribute("cartItems", cartItems);
            if (selectedProducts != null) {
                System.out.println("Selected Product IDs:");
                for (String productId : selectedProducts) {
                    Product product = p.getProductById(Integer.parseInt(productId));
                    ProductList.add(product);
                    System.out.println(productId);

                }
                imageDAO im = new imageDAO();
                image img = null;
                try {
                    img = im.getImageByProductId(2);
                } catch (SQLException ex) {

                }
                request.setAttribute("logo", img);
                request.setAttribute("method", "buyfromCart");
                request.setAttribute("ProductList", ProductList);
                request.getRequestDispatcher("/orderPayment.jsp").forward(request, response);
            } else {
                // Không có sản phẩm nào được chọn, chuyển hướng trở lại trang giỏ hàng với thông báo lỗi hoặc thông tin
                response.sendRedirect("cart?error=noProductSelected");
            }
        } else {
            String productIdStr = request.getParameter("productId");

            System.out.println(productIdStr);

            int quantity = 1;
            int productId = 0;
            try {
                String quantityStr = request.getParameter("quantity");
                if (quantityStr != null) {
                    quantity = Integer.parseInt(quantityStr);
                }

            } catch (NumberFormatException e) {

            }
            imageDAO im = new imageDAO();
            image img = null;
            try {
                img = im.getImageByProductId(2);
            } catch (SQLException ex) {

            }
            request.setAttribute("logo", img);
            productId = Integer.parseInt(productIdStr);
            ProductDAO p = new ProductDAO();
            Product p1 = p.getProductById(productId);
            request.setAttribute("method", "buy");
            request.setAttribute("product", p1);
            request.setAttribute("quantity", quantity);
            request.getRequestDispatcher("/orderPayment.jsp").forward(request, response);

        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
