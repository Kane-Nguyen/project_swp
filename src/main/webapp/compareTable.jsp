<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <head>
        <title>How To Create Bootstrap 5 Table For Compare Packages</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.2/css/all.css" />
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://www.markuptag.com/bootstrap/5/css/bootstrap.min.css" />
    </head>
    <style>
        <!-- Custom CSS -->
        .compare-packages table thead th {
            border-bottom: 2px solid #dee2e6;
            vertical-align: middle;
            font-size: 20px;
            color: #ff9800;
        }
        .compare-packages table thead th p {
            font-size: 16px;
            font-weight: 400;
            color: #333;
        }
        .compare-packages table td {
            text-align: center;
        }
        .compare-packages table td:first-child {
            text-align: left;
        }
        .compare-packages table tr:last-child td {
            font-weight: bold;
            line-height: 40px;
            font-size: 20px;
        }

    </style>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-8 offset-md-2 mt-5">
                    <h3 class="bg-light p-2 mb-3">Compare Product</h3>
                    <div class="table-responsive compare-packages">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th width="240px">Hình ảnh</th>
                                    <th><img src="${url1}" alt="alt" style="width: 100%"/>
                                    </th>
                                    <th> <img src="${url2}" alt="alt" style="width: 100%"/>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item1" items="${pd1}" varStatus="status">
                                <c:set var="item2" value="${pd2[status.index]}" />
                                <!-- Sử dụng item1 và item2 tại đây -->

                                <tr>
                                    <td>Name</td>
                                    <td>${name1}</td>
                                    <td>${name2}</td>

                                </tr>
                                <tr>            
                                    <td>size display</td>

                                    <td>${item1.sizeDisplay}</td>
                                    <td>${item2.sizeDisplay}</td>

                                </tr>

                                <tr>
                                    <td>Chip set</td>
                                    <td>${item1.chipset}</td>
                                    <td>${item2.chipset}</td>

                                </tr>

                                <tr>
                                    <td>Battery</td>
                                    <td>${item1.battery}</td>
                                    <td>${item2.battery}</td>

                                </tr>

                                <tr>
                                    <td>Osystem</td>
                                    <td>${item1.osystem}</td>
                                    <td>${item2.osystem}</td>

                                </tr>

                                <tr>
                                    <td>Camera</td>
                                    <td>${item1.camera}</td>
                                    <td>${item2.camera}</td>

                                </tr>

                                <tr>
                                    <td>Sim</td>
                                    <td>${item1.sim}</td>
                                    <td>${item2.sim}</td>

                                </tr>

                            </c:forEach>
                            <tr>
                                <td>Total Prices</td>
                                <td>${price1} VND<br />
                                    <button class="btn btn-warning">Mua ngay</button>
                                </td>
                                <td>${price2} VND<br />
                                    <button class="btn btn-warning">Continue</button>
                                </td>

                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://www.markuptag.com/bootstrap/5/js/bootstrap.bundle.min.js"></script>
    </body>
</html>