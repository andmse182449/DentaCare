<%@page import="booking.BookingDTO"%>
<%@include file="/headerLog.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@page import="clinic.*" %>
<%@page import="Service.*" %>
<%@page import="timeSlot.*" %>
<%@page import="account.*" %>
<%@ page import="java.util.List" %>
<%@page import="java.text.NumberFormat" %>
<%@page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking History</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link rel="stylesheet" href="css/account-information.css" />
        <link rel="stylesheet" href="css/bookingHistory.css"/>
        <link rel="stylesheet" href="css/feedback.css"/>
        <link rel="stylesheet" href="css/reviewFeedback.css"/>
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
                                    float price1 = 0;
                                    float deposit1 = 0;
                                    String dentistID = "";
                                    String price = "";
                                    String deposit = "";

                                    ServiceDTO service = null;
                                    ClinicDTO clinic = null;
                                    TimeSlotDTO slot = null;
                                    AccountDTO dentist = null;
                                    // Implement this method to check if feedback exists
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
                                        
                                        price1 = (float) pageContext.getAttribute("booking").getClass().getMethod("getPrice").invoke(pageContext.getAttribute("booking"));
                                        Locale currentLocale = new Locale("vi", "VN");
                                        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(currentLocale);
                                        price = currencyFormatter.format(price1);
                                        
                                        deposit1 = (float) pageContext.getAttribute("booking").getClass().getMethod("getDeposit").invoke(pageContext.getAttribute("booking"));
                                        deposit = currencyFormatter.format(deposit1);

                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                %>
                                <div class="booking-title"><strong><%= service.getServiceName()%></strong></div>
                                <div class="booking-details"><%= clinic.getClinicName()%><br><%= slot.getTimePeriod()%> <strong>on</strong> ${booking.getAppointmentDay()}</div>
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
                                    <c:when test="${booking.status == 4}">
                                        <div class="booking-details" style="text-align: right; font-weight: 600; color: red;">Expired</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="booking-details" style="text-align: right; font-weight: 600; color: green;">Completed</div>

                                    </c:otherwise>
                                </c:choose>

                                <a href="#" class="details-link" data-booking-id="${booking.bookingID}"><span class="material-symbols-outlined">visibility</span></a>
                                <c:set var="fbList" value="${requestScope.feedbackList}"/>

                                <c:set var="isInFbList" value="false"/>

                                <!-- Loop through fbList to check if booking.bookingID is present -->
                                <c:forEach var="id" items="${fbList}">
<!--                                    <h3>${id.getBookingID()}</h3>
                                    <br>-->
                                    <c:if test="${id.getBookingID() == booking.bookingID}">
                                        <c:set var="isInFbList" value="true"/>
                                    </c:if>

                                </c:forEach>
                                <c:choose>
                                    <c:when test="${isInFbList == 'true'}">
                                        <input type="hidden" value="${booking.bookingID}" class="bookingID"/>
                                        <button class="btnViewFeedBack" id="viewFeedbackBtn-${booking.bookingID}">View Feedback</button>
                                    </c:when>
                                    <c:when test="${booking.status == 2 && isInFbList == 'true'}">
                                        <input type="hidden" value="${booking.bookingID}" class="bookingID"/>
                                        <button class="btnViewFeedBack" id="viewFeedbackBtn-${booking.bookingID}">View Feedback</button>
                                    </c:when>
                                    <c:when test="${booking.status == 2}">
                                        <input type="hidden" value="${booking.bookingID}" class="bookingID"/>
                                        <button class="btnFeedBack">Give feedback</button>
                                    </c:when>
                                </c:choose>

                            </div>
                        </div>
                        <!--cua an-->
                        <div class="overlay" id="feedbackOverlay-${booking.bookingID}">

                            <div class="overlay-content">
                                <span class="close-btn" onclick="closeToggle()">&times;</span>
                                <div class="product-header">
                                    <img src="product_image.jpg" alt="Product Image" class="product-image">
                                    <div class="product-info">
                                        <h2>${booking.bookingID}</h2>
                                    </div>
                                </div>

                                <form id="comment-form-${booking.bookingID}">
                                    <div class="review-content">
                                        <div class="section">
                                            <textarea placeholder="Please share your experience with our services to everyone..." class="input-field usercomment" id="comment-text"></textarea>
                                        </div>
                                    </div>
                                    <input type="hidden" value="${booking.bookingID}" class="bookingID">
                                    <input type="hidden" value="${account.getFullName()}" class="user">
                                    <div class="form-actions">
                                        <input type="submit" id="publish" value="Publish" onclick="saveFeedback('${booking.bookingID}')"/>

                                        <button class="btn cancel-btn" onclick="toggleFeedbackForm(${booking.bookingID})">Cancel</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!--cua hung-->
                        <c:set var="records" value="${requestScope.recordList}"/>
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
                                    <div style="display: flex; justify-content: space-between;">
                                        <div>
                                            <div><strong>Service Name</strong> <p><%= service.getServiceName()%></p></div>
                                            <div><strong>Address</strong> <p><%= clinic.getClinicAddress()%></p></div>
                                            <div><strong>Time</strong> <p><%= slot.getTimePeriod()%></p></div>
                                            <div><strong>Day</strong> <p>${booking.getAppointmentDay()}</p></div>
                                            <div><strong>Dentist</strong> <p><%= dentist != null ? dentist.getFullName() : ""%></p></div>
                                        </div>
                                        <div>
                                            <c:forEach items="${records}" var="record">
                                                <c:if test="${record.bookingID eq booking.bookingID}">
                                                    <div><strong>Result</strong> <p>${record.getResults()}</p></div>
                                                    <div><strong>Re-Examination Date</strong> <p>${record.getReExanime()}</p></div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <hr>
                                    <div style="display: flex; justify-content: space-between;">
                                            <div><strong>Price</strong> <p><%= price %></p></div>
                                        <div><strong>Deposit</strong> <p><%= deposit %></p></div>
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
            <!-- Main container and content are already here -->
            <div id="confirmationPopup" class="popup">
                <div class="popup-content">
                    <span class="close-popup" onclick="toggleConfirmationPopup()">&times;</span>
                    <p>Comment saved successfully!</p>
                </div>
            </div>




        </div>
        <%@include file="/footer.jsp" %>
        <script src="js/bookingHistory.js"></script>
        <script src="js/writeFeedback.js"></script>
        <script>
                        function closeToggle() {
                            var overlay = document.querySelectorAll('.overlay');
                            for (var i = 0; i < overlay.length; i++) {
                                overlay[i].style.display = 'none';
                            }
                        }
// Function to toggle feedback form visibility for the specific booking
                        function toggleFeedbackForm(bookingID) {
                            // Find the specific overlay for the given bookingID
                            var overlay = document.getElementById('feedbackOverlay-' + bookingID);
                            if (overlay) {
                                overlay.style.display = (overlay.style.display === 'none' || overlay.style.display === '') ? 'flex' : 'none';
                            }
                        }

// Function to show the confirmation popup after a comment is saved
                        function showConfirmationPopup() {
                            toggleConfirmationPopup(); // Show the popup

                            // Automatically hide the popup after 3 seconds
                            setTimeout(toggleConfirmationPopup, 1500);
                        }

// Function to save feedback (this can be extended to actually send the feedback to the server)
                        function saveFeedback(bookingID) {
                            // Log or handle the feedback saving process
                            console.log('Saving feedback for bookingID:', bookingID);

                            // Show the confirmation popup
                            showConfirmationPopup();
                            // Close the feedback form for the specific bookingID
                            toggleFeedbackForm(bookingID);
                        }

// Function to toggle the confirmation popup visibility
                        function toggleConfirmationPopup() {
                            var popup = document.getElementById('confirmationPopup');
                            popup.style.display = (popup.style.display === 'none' || popup.style.display === '') ? 'block' : 'none';
                        }

                        // Attach event listeners to each feedback button and form
                        document.addEventListener('DOMContentLoaded', function () {
                            // Select all feedback buttons
                            var feedbackButtons = document.querySelectorAll('.btnFeedBack');

                            feedbackButtons.forEach(function (button) {
                                // Get the bookingID from a data attribute or hidden input
                                var bookingID = button.closest('.card').querySelector('input.bookingID').value;

                                // Attach click event listener to open the feedback form
                                button.addEventListener('click', function () {
                                    toggleFeedbackForm(bookingID);
                                });
                            });

                            // Select all feedback forms
                            var feedbackForms = document.querySelectorAll('#comment-form');

                            feedbackForms.forEach(function (form) {
                                // Get the bookingID from a hidden input or data attribute
                                var bookingID = form.querySelector('input.bookingID').value;

                                // Attach submit event listener to save feedback
                                form.addEventListener('submit', function (event) {
                                    saveFeedback(event, bookingID);
                                });
                            });
                        });

        </script>

        <script src="js/viewFeedback.js"></script>
        <script src="js/open-close.js"></script>
    </body>
</html>
