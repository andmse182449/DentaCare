
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="clinic.*" %>
<%@page import="Service.*" %>
<%@page import="timeSlot.*" %>
<%@page import="account.*" %>
<%@page import="medicalRecord.*" %>
<%@ page import="java.time.LocalDate, java.time.temporal.WeekFields, java.util.Locale" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking History</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link rel="stylesheet" href="css/account-information.css" />
        <link rel="stylesheet" href="css/bookingHistory.css" />
        <link rel="stylesheet" href="css/styleDen.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    </head>
    <body>
        <div class="header">
            <nav class="menu">
                <span class="logo">logo</span>
                <ul>
                    <li>
                        <%
                LocalDate now2 = LocalDate.now();
                WeekFields weekFields = WeekFields.of(Locale.getDefault());
                int currentYear2 = now2.getYear();
                int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
                int currentMonth2 = now2.getMonthValue(); // Get current month number
                        %>
                        <a href="LoadScheduleForEachDentistServlet?action=loadDenSchedule&clinicByID=${requestScope.clinicID}&year=<%=currentYear2%>&week=<%=currentWeek2%>">my schedule</a>
                    </li>
                    <li>
                        <a href="LoadPatientOfDenServlet">my patient</a>
                    </li>
                </ul>
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
        <div class="container user">

            <div class="alert-message sec">${message}</div>
<!--            <div class="alert-message1 sec">${message1}</div>-->

            <div class="content active" id="bookingHistoryContent" style="height: 600px;">
                <h1>Patient Record</h1>
                <div class="booking-history">
                    <c:forEach var="booking" items="${requestScope.bookingList}">
                        <div class="card">
                            <div class="card-content">
                                <%
                                    // Get the service ID from the booking object using scriptlet-friendly syntax
                                    int serviceID = 0;
                                    int clinicID = 0;
                                    int slotID = 0;
                                    String dentistID = "";
                                    String bookingID;
                                    
                                    ServiceDTO service = null;
                                    ClinicDTO clinic = null;
                                    TimeSlotDTO slot = null;
                                    AccountDTO dentist = null;
                                    MedicalRecordDTO medical = null;
                                    
                                    try {
                                        serviceID = (int) pageContext.getAttribute("booking").getClass().getMethod("getServiceID").invoke(pageContext.getAttribute("booking"));
                                        ServiceDAO serviceDAO = new ServiceDAO();
                                        service = serviceDAO.getServiceByID(serviceID);
                                        
                                        clinicID = (int) pageContext.getAttribute("booking").getClass().getMethod("getClinicID").invoke(pageContext.getAttribute("booking"));
                                        ClinicDAO clinicDAO = new ClinicDAO();
                                        clinic = clinicDAO.getClinicByID(clinicID);
                                        
                                        slotID = (int) pageContext.getAttribute("booking").getClass().getMethod("getSlotID").invoke(pageContext.getAttribute("booking"));
                                        TimeSlotDAO slotDAO = new TimeSlotDAO();
                                        slot = slotDAO.getTimeSLotByID(slotID);
                                        
                                        dentistID = (String) pageContext.getAttribute("booking").getClass().getMethod("getDentistID").invoke(pageContext.getAttribute("booking"));
                                        AccountDAO accountDAO = new AccountDAO();
                                        dentist = accountDAO.getDentistByID(dentistID);
                                            
                                               
                                        
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                %>
                                <div class="booking-title"><strong>${booking.account.getFullName()}</strong></div>
                                <div class="booking-title"><strong><%= service.getServiceName() %></strong></div>
<!--                                <div class="booking-title"><strong> ${booking.bookingID}</strong></div>-->
                                <div class="booking-details">${booking.account.getFullName()}<br><%= slot.getTimePeriod()%> <strong>on</strong> ${booking.getAppointmentDay()}</div>

                                <c:choose>
                                    <c:when test="${booking.status == 1}">
                                        <div class="booking-details" style="text-align: right; font-weight: 600; color: blue;">Check-in</div>
                                    </c:when>
                                    <c:when test="${booking.status == 2}">
                                        <div class="booking-details" style="text-align: right; font-weight: 600; color: green;">Completed</div>
                                    </c:when>
                                </c:choose>
                                <a href="#" class="details-link" data-booking-id="${booking.bookingID}"><span class="material-symbols-outlined">visibility</span></a>
                            </div>
                        </div>

                        <div id="bookingModal-${booking.bookingID}" class="modal">
                            <div class="modal-content">
                                <div style="display: flex; justify-content: space-between;">
                                    <h2>Customer Details</h2>
                                    <span class="close" data-booking-id="${booking.bookingID}">&times;</span>      
                                </div>
                                <div class="modal-detail" style="">
<!--                                            <div style="display: flex; justify-content: space-between; margin: 0;"><strong style="width: 40%">Booking Code: </strong> <p style="text-align: left; width: 60%"> ${booking.bookingID}</p></div>
                                    <div style="display: flex; justify-content: space-between; margin: 0;"><strong style="width: 40%">Confirm Booking Day:  </strong> <p style="text-align: left; width: 60%">${booking.createDay}</p></div>-->
                                    <hr>
                                    <div class="modal-detail-container">
                                        <div class="modal-detail">
                                            <div><strong>Full Name</strong> <p>${booking.account.getFullName()}</p></div>
                                            <div><strong>Date Of Birth</strong> <p>${booking.account.getDob()}</p></div>
                                            <div><strong>Service Name</strong> <p><%= service.getServiceName() %></p></div>
                                            <div><strong>Time</strong> <p><%= slot.getTimePeriod()%></p></div>
                                            <div><strong>Day</strong> <p>${booking.getAppointmentDay()}</p></div>
                                        </div>
                                        <div class="modal-detail">
                                            <div><strong>Result</strong> <p>${booking.medicalRecord.getResults()}</p></div>
                                            <div><strong>ReExanime</strong> <p>${booking.medicalRecord.getReExanime()}</p></div>
                                        </div>
                                    </div>
                                    <hr>
                                    <div style="display: flex; justify-content: space-between;">
    <!--                                            <div><strong>Price</strong> <p>${booking.getPrice()}</p></div>-->
                                        <form action="LoadPatientOfDenServlet"  method="post" style="margin-top: 20px; margin-right: 20px;">
                                            <input type="hidden" name="action" value="addRecord"/>
                                            <c:set value="${requestScope.checkExist}" var="checkExist" />
                                            Result: <input required type="text" name="result"/> <br>
                                            <input type="hidden" name="bookingID" value="${booking.bookingID}"/>
                                            <input  type="hidden" name="reExanime0" value="${booking.medicalRecord.getReExanime()}"/>
                                            ReExamine: <input required type="date" name="reExanime" />
                                            <input type="submit" value="Add Result" id="bookingStatus1"  />
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <%@include file="/footer.jsp" %>
        <script src="js/bookingHistory.js">

        </script>
    </body>
</html>
