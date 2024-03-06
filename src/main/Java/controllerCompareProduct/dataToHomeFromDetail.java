package controllerCompareProduct;

import dao.productDescriptionDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Currency;
import java.util.Locale;
import model.image;
import model.Product;
import model.productDescription;
@WebServlet(name = "dataToHomeFromDetail", urlPatterns = {"/dataToHomeFromDetail"})
public class dataToHomeFromDetail extends HttpServlet {

    public String changeMoney(double price) {
        Locale locale = new Locale("vi", "VN");
        Currency currency = Currency.getInstance("VND");
        DecimalFormatSymbols df = DecimalFormatSymbols.getInstance(locale);
        df.setCurrency(currency);
        NumberFormat numberFormat = NumberFormat.getCurrencyInstance(locale);
        numberFormat.setCurrency(currency);
        return numberFormat.format(price);
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("productId");
        productDescriptionDAO pdModel = new productDescriptionDAO();
        List<Product> pWhereId = new ArrayList<>();
        List<Product> pOutid = new ArrayList<>();
        List<Product> p = pdModel.getProduct();
        List<image> img = pdModel.getImagesByProductId(Integer.parseInt(id));
        List<productDescription> pd = pdModel.getProductDescription();
        List<productDescription> pd1 = new ArrayList<>();
        String price = "";
        for (productDescription description : pd) {
            if (description.getProductId() == Integer.parseInt(id)) {
                pd1.add(description);
            }
        }
        for (Product object : p) {
            if (object.getProduct_id() == Integer.parseInt(id)) {
                price = changeMoney(object.getProduct_price());
                pWhereId.add(object);
            } else {
                pOutid.add(object);
            }
        }
        request.setAttribute("productDescription", pd1);
        request.setAttribute("imgWhereId", img);
        request.setAttribute("listWhId", pWhereId);
        request.setAttribute("listPout", pOutid);
        request.setAttribute("productId", id);
        request.setAttribute("priceId", price);
        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }
}
