<%@page import="booking.BookingDAO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <style>

            .form-group {
                display: flex;
                margin-bottom: 15px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                padding: 10px;
                width: 15%;
            }

            input[type="number"], input[type="text"], input[type="email"] {
                width: 100px;
                padding-left: 10px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 4px;
                
            }

            button[type="submit"] {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 12px 20px;
                font-size: 16px;
                border-radius: 4px;
                cursor: pointer;
            }

            button[type="submit"]:hover {
                background-color: #0056b3;
            }

        </style>
    </head>
    <body>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header" style="">
                <div><h1 style="font-weight: bolder;">SETTINGS</h1></div>
                <div class="header-icon">
                    <span class="material-symbols-outlined" style="font-size: 32px;" onclick="toggleDropdown()">account_circle</span>
                    <!-- Dropdown Content -->
                    <div class="sub-menu-wrap" id="sub-menu-wrap">
                        <div class="sub-menu">
                            <div class="user-info">
                                <h3>${sessionScope.account.userName}</h3>
                            </div>
                            <hr>
                            <a href="SignOutServlet" class="sub-menu-link">
                                <span class="material-symbols-outlined">logout</span>
                                <p>Logout</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>
                    <script>
                        let subMenu = document.getElementById("sub-menu-wrap");
                        function toggleDropdown() {
                            subMenu.classList.toggle("open-menu");
                        }
                    </script>
                </div>
            </header>
            <!-- SIDEBAR -->
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="coWeb-dashboard.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">monitoring</span> <div>Dashboard</div></li></a>
                        <a href="coWeb-dentist.jsp"><li class="sidebar-list-item "><span class="material-symbols-outlined">groups_2</span><div>Manage Dentist</div></li></a>
                        <a href="ManageStaffServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                        <a href="ServiceController"><li class="sidebar-list-item"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                        <a href="ManageCustomerServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">group</span><div>Manage Customer</div></li></a>
                        <a href="coWeb-setting.jsp"><li class="sidebar-list-item sidebar-list-item-selected"><span class="material-symbols-outlined">settings  </span><div>Settings</div></li></a>
                    </ul>
                </div>
            </aside>
            <!-- MAIN -->
            <div class="main-container">
                <%
                    BookingDAO bk = new BookingDAO();
                    double percent = bk.getDepositPercent();
                    int limit = bk.limitBooking();
                %>
                <h1>Settings Management</h1>
                <form id="settings-form">
                    <div class="form-group">
                        <label for="deposit-percent">Deposit Percent</label>
                        <input type="number" id="deposit-percent" name="deposit-percent" min="0" max="100" value = "<%= percent %>" required>
                    </div>
                    <div class="form-group">
                        <label for="limit-booking">Limit Booking</label>
                        <input type="number" id="limit-booking" name="limit-booking" min="1" value="<%= limit%>" required>
                    </div>
                    <button type="submit">Save Settings</button>
                </form>
            </div>
        </div>
        <script>


            let subMenu = document.getElementById("sub-menu-wrap");
            function toggleDropdown() {
                subMenu.classList.toggle("open-menu");
            }

        </script>
    </body>
</html>
