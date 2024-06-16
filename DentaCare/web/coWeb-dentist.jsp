<%-- 
    Document   : coWeb-staff
    Created on : May 23, 2024, 2:24:09 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clinic.*" %>
<%@ page import="java.util.List" %>

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
    </head>
    <body>
        <div class="grid-container">
             <!-- HEADER -->
            <header class="header">
                <div><h1>MANAGE DENTIST</h1></div>
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
            <!-- SIDEBAR -->
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="coWeb-dashboard.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">monitoring</span> <div>Dashboard</div></li></a>
                        <a href="coWeb-dentist.jsp"><li class="sidebar-list-item sidebar-list-item-selected"><span class="material-symbols-outlined">groups_2</span><div>Manage Dentist</div></li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                        <a href="ServiceController"><li class="sidebar-list-item"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                        <a href="ManageStaffServlet"><li class="sidebar-list-item">Staff List</li></a>
                    </ul>
                </div>
            </aside>
            <!-- MAIN -->
            <div class="main-container">
                <div class="main-content">
                    <div class="alert-error sec">${error}</div>
                    <div class="alert-message sec">${message}</div>
                    <button id="create-button" class="create-button">Create Dentist Account</button>
                </div>
                <br>
                <!-- FORM POPUP-->
                <div class="popup" id="popup-form">
                    <div class="close-btn" id="close-btn">&times;</div>
                    <div class="form">
                        <h2>CREATE A DENTIST ACCOUNT</h2>
                        <form action="DentistServlet" method="post">
                            <div class="form-element">
                                <label for="email">Email</label>
                                <input type="email" name="den-email" required>
                            </div>
                            <div class="form-element">
                                <label for="fullname">Full name</label>
                                <input type="text" name="den-fullName" required>
                            </div>
                            <div class="form-element">
                                <label for="phone">Phone</label>
                                <input type="text" name="den-phone" required>
                            </div>
                            <div class="form-element">
                                <label for="address">Address</label>
                                <input type="text" name="den-address" required>
                            </div>
                            <%
                                ClinicDAO clinicDao = new ClinicDAO();
                                List<ClinicDTO> clinics = clinicDao.getAllClinic();
                            %>

                            <div class="form-element">
                                <label for="clinic">Clinic</label>
                                <select name="den-clinic" required>
                                    <c:forEach items="<%= clinics %>" var="clinic">
                                        <option value="${clinic.clinicID}">${clinic.clinicName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <input type="hidden" name="action" value="create"/>
                            <div class="form-element">
                                <input type="submit" value="Submit">
                            </div>
                        </form>
                    </div>
                </div>
                <!-- END POPUP -->
                <div class="main-content">
                    ABC XYZ
                </div>
            </div>
        </div>

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
    </body>
</html>