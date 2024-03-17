/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.User;
import org.apache.commons.codec.binary.Hex;

/**
 *
 * @author tranq
 */
@WebServlet(name = "AddEditDeleteUser", urlPatterns = {"/AddEditDeleteUser"})
public class AddEditDeleteUser extends HttpServlet {

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
            out.println("<title>Servlet EditDeleteUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditDeleteUser at " + request.getContextPath() + "</h1>");
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
  public String GenSHA256(String input) {
        String hashedValue = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] digest = md.digest(input.getBytes());

            hashedValue = Hex.encodeHexString(digest);
            System.out.println(hashedValue);

        } catch (NoSuchAlgorithmException e) {

        }
        return hashedValue;
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

        String idStr = request.getParameter("id");
        String method = request.getParameter("method");
        int id = 0;

        try {          
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {

            System.err.println("Không thể chuyển đổi chuỗi sang số nguyên: " + e.getMessage());
            response.sendRedirect("AdminUser?e=Uid");
        }
        UserDAO ud = new UserDAO();
        if (method.equals("edit")) {
            String fullName = request.getParameter("fullName");
            String birthdateRaw = request.getParameter("birthdate");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String role = request.getParameter("role");
          
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date birthdateUtil = null;
            try {

                birthdateUtil = dateFormat.parse(birthdateRaw);
            } catch (ParseException e) {
                e.printStackTrace();
                response.sendRedirect("AdminUser?e=bd");
                return; // Dừng việc xử lý nếu có lỗi
            }
            java.sql.Date birthdateSql = new java.sql.Date(birthdateUtil.getTime());
            User u = new User(id, fullName, birthdateSql, phoneNumber, email, address, role);

            if (!ud.updateUser(u)) {
                response.sendRedirect("AdminUser?e=UError");
            } else {
                response.sendRedirect("AdminUser");
            }
        } else {
           
            if (!ud.deleteUser(id)) {
                response.sendRedirect("AdminUser?e=DError");
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