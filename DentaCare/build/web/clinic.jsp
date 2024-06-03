
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modify Movie</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f9f9f9;
                text-align: center
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .table-container {
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            th, td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }

            .form-container {
                text-align: center;
                margin-top: 20px;
            }

            .button-container {
                margin-top: 10px;
            }
            .search-form {
                text-align: center;
                margin-top: 20px;
            }

            .search-form input[type="text"] {
                width: 50%;
                padding: 10px;
                margin-bottom: 10px;
                box-sizing: border-box;
            }

            .search-form input[type="submit"] {
                padding: 10px 20px;
                background-color: #1aafff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .search-form input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .movie-add {
                text-align: center;
                margin-top: 20px;
            }

            .movie-add input[type="text"],
            .movie-add input[type="number"],
            .movie-add input[type="file"] {
                width: 50%;
                padding: 10px;
                margin-bottom: 10px;
                box-sizing: border-box;
            }

            .check-button {
                text-align: center;
            }

            .check-button input[type="submit"],
            .check-button input[type="button"] {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
            }

            .check-button input[type="submit"]:hover,
            .check-button input[type="button"]:hover {
                background-color: #0056b3;
            }

            .check-button a {
                text-decoration: none;
            }

            .check-button a input[type="button"] {
                background-color: #dc3545;
            }

            .check-button a input[type="button"]:hover {
                background-color: #c82333;
            }
            .form-container h1 {
                font-size: 35px;
                color: #333;
                margin-bottom: 20px;
                text-align: center;
            }
            .error-message {
                font-weight: bold;
                color: red;
                text-align: center;
            }

            .success-message {
                font-weight: bold;
                color: green;
                text-align: center;
            }
            .check-button {
                text-align: center;
            }

            .check-button input[type="submit"],
            .check-button input[type="button"] {
                padding: 10px 20px;
                background-color: red;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
            }

            .check-button input[type="submit"]:hover,
            .check-button input[type="button"]:hover {
                background-color: #0056b3;
            }

            .check-button a {
                text-decoration: none;
            }

            .check-button a input[type="button"] {
                background-color: #dc3545;
            }

            .check-button a input[type="button"]:hover {
                background-color: #c82333;
            }
            #sanpham3 {
                display: flex;
                flex-wrap: wrap; /* Wrap the clinic cards to form a grid */
                gap: 20px; /* Space between each clinic card */
            }

            .clinic-link {
                text-decoration: none; /* Remove underline from links */
                color: inherit; /* Inherit text color */
            }

            .clinic-card {
                width: 250px; /* Fixed width to ensure square shape */
                height: 250px; /* Fixed height to ensure square shape */
                border: 1px solid #ddd; /* Add a border around each card */
                padding: 10px; /* Add padding inside each card */
                border-radius: 8px; /* Optional: rounded corners for each card */
                background-color: #f9f9f9; /* Optional: background color for each card */
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Optional: subtle shadow for a card */
                display: flex;
                flex-direction: column;
                justify-content: space-between; /* Distribute space evenly */
                align-items: center; /* Center align the contents */
                text-align: center; /* Center align the text */
                transition: transform 0.2s; /* Optional: smooth hover effect */
            }

            .clinic-card:hover {
                transform: scale(1.05); /* Optional: scale up on hover */
            }

            .clinic-card img {
                width: 100px; /* Fixed width for the image */
                height: 100px; /* Fixed height for the image */
                object-fit: cover; /* Ensure image fits within the square */
                margin-bottom: 10px; /* Space between the image and the text */
            }

            .clinic-card .first-line {
                font-weight: bold; /* Make the first line bold */
                margin-bottom: 5px; /* Space between the first line and the following text */
            }

            /* Optional: additional styling for other text elements */
            .clinic-card p {
                margin: 5px 0; /* Space between each paragraph */
                font-size: 14px; /* Adjust font size */
            }
        </style>
    </head>
    <body>
        <h1>Clinic List</h1>
        <div class="col-md-4">
            
            <div id="sanpham3">
                <c:forEach items="${requestScope.clinicList}" var="clinicList">
                    <div class="clinic-card" data-url="LoadFromClinicToScheduleServlet?year=2024&week=8&clinicByID=${clinicList.clinicID}">    
                        <!--sua lai khuc nay-->
                        <img src="images/combo03.PNG" class="img-responsive" />
                        <p class="first-line">${clinicList.clinicID}</p>
                        <p>${clinicList.clinicName}</p>
                        <p>${clinicList.clinicAddress}</p>
                        <p>${clinicList.city}</p>
                        <p>${clinicList.hotline}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>

</html>

<script>
    document.addEventListener('DOMContentLoaded', (event) => {
        const clinicCards = document.querySelectorAll('.clinic-card');

        clinicCards.forEach(card => {
            card.addEventListener('click', () => {
                const url = card.getAttribute('data-url');
                window.location.href = url;
            });
        });
    });
</script>
