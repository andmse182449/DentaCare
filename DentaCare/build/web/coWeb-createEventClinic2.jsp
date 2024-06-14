<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Clinic Schedule</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .form-container {
                width: 50%;
                margin: 50px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }
            h1 {
                text-align: center;
                color: #333;
            }
            .form-container input[type="date"],
            .form-container input[type="text"],
            .form-container select {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }
            .form-container input[readonly] {
                background-color: #e9e9e9;
            }
            .form-container .check-button {
                text-align: center;
                margin-top: 20px;
            }
            .form-container .check-button input[type="submit"],
            .form-container .check-button input[type="button"] {
                text-decoration: none;
                display: inline-block;
                padding: 10px 20px;
                margin: 5px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }
            .form-container .check-button input[type="submit"]:hover,
            .form-container .check-button input[type="button"]:hover {
                background-color: #0056b3;
            }
            .form-container p {
                text-align: center;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <c:set var="clinicByID" value="${requestScope.clinicByID}" />
            <c:set var="getByCliScheID" value="${requestScope.getByCliScheID}" />

            <form action="CreateEventClinicScheduleServlet2?clinicByID=${clinicByID.clinicID}" method="post">
                <h1>Create new event</h1>
<!--                <input readonly required="true" type="text" name="clinicScheduleID" value="${getByCliScheID.clinicScheduleID}"><br>-->
                
                <input required="true" type="date" name="workingDay" placeholder="" ><br>
                
                <input required="true" type="text" name="description" placeholder="Name of event" ><br>

                <div class="check-button">
                    <a href="LoadFromClinicToScheduleServlet?clinicByID=${clinicByID.clinicID}"><input type="button" value="Return"></a>
                    <input type="submit" value="Create">
                </div>
                <c:set value="${requestScope.eventAlready}" var="eventAlready" />
                <% String eventAlready = (String) request.getAttribute("eventAlready");
                    if (eventAlready != null) {
                %>
                <p style="font-weight: bold; color: red" class="error-message">${eventAlready}</p>
                <%
                    }
                %>

                <%
                    Boolean createEventClinicSchedule = (Boolean) request.getAttribute("createEventClinicSchedule");
                    if (Boolean.TRUE.equals(createEventClinicSchedule)) {
                %>
                <p style="font-weight: bold; color: green">Create New Event Successfully!</p>
                <%
                    }
                %>
            </form>
        </div>
    </body>
</html>