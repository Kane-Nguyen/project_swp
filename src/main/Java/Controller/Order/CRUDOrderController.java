/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Order;

import dao.ProductDAO;
import dao.cartDAO;
import dao.orderDAO;
import dao.orderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import model.Order;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.orderDetail;

/**
 *
 * @author khaye
 */
@WebServlet(name = "editorder", urlPatterns = {"/CRUDOrderController"})
public class CRUDOrderController extends HttpServlet {

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
            out.println("<title>Servlet editorder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editorder at " + request.getContextPath() + "</h1>");
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
        String method = request.getParameter("method");
        orderDAO oDAO = new orderDAO();
        System.out.println("method :" + method);
        boolean result = false;

        if (method.equals("edit")) {
            String orderId = request.getParameter("orderId");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String receiver = request.getParameter("receiver");
            String status = request.getParameter("status");

            try {
                result = oDAO.updateOrder(Integer.parseInt(orderId), address, phoneNumber, receiver, Integer.parseInt(status));
                System.out.println(result);
            } catch (SQLException ex) {
                System.out.println("Error :" + ex.toString());
                result = false;
            }
            System.out.println(result);
            if (result == false) {
                System.out.println("Error");

            } else {

                response.sendRedirect("/order?s=ss");

            }

        } else if (method.equals("delete")) {
            String orderId = request.getParameter("orderId");
            int orderIdNumber = Integer.parseInt(orderId);
            System.out.println("id =" + orderIdNumber);
            try {
                result = oDAO.deleteOrder(orderIdNumber);
            } catch (SQLException ex) {
                System.out.println("Error :" + ex.toString());
                result = false;
            }
            if (result == false) {
                System.out.println("Error");

            } else {
                response.sendRedirect("/order?d=ss");

            }
        } else {
            try {
                String methodBuy = request.getParameter("methodBuy");
                int userId = Integer.parseInt(request.getParameter("userIdNumber"));
                String deliveryAddress = request.getParameter("address");
                String phoneNumber = request.getParameter("phoneNumber");
                String recipientName = request.getParameter("receiver");
                String paymentMethod = request.getParameter("paymentMethod");
                java.util.Date utilDate = new java.util.Date();
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
                    for (int i = 0; i < productIds.length; i++) {
                        int productId = Integer.parseInt(productIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        orderDetail oM = new orderDetail(quantity, order_id, productId);
                        if (methodBuy.equals("cart")) {
                            int cardid = Integer.parseInt(cartID[i]);
                            cd.deleteCart(cardid);
                        }
                        if (d.insertOrderDetail(oM)) {

                        } else {
                            response.sendRedirect("cart?error=e");
                        }
                    }
                    response.sendRedirect("/orderHistory");

                }
            } catch (NumberFormatException e) {
                response.sendRedirect("cart?error=e");
            } catch (SQLException ex) {
                Logger.getLogger(CRUDOrderController.class.getName()).log(Level.SEVERE, null, ex);
            }
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
