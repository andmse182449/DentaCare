

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Profile</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link rel="stylesheet" href="css/account-information.css" />
    </head>


    <body>
        <div class="container">
            <nav class="navbar">
                <ul>
                    <li><a href="#" id="userProfileLink" class="active">User Profile</a></li>
                    <li><a href="ExamScheduleController">Examination Schedule</a></li>
                    <li><a href="HistoryController" id="bookingHistoryLink">Booking History</a></li>
                    <li><a href="SignOutController" >Sign out</a></li>
                </ul>
            </nav>

            <div class="content active" id="userProfileContent">
                <h1>User Profile</h1>
                <p>This is the user profile page.</p>
            </div>
        </div>
    </body>

</html>