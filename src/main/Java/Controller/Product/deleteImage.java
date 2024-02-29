package Controller.Product;

import dao.imageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@WebServlet(name = "deleteImage", urlPatterns = {"/deleteImage"})
public class deleteImage extends HttpServlet {

     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String[] imageIdsArray = request.getParameterValues("imageIds");
        List<Integer> imageIds = Arrays.stream(imageIdsArray).map(Integer::parseInt).collect(Collectors.toList());
        imageDAO dao = new imageDAO();

         try {
             dao.deleteMultipleImages(imageIds); // Or use a logger
         } catch (SQLException ex) {
             Logger.getLogger(deleteImage.class.getName()).log(Level.SEVERE, null, ex);
         }
        writeResponse(response, true, "Images deleted successfully.");
    }

    private void writeResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        String jsonResponse = String.format("{\"success\": %b, \"message\": \"%s\"}", success, escapeJson(message));
        response.getWriter().write(jsonResponse);
    }

    private String escapeJson(String text) {
        return text.replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f");
    }
}
