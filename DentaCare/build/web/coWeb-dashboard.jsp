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
        <link rel="stylesheet" href="css/dashboard.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
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
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="coWeb-dashboard.jsp"><li class="sidebar-list-item">Dashboard</li></a>
                        <a href="coWeb-dentist.jsp"><li class="sidebar-list-item">Manage Dentist</li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item">Manage Staff</li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item">Manage Clinic</li></a>
                        <a href="ServiceController"><li class="sidebar-list-item">Manage Service</li></a>
                        <a href="ManageStaffServlet"><li class="sidebar-list-item">Staff List</li></a>
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

                <!-- Page Content -->
                <div id="page-content-wrapper">
                    <div class="content-wrapper">
                        <h1 class="mt-4">Dashboard</h1>

                        <!-- Row start -->
                        <div class="row gutters">
                            <div class="col-lg-2 col-sm-4 col-12">
                                <div class="hospital-tiles">
                                    <img src="images/img/hospital/patient.svg" alt="Best Dashboards" />
                                    <p>Customer</p>
                                    <h2>${countUserAccount}</h2>
                                </div>
                            </div>
                            <div class="col-lg-2 col-sm-4 col-12">
                                <div class="hospital-tiles">
                                    <img src="images/img/hospital/doctor.svg" alt="Top Dashboards" />
                                    <p>Dentist</p>
                                    <h2>${countDentist}</h2>
                                </div>
                            </div>
                            <div class="col-lg-2 col-sm-4 col-12">
                                <div class="hospital-tiles">
                                    <img src="images/img/hospital/staff.svg" alt="Top Dashboards" />
                                    <p>Staff</p>
                                    <h2>${countStaff}</h2>
                                </div>
                            </div>
                            <div class="col-lg-2 col-sm-4 col-12">
                                <div class="hospital-tiles">
                                    <img src="images/img/hospital/revenue.svg" alt="Top Dashboards" />
                                    <p>Earnings</p>
                                    <h2>$900k</h2>
                                </div>
                            </div>
                        </div>

                        <form action="DashBoardServlet?action=Table&year2=${year2}&month=${month}" method="Post" id="yearForm">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            Chart Example
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
                                                    var results = <%= new com.google.gson.Gson().toJson(request.getAttribute("results")) %>;
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
                            <h1 class="mt-4">Patients by Age and Gender</h1>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card mb-6">
                                        <div class="card-header">
                                            Patients by Age Group and Gender
                                        </div>
                                        <div class="card-body">
                                            <canvas id="patientsChart"></canvas>
                                            <script>
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    // Sample data for patients by age group and gender
                                                    var data = {
                                                        labels: ['0-10', '11-20', '21-30', '31-40', '41-50', '51-60', '61-70', '71+'],
                                                        datasets: [{
                                                                label: 'Male',
                                                                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                                                                borderColor: 'rgba(54, 162, 235, 1)',
                                                                borderWidth: 1,
                                                                data: [15, 30, 45, 60, 50, 30, 20, 10] // Example data for males by age group
                                                            }, {
                                                                label: 'Female',
                                                                backgroundColor: 'rgba(255, 99, 132, 0.5)',
                                                                borderColor: 'rgba(255, 99, 132, 1)',
                                                                borderWidth: 1,
                                                                data: [10, 25, 40, 55, 45, 25, 15, 5] // Example data for females by age group
                                                            }]
                                                    };

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
                                                });
                                            </script>
                                        </div>
                                    </div>
                                </div>

                                <!-- Second Chart -->
                                <div class="col-md-6">
                                    <div class="card mb-6">
                                        <div class="card-header">
                                            Booking Status Overview
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
                                    var timeResults = <%= new com.google.gson.Gson().toJson(request.getAttribute("timeResults")) %>;

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

