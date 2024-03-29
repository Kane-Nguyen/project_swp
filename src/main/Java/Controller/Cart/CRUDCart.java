package Controller.Cart;

import dao.cartDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cart;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CRUDCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("method");
        cartDAO cDAO = new cartDAO();
        boolean result = false;
        
        if ("updateQuantity".equals(method)) {
            String cartId = request.getParameter("cartId");
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
            List<Cart> cartList = cDAO.getCartList();
            request.setAttribute("cartList", cartList);
            request.getRequestDispatcher("/cartPage.jsp").forward(request, response);
        }

        if ("delete".equals(method)) {
            String userId = request.getParameter("userId");
            String productId = request.getParameter("productId");
            String cartId = request.getParameter("cartId");
            int cartIdNumber = Integer.parseInt(cartId);
            int userIdNumber = Integer.parseInt(userId);

            try {
                result = cDAO.deleteCart(cartIdNumber, userIdNumber, productId);
            } catch (Exception ex) {
                ex.printStackTrace();
                result = false;
            }

            if (result) {
                request.setAttribute("resultDelete", "Xóa sản phẩm khỏi giỏ hàng thành công");
            } else {
                request.setAttribute("resultDelete", "Lỗi khi xóa sản phẩm khỏi giỏ hàng");
            }

            // Reload the cart page after deletion
            List<Cart> cartList = cDAO.getCartList();
            request.setAttribute("cartList", cartList);
            request.getRequestDispatcher("/cartPage.jsp").forward(request, response);
        }
    }
}
