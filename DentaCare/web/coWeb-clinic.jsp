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
<%@ page import="com.google.gson.Gson" %>


<%@ page import="java.time.LocalDate, java.time.temporal.WeekFields, java.util.Locale" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <!--<link rel="stylesheet" href="css/stylesheet.css">-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="stylesheet" href="css/clinicSchedule.css">
        <link rel="stylesheet" href="css/stylesheet2.css">
                <!--<link rel="stylesheet" href="css/stylesheet.css">-->



    </head>

    <body>
        <%
                        LocalDate now2 = LocalDate.now();
                        WeekFields weekFields = WeekFields.of(Locale.getDefault());
                        int currentYear2 = now2.getYear();
                        int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
                        int currentMonth2 = now2.getMonthValue(); // Get current month number
        %>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header"> 
                <div><h1>CLINIC</h1></div>
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
                <script>
                    let subMenu = document.getElementById("sub-menu-wrap");
                    function toggleDropdown() {
                        subMenu.classList.toggle("open-menu");
                    }
                </script>
            </header>

            <!-- SIDEBAR -->
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="DashBoardServlet?action=dashboardAction&year1=<%=currentYear2%>&year2=<%=currentYear2%>&month=<%=currentMonth2%>"><li class="sidebar-list-item"><span class="material-symbols-outlined">monitoring</span> <div>Dashboard</div></li></a>
                        <a href="ForDentistInfo?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Dentist</div></li></a>
                        <a href="DentistMajorServlet?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Major</div></li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item sidebar-list-item-selected"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                        <a href="ServiceController"><li class="sidebar-list-item"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                        <a href="ManageCustomerServlet"><li class="sidebar-list-item">Manage Customer</li></a>
                    </ul>
                </div>
            </aside>

            <!-- MAIN -->
            <div class="main-container">
                <% ClinicScheduleDAO clinicScheduleDAO = new ClinicScheduleDAO(); %>
                <% TimeSlotDAO timeDao = new TimeSlotDAO(); %>

                <c:set value="${clinicByID.clinicID}" var="clinicID" />

                <div class="form-container">
                    <h2>Clinic Schedule</h2>
                    <form method="post" action="LoadFromClinicToScheduleServlet?action=loadClinicSchedule&clinicByID=${clinicByID.clinicID}">
                        <!--                        <input type="hidden" name="action" value="load">-->
                        <table>
                            <tr>
                                <th>
                                    YEAR 
                                    <select name="year" onchange="this.form.submit()">
                                        <option value="">Select Year</option>
                                        <% 
                                            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                                            String selectedYear = request.getParameter("year");
                                            for (int i = currentYear - 5; i <= currentYear + 5; i++) {
                                                String selected = (selectedYear != null && Integer.toString(i).equals(selectedYear)) ? " selected" : "";
                                                out.println("<option value=\"" + i + "\"" + selected + ">" + i + "</option>");
                                            }
                                        %>
                                    </select> 
                                    <br>
                                    WEEK
                                    <select name="week" onchange="this.form.submit()" id="weekSelect">
                                        <option value="">Select Week</option>
                                        <% 
                                            String selectedWeek = request.getParameter("week");
                                            if (selectedYear != null && !selectedYear.isEmpty()) {
                                                int year = Integer.parseInt(selectedYear);
                                                Calendar calendar = new GregorianCalendar();
                                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM");
                                
                                                for (int i = 1; i <= 52; i++) {
                                                    calendar.set(Calendar.YEAR, year);
                                                    calendar.set(Calendar.WEEK_OF_YEAR, i);
                                                    calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
                                    
                                                    String startDate = sdf.format(calendar.getTime());
                                                    calendar.add(Calendar.DAY_OF_MONTH, 6);  // Move to the end of the week
                                                    String endDate = sdf.format(calendar.getTime());
                                    
                                                    String weekLabel = i + " (" + startDate + " - " + endDate + ")";
                                                    String selected = (selectedWeek != null && Integer.toString(i).equals(selectedWeek)) ? " selected" : "";
                                                    out.println("<option value=\"" + i + "\"" + selected + ">" + weekLabel + "</option>");
                                                }
                                            }
                                        %>
                                    </select>
                                </th>
                                <th>MON</th>
                                <th>TUE</th>
                                <th>WED</th>
                                <th>THU</th>
                                <th>FRI</th>
                                <th>SAT</th>
                                <th>SUN</th>
                            </tr>    
                            <tr>
                                <%--<c:forEach items="${requestScope.clinicScheduleByClinicIDToDen}" var="clinicScheduleByClinicIDToDen">--%>
                                <% 
                                    out.println("<th></th>");
                                String yearStr = (String) request.getAttribute("yearStr");
                                String weekStr = (String) request.getAttribute("weekStr");
                                int clinicID = (int) request.getAttribute("clinicID");
                        
                                List<DayOffScheduleDTO> off = (List<DayOffScheduleDTO>) request.getAttribute("off");


                                if (yearStr != null && !yearStr.isEmpty() && weekStr != null && !weekStr.isEmpty()) {
                                    int year = Integer.parseInt(yearStr);
                                    int week = Integer.parseInt(weekStr);

                                    Calendar calendar = new GregorianCalendar();
                                    calendar.set(Calendar.YEAR, year);
                                    calendar.set(Calendar.WEEK_OF_YEAR, week);
                                    calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                    for (int i = 0; i < 7; i++) {
                                        boolean isWorkingDay = false;
                                        String workingDayInfo = "";
                                        String checkEvent = "";
                                        String currentDate = sdf.format(calendar.getTime());
                                          for (DayOffScheduleDTO offDateDTO : off) {
                                                    if (offDateDTO.getDayOff().equals(currentDate)) {
                                                        isWorkingDay = true;
                                                        checkEvent = offDateDTO.getDescription();
                                                    }
                                                }
                                                if (!isWorkingDay) {
                                        out.println("<td class='table-cell' data-date='" + currentDate + "'>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</td>");
                                            } else {
                                        out.println("<td class='table-cell2' data-date='" + currentDate + "'>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</td>");
                                            }
//                                                out.println("<td class='table-cell' data-date='" + currentDate + "'>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</td>");
                                                calendar.add(Calendar.DAY_OF_MONTH, 1);
                                    }
                                } else {
                                    for (int i = 0; i < 8; i++) {
                                        out.println("<td></td>");
                                    }
                                }
                                %>
                                </div> 
                            </tr>     
                            <tr>
                            <div class="clickDay">
                                <% 
                                    out.println("<th></th>");
                                    if (yearStr != null && !yearStr.isEmpty() && weekStr != null && !weekStr.isEmpty()) {
                                        int year = Integer.parseInt(yearStr);
                                        int week = Integer.parseInt(weekStr);

                                        Calendar calendar = new GregorianCalendar();
                                        calendar.set(Calendar.YEAR, year);
                                        calendar.set(Calendar.WEEK_OF_YEAR, week);
                                        calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                    for (int i = 0; i < 7; i++) {
                                        String currentDate = sdf.format(calendar.getTime());
                                        boolean isWorkingDay = false;
                                        String workingDayInfo = "";
                                        String checkEvent = "";
                                        boolean workingDayExists = false;

                                    if (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
                                                for (DayOffScheduleDTO offDateDTO : off) {
                                                    if (offDateDTO.getDayOff().equals(currentDate)) {
                                                        isWorkingDay = true;
                                                        workingDayInfo = "Working Time " + "<br><br>" + "toi day";
                                                        checkEvent = offDateDTO.getDescription();
                                                    }
                                                }
                                            if (!isWorkingDay) {
                                                out.println("<td class=\"event-day\">" + "di lam ne`" + "</td>");
                                            } else {
                                                out.println("<td class=\"working-day\">" + checkEvent + "</td>");
                                            }
                                        }
                                                calendar.add(Calendar.DAY_OF_MONTH, 1);
                                                }
                                                        // neu ma muon sua thi tu day !!
                                            } else {
                                                for (int i = 0; i < 7; i++) {
                                                    out.println("<td></td>");
                                                }
                                            }
                                %>
                            </div>
                            </tr>
                        </table>

                        <!--TIME SLOT-->
                        <div style="margin-top: 100px" class="time-slot-container">
                            <h2>Time Slot</h2>
                            <table class="time-slot-table">
                                <tr>
                                    <!-- <th>Time Periods</th> --> 
                                </tr>
                                <c:forEach items="${requestScope.getAllTimeSlot}" var="getAllTimeSlot">
                                    <td class="time-slot-row" data-time-period="${getAllTimeSlot.getTimePeriod()}"
                                        onclick="showModifyTimeSlotPopup('${getAllTimeSlot.getTimePeriod()}')">
                                        ${getAllTimeSlot.getTimePeriod()}
                                    </td>                               
                                </c:forEach>
                                </tr>
                            </table>
                        </div>

                        <br>
                        <div class="center-button">
                            <a href="LoadFromClinicScheduleToDentistScheduleServlet?action=loadDenSchedule&clinicByID=${clinicByID.clinicID}&year=<%=currentYear2%>&week=<%=currentWeek2%>">
                                <input type="button" name="" value="View Dentist Schedule">
                            </a>
                        </div>
                    </form>  
                    <c:set value="${requestScope.weekStr}" var="year"/>
                    <c:set value="${requestScope.weekStr}" var="week"/>
                    <a href="LoadAllDentaListServlet" style="background-color: red;
                       color: white;
                       padding: 10px 20px;
                       text-decoration: none;
                       border-radius: 4px;
                       font-size: 16px;
                       display: inline-block;
                       text-align: center;">
                        Return
                    </a>
                </div>
                <!-- First Popup for confirmation -->
                <div id="confirmationPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('confirmationPopup')">&times;</span>
                        <p>Do you want to set an event for this day?</p>
                        <button id="confirmButton">OK</button>
                    </div>
                </div>

                <!-- Second Popup for setting the event -->
                <div id="eventPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('eventPopup')">&times;</span>
                        <h2>Set Event</h2>
                        <form id="eventForm" method="post" action="LoadFromClinicToScheduleServlet?action=loadClinicSchedule&clinicByID=${clinicByID.clinicID}" onsubmit="return submitForm(event)">
                            <input type="hidden" name="offDate" id="eventDate">
                            <label for="eventName">Event Name:</label>
                            <input type="text" id="eventName" name="description" required>
                            <input type="hidden" name="key" value="setEvent" required>
                            <button type="submit">Set Event</button>
                        </form>
                    </div>
                </div>

                <!-- First Popup for confirmation -->
                <div id="confirmationPopup2" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('confirmationPopup2')">&times;</span>
                        <p>Do you want to modify this event ?</p>
                        <button id="confirmButton2">OK</button>
                    </div>
                </div>

                <!-- Second Popup for setting the event -->
                <div id="eventPopup2" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('eventPopup2')">&times;</span>
                        <h2>Modify Event</h2>
                        <form id="eventForm2" method="post" action="LoadFromClinicToScheduleServlet?action=loadClinicSchedule&clinicByID=${clinicByID.clinicID}" onsubmit="return submitForm(event)">
                            <input readonly type="hidden" name="offDate" id="eventDate2">
                            <label for="eventName">Event Name:</label>
                            <input type="text" id="eventName" name="description" required>
                            <input type="hidden" name="key" value="modifyEvent" required>
                            <button type="submit">Set Event</button>
                        </form>
                    </div>
                </div>

                <!-- Error Popup -->
                <div id="errorPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('errorPopup')">&times;</span>
                        <p id="errorMessage"></p>
                    </div>
                </div>

                <div id="successPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('successPopup')">&times;</span>
                        <p id="successMessage"></p>
                    </div>
                </div>

                <!-- Modify Time Slot Popup -->
                <div id="modifyTimeSlotPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('modifyTimeSlotPopup')">&times;</span>
                        <h2>Modify Time Slot</h2>
                        <form id="modifyTimeSlotForm" method="post" action="LoadFromClinicToScheduleServlet?action=loadClinicSchedule&clinicByID=${clinicByID.clinicID}" onsubmit="return submitForm(event)">
                            <label for="timePeriod">Change Time Period From:</label>
                            <input readonly type="text" id="timePeriod" name="oldTimePeriod" required>
                            <label for="timePeriod">To Time Period</label>
                            <!--<input type="text" id="timePeriod" name="timePeriod" required>-->

                            <input type="time" id="timePeriod" name="timePeriod1" required>
                            <input type="time" id="timePeriod" name="timePeriod2" required>

                            <button type="submit">Save Changes</button>
                            <input type="hidden" name="key" value="timeSlot">
                        </form>
                    </div>
                </div>



                <script>
                    document.querySelector("#create-button").addEventListener("click", function () {
                        document.querySelector(".popup").classList.add("active");
                    });
                    document.querySelector(".popup .close-btn").addEventListener("click", function () {
                        document.querySelector(".popup").classList.remove("active");
                    });
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

                <!-- JavaScript code for handling calendar cell clicks -->
                <script>
                    // Function to handle click event on calendar cell
                    function handleDayClick(date) {
                        // You can perform actions based on the clicked date
                        alert("Clicked on date: " + date);
                        // For example, you can redirect to another page passing the date as a parameter
                        window.location.href = "handleDayClickServlet?date=" + date;
                    }

                </script>

                <script>
                    // JavaScript code for handling calendar cell clicks
                    let selectedDate = '';
                    function handleDayClick(date, cell) {
                        selectedDate = date;
                        // Remove 'selected' class from all cells
                        document.querySelectorAll('.table-cell, .table-cell2').forEach(c => c.classList.remove('selected'));
                        // Add 'selected' class to the clicked cell
                        cell.classList.add('selected');
                        // Show the correct confirmation popup based on the cell's class
                        if (cell.classList.contains('table-cell')) {
                            document.getElementById('confirmationPopup').style.display = 'flex';
                        } else if (cell.classList.contains('table-cell2')) {
                            document.getElementById('confirmationPopup2').style.display = 'flex';
                        }
                    }

                    document.addEventListener('DOMContentLoaded', () => {
                        // Add click event listener to each calendar cell
                        document.querySelectorAll('.table-cell, .table-cell2').forEach(cell => {
                            const date = cell.getAttribute('data-date');
                            cell.addEventListener('click', () => handleDayClick(date, cell));
                        });
                        // Add click event listener to the confirm button in the confirmation popup
                        document.getElementById('confirmButton').addEventListener('click', () => {
                            document.getElementById('confirmationPopup').style.display = 'none';
                            document.getElementById('eventPopup').style.display = 'flex';
                            document.getElementById('eventDate').value = selectedDate;
                        });
                        // Add click event listener to the confirm button in the confirmation popup2
                        document.getElementById('confirmButton2').addEventListener('click', () => {
                            document.getElementById('confirmationPopup2').style.display = 'none';
                            document.getElementById('eventPopup2').style.display = 'flex';
                            document.getElementById('eventDate2').value = selectedDate;
                        });
                        // Add click event listener to the close button in the confirmation popup
                        document.querySelector('#confirmationPopup .close-btn').addEventListener('click', () => {
                            closePopup('confirmationPopup');
                        });
                        // Add click event listener to the close button in the confirmation popup2
                        document.querySelector('#confirmationPopup2 .close-btn').addEventListener('click', () => {
                            closePopup('confirmationPopup2');
                        });
                        // Add click event listener to the close button in the event popup
                        document.querySelector('#eventPopup .close-btn').addEventListener('click', () => {
                            closePopup('eventPopup');
                        });
                        // Add click event listener to the close button in the event popup2
                        document.querySelector('#eventPopup2 .close-btn').addEventListener('click', () => {
                            closePopup('eventPopup2');
                        });
                        document.getElementById('modifyTimeSlotButton').addEventListener('click', function () {
                            document.getElementById('modifyTimeSlotPopup').style.display = 'flex';
                        });
                        // Handle the event form submission via AJAX
                        $('#eventForm').on('submit', function (e) {
                            e.preventDefault();
                            const formData = $(this).serialize();
                            $.ajax({
                                type: 'POST',
                                url: $(this).attr('action'),
                                data: formData,
                                success: function (response) {
                                    if (response.success) {
                                        const successMessage = response.message;
                                        document.getElementById('successMessage').textContent = successMessage;
                                        closePopup('eventPopup'); // Close eventPopup
                                        showPopup('successPopup');
                                    } else {
                                        document.getElementById('errorMessage').textContent = response.message;
                                        showPopup('errorPopup');
                                    }
                                },
                                error: function (jqXHR) {
                                    const response = jqXHR.responseJSON;
                                    if (response && !response.success) {
                                        document.getElementById('errorMessage').textContent = response.message;
                                        closePopup('eventPopup'); // Close eventPopup
                                        showPopup('errorPopup');
                                    } else {
                                        alert('An error occurred. Please try again.');
                                    }
                                }
                            });
                        });
                        // Handle the event form2 submission via AJAX
                        $('#eventForm2').on('submit', function (e) {
                            e.preventDefault();
                            const formData = $(this).serialize();
                            $.ajax({
                                type: 'POST',
                                url: $(this).attr('action'),
                                data: formData,
                                success: function (response) {
                                    if (response.success) {
                                        const successMessage = response.message;
                                        document.getElementById('successMessage').textContent = successMessage;
                                        closePopup('eventPopup2'); // Close eventPopup2
                                        showPopup('successPopup');
                                        location.reload(); // Reload the page to show updated data
                                    } else {
                                        document.getElementById('errorMessage').textContent = response.message;
                                        showPopup('errorPopup');
                                    }
                                },
                                error: function (jqXHR) {
                                    const response = jqXHR.responseJSON;
                                    if (response && !response.success) {
                                        document.getElementById('errorMessage').textContent = response.message;
                                        closePopup('eventPopup2'); // Close eventPopup2
                                        showPopup('errorPopup');
                                    } else {
                                        alert('An error occurred. Please try again.');
                                    }
                                }
                            });
                        });
                        // Add click event listener to the close button in the success popup to reload the page
                        document.querySelector('#successPopup .close-btn').addEventListener('click', () => {
                            closePopup('successPopup');
                            location.reload();
                        });
                        document.querySelector('#errorPopup .close-btn').addEventListener('click', () => {
                            closePopup('errorPopup');
                            location.reload();
                        });
                    });
                    function closePopup(popupId) {
                        document.getElementById(popupId).style.display = 'none';
                    }

                    function showPopup(popupId) {
                        document.getElementById(popupId).style.display = 'flex';
                    }

                    function someConditionForPopup1(date) {
                        // Replace this function with your actual condition to determine which popup to show
                        // For example, you could check if the date has an event or some other condition
                        return true; // or false depending on the condition
                    }
                </script>

                <script>
                    function showModifyTimeSlotPopup(timePeriod) {
                        document.getElementById('timePeriod').value = timePeriod;
                        document.getElementById('modifyTimeSlotPopup').style.display = 'flex';
                    }

                    document.getElementById('modifyTimeSlotButton').addEventListener('click', function () {
                        document.getElementById('modifyTimeSlotPopup').style.display = 'flex';
                    });

                    function closePopup(popupId) {
                        document.getElementById(popupId).style.display = 'none';
                    }

                    function showPopup(popupId) {
                        document.getElementById(popupId).style.display = 'flex';
                    }

                    document.addEventListener('DOMContentLoaded', () => {
                        // Handle the modify time slot form submission via AJAX
                        $('#modifyTimeSlotForm').on('submit', function (e) {
                            e.preventDefault();
                            const formData = $(this).serialize();
                            $.ajax({
                                type: 'POST',
                                url: $(this).attr('action'),
                                data: formData,
                                success: function (response) {
                                    if (response.success) {
                                        document.getElementById('successMessage').textContent = response.message || 'Time slot modified successfully!';
                                        closePopup('modifyTimeSlotPopup');
                                        showPopup('successPopup');
                                    } else {
                                        document.getElementById('errorMessage').textContent = response.message || 'Failed to modify the time slot. Please try again.';
                                        closePopup('modifyTimeSlotPopup');
                                        showPopup('errorPopup');
                                    }
                                },
                                error: function (jqXHR) {
                                    const response = jqXHR.responseJSON;
                                    if (response && !response.success) {
                                        document.getElementById('errorMessage').textContent = response.message || 'Failed to modify the time slot. Please try again.';
                                    } else {
                                        document.getElementById('errorMessage').textContent = 'An error occurred. Please try again.';
                                    }
                                    closePopup('modifyTimeSlotPopup');
                                    showPopup('errorPopup');
                                }
                            });
                        });

                        // Add click event listeners to close buttons in popups
                        document.querySelectorAll('.popup .close-btn').forEach(button => {
                            button.addEventListener('click', () => {
                                closePopup(button.parentElement.parentElement.id);
                            });
                        });
                    });
                </script>


                <style>
                    /* General popup styling */
                    .popup {
                        display: none;
                        position: fixed;
                        z-index: 1000;
                        left: 0;
                        top: 0;
                        width: 100%;
                        height: 100%;
                        background-color: rgba(0, 0, 0, 0.6);
                        justify-content: center;
                        align-items: center;
                        transition: all 0.3s ease-in-out;
                    }

                    .popup-content {
                        position: relative;
                        background-color: #fff;
                        padding: 30px;
                        border-radius: 10px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                        text-align: center;
                        max-width: 500px;
                        width: 90%;
                        animation: popupAnimation 0.3s ease-out;
                    }

                    @keyframes popupAnimation {
                        from {
                            transform: scale(0.8);
                            opacity: 0;
                        }
                        to {
                            transform: scale(1);
                            opacity: 1;
                        }
                    }

                    .close-btn {
                        position: absolute;
                        right: 15px;
                        top: 15px;
                        font-size: 24px;
                        font-weight: bold;
                        color: #999;
                        cursor: pointer;
                        transition: color 0.3s ease;
                    }

                    .close-btn:hover {
                        color: #333;
                    }

                    .popup p {
                        margin: 20px 0;
                        font-size: 16px;
                        color: #555;
                    }

                    button {
                        text-align: center;
                        background-color: #007bff;
                        color: white;
                        border: none;
                        padding: 12px 25px;
                        border-radius: 5px;
                        cursor: pointer;
                        font-size: 16px;
                        transition: background-color 0.3s ease;
                    }

                    button:hover {
                        background-color: #0056b3;
                    }

                    .button-container {
                        display: flex;
                        justify-content: center;
                    }

                    /* Specific styles for each popup */
                    #confirmationPopup .popup-content {
                        background-color: #f9f9f9;
                    }

                    #errorPopup .popup-content {
                        background-color: #ffe6e6;
                    }

                    #successPopup .popup-content {
                        background-color: #e6ffe6;
                    }

                    #eventPopup .popup-content {
                        background-color: #f9f9f9;
                        text-align: left;
                    }

                    #eventPopup label {
                        display: block;
                        margin-bottom: 10px;
                        font-weight: bold;
                        color: #333;
                    }

                    #eventPopup select, #eventPopup input[type="hidden"] {
                        width: 100%;
                        padding: 10px;
                        margin-bottom: 20px;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        box-sizing: border-box;
                    }

                </style>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

            </div>
        </div>
    </div>
</body>
</html>