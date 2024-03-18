// Source code is decompiled from a .class file using FernFlower decompiler.
package Controller.Order;

import dao.cartDAO;
import dao.orderDAO;
import dao.orderDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.orderDetail;

@WebServlet(
        name = "editorder",
        urlPatterns = {"/CRUDOrderController"}
)
public class CRUDOrderController extends HttpServlet {

    public CRUDOrderController() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet editorder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editorder at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (Throwable var7) {
            if (out != null) {
                try {
                    out.close();
                } catch (Throwable var6) {
                    var7.addSuppressed(var6);
                }
            }

            throw var7;
        }

        if (out != null) {
            out.close();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        orderDAO oDAO = new orderDAO();
        System.out.println("method :" + method);
        boolean result = false;
        String methodBuy;
        String deliveryAddress;
        String phoneNumber;
        String recipientName;
        if (method.equals("edit")) {
            methodBuy = request.getParameter("orderId");
            String address = request.getParameter("address");
            deliveryAddress = request.getParameter("phoneNumber");
            phoneNumber = request.getParameter("receiver");
            recipientName = request.getParameter("status");

            try {
                result = oDAO.updateOrder(Integer.parseInt(methodBuy), address, deliveryAddress, phoneNumber, Integer.parseInt(recipientName));
                System.out.println(result);
            } catch (SQLException var29) {
                System.out.println("Error :" + var29.toString());
                result = false;
            }

            System.out.println(result);
            if (!result) {
                System.out.println("Error");
            } else {
                response.sendRedirect("/order?s=ss");
            }
        } else if (method.equals("cancel")) {
            String idStr = request.getParameter("order_id");
            int id = -1;
            try {
                id = Integer.parseInt(idStr);
            } catch (NumberFormatException e) {
            }
            try {
                if (oDAO.updateOrderStatus(id)) {
                    response.sendRedirect("orderHistory");
                }
            } catch (SQLException ex) {
                Logger.getLogger(CRUDOrderController.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else {
            int userId;
            if (method.equals("delete")) {
                methodBuy = request.getParameter("orderId");
                userId = Integer.parseInt(methodBuy);
                System.out.println("id =" + userId);

                try {
                    result = oDAO.deleteOrder(userId);
                } catch (SQLException var28) {
                    System.out.println("Error :" + var28.toString());
                    result = false;
                }

                if (!result) {
                    System.out.println("Error");
                } else {
                    response.sendRedirect("/order?d=ss");
                }
            } else {
                try {
                    methodBuy = request.getParameter("methodBuy");
                    userId = Integer.parseInt(request.getParameter("userIdNumber"));
                    deliveryAddress = request.getParameter("address");
                    phoneNumber = request.getParameter("phoneNumber");
                    recipientName = request.getParameter("receiver");
                    String paymentMethod = request.getParameter("paymentMethod");

                    if (deliveryAddress.equals("") || phoneNumber.equals("") || recipientName.equals("")) {

                        request.getRequestDispatcher("page505").forward(request, response);
                        return;
                    }
                    if (!phoneNumber.matches("^0\\d{9}$")) {

                        request.getRequestDispatcher("page505").forward(request, response);
                        return;
                    }

                    Date utilDate = new Date();
                    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                    orderDAO od = new orderDAO();
                    int status = 1;
                    if (paymentMethod.equals("COD")) {
                        status = 2;
                    }

                    cartDAO cd = new cartDAO();
                    String[] productIds = request.getParameterValues("productId");
                    String[] quantities = request.getParameterValues("quantity");
                    String[] cartID = null;
                    if (methodBuy.equals("cart")) {
                        cartID = request.getParameterValues("cartID");
                    }

                    Order order = new Order(userId, deliveryAddress, phoneNumber, recipientName, paymentMethod, status, sqlDate);
                    int order_id = od.insertOrder(order);
                    if (order_id == -1) {
                        response.sendRedirect("cart?error=e");
                    } else {
                        System.out.println("orderID = " + order_id);
                        orderDetailDAO d = new orderDetailDAO();

                        for (int i = 0; i < productIds.length; ++i) {
                            int productId = Integer.parseInt(productIds[i]);
                            int quantity = Integer.parseInt(quantities[i]);
                            orderDetail oM = new orderDetail(quantity, order_id, productId);
                            if (methodBuy.equals("cart")) {
                                int cardid = Integer.parseInt(cartID[i]);
                                cd.deleteCart(cardid);
                            }

                            if (!d.insertOrderDetail(oM)) {
                                response.sendRedirect("cart?error=e");
                            }
                        }

                        response.sendRedirect("/orderHistory?status=ok");
                    }
                } catch (NumberFormatException var30) {
                    response.sendRedirect("/orderHistory?status=e");
                } catch (SQLException var31) {
                    Logger.getLogger(CRUDOrderController.class.getName()).log(Level.SEVERE, (String) null, var31);
                }
            }
        }

    }

    public String getServletInfo() {
        return "Short description";
    }
}
