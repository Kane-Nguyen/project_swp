package Controller.Cart;

import dao.ProductDAO;
import dao.cartDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CRUDCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        cartDAO cartDAO = new cartDAO();
        List<Cart> cartList = cartDAO.getCartItemsByUserId(userId);

        List<Product> ProductList = new ArrayList<>();
        ProductDAO p = new ProductDAO();
        for (Cart item : cartList) {
            Product product = p.getProductById(item.getProduct_id());
            ProductList.add(product);
        }
        for (int i = 0; i < ProductList.size(); i++) {
            System.out.println(ProductList.get(i).getProduct_name());
        }
        request.setAttribute("cartList", cartList);
        request.setAttribute("ProductList", ProductList);
        request.getRequestDispatcher("cartPage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("method");
        cartDAO cDAO = new cartDAO();
        boolean result = false;

        if ("updateQuantity".equals(method)) {
            String cartId = request.getParameter("id");
            String newQuantity = request.getParameter("newQuantity");
            int cartIdNumber = Integer.parseInt(cartId);
            int newQuantityNumber = Integer.parseInt(newQuantity);

            try {
                // Thực hiện cập nhật số lượng và kiểm tra số lượng tồn kho
                result = cDAO.updateCartQuantity(cartIdNumber, newQuantityNumber);

                if (result) {
                    request.setAttribute("resultUpdate", "Cập nhật số lượng thành công");
                } else {
                    request.setAttribute("resultUpdate", "Không thể cập nhật số lượng vượt quá số lượng tồn kho");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                request.setAttribute("resultUpdate", "Lỗi khi cập nhật số lượng");
            }

            // Reload the cart page after update
           response.sendRedirect("cart");
        }

        if ("delete".equals(method)) {

            String cartId = request.getParameter("id");
            int cartIdNumber = Integer.parseInt(cartId);
            System.out.println("cartid " +cartIdNumber);
            try {
                result = cDAO.deleteCart(cartIdNumber);
            } catch (Exception ex) {
                ex.printStackTrace();
                result = false;
            }

            if (result) {
                request.setAttribute("resultDelete", "Xóa sản phẩm khỏi giỏ hàng thành công");
                response.sendRedirect("/cart");
            } else {
                request.setAttribute("resultDelete", "Lỗi khi xóa sản phẩm khỏi giỏ hàng");
                response.sendRedirect("/cart?e=e123");
            }

        }
    }
}
