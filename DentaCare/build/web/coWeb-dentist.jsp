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
                <div class="main-header">
                    <h2>DENTIST</h2>
                    <button id="create-button" class="create-button">Create Dentist Account</button>
                </div>
                <!-- FORM POPUP-->
                <div class="popup" id="popup-form">
                    <div class="close-btn" id="close-btn">&times;</div>
                    <div class="form">
                        <h2>CREATE A DENTIST ACCOUNT</h2>
                        <form action="your-action-url" method="post">
                            <div class="form-element">
                                <label for="username">Username</label>
                                <input type="text" name="username" required>
                            </div>
                            <div class="form-element">
                                <label for="password">Password</label>
                                <input type="password" name="password" required>
                            </div>
                            <div class="form-element">
                                <label for="email">Email</label>
                                <input type="email" name="email" required>
                            </div>
                            <div class="form-element">
                                <label for="fullname">Full name</label>
                                <input type="text" name="fullName" required>
                            </div>
                            <div class="form-element">
                                <label for="phone">Phone</label>
                                <input type="text" name="phone" required>
                            </div>
                            <div class="form-element">
                                <label for="address">Address</label>
                                <input type="text" name="address" required>
                            </div>
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

        <script src="js/script.js">
        </script>
    </body>
</html>
