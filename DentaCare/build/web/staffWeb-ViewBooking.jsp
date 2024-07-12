<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff</title>
        <link href="admin-front-end/css/styleViewBooking.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="fixed-element">
                <div class="header-icon">
                    <span class="material-symbols-outlined" style="font-size: 32px;" onclick="toggleDropdown()">
                        <i class="fa-solid fa-user" style="font-size: 29px; margin-right: 45px;"></i>
                    </span>
                    <div class="sub-menu-wrap" id="sub-menu-wrap">
                        <div class="sub-menu">
                            <div class="user-info">
                                <h3>${sessionScope.account.userName}</h3>
                            </div>
                            <hr>
                            <a href="ProfileStaffServlet" class="sub-menu-link">
                                <p>Profile</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                            <hr>
                            <a href="ProfileStaffServlet?action=changePassword" class="sub-menu-link">
                                <p>Change Password</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                            <hr>
                            <a href="StaffViewBooking?action=pastBookingList" class="sub-menu-link">
                                <p>Past Booking List</p>
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
                <h1>Booking View for Staff</h1>

                <div class="header-button">
                    <div class="daily-revenue">
                        <h3>Daily Revenue: <fmt:formatNumber value="${dailyRevenue}" type="currency" currencyCode="VND" maxFractionDigits="0"/></h3>
                    </div>
                    <form>
                        <input type="text" name="nameBooking" placeholder="Search by Name" />
                    </form>
                </div>
            </div>

            <input type="hidden" id="openBookingDetail" value="${requestScope.openBookingDetail}" />

            <div id="bookingList">
                <div class="popup-header">
                    <h2>Today's Bookings</h2>
                </div>
                <c:forEach items="${listBookingStaff}" var="booking" varStatus="status">
                    <div class="booking-item" data-date="${booking.appointmentDay}" data-name="${booking.account.fullName}" onclick="showDetail('${status.index}')">
                        Booking ID: ${booking.bookingID} | Name: ${booking.account.fullName} | Time: ${booking.timeSlot.timePeriod} |
                        <c:choose>
                            <c:when test="${booking.status == 1}">
                                Status: Checked-in
                            </c:when>
                            <c:when test="${booking.status == 0}">
                                Status: Placed
                            </c:when>
                            <c:when test="${booking.status == 2}">
                                Status: Completed
                            </c:when>
                            <c:when test="${booking.status == 5}">
                                Status: Placed and Sent Email
                            </c:when>
                        </c:choose>
                        <div id="detail-${status.index}" class="booking-detail hidden">
                            <p><strong>Booking ID:</strong> ${booking.bookingID}</p>
                            <p><strong>Create Day:</strong> ${booking.createDay}</p>
                            <p><strong>Appointment Day:</strong> ${booking.appointmentDay}</p>
                            <p><strong>Appointment Time:</strong> ${booking.timeSlot.timePeriod}</p>
                            <p><strong>Status:</strong> 
                                <c:choose>
                                    <c:when test="${booking.status == 1}">Checked-in</c:when>
                                    <c:when test="${booking.status == 2}">Completed</c:when>
                                    <c:when test="${booking.status == 5}">Placed and Sent Email</c:when>
                                    <c:otherwise>Unknown</c:otherwise>
                                </c:choose>
                            </p>
                            <p><strong>Service Name:</strong> ${booking.service.serviceName}</p>
                            <p><strong>Customer Name:</strong> ${booking.account.fullName}</p>
                            <p><strong>Customer Phone:</strong> ${booking.account.phone}</p>
                            <div class="dentist-info">
                                <p><strong>Dentist Name:</strong> ${booking.fullNameDentist}</p>
                                <form action="./StaffViewBooking" method="post">
                                    <input name="action" value="assignDentist" type="hidden" />
                                    <select name="dentistID" id="dentistID-${status.index}">
                                        <option value="">Select a dentist</option>
                                        <c:forEach items="${listNameDentist1}" var="dentist">
                                            <option value="${dentist.accountID}">${dentist.fullName}</option>
                                        </c:forEach>
                                    </select>
                                    <input name="bookingID" value="${booking.bookingID}" type="hidden" />
                                    <input type="hidden" name="openBookingDetail" value="${status.index}" />
                                    <input type="hidden" name="bookingDate" value="${selectedDate}" />
                                    <input type="submit" value="Assign" <c:if test="${booking.status != 5}">disabled</c:if> />
                                    </form>
                                </div>
                                <p><strong>Price: </strong><fmt:formatNumber value="${booking.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/></p>
                            <p><strong>Deposit: </strong><fmt:formatNumber value="${booking.deposit}" type="currency" currencyCode="VND" maxFractionDigits="0"/></p>
                            <div style="display: flex; justify-content: space-between;">
                                <div style="display: flex; gap: 20px">

                                    <form action="./StaffViewBooking" method="post">
                                        <input type="hidden" name="action" value="viewInvoice" />
                                        <input name="bookingID" value="${booking.bookingID}" type="hidden" />
                                        <input name="customerID" value="${booking.customerID}" type="hidden" />
                                        <input type="submit" value="View Invoice" />
                                    </form>

                                </div>
                                <button style="margin-left: 445px; height: 42px; margin-top: 15px; z-index: 899" onclick="closeDetail('${status.index}', event)">Close</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div id="bookingListUpcoming">
                <div class="popup-header">
                    <h2>Bookings Upcoming</h2>
                </div>
                <c:forEach items="${listUpcomingBookings}" var="booking" varStatus="status">
                    <div class="booking-item" data-date="${booking.appointmentDay}" data-name="${booking.account.fullName}" onclick="showDetailUpcoming('${status.index}')">
                        Booking ID: ${booking.bookingID} | Name: ${booking.account.fullName} | Time: ${booking.timeSlot.timePeriod} |
                        <c:choose>
                            <c:when test="${booking.status == 0}">Status: Placed</c:when>
                            <c:when test="${booking.status == 5}">Status: Placed and Sent Email</c:when>
                        </c:choose>
                        <div id="detail-upcoming-${status.index}" class="booking-detail-upcoming hidden">
                            <p><strong>Booking ID:</strong> ${booking.bookingID}</p>
                            <p><strong>Create Day:</strong> ${booking.createDay}</p>
                            <p><strong>Appointment Day:</strong> ${booking.appointmentDay}</p>
                            <p><strong>Appointment Time:</strong> ${booking.timeSlot.timePeriod}</p>
                            <p><strong>Status:</strong> 
                                <c:choose>
                                    <c:when test="${booking.status == 0}">Status: Placed</c:when>
                                    <c:when test="${booking.status == 5}">Status: Placed and Sent Email</c:when>
                                </c:choose>
                            </p>
                            <p><strong>Service Name:</strong> ${booking.service.serviceName}</p>
                            <p><strong>Customer Name:</strong> ${booking.account.fullName}</p>
                            <p><strong>Customer Phone:</strong> ${booking.account.phone}</p>
                            <p><strong>Price: </strong><fmt:formatNumber value="${booking.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/></p>
                            <p><strong>Deposit: </strong><fmt:formatNumber value="${booking.deposit}" type="currency" currencyCode="VND" maxFractionDigits="0"/></p>
                            <div style="display: flex; justify-content: space-between;">
                                <div style="display: flex; gap: 20px">
                                    <c:if test="${booking.status == 0}">
                                        <form action="./SendEmailNotificationBookingServlet" method="post">
                                            <input name="bookingInvoiceID" value="${booking.bookingID}" type="hidden" />
                                            <input name="customerID" value="${booking.customerID}" type="hidden" />
                                            <input type="Submit" value="Send Mail" />
                                        </form>
                                    </c:if>
                                </div>
                                <button style="margin-left: 445px; height: 42px; margin-top: 15px; z-index: 899" onclick="closeDetailUpcoming('${status.index}', event)">Close</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <style>
                #PastbookingList {
                    display: ${style};
                    position: fixed;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    z-index: 1000;
                    background-color: white;
                    padding: 27px;
                    border-radius: 8px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    width: 51%;
                    max-height: 80%;
                    overflow-y: auto;

                }
                .overlay {
                    display: ${style};
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
                    z-index: 1000; /* Lower z-index to be behind the pop-up */
                }
                .close-button {
                    position: absolute;
                    top: 10px;
                    right: 10px;
                    z-index: 10;
                    background-color: white; /* Optional: Add background to ensure readability */
                    padding: 0 5px; /* Optional: Add some padding for better appearance */
                    border-radius: 5px; /* Optional: Add border radius for better appearance */
                }

                .close-button a {
                    color: #d9534f;
                    text-decoration: none;
                    font-weight: bold;
                }

                .close-button a:hover {
                    text-decoration: underline;
                }
            </style>
            <div id="overlay" class="overlay"></div>
            <div id="PastbookingList">
                <div style="display: flex;" class="popup-header">
                    <h2>Past Bookings</h2>
                    <span class="close-button"><a href="StaffViewBooking?action=closePopUp">X</a></span>
                </div>
                <c:forEach items="${bookingsByDate}" var="entry">
                    <h3>${entry.key}</h3>
                    <c:forEach items="${entry.value}" var="booking" varStatus="status">
                        <div class="booking-item" data-date="${booking.appointmentDay}" data-name="${booking.account.fullName}" onclick="showDetailPast('${entry.key}-${status.index}')">
                            Booking ID: ${booking.bookingID} | Name: ${booking.account.fullName} | Time: ${booking.timeSlot.timePeriod} |
                            <c:choose>
                                <c:when test="${booking.status == 2}">Status: Completed</c:when>
                                <c:when test="${booking.status == 3}">Status: Cancelled</c:when>
                                <c:when test="${booking.status == 4}">Status: Expired</c:when>
                            </c:choose>
                            <div id="detail-past-${entry.key}-${status.index}" class="booking-detail-past hidden">
                                <p><strong>Booking ID:</strong> ${booking.bookingID}</p>
                                <p><strong>Create Day:</strong> ${booking.createDay}</p>
                                <p><strong>Appointment Day:</strong> ${booking.appointmentDay}</p>
                                <p><strong>Appointment Time:</strong> ${booking.timeSlot.timePeriod}</p>
                                <p><strong>Status:</strong> 
                                    <c:choose>
                                        <c:when test="${booking.status == 2}">Status: Completed</c:when>
                                        <c:when test="${booking.status == 3}">Status: Cancelled</c:when>
                                        <c:when test="${booking.status == 4}">Status: Expired</c:when>
                                    </c:choose>
                                </p>
                                <p><strong>Service Name:</strong> ${booking.service.serviceName}</p>
                                <p><strong>Customer Name:</strong> ${booking.account.fullName}</p>
                                <p><strong>Customer Phone:</strong> ${booking.account.phone}</p>
                                <p><strong>Price: </strong><fmt:formatNumber value="${booking.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/></p>
                                <p><strong>Deposit: </strong><fmt:formatNumber value="${booking.deposit}" type="currency" currencyCode="VND" maxFractionDigits="0"/></p>
                                <div style="display: flex; justify-content: space-between;">
                                    <div style="display: flex; gap: 20px">

                                        <form action="./StaffViewBooking" method="post">
                                            <input type="hidden" name="action" value="viewInvoice" />
                                            <input name="bookingID" value="${booking.bookingID}" type="hidden" />
                                            <input name="customerID" value="${booking.customerID}" type="hidden" />
                                            <input type="submit" value="View Invoice" />
                                        </form>

                                    </div>
                                    <button style="margin-left: 445px; height: 42px; margin-top: 15px; z-index: 899" onclick="closeDetailPast('${entry.key}-${status.index}', event)">Close</button>
                                </div>

                            </div>
                        </div>

                    </c:forEach>
                </c:forEach>


            </div>
        </div>
        <script>
            function showDetail(id) {
                var details = document.getElementsByClassName('booking-detail');
                for (var i = 0; i < details.length; i++) {
                    details[i].classList.add('hidden');
                }
                document.getElementById('detail-' + id).classList.remove('hidden');
            }

            function closeDetail(id, event) {
                event.stopPropagation();
                document.getElementById('detail-' + id).classList.add('hidden');
            }

            function showDetailUpcoming(id) {
                var details = document.getElementsByClassName('booking-detail-upcoming');
                for (var i = 0; i < details.length; i++) {
                    details[i].classList.add('hidden');
                }
                document.getElementById('detail-upcoming-' + id).classList.remove('hidden');
            }

            function closeDetailUpcoming(id, event) {
                event.stopPropagation();
                document.getElementById('detail-upcoming-' + id).classList.add('hidden');
            }

            function showDetailPast(id) {
                var details = document.getElementsByClassName('booking-detail-past');
                for (var i = 0; i < details.length; i++) {
                    details[i].classList.add('hidden');
                }
                document.getElementById('detail-past-' + id).classList.remove('hidden');
            }

            function closeDetailPast(id, event) {
                event.stopPropagation();
                document.getElementById('detail-past-' + id).classList.add('hidden');
            }

            function toggleDropdown() {
                let subMenu = document.getElementById("sub-menu-wrap");
                subMenu.classList.toggle("open-menu");
            }

            function formatMoney(value) {
                // Ensure value is treated as a number
                value = Number(value);
                return value.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
            }

            document.addEventListener('DOMContentLoaded', function () {
                const moneyElements = document.querySelectorAll('.money-format');

                moneyElements.forEach(element => {
                    let text = element.textContent.trim();
                    // Convert to number and format
                    const amount = parseFloat(text);
                    if (!isNaN(amount)) {
                        const formattedMoney = formatMoney(amount);
                        element.textContent = formattedMoney;
                    }
                });
            });



        </script>
        <script src="admin-front-end/js/staffViewBooking.js"></script>
    </body>
</html>
