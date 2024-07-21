function generateCalendar(year, month) {
    var today = new Date();
    var lastSelectableDate = new Date();
    lastSelectableDate.setDate(today.getDate() + 31);
    var firstDay = new Date(year, month, 1);
    var lastDay = new Date(year, month + 1, 0);
    var daysInMonth = lastDay.getDate();
    var selectedDays = [];

    var calendarHTML = '<div class="month"><div id="prevMonth"><i class="fa fa-chevron-left"></i></div><div><h2>' + firstDay.toLocaleString('default', {month: 'long'}) + ' ' + year + '</h2></div><div id="nextMonth"><i class="fa fa-chevron-right"></i></div></div><div class="days">';

    var dayHeaders = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    dayHeaders.forEach(day => {
        calendarHTML += '<div class="day" style="font-weight: 700;">' + day + '</div>';
    });

    for (var i = 0; i < firstDay.getDay(); i++) {
        calendarHTML += '<div class="day"></div>';
    }

    for (var i = 1; i <= daysInMonth; i++) {
        var currentDate = new Date(year, month, i);
        var dayClass = 'day';
        if (currentDate.getDay() === 0) { // Disable Sundays
            dayClass += ' past';
        } else if (currentDate.toDateString() === today.toDateString()) {
            dayClass += ' current';
        } else if (currentDate < today || currentDate > lastSelectableDate) {
            dayClass += ' past';
        } else {
            dayClass += ' future';
        }
        calendarHTML += '<div class="' + dayClass + '">' + i + '</div>';
    }
    calendarHTML += '</div>';

    document.getElementById('calendar').innerHTML = calendarHTML;

    var futureDays = document.querySelectorAll('.future');
    futureDays.forEach(function (day) {
        day.addEventListener('click', function () {
            day.classList.toggle('selected-calendar');
            var dayNumber = parseInt(day.innerHTML);
            var selectedDate = new Date(year, month, dayNumber).toLocaleDateString('en-CA', {year: 'numeric', month: '2-digit', day: '2-digit'});

            if (selectedDays.includes(selectedDate)) {
                selectedDays = selectedDays.filter(date => date !== selectedDate);
            } else {
                selectedDays.push(selectedDate);
            }

            document.getElementById('date-input').value = selectedDays.join(', ');
        });
    });

    document.getElementById('nextMonth').addEventListener('click', function () {
        if (month === 11) {
            year++;
            month = 0;
        } else {
            month++;
        }
        generateCalendar(year, month);
    });

    var prevButton = document.getElementById('prevMonth');
    prevButton.addEventListener('click', function () {
        if (year === today.getFullYear() && month === today.getMonth()) {
            return;
        }
        if (month === 0) {
            year--;
            month = 11;
        } else {
            month--;
        }
        generateCalendar(year, month);
    });

    if (year === today.getFullYear() && month === today.getMonth()) {
        prevButton.disabled = true;
    } else {
        prevButton.disabled = false;
    }

    if (!document.getElementById('submitDays')) {
        var submitButton = document.createElement('button');
        submitButton.id = 'submitDays';
        submitButton.textContent = 'Submit';
        submitButton.type = 'button';
        submitButton.addEventListener('click', function () {
            var selectedDaysDisplay = document.getElementById('selectedDaysDisplay').innerHTML = 'Chosen Days: ' + selectedDays.join(', ');
            document.getElementById('calendarModal').style.display = 'none';
            document.getElementById('calendar').style.display = 'none';
            submitForm();
        });
        document.getElementById('calendar').appendChild(submitButton);
    }
}

function submitForm() {
    var form = document.getElementById('calendarForm');
    var formData = new FormData(form);
    var xhr = new XMLHttpRequest();
    xhr.open('POST', form.action, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            var status = xhr.status;
            if (status === 0 || (status >= 200 && status < 400)) {
                // Request was successful
                console.log(xhr.responseText);
                var response = JSON.parse(xhr.responseText);
                alert(response.message);
            } else {
                // An error occurred during the request
                console.error(xhr.responseText);
                var response = JSON.parse(xhr.responseText);
                alert('Error: ' + response.message);
            }
        }
    };
    xhr.send(formData);
}

document.addEventListener("DOMContentLoaded", function () {
    var today = new Date();
    generateCalendar(today.getFullYear(), today.getMonth());

    document.getElementById('openCalendarButton').addEventListener('click', function () {
        document.getElementById('calendarModal').style.display = 'block';
        document.getElementById('calendar').style.display = 'block';
    });

    window.onclick = function (event) {
        if (event.target == document.getElementById('calendarModal')) {
            document.getElementById('calendarModal').style.display = 'none';
            document.getElementById('calendar').style.display = 'none';
        }
    };
});
