<%-- 
    Document   : coWeb-dentist
    Created on : May 24, 2024, 6:43:11 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <link rel="stylesheet" href="css/stylesheet.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>
    <body>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header">
                <div></div>
                <div class="header-icon">
                    <span class="material-symbols-outlined">notifications</span>
                    <span class="material-symbols-outlined">mail</span>
                    <span class="material-symbols-outlined">account_circle</span>
                </div>
            </header>
            <!-- SIDEBAR -->
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="coWeb-dashboard.jsp">
                            <li class="sidebar-list-item">Dashboard</li>
                        </a>
                        <a href="coWeb-dentist.jsp">
                            <li class="sidebar-list-item">Manage Dentist</li>
                        </a>
                        <a href="coWeb-staff.jsp">
                            <li class="sidebar-list-item">Manage Staff</li>
                        </a>
                        <a href="coWeb-clinic.jsp">
                            <li class="sidebar-list-item">Manage Clinic</li>
                        </a>
                    </ul>
                </div>
            </aside>
            <!-- MAIN -->
            <div class="main-container">
                <div class="alert-error sec">${error}</div>
                <div class="alert-message sec">${message}</div>
                <div class="main-header">
                    <h2>DENTIST</h2>
                    <button id="create-button" class="create-button">Create Dentist Account</button>
                </div>
                <!-- FORM POPUP-->
                <div class="popup" id="popup-form">
                    <div class="close-btn" id="close-btn">&times;</div>
                    <div class="form">
                        <h2>CREATE A DENTIST ACCOUNT</h2>
                        <form action="DentistServlet" method="post">
                            <div class="form-element">
                                <label for="username">Username</label>
                                <input type="text" name="den-username" required>
                            </div>
                            <div class="form-element">
                                <label for="password">Password</label>
                                <input type="password" name="den-password" value="abc" required readonly>
                            </div>
                            <div class="form-element">
                                <label for="email">Email</label>
                                <input type="email" name="den-email" required>
                            </div>
                            <div class="form-element">
                                <label for="fullname">Full name</label>
                                <input type="text" name="den-fullName" required>
                            </div>
                            <div class="form-element">
                                <label for="phone">Phone</label>
                                <input type="text" name="den-phone" required>
                            </div>
                            <div class="form-element">
                                <label for="address">Address</label>
                                <input type="text" name="den-address" required>
                            </div>
                            <input type="hidden" name="action" value="create"/>
                            <div class="form-element">
                                <input type="submit" value="Submit">
                            </div>
                        </form>
                    </div>
                </div>
                <!-- END POPUP -->
                ABC XYZ
            </div>
        </div>

        <script>
            document.querySelector("#create-button").addEventListener("click", function () {
                document.querySelector(".popup").classList.add("active");
            });

            document.querySelector(".popup .close-btn").addEventListener("click", function () {
                document.querySelector(".popup").classList.remove("active");
            });
            
            document.addEventListener("DOMContentLoaded", function () {
                const alertBox = document.querySelector(".alert-error.sec");
                if (alertBox && alertBox.textContent.trim()) {
                    alertBox.style.display = "block"; // Show the alert if there's an error message
                    alertBox.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                    setTimeout(function () {
                        alertBox.classList.remove("show");
                        setTimeout(function () {
                            alertBox.style.display = "none"; // Hide the alert after the fade-out animation
                        }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                    }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                }
            });
            
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
    </body>
</html>
