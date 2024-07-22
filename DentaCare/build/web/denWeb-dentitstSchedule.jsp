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
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dentist</title>
        <link rel="stylesheet" href="css/styleDen.css">
        <link rel="stylesheet" href="css/co-denSchedule.css">


        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
    <body>
        <div class="header">
            <nav class="menu">
                <a class="navbar-brand" href="" style="color: black">Denta<span>Care</span></a>
                <ul style="color: black;">
                    <li class="active">
                        <a href="#">My Schedule</a>
                    </li>
                    <li>
                        <a href="LoadPatientOfDenServlet">My Patient</a>
                    </li>
                </ul>
                <!--icon-->
                <div class="header-icon">
                    <span class="material-symbols-outlined" style="font-size: 32px;" onclick="toggleDropdown()">account_circle</span>
                    <!-- Dropdown Content -->
                    <div class="sub-menu-wrap" id="sub-menu-wrap">
                        <div class="sub-menu">
                            <div class="user-info">
                                <h3>${sessionScope.account.userName}</h3>
                            </div>
                            <hr>
                            <a href="ProfileDentistServlet" class="sub-menu-link">
                                <p>Profile</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                            <hr>
                            <a href="ProfileDentistServlet?action=changePassword" class="sub-menu-link">
                                <p>Change Password</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                            <hr>
                            <a href="SignOutServlet" class="sub-menu-link">
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
                <!--icon-->
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

            <c:set value="${clinicByID.clinicID}" var="clinicID" />

            <div class="form-container">
                <h2>Dentist Schedule</h2>
                <form method="post" action="LoadScheduleForEachDentistServlet?action=loadDenSchedule&clinicByID=${clinicByID.clinicID}">
                    <!--                        <input type="hidden" name="action" value="load">-->
                    <table>
                        <tr>
                            <th>
                                <span>YEAR</span>
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

                                <span>WEEK</span>
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
                                BookingDAO bookDao = new BookingDAO();
                                AccountDTO account1 = (AccountDTO) session.getAttribute("account");

                                if (yearStr != null && !yearStr.isEmpty() && weekStr != null && !weekStr.isEmpty()) {
                                    int year = Integer.parseInt(yearStr);
                                    int week = Integer.parseInt(weekStr);

                                    Calendar calendar = new GregorianCalendar();
                                    calendar.set(Calendar.YEAR, year);
                                    calendar.set(Calendar.WEEK_OF_YEAR, week);
                                    calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                    String currentDate = null;
                                    
                                    for (int i = 0; i < 7; i++) {
                                        boolean isWorkingDay = false;
                                        String workingDayInfo = "";
                                        String checkEvent = "";
                                        currentDate = sdf.format(calendar.getTime());
                                        for (DayOffScheduleDTO offDateDTO : off) {
                                            if (offDateDTO.getDayOff().equals(currentDate)) {
                                                isWorkingDay = true;
                                                checkEvent = offDateDTO.getDescription();
                                            }
                                        }
                                        if (!isWorkingDay) {
                                            out.println("<td class='table-cell' data-date='" + currentDate + "' onclick='handleDayClick(\"" + currentDate + "\", this)'>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</td>");
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
                        <div style="background-color: red" class="clickDay">
                            <c:set value="${requestScope.account}" var="account" />
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
                                    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

                                     for (int i = 0; i < 7; i++) {
                                        String workingDayInfo = "";
                                        String currentDate = sdf.format(calendar.getTime());
                                        boolean isWorkingDay = false;
                                        boolean isHaveBooking = false;
                                        String checkEvent = "";

                                        if (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
                                            for (DentistScheduleDTO dentistScheduleDTO : getEachdentist) {
                                                if (currentDate.equals(dentistScheduleDTO.getWorkingDate())) {
                                                    if (dentistScheduleDTO.getAccountID() != null) {
                                                        isWorkingDay = true;
                                                        workingDayInfo = "Working Day";
                                                        break;
                                                    }
                                                }
                                            }
                                            checkEvent = dayOffMap.getOrDefault(currentDate, "");
                                            if (!checkEvent.isEmpty()) {
                                                out.println("<td class='working-day'>" + checkEvent + "</td>");
                                            } else if (isWorkingDay) {
                                                List<BookingDTO> getAllBookingForDen = bookDao.getAllBookingByIdAndDayForDen(account1.getAccountID());
                                                for (BookingDTO bookingDTO : getAllBookingForDen) {
                                                    String bookingDate = bookingDTO.getAppointmentDay().format(dateFormatter);
                                                    if (currentDate.equals(bookingDate)) {
                                                        isHaveBooking = true;
                                                        break;
                                                    }
                                                }
                                                if (isHaveBooking) {
                                                    out.println("<td style='background-color: #ffcccc' class='event-day'>" + workingDayInfo + "</td>");
                                                } else {
                                                    out.println("<td class='event-day'>" + workingDayInfo + "</td>");
                                                }
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

//          String app = (String) request.getParameter("app");

                    %>


                    <!-- Hidden form to pass selected date -->
                    <div id="confirmationPopup" class="popup">
                        <div class="popup-content">
                            <span class="close-btn" onclick="closePopup('confirmationPopup')">&times;</span>

                            <p id="selectedDateDisplay">Selected Date: </p>
                            <ul id="bookingsList"></ul>
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
                        document.addEventListener('DOMContentLoaded', () => {
                            console.log('DOMContentLoaded event triggered.');
                            let selectedDate = '';
                            function handleDayClick(date, cell) {
                                selectedDate = date;
                                document.querySelectorAll('.table-cell, .table-cell2').forEach(c => c.classList.remove('selected'));
                                cell.classList.add('selected');
                                document.getElementById('selectedDateDisplay').textContent = 'Selected Date: ' + selectedDate;
                                showPopup('confirmationPopup');
                                const data = JSON.stringify({selectedDate: selectedDate});
                                fetch('GetBookServlet', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/json'
                                    },
                                    body: JSON.stringify({selectedDate: selectedDate})
                                })
                                        .then(response => {
                                            console.log('Response status:', response.status);
                                            return response.json();
                                        })
                                        .then(data => {
                                            console.log('Data received:', data);
                                            const bookings = data.bookings;
                                            if (bookings) {
                                                const bookingsList = document.getElementById('bookingsList');
                                                bookingsList.innerHTML = '';
                                                bookings.forEach(booking => {
                                                    const li1 = document.createElement('ul');
                                                    const li2 = document.createElement('ul');
                                                    const li3 = document.createElement('ul');
                                                    const li4 = document.createElement('ul');
                                                    const li5 = document.createElement('ul');
                                                    const li6 = document.createElement('ul');
                                                    const li7 = document.createElement('ul');

                                                    li1.textContent = booking.bookingID;
                                                    li2.textContent = booking.appointmentDay;
                                                    li3.textContent = booking.customerName;
                                                    li4.textContent = booking.serviceName;
                                                    li5.textContent = booking.timePeriod;
                                                    li6.textContent = booking.price;
                                                    li6.textContent = `=======================`;

                                                    bookingsList.appendChild(li1);
                                                    bookingsList.appendChild(li2);
                                                    bookingsList.appendChild(li3);
                                                    bookingsList.appendChild(li4);
                                                    bookingsList.appendChild(li5);
                                                    bookingsList.appendChild(li6);
                                                    bookingsList.appendChild(li7);

                                                });
                                                showPopup('confirmationPopup');
                                            } else {
                                                console.error('Bookings not found in the response:', data);
                                                document.getElementById('errorMessage').textContent = 'Error: Bookings not found in the response';
                                                showPopup('errorPopup');
                                            }
                                        })
                                        .catch(error => {
                                            console.error('Fetch error:', error);
                                            document.getElementById('errorMessage').textContent = 'Error: ' + error.message;
                                            showPopup('errorPopup');
                                        });
                            }

                            function displayBookings(bookings) {
                                const bookingsList = document.getElementById('bookingsList');
                                bookingsList.innerHTML = '';
                                bookings.forEach(booking => {
                                    console.log('Booking:', booking);
                                    const li1 = document.createElement('li');
                                    const li2 = document.createElement('li');
                                    const li3 = document.createElement('li');
                                    li1.textContent = `Booking ID: ${booking.bookingID}`;
                                    li2.textContent = `appointmentDay: ${booking.appointmentDay}`;
                                    li3.textContent = `Customer: ${booking.cus }`;
                                    bookingsList.appendChild(li1);
                                    bookingsList.appendChild(li2);
                                    bookingsList.appendChild(li3);
                                });
                            }

                            document.querySelectorAll('.table-cell').forEach(cell => {
                                const date = cell.getAttribute('data-date');
                                cell.addEventListener('click', () => handleDayClick(date, cell));
                            });
                            function showPopup(popupId) {
                                const popup = document.getElementById(popupId);
                                if (popup) {
                                    popup.style.display = 'flex';
                                }
                            }

                            function closePopup(popupId) {
                                document.getElementById(popupId).style.display = 'none';
                            }

                            document.getElementById('confirmButton').addEventListener('click', (event) => {
                                event.preventDefault();
                                closePopup('confirmationPopup');
                                showPopup('eventPopup');
                                document.getElementById('eventDate').textContent = selectedDate;
                            });
                        });

                    </script>

                </form>  
                <c:set value="${requestScope.weekStr}" var="year"/>
                <c:set value="${requestScope.weekStr}" var="week"/>
                <br>
            </div>
        </div>
    </div>
</div>
</body>
</html>
