/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import com.mysql.cj.conf.PropertyKey;
import dao.UserDAO;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import model.User;
import org.apache.commons.codec.binary.Hex;

/**
 *
 * @author tranq
 */
@WebServlet(name = "VerifyOtpServlet", urlPatterns = {"/VerifyOtpServlet"})
public class VerifyOtpServlet extends HttpServlet {

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
            out.println("<title>Servlet VerifyOtpServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyOtpServlet at " + request.getContextPath() + "</h1>");
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userOtpraw = request.getParameter("otp");
        String email = request.getParameter("email");
        String feature = request.getParameter("feature");
        HttpSession session = request.getSession();
        String userOtp = GenSHA256(userOtpraw);
        String sessionOtp = (String) session.getAttribute("otp");
        Long otpExpiry = (Long) session.getAttribute("otpExpiry");
        if (feature.equals("SignUp")) {
            if (sessionOtp != null && userOtp.equals(sessionOtp) && System.currentTimeMillis() <= otpExpiry) {
                session.removeAttribute("otp"); // Xóa OTP sau khi xác thực thành công
                response.sendRedirect("signUp?method=infomation&email=" + email);
            } else {
                response.sendRedirect("signUp?method=enter&email=" + email + "&error=invalidOTP");
            }
        } else if (feature.equals("FGPW")) {
            if (sessionOtp != null && userOtp.equals(sessionOtp) && System.currentTimeMillis() <= otpExpiry) {
                session.removeAttribute("otp"); // Xóa OTP sau khi xác thực thành công
                response.sendRedirect("forgotPassword?method=enterPassword&email=" + email);
            } else {
                response.sendRedirect("forgotPassword?method=enter&error=invalidOTP&email=" + email);
            }

        } else {
            if (sessionOtp != null && userOtp.equals(sessionOtp) && System.currentTimeMillis() <= otpExpiry) {
                session.removeAttribute("otp");
                String fullName = (String) session.getAttribute("fullName");
                String birthdateRaw = (String) session.getAttribute("birthdate");
                String address = (String) session.getAttribute("address");
                String email1 = (String) session.getAttribute("email");
                String phoneNumber = (String) session.getAttribute("phoneNumber");
                String password = (String) session.getAttribute("password");
                String role = (String) session.getAttribute("role");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
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
