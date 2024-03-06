/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllerCompareProduct;

import com.google.gson.Gson;
import dao.productDescriptionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import model.Product;

/**
 *
 * @author THANHVINH
 */
@WebServlet(name = "update", urlPatterns = {"/update"})
public class update extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            String productId2 = request.getParameter("productId2");
          
           
            
            productDescriptionDAO dao = new productDescriptionDAO();
            List<Product> p = dao.getIMG(productId2, null); // Thay đổi phương thức để nó phù hợp

            Gson gson = new Gson();
            String productJson = gson.toJson(p);
            // Cập nhật danh sách sản phẩm vào session
            session.setAttribute("productId2", productId2);
            session.setAttribute("productName", p.get(0).getProduct_name());
            session.setAttribute("productUrl", p.get(0).getImage_url());
            out.print(productJson);
            out.flush();

        }    }
}
