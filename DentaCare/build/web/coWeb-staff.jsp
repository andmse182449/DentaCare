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

                        <div id="form-dentist">
                            <form id="dentistForm" action="CreateStaffServlet" method="post">
                                <label for="sta-username">Username</label>
                                <input type="text" id="den-username" name="sta-username" required />
                
                                <label for="sta-password">Password</label>
                                <input type="password" id="den-password" name="sta-password" required />
                
                                <label for="sta-email">Email</label>
                                <input type="email" id="den-email" name="sta-email" required />
                
                                <label for="sta-fullName">Full Name</label>
                                <input type="text" id="den-fullName" name="sta-fullName" required />
                
                                <label for="sta-phone">Phone</label>
                                <input type="text" id="den-phone" name="sta-phone" required />  
                                
                                <label for="sta-address">Address</label>
                                <input type="text" id="den-address" name="sta-address" required /> 
                                
                                <label></label>
                                <input type="submit" value="Submit" />
                            </form>
                        </div>
                        ${requestScope.error}
            </div>
        </div>
<!--            <script>
                document.addEventListener('DOMContentLoaded', (event) => {
                    const createButton = document.getElementById('createButton');
                    const formDentist = document.getElementById('form-dentist');
                    const dentistForm = document.getElementById('dentistForm');

                    createButton.addEventListener('click', () => {
                        formDentist.style.display = 'block';
                    });

                    dentistForm.addEventListener('submit', (event) => {
                        event.preventDefault(); // Prevent actual form submission for demonstration
                        formDentist.style.display = 'none';
                    });
                });
            </script>-->
    </body>
</html>
