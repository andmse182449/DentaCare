<%-- 
    Document   : denWeb-addDenToSchedule
    Created on : May 27, 2024, 9:46:58 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
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
        <c:set var="clinicID" value="${clinicByID.clinicID}" />
        <c:set var="clinicScheduleID" value="${getByCliScheID.clinicScheduleID}" />


        <form action="AddDentistToScheduleServlet?clinicSchedule=${clinicScheduleID}&clinicByID=${clinicID}" method="post">
            <h1>Add Dentist Schedule</h1>
            <input readonly required="true" type="text" name="clinicScheduleID" value="${clinicScheduleID}"><br>
            Den list
            <select name="accountID">
                <c:forEach items="${requestScope.denList}" var="den">
                    <option value="${den.accountID}">${den.fullName}</option>
                </c:forEach>
            </select>

            <div class="check-button">
                <a href="LoadFromClinicScheduleToDentistScheduleServlet?clinicSchedule=${clinicScheduleID}&clinicByID=${clinicID}" 
                   style="background-color: red; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; font-size: 16px; display: inline-block; text-align: center;">
                    Return
                </a>                <input type="submit" value="Create">
            </div>
            <c:set value="${requestScope.alreadyHave}" var="alreadyHave"/>
            <c:set value="${requestScope.successfully}" var="successfully"/>
            <% String alreadyHave = (String) request.getAttribute("alreadyHave");
                if (alreadyHave != null) {
            %>
            <p style="font-weight: bold; color: red" class="error-message">${alreadyHave}</p>
            <%
                }
            %>

            <%
                Boolean addDenToSche = (Boolean) request.getAttribute("addDenToSche");
                if (Boolean.TRUE.equals(addDenToSche)) {
            %>
            <p style="font-weight: bold; color: green">Create New Schedule Successfully!</p>
            <%
                }
            %>
        </form>

        <form action="ModifyDentistScheduleServlet?clinicSchedule=${clinicScheduleID}&clinicByID=${clinicID}" method="post">
            <h1>Modify Dentist Schedule</h1>
            <input readonly required="true" type="text" name="clinicScheduleID" value="${clinicScheduleID}"><br>
            Change this dentist:
            <select name="accountID">
                <c:forEach items="${requestScope.denList}" var="den">
                    <option value="${den.accountID}">${den.fullName}</option>
                </c:forEach>
            </select>
            To this dentist:
            <select name="accountID2">
                <c:forEach items="${requestScope.denList}" var="den">
                    <option value="${den.accountID}">${den.fullName}</option>
                </c:forEach>
            </select>


            <div class="check-button">
                <a href="LoadFromClinicScheduleToDentistScheduleServlet?clinicSchedule=${clinicScheduleID}&clinicByID=${clinicID}" 
                   style="background-color: red; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; font-size: 16px; display: inline-block; text-align: center;">
                    Return
                </a>                <input type="submit" value="Create">
            </div>
            <c:set value="${requestScope.notExist}" var="notExist"/>
            <c:set value="${requestScope.modifyDentistSchedule}" var="modifyDentistSchedule"/>
            <% String notExist = (String) request.getAttribute("notExist");
                if (notExist != null) {
            %>
            <p style="font-weight: bold; color: red" class="error-message">${notExist}</p>
            <%
                }
            %>

            <%
                Boolean modifyDentistSchedule = (Boolean) request.getAttribute("modifyDentistSchedule");
                if (Boolean.TRUE.equals(modifyDentistSchedule)) {
            %>
            <p style="font-weight: bold; color: green">Modify New Schedule Successfully!</p>
            <%
                }
            %>
        </form>
    </div>
</body>
</html>
