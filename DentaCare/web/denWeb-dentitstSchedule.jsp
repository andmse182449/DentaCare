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
        <div class="header">
            <nav class="menu">
                <span class="logo">logo</span>
                <ul>
                    <li>
                        <a href="#">my schedule</a>
                    </li>
                    <li>
                        <a href="#">my patient</a>
                    </li>
                </ul>
                <spadn class="material-symbols-outlined" onclick="toggleMenu()">account_circle
                    </span>
                    <div class="sub-menu-wrap" id="sub-menu-wrap">
                    <div class="sub-menu">
                        <div class="user-info">
                            <h3>${sessionScope.account.userName}</h3>
                        </div>
                        <hr>
                        <form action="DentistServlet" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="profile">
                            <input type="hidden" name="accountID" value="${sessionScope.account.accountID}">
                            <button type="submit" class="sub-menu-link" style="border: none; background: none; padding: 0; margin: 0; display: flex; align-items: center; justify-content: space-between; width: 100%; cursor: pointer;">
                                <div style="display: flex; align-items: center;">
                                    <span class="material-symbols-outlined">person</span>
                                    <p>Profile</p>
                                </div>
                                <i class="fa fa-chevron-right"></i>
                            </button>
                        </form>
                        <a href="SignOutServlet" class="sub-menu-link">
                            <span class="material-symbols-outlined">logout</span>
                            <p>Sign out</p>
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
