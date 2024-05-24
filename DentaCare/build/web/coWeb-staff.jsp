<%-- 
    Document   : coWeb-staff
    Created on : May 23, 2024, 2:24:09 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
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
                        <a href="coWeb-dashboard.jsp"><li class="sidebar-list-item">Dashboard</li></a>
                        <a href="coWeb-dentist.jsp"><li class="sidebar-list-item">Manage Dentist</li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item">Manage Staff</li></a>
                        <a href="coWeb-clinic.jsp"><li class="sidebar-list-item">Manage Clinic</li></a>
                    </ul>
                </div>
            </aside>

            <!-- MAIN -->
            <div class="main-container">
                <div class="main-header">
                    <h2>Staff</h2>
                    <button id="createButton" class="create-button">Create Dentist Account</button>
                </div>

                <div class="popup">
                    <div class="close-btn">&times;</div>
                    <div class="form">
                        <h2>CREATE A DENTIST ACCOUNT</h2>
                        <form action="">
                            <div class="form-element">
                                <label for="username">Username</label>
                                <input type="text" name="sta-username" required>
                            </div>
                            <div class="form-element">
                                <label for="password">Password</label>
                                <input type="password" name="sta-password" required>
                            </div>
                            <div class="form-element">
                                <label for="email">Email</label>
                                <input type="email" name="sta-email" required>
                            </div>
                            <div class="form-element">
                                <label for="fullname">Full name</label>
                                <input type="text" name="sta-fullName" required>
                            </div>
                            <div class="form-element">
                                <label for="phone">Phone</label>
                                <input type="text" name="sta-phone" required>
                            </div>
                            <div class="form-element">
                                <label for="address">Address</label>
                                <input type="text" name="sta-address" required>
                            </div>
                            <div class="form-element">
                                <input type="submit" value="Submit">
                            </div>
                        </form>
                    </div>
                </div>
                        ${requestScope.error}
            </div>
        </div>
    </body>
</html>
