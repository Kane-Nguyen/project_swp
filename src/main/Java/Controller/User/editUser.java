/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import dao.UserDAO;
import dao.imageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.User;
import model.image;
import org.apache.commons.codec.binary.Hex;

/**
 *
 * @author tranq
 */
@WebServlet(name = "editUser", urlPatterns = {"/editUser"})
public class editUser extends HttpServlet {

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
            out.println("<title>Servlet editUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editUser at " + request.getContextPath() + "</h1>");
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
        imageDAO im = new imageDAO();

        image img = null;
        try {
            img = im.getImageByProductId(2);
        } catch (SQLException ex) {

        }

        request.setAttribute("logo", img);
        String email = (String) session.getAttribute("email");
        UserDAO ud = new UserDAO();
        User u = ud.getUserByEmail(email);
        request.setAttribute("User", u);
        request.getRequestDispatcher("/editUser.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String feature = request.getParameter("feature");
        String email = (String) session.getAttribute("email");
        String fullName = request.getParameter("fullName");
        String birthdateRaw = request.getParameter("birthDate");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        UserDAO ud = new UserDAO();
        if (feature.equals("info")) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date birthdateUtil = null;
            try {

                birthdateUtil = dateFormat.parse(birthdateRaw);
            } catch (java.text.ParseException e) {

                response.sendRedirect("editUser?e=bd");
                return;
            }

            java.sql.Date birthdateSql = new java.sql.Date(birthdateUtil.getTime());
            User u = new User(fullName, birthdateSql, phoneNumber, address);

            if (ud.editInfo(u, email)) {
                response.sendRedirect("editUser");
            } else {
                response.sendRedirect("editUser?e=Error");
            }
        } else {
            String oldPassword = GenSHA256(request.getParameter("oldpassword"));
            if (ud.comparePassword(email, oldPassword)) {
                String password = GenSHA256(request.getParameter("password"));
                if (ud.updatePassword(email, password)) {
                    response.sendRedirect("editUser");
                } else {
                    response.sendRedirect("editUser?e=ErrorP");
                }

            } else {
                response.sendRedirect("editUser?e=ErrorP1");
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
