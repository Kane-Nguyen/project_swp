package Controller.Product;

import dao.ProductDAO;
import dao.imageDAO;
import model.Product;
import model.image;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@WebServlet(name = "CrudProduct", urlPatterns = {"/CrudProduct"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class CrudProduct extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CrudProduct.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAll();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("showProducts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                    break;
            }
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get productId parameter from the request
            String productId = request.getParameter("product_id");

            // Delete the product
            ProductDAO productDAO = new ProductDAO();
            boolean success = productDAO.deleteProduct(productId);

            // Redirect to the product list page or handle failure
            if (success) {
                response.sendRedirect("CrudProduct");
            } else {
                response.getWriter().println("Failed to delete product.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("Number format error: " + e.getMessage());
        } catch (Exception e) {
            response.getWriter().println("An error occurred in deleteProduct: " + e.getMessage());
        }
    }

    private String convertImageToBase64(Part imagePart) throws IOException {
        if (!isValidImageType(imagePart.getContentType())) {
            throw new IOException("Invalid image type.");
        }
        InputStream inputStream = imagePart.getInputStream();
        byte[] bytes = inputStream.readAllBytes();
        return Base64.getEncoder().encodeToString(bytes);
    }

    private boolean isValidImageType(String contentType) {
        return contentType.equals("image/jpeg") || contentType.equals("image/png");
    }
}
