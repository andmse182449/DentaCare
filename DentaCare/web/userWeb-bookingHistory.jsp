<%@include file="/headerLog.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking History</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link rel="stylesheet" href="css/account-information.css" />
    </head>


    <body>
        <div class="container user">
            <nav class="navbar user">
                <ul>
                    <li><a href="ProfileServlet" id="userProfileLink">User Profile</a></li>
                    <li><a href="ExamScheduleServlet" id="bookingScheduleLink">Examination Schedule</a></li>
                    <li><a href="#" id="bookingHistoryLink" class="active">Booking History</a></li>
                    <li><a href="SignOutServlet" >Sign out</a></li>
                </ul>
            </nav>
            <div class="alert-message sec">${message}</div>
            <div class="content active" id="bookingHistoryContent">
                <h1>Booking History</h1>
                <p>This is the booking history page.</p>
            </div>
        </div>
    </body>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const alertBox2 = document.querySelector(".alert-message.sec");
            if (alertBox2 && alertBox2.textContent.trim()) {
                alertBox2.style.display = "block"; // Show the alert if there's an error message
                alertBox2.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                setTimeout(function () {
                    alertBox2.classList.remove("show");
                    setTimeout(function () {
                        alertBox2.style.display = "none"; // Hide the alert after the fade-out animation
                    }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
            }
        });
    </script>
</html>