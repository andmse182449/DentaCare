<%@include file="/headerLog.jsp" %>
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
        <div class="container user">
            <nav class="navbar user">
                <ul>
                    <li><a href="#" id="userProfileLink" class="active">User Profile</a></li>
                    <li><a href="ExamScheduleServlet">Examination Schedule</a></li>
                    <li><a href="HistoryServlet" id="bookingHistoryLink">Booking History</a></li>
                    <li><a href="SignOutServlet" >Sign out</a></li>
                </ul>
            </nav>
            <c:set var="account" value="${sessionScope.account}"/>
            <div class="content active" id="userProfileContent">
                <div class="profile">
                    <div class="inf">
                        <h5>User Information</h5>
                        <label for="accountID">Full Name: <b>${account.getFullName()}</b></label>
                        <br>
                        <!--                    <input type="text" id="accountID" name="accountID"><br><br>-->

                        <label for="phone">Phone: <b>${account.getPhone()}</b></label>
                        <!--                    <input type="tel" id="phone" name="phone"><br><br>-->
                        <br>
                        <label for="dob">Date of Birth: <b>${account.getDob()}</b></label>
                        <!--                    <input type="date" id="dob" name="dob"><br><br>-->
                        <br>
                        <label for="email">Email: <b>${account.getEmail()}</b></label>
                        <br>
                        <!--                    <input type="email" id="email" name="email"><br><br>-->
                        <label for="gender">Gender: 
                            <c:choose>
                                <c:when test="${account.isGender() == 'true'}">
                                    <b>Male</b>
                                </c:when>
                                <c:otherwise>
                                    <b>Female</b>
                                </c:otherwise>
                            </c:choose>
                        </label><br><br>
                        <!--                    <select id="gender" name="gender">
                                                <option value="true">Male</option>
                                                <option value="false">Female</option>F
                                            </select>-->
                    </div>
                    <div class="reset">
                        <h5>Change Password </h5>
                        <label for="password">Current Password:</label><br>
                        <input type="password" id="password" name="currentPassword"><br><br>
                        <label for="password">New Password:</label><br>
                        <input type="password" id="password" name="newPassword"><br><br>
                    </div>

                </div>
            </div>
    </body>

</html>