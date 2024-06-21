<%@include file="/headerLog.jsp" %>

<%@page import="clinic.*" %>
<%@page import="Service.*" %>
<%@page import="timeSlot.*" %>
<%@page import="account.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Examination Schedule</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link rel="stylesheet" href="css/account-information.css" />
        <link rel="stylesheet" href="css/examSchedule.css" />
    </head>


    <body>
        <input type="hidden" id="listBooking" value="${requestScope.listBooking}">
        <div class="container user">
            <nav class="navbar user">
                <ul>
                    <li><a href="ProfileServlet" id="userProfileLink">User Profile</a></li>
                    <li><a href="#" id="bookingScheduleLink" class="active">Examination Schedule</a></li>
                    <li><a href="HistoryServlet" id="bookingHistoryLink">Booking History</a></li>
                    <li><a href="SignOutServlet" >Sign out</a></li>
                </ul>
            </nav>
            <div class="content active" id="calendar"></div>
        </div>
        <c:forEach items="${requestScope.listBooking}" var="booking">
            <div id="bookingModal-${booking.appointmentDay}" class="modal">
                <div class="modal-content">
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
                    <div style="display: flex; justify-content: space-between;">
                        <strong>${booking.appointmentDay}</strong>
                        <span class="close" data-check="${booking.appointmentDay}">&times;</span>      
                    </div>

                    <div class="modal-detail" style="padding: 10px;">
                        <div><strong>Service Name</strong> <p><%= service.getServiceName() %></p></div>  
                        <div><strong>Address</strong> <p><%= clinic.getClinicAddress() %></p></div>
                        <div><strong>Time</strong> <p><%= slot.getTimePeriod()%></p></div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <%@include file="/footer.jsp" %>    
        <script src="js/examSchedule.js"></script>
        <script>

            document.querySelectorAll(".selected-calendar").forEach(link => {
                link.addEventListener("click", function (event) {
                    event.preventDefault();
                    const day = this.getAttribute("data-check");
                    document.querySelector(`#bookingModal-` + day).classList.add("active");
                });
            });

            document.querySelectorAll(".modal .close").forEach(closeBtn => {
                closeBtn.addEventListener("click", function () {
                    const day = this.getAttribute("data-check");
                    document.querySelector(`#bookingModal-` + day).classList.remove("active");
                });
            });

            window.addEventListener("click", function (event) {
                if (event.target.classList.contains('modal')) {
                    event.target.classList.remove('active');
                }
            });

        </script>

    </body>

</html>