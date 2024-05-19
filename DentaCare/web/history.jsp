<%@include file="/header.jsp" %>
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
                    <li><a href="ProfileController" id="userProfileLink">User Profile</a></li>
                    <li><a href="ExamScheduleController" id="bookingScheduleLink">Examination Schedule</a></li>
                    <li><a href="#" id="bookingHistoryLink" class="active">Booking History</a></li>
                    <li><a href="SignOutController" >Sign out</a></li>
                </ul>
            </nav>

            <div class="content active" id="bookingHistoryContent">
                <h1>Booking History</h1>
                <p>This is the booking history page.</p>
            </div>
        </div>
    </body>

</html>