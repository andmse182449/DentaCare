<%-- 
    Document   : denWeb-dentitstSchedule
    Created on : May 27, 2024, 11:52:16 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dentist</title>
        <link rel="stylesheet" href="css/styleDen.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <div class="hero">
            <!-- MENU -->
            <nav>
                <span class="logo">Dentist</span>
                <ul>
                    <li><a href="denWeb-dentitstSchedule.jsp">My Schedule</a></li>
                    <li><a href="#">My Patients</a></li>
                </ul>
                <span class="material-symbols-outlined" onclick="toggleMenu()">account_circle</span>
                <div class="sub-menu-wrap" id="sub-menu-wrap">
                    <div class="sub-menu">
                        <div class="user-info">
                            <h3>Hugo</h3>
                        </div>
                        <hr>
                        <a href="denWeb-dentistProfile.jsp" class="sub-menu-link">
                            <span class="material-symbols-outlined">person</span>
                            <p>Profile</p>
                            <i class="fa fa-chevron-right"></i>
                        </a>
                        <a href="SignOutServlet" class="sub-menu-link">
                            <span class="material-symbols-outlined">logout</span>
                            <p>Logout</p>
                            <i class="fa fa-chevron-right"></i>
                        </a>
                    </div>
                </div>
            </nav>
        </div>
        <script>
            let subMenu = document.getElementById("sub-menu-wrap");
            function toggleMenu() {
                subMenu.classList.toggle("open-menu");
            }
        </script>
    </body>
</html>
