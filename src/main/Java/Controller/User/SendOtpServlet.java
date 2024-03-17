/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import org.apache.commons.codec.binary.Hex;

/**
 *
 * @author tranq
 */
@WebServlet(name = "SendOtpServlet", urlPatterns = {"/SendOtpServlet"})
public class SendOtpServlet extends HttpServlet {

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
            out.println("<title>Servlet SendOtpServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendOtpServlet at " + request.getContextPath() + "</h1>");
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
        String email = request.getParameter("email");
        String feature = request.getParameter("feature");
        System.out.println("Dang SEND Email");
        UserDAO u = new UserDAO();
        if (feature.equals("SignUp")) {
            if (u.emailExists(email)) {
                System.out.println("");
                response.sendRedirect("signUp?error=exited");
            } else if (email != null && !email.isEmpty()) {
                String otp = String.format("%06d", new Random().nextInt(1000000));
                sendOtpByEmail(email, otp);

                HttpSession session = request.getSession();
                session.setAttribute("otp", GenSHA256(otp));
                session.setAttribute("email", email);
                session.setAttribute("otpExpiry", System.currentTimeMillis() + 300000); // 5 phút sau

                response.sendRedirect("signUp?method=enter");
            } else {
                response.sendRedirect("signUp?error=invalid");
            }
        } else if (feature.equals("FGPW")) {
            if (email != null && !email.isEmpty() && u.emailExists(email)) {
                String otp = String.valueOf(new Random().nextInt(999999));
                sendOtpByEmail(email, otp);

                HttpSession session = request.getSession();
                session.setAttribute("otp", GenSHA256(otp));
                session.setAttribute("otpExpiry", System.currentTimeMillis() + 300000); // 5 phút sau
                   session.setAttribute("email", email);
                response.sendRedirect("forgotPassword?method=enter");
            } else {
                response.sendRedirect("forgotPassword?error=emailNotExit");
            }
        } else {
            if (u.emailExists(email)) {
                System.out.println("");
                response.sendRedirect("AdminUser?error=exited");
            } else if (email != null && !email.isEmpty()) {
                String otp = String.format("%06d", new Random().nextInt(1000000));
                sendOtpByEmail(email, otp);
                String idStr = request.getParameter("id");
                String fullName = request.getParameter("fullName");
                String birthdateRaw = request.getParameter("birthdate");
                String address = request.getParameter("address");
                String phoneNumber = request.getParameter("phoneNumber");               
                String rawpassword = request.getParameter("password");
                String role = request.getParameter("role");
                String password = GenSHA256(rawpassword);
             
                HttpSession session = request.getSession();
                session.setAttribute("id", idStr);
                session.setAttribute("fullName", fullName);
                session.setAttribute("birthdate", birthdateRaw);
                session.setAttribute("address", address);
                session.setAttribute("phoneNumber", phoneNumber);
                session.setAttribute("email", email);
                session.setAttribute("password", password);
                session.setAttribute("role", role);
                session.setAttribute("otp", GenSHA256(otp));
                session.setAttribute("otpExpiry", System.currentTimeMillis() + 300000); // 5 phút sau

               response.sendRedirect("AdminUser?method=add");
            } else {
                response.sendRedirect("AdminUser?error=invalid");
            }
        }
    }

    private void sendOtpByEmail(String toEmail, String otp) {
        final String fromEmail = "noreplyswpgr4@gmail.com";
        final String emailPassword = "casvzvxejelfctqz";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth;
        auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, emailPassword);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("Your OTP");
            message.setText("Your OTP is: " + otp);

            Transport.send(message);
            System.out.println("OTP Email sent successfully...");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
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
        processRequest(request, response);
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