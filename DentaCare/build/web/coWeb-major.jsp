<%-- 
    Document   : coWeb-major
    Created on : Jun 23, 2024, 8:37:59 PM
    Author     : ROG STRIX
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.temporal.WeekFields" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <link rel="stylesheet" href="css/stylesheet.css">
        <link rel="stylesheet" href="css/dashboard.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link rel="stylesheet" href="css/denSpec.css">
    </head>
    <style>
        .find-section {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            margin: 0;
            padding: 20px 40px;
            justify-content: center;
            /* Added padding to the left and right */
        }

        .left-container {
            width: 15%;
            margin-right: 20px;
        }

        .search-container {
            margin-bottom: 0;
        }

        #searchBar {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px 4px 0 0;
            transition: border-color 0.3s;
        }

        #searchBar:hover,
        #searchBar:focus {
            border-color: #2f89fc;
            outline: none;
        }

        .scroll-section {
            width: 100%;
            height: 300px;
            overflow-y: scroll;
            border: 1px solid #ccc;
            border-top: none;
            padding: 10px;
            border-radius: 0 0 4px 4px;
        }

        .scroll-item {
            display: flex;
            align-items: center;
            margin: 5px 0;
            padding: 10px;
            background-color: #f0f0f0;
            cursor: pointer;
        }

        .scroll-item:hover {
            background-color: #e0e0e0;
        }

        .circle {
            width: 16px;
            height: 16px;
            border-radius: 50%;
            border: 2px solid #ccc;
            margin-right: 10px;
            position: relative;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .circle.active {
            background-color: white;
            border-color: #2f89fc;
        }

        .circle.active::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 8px;
            height: 8px;
            background-color: #2f89fc;
            border-radius: 50%;
            transform: translate(-50%, -50%);
        }

        .right-container {
            width: 52%;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 10px;
        }

        .results-header {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .results {
            list-style: none;
            padding: 0;
        }

        .result-item {
            padding: 5px 0;
        }

        .booking-section {
            margin-top: 20px;
        }

        .booking-section input[type="text"],
        .serviceBtn {
            display: block;
            width: 20%;
            margin-bottom: 10px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .serviceBtn {
            margin: 0 auto;
            background-color: #2f89fc;
            color: white;
            cursor: pointer;
        }

        .serviceBtn:hover {
            background-color: #1e77e0;
        }
    </style>
    <body>
        <c:set var="majors"  value="${requestScope.MAJOR}"/>
        <c:set var="services"  value="${requestScope.SERVICE}"/>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header">
                <div><h1>DASHBOARD</h1></div>
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
                </div>
            </header>
            <!-- SIDEBAR -->
            <%
                LocalDate now2 = LocalDate.now();
                WeekFields weekFields = WeekFields.of(Locale.getDefault());
                int currentYear2 = now2.getYear();
                int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
                int currentMonth2 = now2.getMonthValue(); // Get current month number
            %>
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="DashBoardServlet?action=dashboardAction&year1=<%=currentYear2%>&year2=<%=currentYear2%>&month=<%=currentMonth2%>"><li class="sidebar-list-item"><span class="material-symbols-outlined">monitoring</span> <div>Dashboard</div></li></a>
                        <a href="ForDentistInfo?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Dentist</div></li></a>
                        <a href="#"><li class="sidebar-list-item sidebar-list-item-selected"><span class="material-symbols-outlined">groups_2</span><div>Manage Major</div></li></a>
                        <a href="ManageStaffServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                        <a href="ServiceController"><li class="sidebar-list-item"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                        <a href="ManageCustomerServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">group</span><div>Manage Customer</div></li></a>
                        <a href="coWeb-setting.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">settings</span><div>Setting</div></li></a>

                    </ul>
                </div>
            </aside>
            <div class="d-flex" id="wrapper">
                <div class="find-section">

                    <div class="left-container">
                        <div class="search-container">
                            <input type="text" id="searchBar" placeholder="Search a speciality">

                        </div>
                        <div class="scroll-section" id="scrollSection">
                            <c:forEach var="major" items="${majors}">
                                <div class="scroll-item">
                                    <div class="circle"></div>
                                    <div class="majorName">${major.getMajorName()}</div>
                                </div>

                                <script>
                                    $(document).ready(function () {
                                        $('.scroll-item').on('click', function (event) {
                                            event.preventDefault();
                                            $('#tagContainer').empty();
                                            var majorName = $(this).text().trim(); // Get the text content of the clicked element


                                            $.ajax({
                                                type: 'POST',
                                                url: 'ViewDentistServlet',
                                                contentType: 'application/json',
                                                data: JSON.stringify({majorName: majorName}),
                                                success: function (response) {
                                                    console.log('Received response:', response); // Log the response data

                                                    // Clear previous results
                                                    const resultsList = document.getElementById('resultsList');
                                                    resultsList.innerHTML = '';
                                                    const idList = document.getElementById('denIdList');
                                                    idList.innerHTML = '';
                                                    const btnList = document.getElementById('btnList');
                                                    btnList.innerHTML = '';
                                                    const selectElement = document.getElementById('tagSelect');
                                                    selectElement.innerHTML = '<option value="">Choose a dentist</option>'; // Clear previous results

                                                    // Check if the response contains the expected keys and values
                                                    if (response && response.success && Array.isArray(response.dentist)) {
                                                        response.dentist.forEach(dentist => {
                                                            // Validate each dentist object to ensure it has the expected property
                                                            if (dentist && dentist.accountFullName) {
                                                                const listItem = document.createElement('li');
                                                                listItem.textContent = dentist.accountFullName;
                                                                listItem.id = dentist.accountID;
                                                                listItem.style.marginBottom = '10px';
                                                                listItem.style.borderBottom = '1px solid #ccc';
                                                                const deleteButton = document.createElement('button');
                                                                deleteButton.textContent = 'Delete';
                                                                deleteButton.id = dentist.accountID;
                                                                deleteButton.style.marginBottom = '8px';
                                                                deleteButton.style.fontSize = 'revert';


                                                                const idItem = document.createElement('li');
                                                                idItem.textContent = dentist.accountID;
                                                                idItem.id = dentist.accountID;
                                                                idItem.style.marginBottom = '10px';
                                                                idItem.style.borderBottom = '1px solid #ccc';

                                                                dentist.listItem = listItem;
                                                                dentist.deleteButton = deleteButton;
                                                                dentist.idItem = idItem;

                                                                deleteButton.addEventListener('click', function () {
                                                                    swal({
                                                                        title: "Are you sure?",
//                                                                        text: "Once deleted, you will not be able to recover this dentist!",
                                                                        icon: "warning",
                                                                        buttons: true,
                                                                        dangerMode: true,
                                                                    })
                                                                            .then((willDelete) => {
                                                                                if (willDelete) {
                                                                                    removeListItemById(dentist.accountID);
                                                                                    // Log the dentist object for debugging

                                                                                    // Send the dentist data as JSON
                                                                                    $.ajax({
                                                                                        type: 'POST',
                                                                                        url: 'RemoveDentistMajorServlet', // Replace with the actual URL for deleting a dentist
                                                                                        contentType: 'application/json',
                                                                                        data: JSON.stringify({
                                                                                            dentistID: dentist.accountID,
                                                                                            majorName: majorName
                                                                                        }), // Convert the dentist object to a JSON string
                                                                                        success: function (response) {
                                                                                            response.Notdentist.forEach(notDentist => {
                                                                                                // Validate each notDentist object to ensure it has the expected property
                                                                                                if (notDentist && notDentist.accountFullName) {
                                                                                                    const option = document.createElement('option');
                                                                                                    option.id = notDentist.accountID;
                                                                                                    option.text = notDentist.accountFullName;
                                                                                                    selectElement.appendChild(option); // Assuming you have a separate select element for notDentist

                                                                                                } else {
                                                                                                    console.error('notDentist object:', notDentist);
                                                                                                }
                                                                                            });
                                                                                            swal("Dentist deleted successfully!", {
                                                                                                icon: "success",
                                                                                            });
                                                                                        },
                                                                                        error: function (xhr, status, error) {
                                                                                            console.error('Error deleting dentist:', error);
                                                                                            swal("Error deleting dentist!", {
                                                                                                icon: "error",
                                                                                            });
                                                                                        }
                                                                                    });
                                                                                }
                                                                            });
                                                                });




//                                                                listItem.appendChild(deleteButton);
                                                                resultsList.appendChild(listItem);
                                                                idList.appendChild(idItem)
                                                                btnList.appendChild(deleteButton)
                                                            } else {
                                                                console.error('Invalid dentist object:', dentist);
                                                            }
                                                        });
                                                        response.Notdentist.forEach(notDentist => {
                                                            // Validate each notDentist object to ensure it has the expected property
                                                            if (notDentist && notDentist.accountFullName) {
                                                                const option = document.createElement('option');
                                                                option.id = notDentist.accountID;
                                                                option.text = notDentist.accountFullName;
                                                                selectElement.appendChild(option); // Assuming you have a separate select element for notDentist
                                                            } else {
                                                                console.error('Invalid notDentist object:', notDentist);
                                                            }
                                                        });
                                                    } else {
                                                        console.error('Unexpected response format:', response);
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    console.error('Error sending major name:', error);
                                                }
                                            });
                                        });
                                        function removeListItemById(itemId) {
                                            // Find the list item element by its ID
                                            const listItem = document.getElementById(itemId);
                                            // Check if the element exists
                                            if (listItem) {
                                                // Remove the element from the DOM
                                                listItem.remove();
                                                // Remove the corresponding idItem and deleteButton elements
                                                const idItem = document.getElementById(itemId);
                                                idItem.remove();
                                                const deleteButton = document.getElementById(itemId);
                                                deleteButton.remove();
                                                console.log(`Element with id ${itemId} has been removed.`);
                                            } else {
                                                console.error(`Element with id ${itemId} not found.`);
                                            }
                                        }
                                        // Add active class to the clicked element
                                        $('.scroll-item').on('click', function () {
                                            $(this).siblings().find('.circle').removeClass('active');
                                            $(this).find('.circle').addClass('active');
                                        });
                                    });
                                </script>
                            </c:forEach>


                        </div>
                    </div>

                    <div class="right-container">
                        <div class="booking-section" id="serviceDetails">
                            <button id="openPopup">Add Dentist</button>
                            <div id="tagContainer"></div>
                            <div class="overlay-spec" id="overlay-spec"></div>
                            <div class="popup3" id="popup3">
                                <h2>Select a Tag</h2>
                                <select id="tagSelect">

                                </select>

                                <button id="addTag">Add</button>

                                <script>
                                    //                                    $(document).ready(function () {
                                    //                                        $('#addTag').on('click', function (event) {
                                    //                                            event.preventDefault();
                                    //                                            const tagSelect = document.getElementById('tagSelect'); // assuming this is the id of the select element
                                    //                                            const selectedOption = tagSelect.options[tagSelect.selectedIndex];
                                    //                                            const selectedTagId = selectedOption.id; // get the id from the selected option
                                    //
                                    //                                            const tagContainer = document.getElementById('tagContainer');
                                    //                                            const dentistName = $(tagContainer).find('div').first().text().trim();
                                    //
                                    //                                            const scrollItem = document.querySelector('.circle.active').closest('.scroll-item')
                                    //                                            const majorNameElement = scrollItem.querySelector('.majorName').textContent;
                                    //                                            console.log('Received response:', majorNameElement);
                                    ////                                            console.log('id', selectedOption);
                                    //
                                    //                                            $.ajax({
                                    //                                                type: 'POST',
                                    //                                                url: 'AddDentistMajorServlet',
                                    //                                                contentType: 'application/json',
                                    //                                                data: JSON.stringify({
                                    //                                                    majorName: majorNameElement,
                                    //                                                    tagId: selectedTagId // send the selected tag id in the request
                                    //                                                }),
                                    //                                                success: function (response) {
                                    //                                                    console.log('id', selectedTagId);
                                    //                                                    // Handle the response data here
                                    //                                                },
                                    //                                                error: function (xhr, status, error) {
                                    //                                                    console.error('Error sending dentist names:', error);
                                    //                                                }
                                    //                                            });
                                    //                                        });
                                    //                                    });
                                </script>
                                <button id="closePopup">Cancel</button>
                            </div>
                            <div style="display: flex;
                                 gap: 10rem;">
                                <div>
                                    <h3>Full Name</h3>
                                    <ul id="resultsList" class="results"></ul>
                                </div>
                                <div>
                                    <h3>Identifier Number</h3>
                                    <ul id="denIdList" class="results"></ul>
                                </div>
                                <div style="
                                     width: 100px;

                                     ">
                                    <h3 style="
                                        color: white;

                                        " >Func</h3>
                                    <ul id="btnList" class="results"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>
                        const searchBar = document.getElementById('searchBar');
                        const resultsCount = document.getElementById('resultsCount');
                        const resultsList = document.getElementById('resultsList');
                        searchBar.addEventListener('input', function () {
                            const filter = this.value.toLowerCase();
                            const items = document.querySelectorAll('.scroll-item');
                            let visibleCount = 0;
                            resultsList.innerHTML = '';
                            items.forEach(item => {
                                const text = item.textContent.toLowerCase();
                                if (text.includes(filter)) {
                                    item.style.display = '';
                                    visibleCount++;
                                    const listItem = document.createElement('li');
                                    listItem.textContent = item.textContent;
                                    listItem.className = 'result-item';
                                } else {
                                    item.style.display = 'none';
                                }
                            });
                            resultsCount.textContent = visibleCount;
                        });
                        document.querySelectorAll('.scroll-item').forEach(item => {
                            function selectFirstService() {
                                const firstServiceItem = document.querySelector('.scroll-item');
                                if (firstServiceItem) {
                                    firstServiceItem.click(); // Simulate a click on the first service item
                                }
                            }

                            // Call the function to select the first service item
                            selectFirstService();
                            item.addEventListener('click', function () {
                                document.querySelectorAll('.circle').forEach(circle => {
                                    circle.classList.remove('active');
                                });
                                this.querySelector('.circle').classList.add('active');
                                // Optionally, you can handle booking functionality here
                                // For example, by showing a modal or redirecting to a booking page

                                const selectedItemText = this.textContent.trim();
                                const currentUrl = new URL(window.location.href);
                                const selectedParam = currentUrl.searchParams.get('selected');
                                if (selectedParam) {
                                    // Remove the previous selection from the URL
                                    currentUrl.searchParams.delete('selected');
                                }

                                if (selectedItemText) {
                                    // Append the new selection to the URL without encoding spaces
                                    currentUrl.searchParams.append('selected', decodeURIComponent(selectedItemText));
                                }

                                const newUrl = currentUrl.toString();
                                window.history.pushState({}, '', newUrl);
                            });
                        });
                    </script>
                </div>
                <script>
                    const openPopupButton = document.getElementById('openPopup');
                    const closePopupButton = document.getElementById('closePopup');
                    const popup = document.getElementById('popup3');
                    const overlay = document.getElementById('overlay-spec');
                    const tagSelect = document.getElementById('tagSelect');
                    const addTagButton = document.getElementById('addTag');
                    const tagContainer = document.getElementById('tagContainer');
                    const idList = document.getElementById('denIdList');
                    const btnList = document.getElementById('btnList');
                    const addedTags = new Set();
                    function createTagElement(tag) {
                        const tagElement = document.createElement('div');
                        tagElement.className = 'tag';
                        tagElement.innerHTML = `\${tag}<button class="deleteBtn button"></button>`;
                        const deleteBtn = tagElement.querySelector('.deleteBtn');
                        deleteBtn.addEventListener('click', () => {
                            tagContainer.removeChild(tagElement);
                            addedTags.delete(tag);
                        });
                        return tagElement;
                    }

                    function openPopup() {
                        popup.style.display = 'block';
                        overlay.style.display = 'block';
                    }

                    function closePopup() {
                        popup.style.display = 'none';
                        overlay.style.display = 'none';
                        tagSelect.value = '';
                    }

                    openPopupButton.addEventListener('click', openPopup);
                    closePopupButton.addEventListener('click', closePopup);
                    overlay.addEventListener('click', closePopup);
                    //                    addTagButton.addEventListener('click', () => {
                    //                        const selectedOption = tagSelect.options[tagSelect.selectedIndex];
                    //                        const selectedTagId = selectedOption.id;
                    //                        const selectedTag = tagSelect.value;
                    //                        if (selectedTag && !addedTags.has(selectedTag)) {
                    //                            addedTags.add(selectedTag);
                    //                            const tagElement = createTagElement(selectedTag);
                    //                            tagElement.id = selectedTagId;
                    //                            tagContainer.appendChild(tagElement);
                    //                            closePopup();
                    //                        } else if (addedTags.has(selectedTag)) {
                    //                            alert('This tag has already been added!');
                    //                        }
                    //                    });

                    let tagElements = [];
                    addTagButton.addEventListener('click', () => {
                        const selectedOption = tagSelect.options[tagSelect.selectedIndex];
                        const selectedTagId = selectedOption.id;
                        const selectedTag = tagSelect.value;
                        const scrollItem = document.querySelector('.circle.active').closest('.scroll-item')
                        const majorNameElement = scrollItem.querySelector('.majorName').textContent;
                        if (selectedTag && !addedTags.has(selectedTag)) {
                            addedTags.add(selectedTag);
                            const tagElement = createTagElement(selectedTag);
                            tagElement.id = selectedTagId;
                            tagContainer.appendChild(tagElement);
                            tagElements.push(tagElement); // Store the tag element in the array

                            // Add the new tag to the resultsList
                            const newTagLi = document.createElement('li');
                            newTagLi.textContent = selectedTag;
                            newTagLi.id = `\${selectedTagId}`; // Add the id to the list item
                            newTagLi.style.borderBottom = '1px solid #ccc';

                            const idItem = document.createElement('li');
                            idItem.textContent = `\${selectedTagId}`;
                            idItem.id = `\${selectedTagId}`;
                            idItem.style.marginBottom = '10px';
                            idItem.style.borderBottom = '1px solid #ccc';


                            // Add a delete button to the list item
                            const deleteBtn = document.createElement('button');
                            deleteBtn.textContent = 'Delete';
                            deleteBtn.style.marginBottom = '8px';
                            deleteBtn.style.fontSize = 'revert';
                            deleteBtn.addEventListener('click', () => {
                                swal({
                                    title: "Are you sure?",

                                    icon: "warning",
                                    buttons: true,
                                    dangerMode: true,
                                })
                                        .then((willDelete) => {
                                            if (willDelete) {
                                                $.ajax({
                                                    type: 'POST',
                                                    url: 'RemoveDentistMajorServlet', // Replace with the actual URL for deleting a dentist
                                                    contentType: 'application/json',
                                                    data: JSON.stringify({
                                                        dentistID: selectedTagId,
                                                        majorName: majorNameElement
                                                    }), // Convert the dentist object to a JSON string
                                                    success: function (response) {
                                                        response.Notdentist.forEach(notDentist => {
                                                            // Validate each notDentist object to ensure it has the expected property
                                                            if (notDentist && notDentist.accountFullName) {
                                                                const option = document.createElement('option');
                                                                option.id = notDentist.accountID;
                                                                option.text = notDentist.accountFullName;
                                                                selectElement.appendChild(option); // Assuming you have a separate select element for notDentist

                                                            } else {
                                                                console.error('notDentist object:', notDentist);
                                                            }
                                                        });
                                                        swal("Dentist deleted successfully!", {
                                                            icon: "success",
                                                        });
                                                    },
                                                    error: function (xhr, status, error) {
                                                        console.error('Error deleting dentist:', error);
                                                        swal("Error deleting dentist!", {
                                                            icon: "error",
                                                        });
                                                    }
                                                });

                                                // Remove the tag from the tagContainer
                                                const tagToRemove = tagContainer.querySelector(`#\${selectedTagId}`);
                                                if (tagToRemove) {
                                                    tagContainer.removeChild(tagToRemove);
                                                }
                                                resultsList.removeChild(newTagLi);
                                                btnList.removeChild(deleteBtn);
                                                idList.removeChild(idItem);
                                                // Remove the tag from the addedTags set
                                                addedTags.delete(selectedTag);
                                            }
                                        });
                            });
                            btnList.appendChild(deleteBtn);
                            resultsList.appendChild(newTagLi);
                            idList.appendChild(idItem);
                            // If there are more than one tags, remove the first tag
                            if (resultsList.children.length > 1) {
                                const firstTagElement = tagElements.shift(); // Remove the first tag element from the array
                                if (firstTagElement) {
                                    tagContainer.removeChild(firstTagElement); // Remove the first tag element from the tagContainer
                                }
                            }

                            const selectElement = document.getElementById('tagSelect');
                            selectElement.innerHTML = '<option value="">Choose a dentist</option>';
                            $.ajax({
                                type: 'POST',
                                url: 'AddDentistMajorServlet',
                                contentType: 'application/json',
                                data: JSON.stringify({
                                    majorName: majorNameElement,
                                    tagId: selectedTagId // send the selected tag id in the request
                                }),
                                success: function (response) {
                                    console.log('Response:', response);
                                    response.Notdentist.forEach(notDentist => {
                                        // Validate each notDentist object to ensure it has the expected property
                                        if (notDentist && notDentist.accountFullName) {
                                            const option = document.createElement('option');
                                            option.id = notDentist.accountID;
                                            option.text = notDentist.accountFullName;
                                            selectElement.appendChild(option); // Assuming you have a separate select element for notDentist
                                            swal("Added Successfully!", "New dentist has been added!", "success");
                                        } else {
                                            console.error('Invalid notDentist object:', notDentist);
                                        }
                                    });
                                },
                                error: function (xhr, status, error) {
                                    console.error('Error sending dentist names:', error);
                                }
                            });
                            /// end 2
                            closePopup();
                        } else if (addedTags.has(selectedTag)) {
                            alert('This tag has already been added!');
                        }
                    })
                            ;

                </script>
            </div>
        </div>
    </body>
</html>
