// Function to generate a calendar
function generateCalendar(year, month) {
    var today = new Date();
    var firstDay = new Date(year, month, 1);
    var lastDay = new Date(year, month + 1, 0);
    var daysInMonth = lastDay.getDate();

    var calendarHTML = '<div class="month"><div id="prevMonth"><i class="fa fa-chevron-left"></i></div> <div><h2 style="font-weight: 700;">' + firstDay.toLocaleString('default', {month: 'long'}) + ' ' + year + '</h2></div> <div id="nextMonth"><i class="fa fa-chevron-right"></i></div> </div> <div class="days">';

    // Add day headers
    var dayHeaders = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    dayHeaders.forEach(day => {
        calendarHTML += '<div class="day" style="font-size: 20px; font-weight: 700;">' + day + '</div>';
    });

    // Add empty cells for days before the first day of the month
    for (var i = 0; i < firstDay.getDay(); i++) {
        calendarHTML += '<div class="day"></div>';
    }

    // Add days of the month
    for (var i = 1; i <= daysInMonth; i++) {
        var dayClass = 'day';
        calendarHTML += '<div class="' + dayClass + '">' + i + '</div>';
    }
    calendarHTML += '</div>';

    document.getElementById('calendar').innerHTML = calendarHTML;

    var listBooking = document.getElementById('listBooking').value;
    // Add event listeners to future days
    var futureDays = document.querySelectorAll('.day');
    futureDays.forEach(function (day) {
        console.log(listBooking);
        var check = new Date(year, month, day.innerHTML).toLocaleDateString('en-CA', {year: 'numeric', month: '2-digit', day: '2-digit'});
        if (listBooking.includes("appointmentDay=" + check)) {
            day.classList.add('selected-calendar');
            day.setAttribute('data-check', check);
        } else if (check === today.toLocaleDateString('en-CA', {year: 'numeric', month: '2-digit', day: '2-digit'})) {
            day.classList.add('current');
        }
    });



    // Add event listener for "Next Month" button
    document.getElementById('nextMonth').addEventListener('click', function () {
        if (month === 11) {
            year++;
            month = 0;
        } else {
            month++;
        }
        generateCalendar(year, month);
    });

    // Add event listener for "Previous Month" button
    var prevButton = document.getElementById('prevMonth');
    prevButton.addEventListener('click', function () {
        if (month === 0) {
            year--;
            month = 11;
        } else {
            month--;
        }
        generateCalendar(year, month);
    });

    document.querySelectorAll(".selected-calendar").forEach(link => {
        link.addEventListener("click", function (event) {
            event.preventDefault();
            const day = this.getAttribute("data-check");
            document.querySelector(`#bookingModal-` + day).classList.add("active");
        });
    });

    document.querySelectorAll(".modal .close").forEach(closeBtn => {
        closeBtn.addEventListener("click", function () {
            const day = this.getAttribute("data-check");
            document.querySelector(`#bookingModal-` + day).classList.remove("active");
        });
    });

    window.addEventListener("click", function (event) {
        if (event.target.classList.contains('modal')) {
            event.target.classList.remove('active');
        }
    });

}

// Generate calendar for the current month
generateCalendar(new Date().getFullYear(), new Date().getMonth());

