<%-- 
    Document   : staffWeb-ChangePassword
    Created on : Jun 27, 2024, 12:36:32 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate, java.time.temporal.WeekFields, java.util.Locale" %>
<%@page import="account.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Staff</title>
        <link href="admin-front-end/css/styleProfileStaff.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <%
            LocalDate now2 = LocalDate.now();
            WeekFields weekFields = WeekFields.of(Locale.getDefault());
            int currentYear2 = now2.getYear();
            int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
            AccountDTO account = (AccountDTO) session.getAttribute("account");
            int clinicID = account.getClinicID();         
        %>
        <style>
            /* Pop-up styles */
            .pop-up-warning-change-password {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 400px;
                padding: 30px;
                background-color: #fff;
                border: 2px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
                z-index: 1001; /* Higher z-index to appear above the overlay */
                text-align: center;
            }

            .pop-up-warning-change-password p {
                margin-bottom: 20px;
                font-size: 18px;
                font-weight: bold;
                color: #333;
            }

            .pop-up-warning-change-password input[type="submit"] {
                display: block;
                margin: 0 auto;
                padding: 10px 20px;
                font-size: 16px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .pop-up-warning-change-password input[type="submit"]:hover {
                background-color: #0056b3;
            }

            /* Overlay styles */
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
                z-index: 1000; /* Lower z-index to be behind the pop-up */
            }
        </style>
    </head>
    <body>
        <div class="container rounded bg-white mt-5 mb-5">
        <div><a class="back-link" href="LoadScheduleForEachDentistServlet?action=loadDenSchedule&clinicByID=<%=clinicID%>&year=<%=currentYear2%>&week=<%=currentWeek2%>">Back</a></div>
            <div class="row">
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <img class="rounded-circle mt-5" width="150px" src="images/${account.image}">
                        <span class="font-weight-bold">${account.fullName}</span>
                        <span class="text-black-50">${account.email}</span>
                        <span> </span>
                    </div>
                </div>
                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Password Settings</h4>
                        </div>
                        <div>
                            <form id="profileForm" action="./ProfileStaffServlet" method="post">
                                <div class="row mt-3">
                                    <input type="hidden" value="${account.accountID}" name="accountId" />
                                    <div class="col-md-12"><label class="labels">UserName</label><input type="text" class="form-control" placeholder="Username" name="username" value="${account.userName}" required readonly></div>
                                    <div class="col-md-12"><label class="labels">Your Current Password</label><input type="password" class="form-control" placeholder="Current Password" name="oldPassword" required></div>
                                    <div class="col-md-12"><label class="labels">New Password</label><input type="password" class="form-control" placeholder="New Password" name="newPassword1" required></div>
                                    <div class="col-md-12"><label class="labels">Confirm New Password</label><input type="password" class="form-control" placeholder="Confirm New Password" name="newPassword2" required></div>
                                    <input type="hidden" value="updatePassword" name="action" />
                                </div>
                                <input type="submit" class="btn btn-primary mt-3" value="Change Password" />
                            </form>
                        </div>

                        <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger mt-3"  role="alert">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                        <div id="pop-up-warning-change-password" class="pop-up-warning-change-password">
                            <form action="./SignOutServlet" method="post">
                                <p>Password updated successfully.</p>
                                <p>Please log in again.</p>
                                <input type="submit" class="btn btn-primary" value="Accept" />
                            </form>
                        </div>

                        <div id="overlay" class="overlay"></div> <!-- Overlay -->
                    </div>
                </div>
            </div>
        </div>

        <script>
            <% if ("Update Password Successfully".equals(request.getAttribute("error"))) { %>
            document.getElementById("pop-up-warning-change-password").style.display = "block";
            document.getElementById("overlay").style.display = "block"; /* Show overlay */
            <% } %>
        </script>
    </body>
</html>
