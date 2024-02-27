/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.productDescriptionDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.product;


public class dataProductServlet extends HttpServlet {




    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        productDescriptionDAO pdModel;
        try {
            pdModel = new productDescriptionDAO();
            List<product> p = pdModel.getProduct();   
            request.setAttribute("p", p);
            request.getRequestDispatcher("/helloae.jsp").forward(request, response);
            
        } catch (SQLException ex) {
            Logger.getLogger(dataProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
           
    }

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    

}
