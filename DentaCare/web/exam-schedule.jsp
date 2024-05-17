

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Examination Schedule</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link rel="stylesheet" href="css/account-information.css" />
    </head>


    <body>
        <div class="container">
            <nav class="navbar">
                <ul>
                    <li><a href="ProfileController" id="userProfileLink">User Profile</a></li>
                    <li><a href="#" id="bookingScheduleLink" class="active">Examination Schedule</a></li>
                    <li><a href="HistoryController" id="bookingHistoryLink">Booking History</a></li>
                    <li><a href="SignOutController" >Sign out</a></li>
                </ul>
            </nav>
            <div class="content active" id="bookingScheduleContent">
                <h1>Booking Schedule</h1>
                <p>This is the booking schedule page.</p>
            </div>
        </div>
    </body>

</html>