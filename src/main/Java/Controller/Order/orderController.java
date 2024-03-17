/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Order;

import dao.ProductDAO;
import dao.UserDAO;
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.Product;
import model.User;
import model.orderDetail;
import model.orderStatus;

/**
 *
 * @author khaye
 */
@WebServlet(name = "orderController", urlPatterns = {"/order"})
public class orderController extends HttpServlet {

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
            out.println("<title>Servlet orderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet orderController at " + request.getContextPath() + "</h1>");
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
          HttpSession session = request.getSession();
        String role = (String) session.getAttribute("UserRole");
        int sellerId= (int) session.getAttribute("userId");
        UserDAO ud = new UserDAO();
        orderDAO od = new orderDAO();
        List<User> lu = ud.getAll();
        
        List<Order> listOrderSeller;
        try {

            listOrderSeller = od.getOrdersByUserId(sellerId);
            for (Order order : listOrderSeller) {
                List<Product> products = od.getProductsByOrderId(order.getOrderID());
                
            }
            request.setAttribute("listOrderSeller", listOrderSeller);
        } catch (SQLException ex) {
            Logger.getLogger(orderController.class.getName()).log(Level.SEVERE, null, ex);
        }
        List<Order> lo = od.getOrderList();
        request.setAttribute("listOrder", lo);
        List<orderStatus> ls = od.getOrderStatus();
        request.setAttribute("listOrderStatus", ls);
        
        ProductDAO p = new ProductDAO();
        List<Product> lp = p.getAll();
        request.setAttribute("ListProduct", lp);
        request.setAttribute("listUser", lu);
        if (role.trim().equals("admin")) {
            orderDetailDAO odd = new orderDetailDAO();
            List<orderDetail> lod = odd.getOrderDetailListBy();
            request.setAttribute("ListOrderDetail", lod);
        } else if (role.trim().equals("seller")) {
            orderDetailDAO odd = new orderDetailDAO();
            List<orderDetail> lod = odd.getOrderDetailListByUserId(sellerId);
            request.setAttribute("ListOrderDetail", lod);
        }
        
        request.getRequestDispatcher("/orderPage.jsp").forward(request, response);
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
