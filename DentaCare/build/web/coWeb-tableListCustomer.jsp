<%-- 
    Document   : tableList
    Created on : May 23, 2024, 11:08:40 AM
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.temporal.WeekFields" %>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="keywords"
              content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Ample lite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Ample admin lite dashboard bootstrap 5 dashboard template">
        <meta name="description"
              content="Ample Admin Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
        <meta name="robots" content="noindex,nofollow">
        <title>Admin</title>
        <link rel="canonical" href="https://www.wrappixel.com/templates/ample-admin-lite/" />
        <!-- Favicon icon -->

        <!-- Custom CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link href="admin-front-end/css/style.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/stylesheet.css">
    </head>

    <body>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header"> 
                <div></div>
                <div class="header-icon">
                    <span class="material-symbols-outlined">notifications</span>
                    <span class="material-symbols-outlined">mail</span>
                    <span class="material-symbols-outlined">account_circle</span>
                </div>
            </header>

            <!-- SIDEBAR -->
            <%
                        LocalDate now2 = LocalDate.now();
                        WeekFields weekFields = WeekFields.of(Locale.getDefault());
                        int currentYear2 = now2.getYear();
                        int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
                        int currentMonth2 = now2.getMonthValue(); // Get current month number
            %>
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="DashBoardServlet?action=dashboardAction&year1=<%=currentYear2%>&year2=<%=currentYear2%>&month=<%=currentMonth2%>"><li class="sidebar-list-item">Dashboard</li></a>
                        <a href="coWeb-dentist.jsp"><li class="sidebar-list-item">Manage Dentist</li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item">Manage Staff</li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item">Manage Clinic</li></a>
                        <a href="ServiceController"><li class="sidebar-list-item">Manage Service</li></a>
                        <a href="ManageCustomerServlet"><li class="sidebar-list-item">Manage Customer</li></a>
                    </ul>
                </div>
            </aside>
            <style>
                p{
                    color: #555;
                }
                .BookingOfCustomer {
                    display: ${style};
                    position: fixed;
                    top: 50%;
                    left: 73%;
                    transform: translate(-50%, -50%);
                    z-index: 1000;
                    background-color: white;
                    padding: 27px;
                    border-radius: 8px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    width: 37%;
                    max-height: 80%;
                    overflow-y: auto;
                }

                .BookingOfCustomer p {
                    font-size: 20px;

                    margin-bottom: 20px;
                    color: #333;
                }

                .booking-item {
                    background-color: #fff;
                    border: 1px solid #e0e0e0;
                    border-radius: 8px;
                    padding: 15px;
                    margin-bottom: 15px;
                }

                .booking-item p {
                    margin: 5px 0;
                    color: #555;
                    font-size: 16px;
                }

                .booking-item p strong {
                    color: #000;
                }

                .booking-item hr {
                    border: none;
                    border-top: 1px solid #e0e0e0;
                    margin-top: 10px;
                }
                .linkUserName {
                    text-align: center;
                    text-decoration: none;
                }

                .userNameLink {
                    color: #555;
                    text-decoration: none;
                }

                .userNameLink:hover {
                    color: #007BFF;
                }
                .border-top-0{
                    text-align: center;
                }


            </style>
            <!-- MAIN -->
            <div class="main-container">
                <div class="container-fluid">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- ============================================================== -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="white-box">
                                <h3 class="box-title">Table Customer</h3>
                                <div class="table-responsive">
                                    <table class="table text-nowrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">#</th>
                                                <th class="border-top-0">Customer-Username</th>
                                                <th class="border-top-0">Email</th>
                                                <th class="border-top-0">Full Name</th>
                                                <th class="border-top-0">Dob</th>
                                                <th class="border-top-0">Address</th>
                                                <th class="border-top-0">Phone</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listAccountActive}" var="customer" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td class="linkUserName">
                                                        <a class="userNameLink" href="ManageCustomerServlet?action=viewBookingOfCustomer&customerID=${customer.accountID}">
                                                            ${customer.userName}
                                                        </a>
                                                    </td>
                                                    <td>${customer.email}</td>
                                                    <td>${customer.fullName}</td>
                                                    <td>${customer.dob}</td>     
                                                    <td style="white-space: pre-wrap;">${customer.address}</td>
                                                    <td>${customer.phone}</td>
                                                    <td>
                                                        <i class="fa-solid fa-trash" onclick="submitForm(this.nextElementSibling)"></i>
                                                        <form action="./ManageCustomerServlet" method="post">
                                                            <input name="action" value="deteleCustomer" type="hidden" />
                                                            <input name="customerUserName" value="${customer.userName}" type="hidden" />
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- ============================================================== -->
                    <!-- End PAge Content -->
                    <!-- ============================================================== -->
                    <!-- ============================================================== -->
                    <!-- Right sidebar -->
                    <!-- ============================================================== -->
                    <!-- .right-sidebar -->
                    <!-- ============================================================== -->
                    <!-- End Right sidebar -->
                    <!-- ============================================================== -->
                </div>
                <hr>
                <div class="container-fluid">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- ============================================================== -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="white-box">
                                <h3 class="box-title">Table Account Customer Removed</h3>


                                <div class="table-responsive">
                                    <table class="table text-nowrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">#</th>
                                                <th class="border-top-0">Customer-Username</th>
                                                <th class="border-top-0">Email</th>
                                                <th class="border-top-0">Full Name</th>
                                                <th class="border-top-0">Dob</th>
                                                <th class="border-top-0">Address</th>
                                                <th class="border-top-0">Phone</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listAccountUnactive}" var="customer" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td class="linkUserName">
                                                        <a class="userNameLink" href="ManageCustomerServlet?action=viewBookingOfCustomer&customerID=${customer.accountID}">
                                                            ${customer.userName}
                                                        </a>
                                                    </td>
                                                    <td>${customer.email}</td>
                                                    <td>${customer.fullName}</td>
                                                    <td>${customer.dob}</td>     
                                                    <td style="white-space: pre-wrap;">${customer.address}</td>
                                                    <td>${customer.phone}</td>
                                                    <td>
                                                        <i class="fa-solid fa-plus" onclick="submitForm(this.nextElementSibling)"></i>
                                                        <form action="./ManageCustomerServlet" method="post">
                                                            <input name="action" value="addAgainStaff" type="hidden" />
                                                            <input name="customerUserName" value="${customer.userName}" type="hidden" />
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="BookingOfCustomer hidden" >
                    <p>List Booking Of ${customer.fullName}<span style="margin-left: 135px;"><a  href="ManageCustomerServlet?action=closePopUp">X</a></span></p>

                    <c:forEach items="${listBookingOfCustomer}" var="booking">
                        <div class="booking-item">
                            <p><strong>Booking ID:</strong> ${booking.bookingID}</p>
                            <p><strong>Create day:</strong> ${booking.createDay}</p>
                            <p><strong>Appointment day:</strong> ${booking.appointmentDay}</p>
                            <p><strong>Dentist:</strong> ${booking.fullNameDentist}</p>
                            <c:choose>
                                <c:when test="${booking.clinicID == 1}">
                                    <p><strong>Clinic:</strong> DentaCare 1</p>
                                </c:when>
                                <c:when test="${booking.status == 2}">
                                    <p><strong>Clinic:</strong> DentaCare 2</p>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${booking.status == 0}">
                                    <p><strong>Status:</strong> Placed</p>
                                </c:when>
                                <c:when test="${booking.status == 1}">
                                    <p><strong>Status:</strong> Checked-in</p>
                                </c:when>
                                <c:when test="${booking.status == 2}">
                                    <p><strong>Status:</strong> Completed</p>
                                </c:when>
                                <c:when test="${booking.status == 3}">
                                    <p><strong>Status:</strong> Canceled</p>
                                </c:when>
                                <c:when test="${booking.status == 4}">
                                    <p><strong>Status:</strong> Placed and sent email</p>
                                </c:when>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>



                <script>
                    function submitForm(formElement) {
                        formElement.submit();
                    }
                </script>
            </div>
        </div>
    </body>
</html>