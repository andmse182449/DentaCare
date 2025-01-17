<%-- 
    Document   : coWeb-dashboard
    Created on : May 23, 2024, 2:22:42 PM
    Author     : Admin
--%>

<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="clinicSchedule.ClinicScheduleDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="clinicSchedule.ClinicScheduleDAO" %>
<%@ page import="timeSlot.TimeSlotDAO" %>
<%@ page import="timeSlot.TimeSlotDTO" %>
<%@ page import="slotDetail.SlotDetailDAO" %>
<%@ page import="slotDetail.SlotDetailDTO" %>
<%@ page import="dayOffSchedule.DayOffScheduleDTO" %>
<%@ page import="dayOffSchedule.DayOffScheduleDAO" %>


<%@ page import="java.time.LocalDate, java.time.temporal.WeekFields, java.util.Locale" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <!--<link rel="stylesheet" href="css/stylesheet.css">-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="stylesheet" href="css/stylesheet.css">
        <link rel="stylesheet" href="css/dashboard.css">

    </head>
    <body>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header" style="height: 110px;">
                <div><h1 style="font-size: 2rem; font-weight: bold;">DASHBOARD</h1></div>
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
<!--                        <a href="DentistMajorServlet?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Major</div></li></a>-->
                        <a href="ManageStaffServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                        <a href="ServiceController"><li class="sidebar-list-item"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                        <a href="ManageCustomerServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">group</span><div>Manage Customer</div></li></a>
                        <a href="coWeb-setting.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">settings</span><div>Setting</div></li></a>
                    </ul>
                </div>
            </aside>

            <!-- MAIN -->
            <div class="d-flex" id="wrapper">
                <!-- Sidebar -->

                <!-- /#sidebar-wrapper -->

                <c:set value="${requestScope.countDentist}" var="countDentist" />
                <c:set value="${requestScope.countStaff}" var="countStaff" />
                <c:set value="${requestScope.countUserAccount}" var="countUserAccount" />
                <c:set value="${requestScope.month}" var="month" />
                <c:set value="${requestScope.allPriceInYear}" var="allPriceInYear" />


                <!-- Page Content -->
                <div id="page-content-wrapper">
                    <div class="content-wrapper">

                        <!-- Row start -->
                        <div class="row gutters">
                            <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                                <div class="hospital-tiles">
                                    <img src="images/img/user-hand-up-svgrepo-com.png" alt="Best Dashboards" />
                                    <p>Customer</p>
                                    <h2>${countUserAccount}</h2>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                                <div class="hospital-tiles">
                                    <img src="images/img/dentist-1-svgrepo-com.png" alt="Top Dashboards" />
                                    <p>Dentist</p>
                                    <h2>${countDentist}</h2>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                                <div class="hospital-tiles">
                                    <img src="images/img/customer-class-line-svgrepo-com (2).png" alt="Top Dashboards" />
                                    <p>Staff</p>
                                    <h2>${countStaff}</h2>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                                <div class="hospital-tiles">
                                    <img src="images/img/money-mouth-face-svgrepo-com.png" alt="Top Dashboards" />
                                    <p>Total earning in year</p>
                                    <h2>${allPriceInYear} vnđ</h2> 
                                    <%--<c:forEach var="item" items="${allPriceInYear}">--%>
                                    <h2 class="money-format"></h2>
                                    <%--</c:forEach>--%>
                                </div>
                            </div>
                        </div>
                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                const moneyElements = document.querySelectorAll('.money-format');

                                moneyElements.forEach(element => {
                                    const text = element.textContent;
                                    const amount = text.match(/[\d,.]+/);
                                    if (amount) {
                                        const moneyValue = parseFloat(amount[0].replace(/,/g, ''));
                                        const formattedMoney = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(moneyValue);
                                        element.textContent = text.replace(amount[0], formattedMoney);
                                    }
                                });
                            });
                        </script>

                        <form action="DashBoardServlet?action=Table&year2=${year2}&month=${month}" method="Post" id="yearForm">
                            <div class="container-fluid">
                                <div class="row">
                                    <h1 class="mt-4">Total earning in year</h1>
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            Total earning in year
                                        </div>
                                        <div class="card-body">
                                            YEAR 
                                            <select name="year1" id="selectYear" onchange="form.submit()">
                                                <option value="">Select Year</option>
                                                <%
                                                    int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                                                    String selectedYear = request.getParameter("year1");
                                                    for (int i = currentYear - 5; i <= currentYear + 5; i++) {
                                                        String selected = (selectedYear != null && Integer.toString(i).equals(selectedYear)) ? " selected" : "";
                                                        out.println("<option value=\"" + i + "\"" + selected + ">" + i + "</option>");
                                                    }
                                                %>
                                            </select>
                                            <canvas id="myChart"></canvas>
                                            <ul id="resultsList"></ul>

                                            <script>
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    var results = <%= new com.google.gson.Gson().toJson(request.getAttribute("results"))%>;
                                                    console.log(results);
                                                    if (results) {
                                                        var labels = [];
                                                        var data = [];
                                                        var resultsList = document.getElementById('resultsList');
                                                        for (var i = 0; i < results.length; i++) {
                                                            labels.push(new Date(results[i].Year, results[i].Month, i).toLocaleString('en-CA', {month: 'long'}));
                                                            data.push(results[i].TotalPrice);
                                                            // Print results to the screen
                                                            var li = document.createElement('li');
                                                        }

                                                        var ctx = document.getElementById('myChart').getContext('2d');
                                                        var gradient = ctx.createLinearGradient(0, 0, 0, 400);
                                                        gradient.addColorStop(0, 'rgba(75, 192, 192, 0.2)');
                                                        gradient.addColorStop(1, 'rgba(75, 192, 192, 0)');
                                                        var myChart = new Chart(ctx, {
                                                            type: 'line',
                                                            data: {
                                                                labels: labels,
                                                                datasets: [{
                                                                        label: 'Total Price',
                                                                        data: data,
                                                                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                                                        borderColor: 'rgba(255, 99, 132, 1)',
                                                                        borderWidth: 2,
                                                                        pointBackgroundColor: 'rgba(255, 99, 132, 1)',
                                                                        pointBorderColor: '#fff',
                                                                        pointHoverBackgroundColor: '#fff',
                                                                        pointHoverBorderColor: 'rgba(255, 99, 132, 1)',
                                                                    }]
                                                            },
                                                            options: {
                                                                scales: {
                                                                    y: {
                                                                        beginAtZero: true
                                                                    }
                                                                }
                                                            }
                                                        });
                                                    } else {
                                                        console.log("No data available for the selected year.");
                                                    }
                                                });
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>

                        <div class="container">
                            <div class="row">
                                <div class="col-md-6">
                                    <h1 class="mt-4">Patients by Age and Gender</h1>
                                    <form action="DashBoardServlet?action=Table&year2=${year2}&month=${month}" method="Post" id="yearForm">
                                        <div class="card mb-6">
                                            <div class="card-header">
                                                Patients by Age Group and Gender
                                            </div>
                                            <div class="card-body">
                                                <canvas id="patientsChart"></canvas>
                                                <script>
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        // Fetch the values from the request attributes
                                                        var male = <%= new com.google.gson.Gson().toJson(request.getAttribute("male"))%>;
                                                        var female = <%= new com.google.gson.Gson().toJson(request.getAttribute("female"))%>;

                                                        // Check if the data is being fetched correctly
                                                        console.log('Male data:', male);
                                                        console.log('Female data:', female);

                                                        // Validate data is not null or undefined
                                                        if (male && female && male.length >= 0 && female.length >= 0) {
                                                            var labels = ['0-10', '11-20', '21-30', '31-40', '41-50', '51-60', '61-70', '71+'];
                                                            var data = {
                                                                labels: labels,
                                                                datasets: [{
                                                                        label: 'Male',
                                                                        backgroundColor: 'rgba(54, 162, 235, 0.5)',
                                                                        borderColor: 'rgba(54, 162, 235, 1)',
                                                                        borderWidth: 1,
                                                                        data: []
                                                                    }, {
                                                                        label: 'Female',
                                                                        backgroundColor: 'rgba(255, 99, 132, 0.5)',
                                                                        borderColor: 'rgba(255, 99, 132, 1)',
                                                                        borderWidth: 1,
                                                                        data: []
                                                                    }]
                                                            };

                                                            // Populate data array for males
                                                            labels.forEach(function (label) {
                                                                var maleCount = 0;
                                                                var femaleCount = 0;

                                                                // Find the corresponding count in male and female data
                                                                male.forEach(function (item) {
                                                                    if (item.age_range === label) {
                                                                        maleCount = item.count;
                                                                    }
                                                                });

                                                                female.forEach(function (item) {
                                                                    if (item.age_range === label) {
                                                                        femaleCount = item.count;
                                                                    }
                                                                });

                                                                data.datasets[0].data.push(maleCount);
                                                                data.datasets[1].data.push(femaleCount);
                                                            });

                                                            var ctx = document.getElementById('patientsChart').getContext('2d');
                                                            var patientsChart = new Chart(ctx, {
                                                                type: 'bar',
                                                                data: data,
                                                                options: {
                                                                    responsive: true,
                                                                    plugins: {
                                                                        legend: {
                                                                            position: 'top',
                                                                        },
                                                                        title: {
                                                                            display: true,
                                                                            text: 'Patients by Age Group and Gender'
                                                                        }
                                                                    },
                                                                    scales: {
                                                                        x: {
                                                                            stacked: true,
                                                                            title: {
                                                                                display: true,
                                                                                text: 'Age Group'
                                                                            }
                                                                        },
                                                                        y: {
                                                                            stacked: true,
                                                                            title: {
                                                                                display: true,
                                                                                text: 'Number of Patients'
                                                                            },
                                                                            ticks: {
                                                                                beginAtZero: true
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            });
                                                        } else {
                                                            console.log("No data available for the selected year and month.");
                                                        }
                                                    });
                                                </script>

                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <!-- Second Chart -->

                                <div class="col-md-6">
                                    <h1 class="mt-4">Booking Time Slot Overview</h1>
                                    <div class="card mb-6">
                                        <div class="card-header">
                                            Booking Time Slot Overview
                                        </div>
                                        <div class="card-body">
                                            <form action="DashBoardServlet?action=Table&year1=${year1}" method="post" id="yearForm">
                                                Select year and Month
                                                <select name="year2" id="selectYear" onchange="form.submit()">
                                                    <option value="">Select Year</option>
                                                    <%
                                                        currentYear = Calendar.getInstance().get(Calendar.YEAR);
                                                        selectedYear = request.getParameter("year2");
                                                        for (int i = currentYear - 5; i <= currentYear + 5; i++) {
                                                            String selected = (selectedYear != null && Integer.toString(i).equals(selectedYear)) ? " selected" : "";
                                                            out.println("<option value=\"" + i + "\"" + selected + ">" + i + "</option>");
                                                        }
                                                    %>
                                                </select>

                                                <select name="month" id="selectMonth" onchange="form.submit()">
                                                    <option value="">Select Month</option>
                                                    <%
                                                        String selectedMonth = request.getParameter("month");
                                                        if (selectedYear != null && !selectedYear.isEmpty()) {
                                                            for (int month = 1; month <= 12; month++) {
                                                                String selected = (selectedMonth != null && Integer.toString(month).equals(selectedMonth)) ? " selected" : "";
                                                                out.println("<option value=\"" + month + "\"" + selected + ">" + month + "</option>");
                                                            }
                                                        }
                                                    %>
                                                </select>
                                                <canvas id="bookingChart"></canvas>
                                                <ul id="resultsList2"></ul>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script>
                                document.addEventListener('DOMContentLoaded', (event) => {
                                    const ctx = document.getElementById('bookingChart').getContext('2d');
                                    var timeResults = <%= new com.google.gson.Gson().toJson(request.getAttribute("timeResults"))%>;

                                    if (timeResults) {
                                        var labels = [];
                                        var data = [];
                                        var resultsList2 = document.getElementById('resultsList2');

                                        timeResults.forEach(result => {
                                            labels.push(result.TimePeriod); // Assuming result.Month gives you the month number (1-12)
                                            data.push(result.TotalTimeSlot); // Adjust according to your SQL query result fields

                                            // Print resultsList2 to the screen
                                            var li = document.createElement('li');
                                        });

                                        const chartData = {
                                            labels: labels, // Use the month names or numbers as labels
                                            datasets: [{
                                                    label: 'Total Time Slots',
                                                    data: data,
                                                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                                    borderColor: 'rgba(75, 192, 192, 1)',
                                                    borderWidth: 1
                                                }]
                                        };

                                        const options = {
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        };

                                        new Chart(ctx, {
                                            type: 'bar',
                                            data: chartData,
                                            options: options
                                        });
                                    } else {
                                        console.log("No data available for the selected year and month.");
                                    }
                                });
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="js/dashboard.js"></script>

    </div>
    <script>
                                let subMenu = document.getElementById("sub-menu-wrap");
                                function toggleDropdown() {
                                    subMenu.classList.toggle("open-menu");
                                }
    </script>
</body>
</html>