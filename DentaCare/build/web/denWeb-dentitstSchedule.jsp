<%-- 
    Document   : denWeb-dentitstSchedule
    Created on : May 27, 2024, 11:52:16 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="clinicSchedule.ClinicScheduleDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="clinicSchedule.ClinicScheduleDAO" %>
<%@ page import="account.AccountDAO" %>
<%@ page import="account.AccountDTO" %>
<%@ page import="booking.BookingDTO" %>
<%@ page import="booking.BookingDAO" %>
<%@ page import="dentistSchedule.DentistScheduleDAO" %>
<%@ page import="dentistSchedule.DentistScheduleDTO" %>
<%@ page import="java.util.*" %>
<%@ page import="dayOffSchedule.DayOffScheduleDTO" %>
<%@ page import="dayOffSchedule.DayOffScheduleDAO" %>
<%@ page import="java.time.LocalDate, java.time.temporal.WeekFields, java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
    <style>


    </style>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dentist</title>
        <link rel="stylesheet" href="css/styleDen.css">
        <link rel="stylesheet" href="css/dentistSchedule.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
    <body>
        <div class="header">
            <nav class="menu">
                <span class="logo">logo</span>
                <ul>
                    <li>
                        <a href="#">my schedule</a>
                    </li>
                    <li>
                        <a href="LoadPatientOfDenServlet">my patient</a>
                    </li>
                </ul>
                <spadn class="material-symbols-outlined" onclick="toggleMenu()">account_circle
                    </span>
                    <div class="sub-menu-wrap" id="sub-menu-wrap">
                        <div class="sub-menu">
                            <div class="user-info">
                                <h3>${sessionScope.account.userName}</h3>
                            </div>
                            <hr>
                            <form action="DentistServlet" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="profile">
                                <input type="hidden" name="accountID" value="${sessionScope.account.accountID}">
                                <button type="submit" class="sub-menu-link" style="border: none; background: none; padding: 0; margin: 0; display: flex; align-items: center; justify-content: space-between; width: 100%; cursor: pointer;">
                                    <div style="display: flex; align-items: center;">
                                        <span class="material-symbols-outlined">person</span>
                                        <p>Profile</p>
                                    </div>
                                    <i class="fa fa-chevron-right"></i>
                                </button>
                            </form>
                            <a href="SignOutServlet" class="sub-menu-link">
                                <span class="material-symbols-outlined">logout</span>
                                <p>Sign out</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>
            </nav>
        </div>
        <% ClinicScheduleDAO clinicScheduleDAO = new ClinicScheduleDAO(); %>
        <%
            LocalDate now2 = LocalDate.now();
            WeekFields weekFields = WeekFields.of(Locale.getDefault());
            int currentYear2 = now2.getYear();
            int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
        %>
        <!-- MAIN -->
        <div class="main-container">
            <h2>Dentist</h2>

            <c:set value="${clinicByID.clinicID}" var="clinicID" />

            <div class="form-container">
                <h1>Dentist Schedule</h1>
                <form method="post" action="LoadScheduleForEachDentistServlet?action=loadDenSchedule&clinicByID=${clinicByID.clinicID}">
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
                                                out.println("<td class='table-cell' data-date='" + currentDate + "' onclick='handleDayClick(\"" + currentDate + "\")'>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</td>");
                                        } else {
                                                out.println("<td class='table-cell2' data-date='" + currentDate + "'>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</td>");
                                        }
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
                                        List<DentistScheduleDTO> getEachdentist = (List<DentistScheduleDTO>) request.getAttribute("getEachdentist"); // get session form servlet
                                        AccountDAO accDao = new AccountDAO();
//                                        List<AccountDTO> denList = accDao.getAccountDentistByRoleID1();

                                        Map<String, String> dayOffMap = new HashMap<>();
                                        for (DayOffScheduleDTO offDate : off) {
                                            dayOffMap.put(offDate.getDayOff(), offDate.getDescription());
                                        }

                                        for (int i = 0; i < 7; i++) {
                                            String workingDayInfo = "";
                                            String currentDate = sdf.format(calendar.getTime());
                                            boolean isWorkingDay = false;
                                            String checkEvent = "";
                                            boolean workingDayExists = false;

                                            if (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
                                                for (DentistScheduleDTO dentistScheduleDTO : getEachdentist) {
                                                    if (currentDate.equals(dentistScheduleDTO.getWorkingDate())) {
                                                        if (!dentistScheduleDTO.getAccountID().equals(null)) {
                                                                isWorkingDay = true;
                                                                workingDayInfo = "di lam`";
                                                                break;
                                                        }
                                                    }
                                                }
                                                checkEvent = dayOffMap.getOrDefault(currentDate, "");

                                                if (!checkEvent.isEmpty()) {
                                                    out.println("<td class=\"working-day\">" + checkEvent + "</td>");
                                                } else if (isWorkingDay) {
                                                    out.println("<td class=\"event-day\">" + workingDayInfo.toString() + "</td>");
                                                } else {
                                                    out.println("<td></td>");
                                                }
                                            } else {
                                                out.println("<td></td>");
                                            }
                                            calendar.add(Calendar.DAY_OF_MONTH, 1);
                                        }
                                    
                                            } else {
                                                for (int i = 0; i < 7; i++) {
                                                    out.println("<td></td>");
                                                }
                                            }
                            %>                       
                        </div>
                        </tr>
                    </table>
                    <%
          String selectedDateDisplay = request.getParameter("selectedDateDisplay");
                    AccountDTO account = (AccountDTO) session.getAttribute("account");

//          String app = (String) request.getParameter("app");
          

                    %>


                    <!-- Hidden form to pass selected date -->
                    <div id="confirmationPopup" class="popup">
                        <div class="popup-content">
                            <span class="close-btn" onclick="closePopup('confirmationPopup')">&times;</span>

                            <p id="selectedDateDisplay">Selected Date: </p>

                            <!--                            <div id="bookingDetails">
                                                             Booking details will be populated here 
                                                            <input type="hidden" value="${clinicByID.clinicID}" class="clinicID"/>
                            
                                                        </div>-->

                            <button id="confirmButton">OK</button>
                        </div>
                    </div>

                    <!-- Error Popup -->
                    <div id="errorPopup" class="popup">
                        <div class="popup-content">
                            <span class="close-btn" onclick="closePopup('errorPopup')">&times;</span>
                            <p id="errorMessage"></p>
                        </div>
                    </div>

                    <!-- Success Popup -->
                    <div id="successPopup" class="popup">
                        <div class="popup-content">
                            <span class="close-btn" onclick="closePopup('successPopup')">&times;</span>
                            <p id="successMessage"></p>
                        </div>
                    </div>

                    <!-- Sunday Popup -->
                    <div id="sundayPopup" class="popup">
                        <div style="background-color: #ffe6e6;" class="popup-content">
                            <span class="close-btn" onclick="closePopup('sundayPopup')">&times;</span>
                            <p>Dentists cannot be added on Sundays!</p>
                        </div>
                    </div>

                    <!-- Holiday Popup -->
                    <div id="holidayPopup" class="popup">
                        <div style="background-color: #ffe6e6;" class="popup-content">
                            <span class="close-btn" onclick="closePopup('holidayPopup')">&times;</span>
                            <p>Dentists cannot be added for holidays!</p>
                        </div>
                    </div>

                    <script>
                        function showPopup(popupId) {
                            document.getElementById(popupId).style.display = 'flex';
                        }

                        function closePopup(popupId) {
                            document.getElementById(popupId).style.display = 'none';
                        }
                        document.addEventListener('DOMContentLoaded', () => {
                            let selectedDate = '';

                            function handleDayClick(date, cell) {
                                console.log('Clicked date:', date);
                                selectedDate = date;
                                console.log('Selected date:', selectedDate);

                                document.querySelectorAll('.table-cell, .table-cell2').forEach(c => c.classList.remove('selected'));
                                cell.classList.add('selected');

                                if (cell.classList.contains('table-cell')) {
//                                    document.getElementById('selectedDateDisplay').textContent = `Selected Date:` ${selectedDate};
//                                    document.getElementById('selectedDateDisplay').innerHTML = 'Selected Date: ' ${selectedDate};
                                    document.getElementById('selectedDateDisplay').textContent = 'Selected Date: ' + selectedDate;

                                    showPopup('confirmationPopup');
                                } else if (cell.classList.contains('table-cell2')) {
                                    showPopup('holidayPopup');
                                }
                            }

                            document.querySelectorAll('.table-cell').forEach(cell => {
                                const date = cell.getAttribute('data-date');
                                cell.addEventListener('click', () => handleDayClick(date, cell));
                            });

                            document.getElementById('confirmButton').addEventListener('click', () => {
                                closePopup('confirmationPopup');
                                showPopup('eventPopup');
                                document.getElementById('eventDate').textContent = selectedDate;
                            });

                            $('#calendarForm').on('submit', function (e) {
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
                                            closePopup('eventPopup');
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
                                            closePopup('eventPopup');
                                            showPopup('errorPopup');
                                        } else {
                                            alert('An error occurred. Please try again.');
                                        }
                                    }
                                });
                            });
                        });
                    </script>

                </form>  
                <c:set value="${requestScope.weekStr}" var="year"/>
                <c:set value="${requestScope.weekStr}" var="week"/>
                <br>
                <a href="LoadFromClinicToScheduleServlet?action=loadClinicSchedule&clinicByID=${clinicByID.clinicID}&year=<%=currentYear2%>&week=<%=currentWeek2%>" style="background-color: red;
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

        </div>
    </div>
</div>
</body>
</html>
