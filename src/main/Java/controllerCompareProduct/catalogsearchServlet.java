/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllerCompareProduct;

import dao.imageDAO;
import dao.productDescriptionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.image;

/**
 *
 * @author THANHVINH
 */
@WebServlet(name = "catalogsearchServlet", urlPatterns = {"/catalogsearchServlet"})
public class catalogsearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        productDescriptionDAO pdModel = new productDescriptionDAO();
        String resutl = request.getParameter("search");
        String pageString = request.getParameter("page");
        String sortString = request.getParameter("sort");
        String price = request.getParameter("price");
     
        List<Product> p = new ArrayList<>();
        String sort = "";
        

        if (sortString == null) {
            sort = "ASC";
        } else {
            sort = sortString;
        }

      
        int page = 1;
        if (pageString != null) {
            page = Integer.parseInt(pageString);
        }
        int pageSize = 12;
        if (price == null) {
            p = pdModel.getTop12(resutl, page, pageSize, sort);
        } else {
            String[] priceToFrom = price.split("-");
            p = pdModel.getTop12FromPrice(resutl, page, pageSize, sort, priceToFrom[0], priceToFrom[1]);
            request.setAttribute("price", price);
        }
        int quantity = p.size();

        int endPage = 0;
        endPage = (quantity / pageSize);
        if (quantity % pageSize != 0) {
            endPage++;
        }
        
         imageDAO im = new imageDAO();
        image img = null;
        try {
            img = im.getImageByProductId(2);
        } catch (SQLException ex) {

        }
        request.setAttribute("logo", img);
        request.setAttribute("page", page);
        request.setAttribute("result", resutl);
        request.setAttribute("noOfPages", endPage);
        request.setAttribute("products", p);
        request.setAttribute("quantity", quantity);
        request.getRequestDispatcher("catalogsearch.jsp").forward(request, response);
    }

}
