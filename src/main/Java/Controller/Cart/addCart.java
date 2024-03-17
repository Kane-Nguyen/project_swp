/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Cart;

import dao.cartDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;

/**
 *
 * @author Asus
 */
@WebServlet(name = "addCart", urlPatterns = {"/addCart"})
public class addCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Lấy session hiện tại nếu có
        boolean isLoggedIn = (session != null && session.getAttribute("UserRole") != null);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(String.valueOf(isLoggedIn)); // Trả về "true" nếu đã đăng nhập, ngược lại "false"
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            // Xử lý trường hợp không có userId (chưa đăng nhập)
            response.sendRedirect("login");
            return;
        }
  

        String productId = request.getParameter("productId");

        int quantity = 1;

        try {
            String quantityStr = request.getParameter("quantity");
            quantity = Integer.parseInt(quantityStr);
            System.out.println(quantity);
        } catch (NumberFormatException e) {

        }

        cartDAO cart = new cartDAO();

      


        System.out.println(userId);

        Cart existingCart = cart.findCartByUserIdAndProductId(userId, Integer.parseInt(productId));

        if (existingCart
                != null) {

            int newQuantity = existingCart.getQuantity() + quantity;
            existingCart.setQuantity(newQuantity);
            Cart cart1 = cart.findCartByUserIdAndProductId(userId, Integer.parseInt(productId));
            int cartId = cart1.getCart_id();
            try {
                cart.updateCartQuantity(cartId, newQuantity);
                response.sendRedirect("cart?s1");
            } catch (SQLException ex) {

                Logger.getLogger(addCart.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("cart?e=erorr");
            }

        } else {
            // Product is not in the cart, add a new entry
            Cart newCart = new Cart(userId, Integer.parseInt(productId), quantity);

            try {
                if (cart.insertCart(newCart)) {
                    response.sendRedirect("cart?ss");
                } else {
                    System.out.println("errorr");
                    response.sendRedirect("cart?error=erorr");
                }
            } catch (SQLException ex) {
                Logger.getLogger(addCart.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
