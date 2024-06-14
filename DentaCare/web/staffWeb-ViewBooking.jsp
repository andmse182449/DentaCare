<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <h1>Booking View for Staff</h1>
                <a href="ProfileStaffServlet"><i class="fa-solid fa-user"></i></a>
                <div class="date-picker">
                    <label for="bookingDate">Select Date:</label>
                    <input type="date" id="bookingDate" name="bookingDate" value="">
                </div>
                <div>
                    <form action="./StaffViewBooking" method="post">
                        <input type="hidden" name="bookingDate" id="hiddenBookingDate">
                        <input type="text" name="nameBooking" placeholder="Enter Name" />
                        <input type="submit" value="Search" />
                        <input type="hidden" name="action" value="searchBooking" />
                    </form>
                </div>
            </div>

            <input type="hidden" id="openBookingDetail" value="${requestScope.openBookingDetail}" />

            <div id="bookingList" class="hidden">
                <c:forEach items="${listBookingStaff}" var="booking" varStatus="status">
                    <div class="booking-item" data-date="${booking.appointmentDay}" data-name="${booking.account.fullName}" onclick="showDetail('${status.index}')">
                        Booking ID: ${booking.bookingID} | Name: ${booking.account.fullName} | Time: ${booking.timeSlot.timePeriod} | Status: Confirmed
                        <div id="detail-${status.index}" class="booking-detail hidden">
                            <p><strong>Booking ID:</strong> ${booking.bookingID}</p>
                            <p><strong>Create Day:</strong> ${booking.createDay}</p>
                            <p><strong>Appointment Day:</strong> ${booking.appointmentDay}</p>
                            <p><strong>Appointment Time:</strong> ${booking.timeSlot.timePeriod}</p>
                            <p><strong>Status:</strong> ${booking.status}</p>
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
                                    <input type="submit" value="Assign" />
                                </form>
                            </div>
                            <p><strong>Price:</strong> ${booking.price}</p>
                            <button style="margin-left: 650px;" onclick="closeDetail('${status.index}', event)">Close</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Retrieve the date from local storage
                const savedDate = localStorage.getItem('selectedDate');
                const bookingDateInput = document.getElementById('bookingDate');
                if (savedDate) {
                    bookingDateInput.value = savedDate;
                    loadBookings(savedDate); // Load bookings for the saved date
                } else {
                    // Set today's date if no date is selected
                    const today = new Date().toISOString().split('T')[0];
                    bookingDateInput.value = today;
                    loadBookings(today);
                }

                // Add event listener to date picker
                bookingDateInput.addEventListener('change', function () {
                    const selectedDate = this.value;
                    localStorage.setItem('selectedDate', selectedDate);
                    loadBookings(selectedDate);
                });

                // Open the detail view if specified
                const openBookingDetail = document.getElementById('openBookingDetail').value;
                if (openBookingDetail) {
                    showDetail(openBookingDetail);
                }
            });

            function loadBookings(date) {
                // Implement the function to load bookings for the selected date
                // This function should make a request to the server to get the bookings for the specified date
                // and update the booking list accordingly.
            }

            document.querySelector('form').addEventListener('submit', function () {
                document.getElementById('hiddenBookingDate').value = document.getElementById('bookingDate').value;
            });

            function showDetail(id) {
                // Hide all other details
                var details = document.getElementsByClassName('booking-detail');
                for (var i = 0; i < details.length; i++) {
                    details[i].classList.add('hidden');
                }

                // Show the selected detail
                document.getElementById('detail-' + id).classList.remove('hidden');
            }

            function closeDetail(id, event) {
                event.stopPropagation(); // Prevent the click event from bubbling up to the parent div
                document.getElementById('detail-' + id).classList.add('hidden');
            }
        </script>
        <script src="admin-front-end/js/staffViewBooking.js"></script>
    </body>
</html>
