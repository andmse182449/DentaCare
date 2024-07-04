<%-- 
    Document   : addNewClinicSchedule
    Created on : May 22, 2024, 11:10:26 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
            .form-container .check-button input[type="button"]{
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
            .form-container .check-button a:hover,
            .form-container .check-button input[type="submit"]:hover {
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

            <form action="AddClinicScheduleServlet?clinicByID=${clinicByID.clinicID}" method="post">
                <h1>Create New Schedule</h1>
                <input required="true" type="date" name="workingDay" placeholder="Working Day"><br>
                <input readonly type="text" name="clinicID" placeholder="Clinic ID" value="${clinicByID.clinicID}"><br>
                DESCRIPTION 
                <select name="description">
                    <option value="di lam">đi làm</option>
                    <option value="nghi le">nghỉ lễ</option>
                </select>
                <div class="check-button">
                    <a href="LoadFromClinicToScheduleServlet?clinicByID=${clinicByID.clinicID}"><input type="button" value="Return"></a>
                    <input type="submit" value="Create">
                </div>
                <c:set value="${requestScope.alreadyHave}" var="existingSchedule"/>
                <% String existingSchedule = (String) request.getAttribute("alreadyHave");
                    if (existingSchedule != null) {
                %>
                <p style="font-weight: bold; color: red" class="error-message">${existingSchedule}</p>
                <%
                    }
                %>
                
                <%
                    Boolean addClinicSchedule = (Boolean) request.getAttribute("addClinicSchedule");
                    if (Boolean.TRUE.equals(addClinicSchedule)) {
                %>
                <p style="font-weight: bold; color: green">Create New Schedule Successfully!</p>
                <%
                    }
                %>
            </form>
        </div>
    </body>
</html>
