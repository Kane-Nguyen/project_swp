package Controller.Category;

import java.io.IOException;
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

    @Override
    public void init() {
        this.categoryDAO = new CategoryDAO(); // Initialize DAO
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "editForm":
                    showEditForm(request, response);
                    break;
                default:
                    listCategories(request, response);
                    break;
            }
        } else {
            listCategories(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
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
                    response.sendRedirect("categories.jsp");
                    break;
            }
        } else {
            response.sendRedirect("showCategoryPage.jsp");
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.getRequestDispatcher("showCategoryPage.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            Category category = categoryDAO.getCategoryById(categoryId);
            if (category != null) {
                request.setAttribute("category", category);
                request.getRequestDispatcher("/editCategory.jsp").forward(request, response);
            } else {
                // Handle category not found
                request.setAttribute("errorMessage", "Category not found");
                request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Category ID format");
            request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
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
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Category ID format");
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            categoryDAO.deleteCategory(categoryId);
            response.sendRedirect("crudCategory");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Category ID format");
        }
    }
}
