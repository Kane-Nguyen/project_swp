package controllerCompareProduct;

import dao.productDescriptionDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.product;

public class dataToHomeFromDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String id = request.getParameter("productId");
            productDescriptionDAO pdModel = new productDescriptionDAO();
            
            List<product> pOutid = pdModel.getProductOutId(id);
            List<product> pWhId = pdModel.getProductWhereId(Integer.parseInt(id));

            request.setAttribute("listPout", pOutid);
            request.setAttribute("listWhId", pWhId);
            request.setAttribute("productId", id);

            request.getRequestDispatcher("test.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(dataToHomeFromDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
