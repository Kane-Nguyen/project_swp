/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Feedback;

import dao.replyDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "feedbackServlet", urlPatterns = {"/feedbackServlet"})
public class feedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("userId") != null) {
            replyDAO rd = new replyDAO();
            int id = (int) session.getAttribute("userId");
            int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
            String text = request.getParameter("reply");
            String productsId = request.getParameter("productId");
            String add = rd.insertComment(feedbackId, id, text);
            System.out.println(id);
            System.out.println(feedbackId);
            System.out.println(text);
            System.out.println(add);
            response.sendRedirect("dataToHomeFromDetail?productId=" + productsId);
        } else {
            System.out.println("khong co");
        }

    }
}
