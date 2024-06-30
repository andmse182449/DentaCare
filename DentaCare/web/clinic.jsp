
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate, java.time.temporal.WeekFields, java.util.Locale" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <!--<link rel="stylesheet" href="css/stylesheet.css">-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link href="admin-front-end/css/style.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/stylesheet.css">
        <link rel="stylesheet" href="css/clinic.css">

    </head>
    <body>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header">
                <div><h1>DASHBOARD</h1></div>
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
                <div>
                    <ul class="sidebar-list">
                        <a href="DashBoardServlet?action=dashboardAction&year1=<%=currentYear2%>&year2=<%=currentYear2%>&month=<%=currentMonth2%>"><li class="sidebar-list-item sidebar-list-item-selected"><span class="material-symbols-outlined">monitoring</span> <div>Dashboard</div></li></a>
                        <a href="ForDentistInfo?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Dentist</div></li></a>
                        <a href="DentistMajorServlet?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Major</div></li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                        <a href="ServiceController"><li class="sidebar-list-item"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                        <a href="ManageCustomerServlet"><li class="sidebar-list-item">Manage Customer</li></a>
                    </ul>
                </div>
            </aside>

            <div class="col-md-4">
                <div id="sanpham3">
                    <c:forEach items="${requestScope.clinicList}" var="clinicList">
                        <div class="clinic-card" data-url="LoadFromClinicToScheduleServlet?action=loadClinicSchedule&clinicByID=${clinicList.clinicID}&year=<%=currentYear2%>&week=<%=currentWeek2%>">    
                            <!--sua lai khuc nay-->
                            <img src="images/combo03.PNG" class="img-responsive" />
                            <p class="first-line">${clinicList.clinicID}</p>
                            <p>${clinicList.clinicName}</p>
                            <p>${clinicList.clinicAddress}</p>
                            <p>${clinicList.city}</p>
                            <p>${clinicList.hotline}</p>
                        </div>
                    </c:forEach>
                </div>
            </div>        
        </div>
    </body>
    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            const clinicCards = document.querySelectorAll('.clinic-card');

            clinicCards.forEach(card => {
                card.addEventListener('click', () => {
                    const url = card.getAttribute('data-url');
                    window.location.href = url;
                });
            });
        });
    </script>
</html>


