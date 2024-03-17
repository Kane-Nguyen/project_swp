package controllerCompareProduct;

import dao.UserDAO;
import dao.feedbackDAO;
import dao.orderDAO;
import dao.productDescriptionDAO;
import dao.replyDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Currency;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;

import model.image;
import model.Product;
import model.Order;
import model.Reply;
import model.User;
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
        try {
            HttpSession session = request.getSession();
            String id = request.getParameter("productId");
            productDescriptionDAO pdModel = new productDescriptionDAO();
            List<Product> pWhereId = new ArrayList<>();
            List<Product> pOutid = new ArrayList<>();
            List<Product> p = pdModel.getProduct();
            List<image> img = pdModel.getImagesByProductId(Integer.parseInt(id));
            List<productDescription> pd = pdModel.getProductDescription();
            List<productDescription> pd1 = new ArrayList<>();
            String price = "";
            boolean checkUserToFeedback = false;
            orderDAO oDAO = new orderDAO();
            replyDAO rd = new replyDAO();
            feedbackDAO fd = new feedbackDAO();
            UserDAO ud = new UserDAO();
            // Lấy danh sách Feedback và Reply
            List<Feedback> feedbackList = fd.selectFeedbacksByProduct(Integer.parseInt(id));
            List<Reply> replyList = rd.getALL(); // Giả sử này lấy tất cả các Reply, bạn có thể thay đổi logic để tối ưu
            // Lấy tên người dùng cho Feedback và Reply
            Map<Integer, String> feedbackNameMap = new HashMap<>();
            Map<Integer, String> replyNameMap = new HashMap<>();
            for (Feedback feedback : feedbackList) {
                String userName = ud.getNameUserById(feedback.getUserId());
                feedbackNameMap.put(feedback.getUserId(), userName);
            }
            for (Reply reply : replyList) {
                String userName = ud.getNameUserById(reply.getUserId());
                replyNameMap.put(reply.getUserId(), userName);
            }
            // Gom nhóm Reply theo FeedbackId
            Map<Integer, List<Reply>> repliesGroupedByFeedback = new HashMap<>();
            for (Reply reply : replyList) {
                repliesGroupedByFeedback.computeIfAbsent(reply.getFeedbackId(), k -> new ArrayList<>()).add(reply);
            }
            System.out.println("Day la user cúa session: "+session.getAttribute("userId"));
            if (session.getAttribute("userId") != null) {
                int userid = (int) session.getAttribute("userId");
                List<Order> olist = oDAO.getOrdersByUserId(userid);
                User user = ud.getALLUserById(userid);
                System.out.println(olist.size());
                if (!olist.isEmpty() || user.getUserRole().equals("admin")) {
                    checkUserToFeedback = true;
                }
            }
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
            System.out.println(checkUserToFeedback);
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("feedbackNameMap", feedbackNameMap);
            request.setAttribute("replyNameMap", replyNameMap);
            request.setAttribute("repliesGroupedByFeedback", repliesGroupedByFeedback);
            request.setAttribute("checkFeedback", checkUserToFeedback);
            request.setAttribute("productDescription", pd1);
            request.setAttribute("imgWhereId", img);
            request.setAttribute("listWhId", pWhereId);
            request.setAttribute("listPout", pOutid);
            request.setAttribute("productId", id);
            request.setAttribute("priceId", price);
            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(dataToHomeFromDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}