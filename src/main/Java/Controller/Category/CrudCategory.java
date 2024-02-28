package Controller.Category;

import java.io.IOException;
import java.util.List;
import model.Category;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/crudCategory")
public class CrudCategory extends HttpServlet {

    private CategoryDAO categoryDAO;

    public CrudCategory() {
        this.categoryDAO = new CategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("editForm".equals(action)) {
            showEditForm(request, response);
        } else {
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("showCategoryPage.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "add":
                addCategory(request, response);
                break;
            case "edit":
                editCategory(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            default:
                response.sendRedirect("Category.jsp");
                break;
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        categoryDAO.createCategory(categoryName);
        response.sendRedirect("crudCategory");
    }

    private void editCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String categoryName = request.getParameter("categoryName");
            categoryDAO.updateCategory(categoryId, categoryName);
            response.sendRedirect("crudCategory");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Category ID");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            Category category = categoryDAO.getCategoryById(categoryId);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/editCategory.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Category ID");
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        categoryDAO.deleteCategory(categoryId);
        response.sendRedirect("crudCategory");
    }

}
