/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Comment;

import dao.feedbackDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

/**
 *
 * @author THANHVINH
 */
@WebServlet(name = "commentServlet", urlPatterns = {"/commentServlet"})
public class commentServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        String id = request.getParameter("productId");
        System.out.println(id);
        int productId = Integer.parseInt(id);
        int userid = (int) session.getAttribute("userId");
        String comment = request.getParameter("comment");
        
        feedbackDAO fbd = new feedbackDAO();
        try {
            boolean check = fbd.insertFeedback(userid, productId, comment, 4);
            System.out.println(check);
        } catch (SQLException ex) {
            
        }
       response.sendRedirect("dataToHomeFromDetail?productId=" + id);
    }


}
