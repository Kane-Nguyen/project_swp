/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllerCompareProduct;

import dao.productDescriptionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.product;
import model.productDescription;

public class compareProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productId = request.getParameter("productId");
        String productId2 = request.getParameter("productId2");

        String url1 = null, url2 = null, name1 = null, name2 = null;
        double price1 = 0;
        double price2 = 0;
        productDescriptionDAO pdModel = null;
        try {
            pdModel = new productDescriptionDAO();
        } catch (SQLException ex) {
            Logger.getLogger(compareProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        List<productDescription> pd1 = new ArrayList<>();
        List<productDescription> pd2 = new ArrayList<>();
        List<productDescription> pd = pdModel.getProductDescription();

        List<product> p = pdModel.getProduct();
        for (productDescription description : pd) {
            if (description.getProductId() == Integer.parseInt(productId)) {
                pd1.add(description);
            }
            if (description.getProductId() == Integer.parseInt(productId2)) {
                pd2.add(description);
            }
        }
        for (int i = 0; i < p.size(); i++) {
            if (p.get(i).getProduct_id() == Integer.parseInt(productId)) {
                url1 = p.get(i).getImage_url();
                name1 = p.get(i).getProduct_name();
                price1 = p.get(i).getProduct_price();
            }
            if (p.get(i).getProduct_id() == Integer.parseInt(productId2)) {
                url2 = p.get(i).getImage_url();
                name2 = p.get(i).getProduct_name();
                price2 = p.get(i).getProduct_price();
            }

        }

        request.setAttribute("price2", price2);
        request.setAttribute("price1", price1);
        request.setAttribute("pd2", pd2);
        request.setAttribute("pd1", pd1);
        request.setAttribute("name1", name1);
        request.setAttribute("name2", name2);
        request.setAttribute("url1", url1);
        request.setAttribute("url2", url2);
        request.setAttribute("productId", productId);
        request.setAttribute("productId2", productId2);
        request.getRequestDispatcher("compareTable.jsp").forward(request, response);
    }

}
