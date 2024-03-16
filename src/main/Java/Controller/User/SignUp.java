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
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.User;
import model.image;
import org.apache.commons.codec.binary.Hex;

/**
 *
 * @author tranq
 */
@WebServlet(name="SignUp", urlPatterns={"/signUp"})
public class SignUp extends HttpServlet {

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
            out.println("<title>Servlet SignUp</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUp at " + request.getContextPath() + "</h1>");
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
       request.getRequestDispatcher("SignUpPage.jsp").forward(request, response);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String birthdateRaw = request.getParameter("birthdate");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber"); 
        String email = request.getParameter("email");
        String userRole = request.getParameter("userRole");
        String passwordraw = request.getParameter("password");     
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date birthdateUtil = null; // java.util.Date
        String password =GenSHA256(passwordraw);
        try {
            
            birthdateUtil = dateFormat.parse(birthdateRaw);
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect("signUpPage.jsp"); 
            return; // Dừng việc xử lý nếu có lỗi
        }

        
        java.sql.Date birthdateSql = new java.sql.Date(birthdateUtil.getTime());

        UserDAO uD = new UserDAO();
        User user = new User(fullName, birthdateSql, phoneNumber, email, password, address, userRole);

        if (uD.insertUser(user)) {
            System.out.println("Đăng ký thành công");
            response.sendRedirect("/login"); // Chuyển hướng tới trang thành công
        } else {
            System.out.println("Đăng ký thất bại");
            response.sendRedirect("signUpPage.jsp"); // Chuyển hướng trở lại form đăng ký
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