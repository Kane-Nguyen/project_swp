/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import dao.UserDAO;
import dao.imageDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.User;
import model.image;

/**
 *
 * @author tranq
 */
@WebServlet(name = "AdminUser", urlPatterns = {"/AdminUser"})
public class AdminUser extends HttpServlet {

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
            out.println("<title>Servlet ShowUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShowUser at " + request.getContextPath() + "</h1>");
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
        imageDAO im = new imageDAO();
        image img = null;
        try {
            img = im.getImageByProductId(2);
        } catch (SQLException ex) {

        }
        request.setAttribute("logo", img);
        UserDAO u = new UserDAO();
        List<User> listUsers = u.getAll();
        request.setAttribute("listUsers", listUsers);
        request.getRequestDispatcher("/adminUserPage.jsp").forward(request, response);
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

        if (method.equals("add")) {
            HttpSession session = request.getSession();
            session.removeAttribute("otp");
            String fullName = (String) session.getAttribute("fullName");
            String birthdateRaw = (String) session.getAttribute("birthdate");
            String address = (String) session.getAttribute("address");
            String email1 = (String) session.getAttribute("email");
            String phoneNumber = (String) session.getAttribute("phoneNumber");
            String password = (String) session.getAttribute("password");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String role = request.getParameter("role");
            Date birthdateUtil = null;
            try {

                birthdateUtil = dateFormat.parse(birthdateRaw);
            } catch (java.text.ParseException e) {
                e.printStackTrace();
                response.sendRedirect("AdminUser?e=bd");
                return; // Dừng việc xử lý nếu có lỗi
            }

            java.sql.Date birthdateSql = new java.sql.Date(birthdateUtil.getTime());

            User u = new User(fullName, birthdateSql, phoneNumber, email1, password, address, role);
            UserDAO ud = new UserDAO();
            if (!ud.insertUser(u)) {
                response.sendRedirect("AdminUser?e=Add");

            } else {
                response.sendRedirect("AdminUser");

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
