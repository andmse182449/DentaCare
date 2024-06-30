<%-- 
    Document   : coWeb-staff
    Created on : May 23, 2024, 2:24:09 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clinic.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.temporal.WeekFields" %>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <link rel="stylesheet" href="css/stylesheet.css">
        <link rel="stylesheet" href="css/manageDen.css">

        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header">
                <div><h1>MANAGE DENTIST</h1></div>
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
                        <a href="coWeb-dentist.jsp"><li class="sidebar-list-item sidebar-list-item-selected"><span class="material-symbols-outlined">groups_2</span><div>Manage Dentist</div></li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                        <a href="ServiceController"><li class="sidebar-list-item"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                        <a href="ManageStaffServlet"><li class="sidebar-list-item">Staff List</li></a>
                    </ul>
                </div>
            </aside>
            <!-- MAIN -->
            <div class="main-container">
                <div class="main-content">
                    <div class="alert-error sec">${error}</div>
                    <div class="alert-message sec">${message}</div>
                    <button id="create-button" class="create-button">Create Dentist Account</button>
                </div>
                <br>
                <!-- FORM POPUP-->
                <div class="popup" id="popup-form">
                    <div class="close-btn" id="close-btn">&times;</div>
                    <div class="form">
                        <h2>CREATE A DENTIST ACCOUNT</h2>
                        <form action="DentistServlet" method="post">
                            <div class="form-element">
                                <label for="email">Email</label>
                                <input type="email" name="den-email" required>
                            </div>
                            <div class="form-element">
                                <label for="fullname">Full name</label>
                                <input type="text" name="den-fullName" required>
                            </div>
                            <div class="form-element">
                                <label for="phone">Phone</label>
                                <input type="text" name="den-phone" required>
                            </div>
                            <div class="form-element">
                                <label for="address">Address</label>
                                <input type="text" name="den-address" required>
                            </div>
                            <%
                                ClinicDAO clinicDao = new ClinicDAO();
                                List<ClinicDTO> clinics = clinicDao.getAllClinic();
                            %>

                            <div class="form-element">
                                <label for="clinic">Clinic</label>
                                <select name="den-clinic" required>
                                    <c:forEach items="<%= clinics%>" var="clinic">
                                        <option value="${clinic.clinicID}">${clinic.clinicName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <input type="hidden" name="action" value="create"/>
                            <div class="form-element">
                                <input type="submit" value="Submit">
                            </div>
                        </form>
                    </div>
                </div>
                <!-- END POPUP -->
                <c:set var="majors" value="${requestScope.MAJOR}"/>
                <div class="main-content">
                    <div class="search-container">
                        <input type="text" id="search-bar" placeholder="Search dentists...">
                    </div>
                    <div class="dentist-list">
                        <c:set var="dentists" value="${requestScope.DENTIST}"/>
                        <c:set var="clinics" value="${requestScope.CLINIC}"/>
                        <c:forEach var="den" items="${dentists}">
                            <div class="dentist ${den.getStatus() == 1 ? 'greyed-out' : ''}" data-name="BS.${den.getFullName()}" 
                                 data-specialty="${den.getMajorName() != null ? den.getMajorName() : '---'}"
                                 data-bio="${den.getIntroduction() != null ? den.getIntroduction() : '---'}"
                                 data-dob="${den.getDob() != null ? den.getDob() : '---'}"
                                 data-fullname="${den.getFullName() != null ? den.getFullName() : '---'}" 
                                 data-phone="${den.getPhone() != null ? den.getPhone() : '---'}" 
                                 data-gender="${den.isGender() == 'true' ? 'Male' : 'Female'}"
                                 data-image="images/${den.getImage()}"
                                 data-id="${den.getAccountID()}"
                                 data-email="${den.getEmail()}"
                                 data-clinic="${den.getClinicName()}"
                                 data-address="${den.getAddress()}">
                                <h2>${den.getFullName()}</h2>
                                <div class="status-icon"></div>

                                <a href="#" class="view-info">View Info</a>
                                <form action="#" id="disable-form">
                                    <input type="hidden" id="den-id" value="${den.getAccountID()}"/>
                                    <input type="submit" class="delete-info" value="Delete"/>
                                </form>

                                <button class="restore-info" style="display: ${den.getStatus() == 1 ? 'incline-block' : 'none'};">Restore</button>
                            </div>
                            <div id="dentist-popup" class="popup2 hidden">
                                <div class="popup-content">
                                    <span class="close">&times;</span>
                                    <div id="view-mode">
                                        <h2 id="dentist-name"></h2>
                                        <img id="dentist-image" src="" alt="Dentist" width="150" height="150">
                                        <p><strong>Full Name:</strong> <span id="dentist-fullname"></span></p>
                                        <p><strong>Email:</strong> <span id="dentist-email"></span></p>
                                        <p><strong>Specialty:</strong> <span id="dentist-specialty"></span></p>
                                        <p><strong>From Clinic: </strong> <span id="dentist-clinic"></span></p>
                                        <p><strong>Date of Birth:</strong> <span id="dentist-dob"></span></p>
                                        <p><strong>Phone:</strong> <span id="dentist-phone"></span></p>
                                        <p><strong>Address:</strong> <span id="dentist-address"></span></p>
                                        <p><strong>Gender:</strong> <span id="dentist-gender"></span></p>
                                        <p><strong>Bio:</strong> <span id="dentist-bio"></span></p>
                                        <button id="edit-info" class="edit-button">Edit</button>
                                    </div>
                                    <div id="edit-mode" class="hidden">
                                        <h2>Edit Dentist Information</h2>
                                        <input type="hidden" id="edit-id" name="edit-id">
                                        <label for="edit-fullname">Full Name:</label>
                                        <input type="text" id="edit-fullname" name="edit-fullname">

                                        <label for="edit-clinic">From Clinic:</label>
                                        <select id="edit-clinic" name="clinic">
                                            <script>
                                                document.addEventListener('DOMContentLoaded', () => {
                                                const clinics = [
                                                <c:forEach items="${CLINIC}" var="clinic">
                                                {
                                                clinicID: "${clinic.clinicID}",
                                                        clinicName: "${clinic.clinicName}",
                                                        clinicAddress: "${clinic.clinicAddress}",
                                                        city: "${clinic.city}",
                                                        hotline: "${clinic.hotline}"
                                                }<c:if test="${!status.last}">,</c:if>
                                                </c:forEach>
                                                ];
                                                        // Populate clinic dropdown
                                                        clinics.forEach(clinic => {
                                                        const option = document.createElement('option');
                                                                option.value = clinic.clinicID;
                                                                option.textContent = clinic.clinicName;
                                                                document.getElementById('edit-clinic').appendChild(option);
                                                        });
                                                        // Popup and form elements
                                                        const viewInfoLinks = document.querySelectorAll('.view-info');
                                                        const popup = document.getElementById('dentist-popup');
                                                        const closeBtn = popup.querySelector('.close');
                                                        const dentistList = document.querySelectorAll('.dentist');
                                                        // View elements
                                                        const nameElement = document.getElementById('dentist-name');
                                                        const specialtyElement = document.getElementById('dentist-specialty');
                                                        const bioElement = document.getElementById('dentist-bio');
                                                        const fullnameElement = document.getElementById('dentist-fullname');
                                                        const dobElement = document.getElementById('dentist-dob');
                                                        const phoneElement = document.getElementById('dentist-phone');
                                                        const genderElement = document.getElementById('dentist-gender');
                                                        const emailElement = document.getElementById('dentist-email');
                                                        const addressElement = document.getElementById('dentist-address');
                                                        const clinicElement = document.getElementById('dentist-clinic');
                                                        // Edit elements


                                                        const editBioTextarea = document.getElementById('edit-bio');
                                                        const editFullnameInput = document.getElementById('edit-fullname');
                                                        const editDobInput = document.getElementById('edit-dob');
                                                        const editPhoneInput = document.getElementById('edit-phone');
                                                        const editID = document.getElementById('edit-id');
                                                        const editGenderInputs = document.querySelectorAll('input[name="edit-gender"]');
                                                        const editImageInput = document.getElementById('edit-image');
                                                        const editAddressInput = document.getElementById('edit-address');
                                                        const clinicSelect = document.getElementById('edit-clinic');
                                                        // Buttons
                                                        const viewMode = document.getElementById('view-mode');
                                                        const editMode = document.getElementById('edit-mode');
                                                        const saveChangesButton = document.getElementById('save-changes');
                                                        const cancelEditButton = document.getElementById('cancel-edit');
                                                        const editInfoButton = document.getElementById('edit-info');
                                                        const returnToViewButton = document.getElementById('return-to-view');
                                                        const saveForm = document.getElementById('save-form');
                                                        let currentDentist = null;
                                                        // Close popup functionality
                                                        if (closeBtn) {
                                                closeBtn.addEventListener('click', () => {
                                                resetPopup();
                                                });
                                                }

                                                // View Info logic
                                                viewInfoLinks.forEach(link => {
                                                link.addEventListener('click', (event) => {
                                                event.preventDefault();
                                                        currentDentist = event.target.closest('.dentist');
                                                        updateViewMode();
                                                        popup.classList.remove('hidden');
                                                        viewMode.classList.remove('hidden');
                                                        editMode.classList.add('hidden');
                                                });
                                                });
                                                        // Edit button functionality
                                                        editInfoButton.addEventListener('click', () => {
                                                        populateEditMode();
                                                                viewMode.classList.add('hidden');
                                                                editMode.classList.remove('hidden');
                                                        });
                                                        // Save Changes logic
                                                        saveChangesButton.addEventListener('click', (event) => {
                                                        event.preventDefault(); // Prevent form from submitting normally
                                                                if (currentDentist) {
                                                        saveChanges();
                                                                updateViewMode();
                                                                viewMode.classList.remove('hidden');
                                                                editMode.classList.add('hidden');
                                                        }
                                                        });
                                                        // Return to view mode without saving changes
                                                        returnToViewButton.addEventListener('click', () => {
                                                        viewMode.classList.remove('hidden');
                                                                editMode.classList.add('hidden');
                                                        });
                                                        // Cancel Edit logic (use returnToViewButton or close popup)
                                                        cancelEditButton.addEventListener('click', () => {
                                                        viewMode.classList.remove('hidden');
                                                                editMode.classList.add('hidden');
                                                        });
                                                        // Close popup if clicking outside of the content area
                                                        popup.addEventListener('click', (event) => {
                                                        if (event.target === popup) {
                                                        resetPopup();
                                                        }
                                                        });
                                                        // Prevent form's default submission behavior
                                                        saveForm.addEventListener('submit', (event) => {
                                                        event.preventDefault(); // Prevent default form submission
                                                                saveChangesButton.click(); // Trigger the save changes button logic
                                                        });
                                                        function resetPopup() {
                                                        popup.classList.add('hidden');
                                                                viewMode.classList.remove('hidden');
                                                                editMode.classList.add('hidden');
                                                                currentDentist = null;
                                                        }

                                                function updateViewMode() {
                                                if (currentDentist) {
                                                nameElement.textContent = currentDentist.dataset.name;
                                                        specialtyElement.textContent = currentDentist.dataset.specialty;
                                                        bioElement.textContent = currentDentist.dataset.bio;
                                                        fullnameElement.textContent = currentDentist.dataset.fullname;
                                                        dobElement.textContent = currentDentist.dataset.dob;
                                                        phoneElement.textContent = currentDentist.dataset.phone;
                                                        genderElement.textContent = currentDentist.dataset.gender;
                                                        emailElement.textContent = currentDentist.dataset.email;
                                                        addressElement.textContent = currentDentist.dataset.address;
                                                        clinicElement.textContent = currentDentist.dataset.clinic;
                                                }
                                                }

                                                function populateEditMode() {
                                                if (currentDentist) {
                                                // Populate other edit fields
                                                editID.value = currentDentist.dataset.id;
                                                        editFullnameInput.value = currentDentist.dataset.fullname;
                                                        editBioTextarea.value = currentDentist.dataset.bio;
                                                        editDobInput.value = currentDentist.dataset.dob;
                                                        editPhoneInput.value = currentDentist.dataset.phone;
                                                        editAddressInput.value = currentDentist.dataset.address;
                                                        // Populate the clinic dropdown (if applicable)
                                                        const clinicDropdown = document.getElementById('edit-clinic');
                                                        const dentistClinicID = currentDentist.dataset.clinic;
                                                        clinicDropdown.innerHTML = ''; // Clear existing options

                                                        clinics.forEach(clinic => {
                                                        const option = document.createElement('option');
                                                                option.value = clinic.clinicID;
                                                                option.textContent = clinic.clinicName;
                                                                clinicDropdown.appendChild(option);
                                                                if (clinic.clinicID === dentistClinicID) {
                                                        option.selected = true;
                                                        }
                                                        });
                                                        if (!clinicDropdown.value) {
                                                console.warn("Dentist's clinic ID not found in the clinic list.");
                                                }

                                                const currentGender = currentDentist.dataset.gender.toLowerCase();
                                                        document.querySelectorAll('input[name="edit-gender"]').forEach((input) => {
                                                input.checked = input.value.toLowerCase() === currentGender;
                                                });
                                                }
                                                }

                                                function saveChanges() {
                                                const selectedClinicID = clinicSelect.value;
                                                        if (currentDentist) {
                                                const updatedData = {
                                                id: editID.value,
                                                        address: editAddressInput.value,
                                                        fullname: editFullnameInput.value,
                                                        bio: editBioTextarea.value,
                                                        dob: editDobInput.value,
                                                        phone: editPhoneInput.value,
                                                        image: editImageInput.value,
                                                        clinic: selectedClinicID,
                                                        gender: document.querySelector('input[name="edit-gender"]:checked')?.value
                                                };
                                                        Object.keys(updatedData).forEach(key => {
                                                if (updatedData[key] !== undefined) {
                                                currentDentist.dataset[key] = updatedData[key];
                                                }
                                                });
                                                        currentDentist.querySelector('h2').textContent = updatedData.fullname; // Assuming you want to update the display name

                                                        const jsonData = JSON.stringify(updatedData);
                                                        fetch('EditDentistServlet', {
                                                        method: 'POST',
                                                                headers: {
                                                                'Content-Type': 'application/json'
                                                                },
                                                                body: jsonData
                                                        })
                                                        .then(response => {
                                                        if (!response.ok) {
                                                        throw new Error('Network response was not ok ' + response.statusText);
                                                        }
                                                        return response.json();
                                                        })
                                                        .then(data => {
                                                        console.log('Success:', data);
                                                        })
                                                        .catch(error => {
                                                        console.error('Error:', error);
                                                        });
                                                }
                                                }
                                                });
                                            </script>
                                        </select>
                                        <br>

                                        <label for="edit-dob">Date of Birth:</label>
                                        <input type="date" id="edit-dob" name="edit-dob">

                                        <label for="edit-phone">Phone:</label>
                                        <input type="tel" id="edit-phone" name="edit-phone">

                                        <label for="edit-address">Address:</label>
                                        <input type="text" id="edit-address" name="edit-address">

                                        <fieldset>
                                            <legend>Gender:</legend>
                                            <input type="radio" id="edit-gender-male" name="edit-gender" value="Male">
                                            <label for="edit-gender-male">Male</label>
                                            <input type="radio" id="edit-gender-female" name="edit-gender" value="Female">
                                            <label for="edit-gender-female">Female</label>
                                        </fieldset>

                                        <label for="edit-image">Image URL:</label>
                                        <input required="true" type="file" name="edit-image" id="edit-image" accept="image/png, image/jpg"/><br><br>

                                        <label for="edit-bio">Bio:</label>
                                        <textarea id="edit-bio" name="edit-bio" rows="4"></textarea>

                                        <form id="save-form">
                                            <input type="submit" id="save-changes" value="Save Changes">
                                        </form>
                                        <button id="return-to-view">Return</button>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </div>
        </div>
        <!--        <script src="js/manageDen.js"></script>-->
        <script>// script.js
                    document.addEventListener('DOMContentLoaded', () => {
                    const searchBar = document.getElementById('search-bar');
                            const dentistList = document.querySelectorAll('.dentist');
                            searchBar.addEventListener('input', function () {
                            const searchTerm = this.value.trim().toLowerCase();
                                    dentistList.forEach(dentist => {
                                    const name = dentist.dataset.name.toLowerCase();
                                            const specialty = dentist.dataset.specialty.toLowerCase();
                                            const bio = dentist.dataset.bio.toLowerCase();
                                            const matchesSearch = name.includes(searchTerm) || specialty.includes(searchTerm) || bio.includes(searchTerm);
                                            dentist.classList.toggle('hidden-dentist', !matchesSearch);
                                    });
                            });
                    });
        </script>
        <script>
                    document.addEventListener('DOMContentLoaded', () => {
                    const dentistList = document.querySelector('.dentist-list');
                            const saveForm = document.getElementById('save-form');
                            const disabledForm = document.getElementById('disable-form');
                            const id = document.getElementById('den-id').value;
                            // get information
                            const nameElement = document.getElementById('dentist-name');
                            const specialtyElement = document.getElementById('dentist-specialty');
                            const bioElement = document.getElementById('dentist-bio');
                            const fullnameElement = document.getElementById('dentist-fullname');
                            const dobElement = document.getElementById('dentist-dob');
                            const phoneElement = document.getElementById('dentist-phone');
                            const genderElement = document.getElementById('dentist-gender');
                            const emailElement = document.getElementById('dentist-email');
                            const addressElement = document.getElementById('dentist-address');
                            const clinicElement = document.getElementById('dentist-clinic');
                            // for edit

                            const editBioTextarea = document.getElementById('edit-bio');
                            const editFullnameInput = document.getElementById('edit-fullname');
                            const editDobInput = document.getElementById('edit-dob');
                            const editPhoneInput = document.getElementById('edit-phone');
                            const editID = document.getElementById('edit-id');
                            const editImageInput = document.getElementById('edit-image');
                            const editAddressInput = document.getElementById('edit-address');
                            // button
                            const viewMode = document.getElementById('view-mode');
                            const editMode = document.getElementById('edit-mode');
                            dentistList.addEventListener('click', (event) => {
                            const dentistItem = event.target.closest('.dentist');
                                    if (!dentistItem)
                                    return; // Exit if the click is not on a dentist item

                                    if (event.target.classList.contains('delete-info')) {
                            event.preventDefault(); // Prevent the form from submitting
                                    const id = dentistItem.dataset.id;
                                    const jsonData = {id: id};
                                    fetch('DisableDentistServlet?action=disable', {
                                    method: 'POST',
                                            headers: {
                                            'Content-Type': 'application/json'
                                            },
                                            body: JSON.stringify(jsonData)
                                    })
                                    .then(response => response.json())
                                    .then(data => {
                                    console.log('Dentist deleted successfully:', data);
                                            // Update the UI or perform any other necessary actions
                                    })
                                    .catch(error => {
                                    console.error('Error deleting dentist:', error);
                                    });
                                    deleteDentist(dentistItem);
                            } else if (event.target.classList.contains('restore-info')) {
                            event.stopPropagation(); // Allow the event to propagate and call restoreDentist
                                    event.preventDefault(); // Prevent the form from submitting
                                    const id = dentistItem.dataset.id;
                                    const jsonData = {id: id};
                                    fetch('DisableDentistServlet?action=restore', {
                                    method: 'POST',
                                            headers: {
                                            'Content-Type': 'application/json'
                                            },
                                            body: JSON.stringify(jsonData)
                                    })
                                    .then(response => response.json())
                                    .then(data => {
                                    console.log('Dentist deleted successfully:', data);
                                            // Update the UI or perform any other necessary actions
                                    })
                                    .catch(error => {
                                    console.error('Error deleting dentist:', error);
                                    });
                                    restoreDentist(dentistItem);
                            }
                            });
                            function deleteDentist(dentistItem) {
                            console.log('Deleting dentist:', dentistItem);
                                    const statusIcon = dentistItem.querySelector('.status-icon');
                                    const restoreButton = dentistItem.querySelector('.restore-info');
                                    const viewInfoButton = dentistItem.querySelector('.view-info');
                                    statusIcon.style.display = 'block'; // Show status icon
                                    dentistItem.classList.add('greyed-out');
                                    restoreButton.style.display = 'inline-block'; // Show restore button

                                    // Disable the view info popup buttons
                                    viewInfoButton.addEventListener('click', () => {
                                    const popup = document.getElementById('dentist-popup');
                                            const deleteButton = popup.querySelector('#delete-info-popup');
                                            const editButton = popup.querySelector('#edit-info');
                                            deleteButton.disabled = true;
                                            editButton.disabled = true;
                                    });
                            }

                    function restoreDentist(dentistItem) {
                    console.log('Restoring dentist:', dentistItem);
                            const statusIcon = dentistItem.querySelector('.status-icon');
                            const restoreButton = dentistItem.querySelector('.restore-info');
                            const viewInfoButton = dentistItem.querySelector('.view-info');
                            statusIcon.style.display = 'none'; // Hide status icon
                            dentistItem.classList.remove('greyed-out');
                            restoreButton.style.display = 'none'; // Hide restore button

                            // Enable the view info popup buttons
                            viewInfoButton.addEventListener('click', () => {
                            const popup = document.getElementById('dentist-popup');
                                    const deleteButton = popup.querySelector('#delete-info-popup');
                                    const editButton = popup.querySelector('#edit-info');
                                    deleteButton.disabled = false;
                                    editButton.disabled = false;
                            });
                            // Update any counters or related UI elements

                    }


                    });
        </script>
        <script>
                    document.querySelector("#create-button").addEventListener("click", function () {
            document.querySelector(".popup").classList.add("active");
            });
                    document.querySelector(".popup .close-btn").addEventListener("click", function () {
            document.querySelector(".popup").classList.remove("active");
            });
                    document.addEventListener("DOMContentLoaded", function () {
                    const alertBox = document.querySelector(".alert-error.sec");
                            if (alertBox && alertBox.textContent.trim()) {
                    alertBox.style.display = "block"; // Show the alert if there's an error message
                            alertBox.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                            setTimeout(function () {
                            alertBox.classList.remove("show");
                                    setTimeout(function () {
                                    alertBox.style.display = "none"; // Hide the alert after the fade-out animation
                                    }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                            }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                    }
                    });
                    document.addEventListener("DOMContentLoaded", function () {
                    const alertBox2 = document.querySelector(".alert-message.sec");
                            if (alertBox2 && alertBox2.textContent.trim()) {
                    alertBox2.style.display = "block"; // Show the alert if there's an error message
                            alertBox2.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                            setTimeout(function () {
                            alertBox2.classList.remove("show");
                                    setTimeout(function () {
                                    alertBox2.style.display = "none"; // Hide the alert after the fade-out animation
                                    }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                            }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                    }
                    });
                    let subMenu = document.getElementById("sub-menu-wrap");
                    function toggleDropdown() {
                    subMenu.classList.toggle("open-menu");
                    }
        </script>
        <!--script major-->

    </body>
</html>