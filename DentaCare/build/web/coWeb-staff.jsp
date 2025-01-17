<%-- 
    Document   : coWeb-staff
    Created on : May 23, 2024, 2:24:09 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clinic.*" %>
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <link rel="stylesheet" href="css/stylesheet.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link href="admin-front-end/css/style.min.css" rel="stylesheet">
        <style>
            body {
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                color: #333;
                font-family: "Montserrat", sans-serif;
            }
        </style>

    </head>
    <body>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header" style="height: 110px;">
                <div><h1 style="font-size: 2rem; font-weight: bold;">MANAGE STAFF</h1></div>
                <div class="header-icon">
                    <span class="material-symbols-outlined" style="font-size: 32px;" onclick="toggleDropdown()">account_circle</span>
                    <!-- Dropdown Content -->
                    <div class="sub-menu-wrap" id="sub-menu-wrap">
                        <div class="sub-menu">
                            <div class="user-info">
                                <h3>${sessionScope.account.userName}</h3>
                            </div>
                            <hr>

                            <a href="SignOutServlet" class="sub-menu-link">
                                <span class="material-symbols-outlined">logout</span>
                                <p>Logout</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>
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
                <!-- SIDEBAR -->
                <aside id="sidebar">
                    <div>
                        <ul class="sidebar-list">
                            <a href="DashBoardServlet?action=dashboardAction&year1=<%=currentYear2%>&year2=<%=currentYear2%>&month=<%=currentMonth2%>"><li class="sidebar-list-item"><span class="material-symbols-outlined">monitoring</span> <div>Dashboard</div></li></a>
                            <a href="ForDentistInfo?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Dentist</div></li></a>
<!--                            <a href="DentistMajorServlet?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Major</div></li></a>-->
                            <a href="ManageStaffServlet"><li class="sidebar-list-item sidebar-list-item-selected"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                            <a href="LoadAllDentaListServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                            <a href="ServiceController"><li class="sidebar-list-item"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                            <a href="ManageCustomerServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">group</span><div>Manage Customer</div></li></a>
                            <a href="coWeb-setting.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">settings</span><div>Setting</div></li></a>

                        </ul>
                    </div>
                </aside>
            </aside>
            <!-- MAIN -->
            <div class="main-container">
                <div class="container-fluid">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- ============================================================== -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="white-box">
                                <h3 class="box-title">Table Staff</h3>
                                <div class="main-content">
                                    <div class="alert-error sec">${error}</div>
                                    <div class="alert-message sec">${message}</div>
                                    <button id="create-button" class="create-button">Create Staff Account</button>
                                </div>
                                <br>

                                <!-- FORM POPUP-->
                                <div style="width: 500px" class="popup" id="popup-form">
                                    <div class="close-btn" id="close-btn">&times;</div>
                                    <div class="form">
                                        <h2>CREATE A STAFF ACCOUNT</h2>
                                        <form action="StaffServlet" method="post">
                                            <div class="form-element">
                                                <label for="email">Email</label>
                                                <input type="email" name="sta-email" required>
                                            </div>
                                            <div class="form-element">
                                                <label for="fullname">Full name</label>
                                                <input type="text" name="sta-fullName" required>
                                            </div>
                                            <div class="form-element">
                                                <label for="phone">Phone</label>
                                                <input type="text" name="sta-phone" required>
                                            </div>
                                            <div class="form-element">
                                                <label for="address">Address</label>
                                                <input type="text" name="sta-address" required>
                                            </div>
                                            <%
                                                ClinicDAO clinicDao = new ClinicDAO();
                                                List<ClinicDTO> clinics = clinicDao.getAllClinic();
                                            %>

                                            <div class="form-element">
                                                <label for="clinic">Clinic</label>
                                                <select name="sta-clinic" required>
                                                    <%
                                                        for (ClinicDTO clinic : clinics) {
                                                    %>
                                                    <option value="<%= clinic.getClinicID()%>"><%= clinic.getClinicName()%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <input type="hidden" name="action" value="create"/>
                                            <div class="form-element">
                                                <input type="submit" value="Submit">
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <div>
                                    <form id="clinicForm" action="./ManageStaffServlet" method="post">
                                        <select name="clinicName-1" id="clinicSelect" onchange="submitFormWithSelectedValue()">
                                            <c:forEach items="${clinicName}" var="name">
                                                <option value="${name}" <c:if test="${name == param.selectedClinic}">selected</c:if>>${name}</option>
                                            </c:forEach>
                                        </select>
                                    </form>
                                </div>
                                <script>
                                    function submitFormWithSelectedValue() {
                                        var selectElement = document.getElementById('clinicSelect');
                                        var selectedValue = selectElement.options[selectElement.selectedIndex].value;
                                        var formElement = document.getElementById('clinicForm');
                                        formElement.action = './ManageStaffServlet?selectedClinic=' + encodeURIComponent(selectedValue);
                                        formElement.submit();
                                    }

                                </script>

                                <div class="table-responsive">
                                    <table class="table text-nowrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">#</th>
                                                <th class="border-top-0">Staff-Username</th>
                                                <th class="border-top-0">Email</th>
                                                <th class="border-top-0">Full Name</th>
                                                <th class="border-top-0">Address</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listAccount}" var="staff" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${staff.userName}</td>
                                                    <td>${staff.email}</td>
                                                    <td>${staff.fullName}</td>   
                                                    <td>${staff.address}</td>
                                                    <td>
                                                        <i class="fa-solid fa-trash" onclick="submitForm(this.nextElementSibling)"></i>
                                                        <form action="./ManageStaffServlet" method="post">
                                                            <input name="action" value="deteleStaff" type="hidden" />
                                                            <input name="staffUserName" value="${staff.userName}" type="hidden" />
                                                            <input name="selectedClinic" value="${param.selectedClinic}" type="hidden" />
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
                                <h3 class="box-title">Table Account Staff Removed</h3>


                                <div class="table-responsive">
                                    <table class="table text-nowrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">#</th>
                                                <th class="border-top-0">Staff-Username</th>
                                                <th class="border-top-0">Email</th>
                                                <th class="border-top-0">Full Name</th>
                                                <th class="border-top-0">Address</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listAccountRemoved}" var="staff" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${staff.userName}</td>
                                                    <td>${staff.email}</td>
                                                    <td>${staff.fullName}</td>
                                                    <td>${staff.address}</td>
                                                    <td>
                                                        <i class="fa-solid fa-plus" onclick="submitForm(this.nextElementSibling)"></i>
                                                        <form action="./ManageStaffServlet" method="post">
                                                            <input name="action" value="addAgainStaff" type="hidden" />
                                                            <input name="staffUserName" value="${staff.userName}" type="hidden" />
                                                            <input name="selectedClinic" value="${param.selectedClinic}" type="hidden" />
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

                <script src="admin-front-end/plugins/bower_components/jquery/dist/jquery.min.js"></script>
                <!-- Bootstrap tether Core JavaScript -->
                <script src="admin-front-end/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
                <script src="admin-front-end/js/app-style-switcher.js"></script>

                <!--Custom JavaScript -->
                <script src="admin-front-end/js/custom.js"></script>
                <script>
                                                            function submitForm(formElement) {
                                                                formElement.submit();
                                                            }
                </script>
                <script>
                    document.querySelector("#create-button").addEventListener("click", function () {
                        document.querySelector(".popup").classList.add("active");
                    });

                    document.querySelector(".popup .close-btn").addEventListener("click", function () {
                        document.querySelector(".popup").classList.remove("active");
                    });

                    document.addEventListener("DOMContentLoaded", function () {
                        const alertBox = document.querySelector(".alert-error.sec");
                        if (alertBox && alertBox.textContent.trim()) {
                            alertBox.style.display = "block"; // Show the alert if there's an error message
                            alertBox.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                            setTimeout(function () {
                                alertBox.classList.remove("show");
                                setTimeout(function () {
                                    alertBox.style.display = "none"; // Hide the alert after the fade-out animation
                                }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                            }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                        }
                    });

                    document.addEventListener("DOMContentLoaded", function () {
                        const alertBox2 = document.querySelector(".alert-message.sec");
                        if (alertBox2 && alertBox2.textContent.trim()) {
                            alertBox2.style.display = "block"; // Show the alert if there's an error message
                            alertBox2.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                            setTimeout(function () {
                                alertBox2.classList.remove("show");
                                setTimeout(function () {
                                    alertBox2.style.display = "none"; // Hide the alert after the fade-out animation
                                }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                            }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                        }
                    });

                    let subMenu = document.getElementById("sub-menu-wrap");
                    function toggleDropdown() {
                        subMenu.classList.toggle("open-menu");
                    }
                </script>
            </div>
        </div>
    </body>
</html>