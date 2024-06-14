<%@include file="/headerLog.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="clinic.*" %>
<%@page import="Service.*" %>
<%@page import="timeSlot.*" %>
<%@page import="account.*" %>
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
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    </head>
    <body>
        <div class="container user">
            <nav class="navbar user" style="margin-top: -369px;">
                <ul>
                    <li><a href="ProfileServlet" id="userProfileLink">User Profile</a></li>
                    <li><a href="ExamScheduleServlet" id="bookingScheduleLink">Examination Schedule</a></li>
                    <li><a href="#" id="bookingHistoryLink" class="active">Booking History</a></li>
                    <li><a href="SignOutServlet">Sign out</a></li>
                </ul>
            </nav>
            <div class="alert-message sec">${message}</div>
            <div class="content active" id="bookingHistoryContent" style="height: 600px;">
                <h1>Booking History</h1>
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
                                    
                                    ServiceDTO service = null;
                                    ClinicDTO clinic = null;
                                    TimeSlotDTO slot = null;
                                    AccountDTO dentist = null;
                                    
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
                                <div class="booking-title"><strong><%= service.getServiceName() %></strong></div>
                                <div class="booking-details"><%= clinic.getClinicName() %><br><%= slot.getTimePeriod()%> <strong>on</strong> ${booking.getAppointmentDay()}</div>
                                    <c:choose>
                                        <c:when test="${booking.status == 0}">
                                        <div class="booking-details" style="text-align: right; font-weight: 600; color: darkorange;">Placed</div>
                                    </c:when>
                                    <c:when test="${booking.status == 1}">
                                        <div class="booking-details" style="text-align: right; font-weight: 600; color: blue;">Check-in</div>
                                    </c:when>
                                    <c:when test="${booking.status == 3}">
                                        <div class="booking-details" style="text-align: right; font-weight: 600; color: red;">Cancelled</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="booking-details" style="text-align: right; font-weight: 600; color: green;">Completed</div>
                                    </c:otherwise>
                                </c:choose>

                                <a href="#" class="details-link" data-booking-id="${booking.bookingID}"><span class="material-symbols-outlined">visibility</span></a>
                            </div>
                        </div>

                        <div id="bookingModal-${booking.bookingID}" class="modal">
                            <div class="modal-content">
                                <div style="display: flex; justify-content: space-between;">
                                    <h2>Booking Details</h2>
                                    <span class="close" data-booking-id="${booking.bookingID}">&times;</span>      
                                </div>
                                <div class="modal-detail" style="padding: 10px;">
                                    <div style="display: flex; justify-content: space-between; margin: 0;"><strong style="width: 40%">Booking Code: </strong> <p style="text-align: left; width: 60%"> ${booking.bookingID}</p></div>
                                    <div style="display: flex; justify-content: space-between; margin: 0;"><strong style="width: 40%">Confirm Booking Day:  </strong> <p style="text-align: left; width: 60%">${booking.createDay}</p></div>
                                    <hr>
                                    <div><strong>Service Name</strong> <p><%= service.getServiceName() %></p></div>
                                    <div><strong>Address</strong> <p><%= clinic.getClinicAddress() %></p></div>
                                    <div><strong>Time</strong> <p><%= slot.getTimePeriod()%></p></div>
                                    <div><strong>Day</strong> <p>${booking.getAppointmentDay()}</p></div>
                                    <div><strong>Dentist</strong> <p><%= dentist != null ? dentist.getFullName() : "" %></p></div>
                                    <hr>
                                    <div style="display: flex; justify-content: space-between;">
                                        <div><strong>Price</strong> <p>${booking.getPrice()}</p></div>
                                        <form action="HistoryServlet"  style="margin-top: 20px; margin-right: 20px;">
                                            <input type="hidden" name="bookingID" value="${booking.bookingID}"/>
                                            <input type="hidden" name="action" value="cancel"/>
                                            <input type="submit" value="Cancel" id="bookingStatus" data-check="${booking.status}" />
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
