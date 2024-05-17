<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Record and User Profile</title>
    <link rel="stylesheet" href="css/userInfo.css" />
</head>


<body>
    <div class="container">
        <nav class="navbar">
            <ul>
                <li><a href="#" id="patientRecordLink" class="active">Patient Record</a></li>
                <li><a href="#" id="userProfileLink">User Profile</a></li>
                <li><a href="#" id="bookingScheduleLink">Booking Schedule</a></li>
                <li><a href="#" id="bookingHistoryLink">Booking History</a></li>
            </ul>
        </nav>

        <div class="content" id="patientRecordContent">
            <h1>Patient Record</h1>
            <p>This is the patient record page.</p>
        </div>

        <div class="content" id="userProfileContent">
            <h1>User Profile</h1>
            <p>This is the user profile page.</p>
        </div>

        <div class="content" id="bookingScheduleContent">
            <h1>Booking Schedule</h1>
            <p>This is the booking schedule page.</p>
        </div>

        <div class="content" id="bookingHistoryContent">
            <h1>Booking History</h1>
            <p>This is the booking history page.</p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const links = {
                patientRecordLink: document.getElementById('patientRecordLink'),
                userProfileLink: document.getElementById('userProfileLink'),
                bookingScheduleLink: document.getElementById('bookingScheduleLink'),
                bookingHistoryLink: document.getElementById('bookingHistoryLink')
            };

            const contents = {
                patientRecordContent: document.getElementById('patientRecordContent'),
                userProfileContent: document.getElementById('userProfileContent'),
                bookingScheduleContent: document.getElementById('bookingScheduleContent'),
                bookingHistoryContent: document.getElementById('bookingHistoryContent')
            };

            Object.keys(links).forEach(link => {
                links[link].addEventListener('click', function (event) {
                    event.preventDefault();
                    showContent(link.replace('Link', 'Content'));
                });
            });

            function showContent(contentType) {
                Object.keys(contents).forEach(content => {
                    if (content === contentType) {
                        contents[content].classList.add('active');
                        links[content.replace('Content', 'Link')].classList.add('active');
                    } else {
                        contents[content].classList.remove('active');
                        links[content.replace('Content', 'Link')].classList.remove('active');
                    }
                });
            }

            // Initial load
            showContent('patientRecordContent'); // or any other content type to default on load
        });


    </script>
</body>

</html>