/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Order;

import dao.orderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        if (method.equals("create")) {
            String userId = request.getParameter("userId");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String receiver = request.getParameter("receiver");
            String paymentMethod = request.getParameter("paymentMethod");
            String price = request.getParameter("price");
            String createOrderDay = request.getParameter("createOrderDay");
            int userIdNumber = Integer.parseInt(userId);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilBirthDate = null;

            try {
                utilBirthDate = dateFormat.parse(createOrderDay);
            } catch (ParseException e) {
                // Xử lý lỗi ở đây nếu không thể chuyển đổi ngày sinh từ chuỗi.

            }
            java.sql.Date birthDate = new java.sql.Date(utilBirthDate.getTime());

            try {
                result = oDAO.createOrder(userIdNumber, address, phoneNumber, receiver, paymentMethod, Float.parseFloat(price), birthDate);
                System.out.println(result);
            } catch (SQLException ex) {
                System.out.println("Error :" + ex.toString());
                result = false;
            }
            System.out.println(result);
            if (result == false) {
                System.out.println("Error");

            } else {
                request.setAttribute("resultEdit", "Tạo đơn hàng thành công");
                request.getRequestDispatcher("orderPage.jsp").forward(request, response);
            }

        } if (method.equals("edit")) {
            String orderId = request.getParameter("orderId");
            String userId = request.getParameter("userId");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String receiver = request.getParameter("receiver");
            String paymentMethod = request.getParameter("paymentMethod");
            String price = request.getParameter("price");
            String createOrderDay = request.getParameter("createOrderDay");
            int orderIdNumber = Integer.parseInt(orderId);
            int userIdNumber = Integer.parseInt(userId);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilBirthDate = null;

            try {
                utilBirthDate = dateFormat.parse(createOrderDay);
            } catch (ParseException e) {
                // Xử lý lỗi ở đây nếu không thể chuyển đổi ngày sinh từ chuỗi.

            }
            java.sql.Date birthDate = new java.sql.Date(utilBirthDate.getTime());

            try {
                result = oDAO.updateOrder(orderIdNumber, userIdNumber, address, phoneNumber, receiver, paymentMethod, Float.parseFloat(price), birthDate);
                System.out.println(result);
            } catch (SQLException ex) {
                System.out.println("Error :" + ex.toString());
                result = false;
            }
            System.out.println(result);
            if (result == false) {
                System.out.println("Error");

            } else {
                request.setAttribute("resultEdit", "Cập nhật đơn hàng thành công");
                request.getRequestDispatcher("orderPage.jsp").forward(request, response);

            }

        } else if (method.equals("delete")) {
            String orderId = request.getParameter("orderId");
            int orderIdNumber = Integer.parseInt(orderId);
            try {
                result = oDAO.deleteOrder(orderIdNumber);
            } catch (SQLException ex) {
                System.out.println("Error :" + ex.toString());
                result = false;
            }
            if (result == false) {
                System.out.println("Error");

            } else {
                request.setAttribute("resultDelete", "Xóa đơn hàng thành công");
                request.getRequestDispatcher("orderPage.jsp").forward(request, response);

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
