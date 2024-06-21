/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.querySelector("#create-button").addEventListener("click", function () {
    document.querySelector(".popup").classList.add("active");
});
document.querySelector(".popup .close-btn").addEventListener("click", function () {
    document.querySelector(".popup").classList.remove("active");
});
document.addEventListener('DOMContentLoaded', (event) => {
    const clinicCards = document.querySelectorAll('.clinic-card');
    clinicCards.forEach(card => {
        card.addEventListener('click', () => {
            const url = card.getAttribute('data-url');
            window.location.href = url;
        });
    });
});

// Function to handle click event on calendar cell
function handleDayClick(date) {
    // You can perform actions based on the clicked date
    alert("Clicked on date: " + date);
    // For example, you can redirect to another page passing the date as a parameter
    window.location.href = "handleDayClickServlet?date=" + date;
}


// JavaScript code for handling calendar cell clicks
let selectedDate = '';

function handleDayClick(date, cell) {
    selectedDate = date;
    // Remove 'selected' class from all cells
    document.querySelectorAll('.table-cell, .table-cell2').forEach(c => c.classList.remove('selected'));
    // Add 'selected' class to the clicked cell
    cell.classList.add('selected');
    // Show the correct confirmation popup based on the cell's class
    if (cell.classList.contains('table-cell')) {
        document.getElementById('confirmationPopup').style.display = 'flex';
    } else if (cell.classList.contains('table-cell2')) {
        document.getElementById('confirmationPopup2').style.display = 'flex';
    }
}

document.addEventListener('DOMContentLoaded', () => {
    // Add click event listener to each calendar cell
    document.querySelectorAll('.table-cell, .table-cell2').forEach(cell => {
        const date = cell.getAttribute('data-date');
        cell.addEventListener('click', () => handleDayClick(date, cell));
    });
    // Add click event listener to the confirm button in the confirmation popup
    document.getElementById('confirmButton').addEventListener('click', () => {
        document.getElementById('confirmationPopup').style.display = 'none';
        document.getElementById('eventPopup').style.display = 'flex';
        document.getElementById('eventDate').value = selectedDate;
    });
    // Add click event listener to the confirm button in the confirmation popup2
    document.getElementById('confirmButton2').addEventListener('click', () => {
        document.getElementById('confirmationPopup2').style.display = 'none';
        document.getElementById('eventPopup2').style.display = 'flex';
        document.getElementById('eventDate2').value = selectedDate;
    });
    // Add click event listener to the close button in the confirmation popup
    document.querySelector('#confirmationPopup .close-btn').addEventListener('click', () => {
        closePopup('confirmationPopup');
    });
    // Add click event listener to the close button in the confirmation popup2
    document.querySelector('#confirmationPopup2 .close-btn').addEventListener('click', () => {
        closePopup('confirmationPopup2');
    });
    // Add click event listener to the close button in the event popup
    document.querySelector('#eventPopup .close-btn').addEventListener('click', () => {
        closePopup('eventPopup');
    });
    // Add click event listener to the close button in the event popup2
    document.querySelector('#eventPopup2 .close-btn').addEventListener('click', () => {
        closePopup('eventPopup2');
    });
    // Handle the event form submission via AJAX
    $('#eventForm').on('submit', function (e) {
        e.preventDefault(); // Prevent the default form submission

        // Serialize form data
        var formData = $(this).serialize();
        // AJAX request
        $.ajax({
            type: 'POST',
            url: $(this).attr('action'),
            data: formData,
            success: function (response) {
                // Handle the successful response (e.g., update the table or DOM)
                alert('Event successfully set!');
                location.reload(); // Reload the page to show updated data
            },
            error: function () {
                // Handle errors
                alert('An error occurred. Please try again.');
            }
        });
    });
    // Handle the event form2 submission via AJAX
    $('#eventForm2').on('submit', function (e) {
        e.preventDefault(); // Prevent the default form submission

        // Serialize form data
        var formData = $(this).serialize();
        // AJAX request
        $.ajax({
            type: 'POST',
            url: $(this).attr('action'),
            data: formData,
            success: function (response) {
                // Handle the successful response (e.g., update the table or DOM)
                alert('Modify event successfully !');
                location.reload(); // Reload the page to show updated data
            },
            error: function () {
                // Handle errors
                alert('An error occurred. Please try again.');
            }
        });
    });
});

function closePopup(popupId) {
    document.getElementById(popupId).style.display = 'none';
}

function showPopup(popupId) {
    document.getElementById(popupId).style.display = 'flex';
}

function someConditionForPopup1(date) {
    // Replace this function with your actual condition to determine which popup to show
    // For example, you could check if the date has an event or some other condition
    return true; // or false depending on the condition
}
