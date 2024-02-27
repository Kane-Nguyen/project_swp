<%-- 
    Document   : compareProducts
    Created on : Jan 31, 2024, 3:58:39 PM
    Author     : THANHVINH
--%>

<%@page import="model.productDescription"%>
<a href="compareProducts.jsp"></a>
<%@page import="java.util.List"%>
<%@page import="model.product"%>
<%@page import="dao.productDescriptionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>So sánh sản phẩm</title>
    </head>
    <body>
        <%
            String id1 = request.getParameter("productId");
            String id2 = request.getParameter("productId2");
            productDescriptionDAO pdModel = new productDescriptionDAO();

            List<product> p = pdModel.getIMG(id1, id2);
            List<productDescription> pd = pdModel.getProductDescription(id1, id2);
        %>

        <table border="1">
            <tr>
                <th></th>
                    <%for (int i = 0; i < p.size(); i++) {%>
                <th>sản phâm <%= i + 1%></th>
                    <%
                        }
                    %>
            </tr>
            <tr>
                <td>Mô tả sản phẩm</td>
                <%for (int i = 0; i < p.size(); i++) {%>
                <td><%= p.get(i).getProduct_name()%></td>
                <%
                    }
                %>
            </tr>
            <tr>
                <td>Ảnh sản phẩm</td>
                <%for (int i = 0; i < p.size(); i++) {%>
                <td><img src="<%= p.get(i).getImage_url()%>" ></td>

                <%
                    }
                %>
            </tr>


            <tr>
                <td>size display</td>
                <%for (int i = 0; i < pd.size(); i++) {%>
                <td><%= pd.get(i).getSizeDisplay()%></td>
                <%
                    }
                %>
            </tr>

            <tr>
                <td>chipset</td>
                <%for (int i = 0; i < pd.size(); i++) {%>
                <td><%= pd.get(i).getChipset()%></td>
                <%
                    }
                %>
            </tr>

            <tr>
                <td>battery</td>
                <%for (int i = 0; i < pd.size(); i++) {%>
                <td><%= pd.get(i).getBattery() %></td>
                <%
                    }
                %>
            </tr>

            <tr>
                <td>osystem</td>
                <%for (int i = 0; i < pd.size(); i++) {%>
                <td><%= pd.get(i).getOsystem() %></td>
                <%
                    }
                %>
            </tr>
            <tr>
                <td>camera</td>
                <%for (int i = 0; i < pd.size(); i++) {%>
                <td><%= pd.get(i).getCamera() %></td>
                <%
                    }
                %>
            </tr>
            <tr>
                <td>sim</td>
                <%for (int i = 0; i < pd.size(); i++) {%>
                <td><%= pd.get(i).getSim() %></td>
                <%
                    }
                %>
            </tr>

        </table>
    </body>
</html>
