// Function to generate a calendar
function generateCalendar(year, month) {
    var today = new Date();
    var lastSelectableDate = new Date();
    lastSelectableDate.setDate(today.getDate() + 31);
    var firstDay = new Date(year, month, 1);
    var lastDay = new Date(year, month + 1, 0);
    var daysInMonth = lastDay.getDate();

    var calendarHTML = '<div class="month"><h4>' + firstDay.toLocaleString('default', {month: 'long'}) + ' ' + year + '</h4><div class="navigation"><button id="prevMonth"><i class="fa fa-chevron-left"></i></button><button id="nextMonth"><i class="fa fa-chevron-right"></i></button></div></div><div class="days">';

    calendarHTML += '<div class="day" style="font-weight: 700;">Sun</div>';
    calendarHTML += '<div class="day" style="font-weight: 700;">Mon</div>';
    calendarHTML += '<div class="day" style="font-weight: 700;">Tue</div>';
    calendarHTML += '<div class="day" style="font-weight: 700;">Wed</div>';
    calendarHTML += '<div class="day" style="font-weight: 700;">Thu</div>';
    calendarHTML += '<div class="day" style="font-weight: 700;">Fri</div>';
    calendarHTML += '<div class="day" style="font-weight: 700;">Sat</div>';

    for (var i = 0; i < firstDay.getDay(); i++) {
        calendarHTML += '<div class="day"></div>';
    }

    var listDayOffValue = document.getElementById('listDayoff').value;
    var clinic = document.getElementById('clinicID-input').value;
    // Add days of the month
    for (var i = 1; i <= daysInMonth; i++) {
        var currentDate = new Date(year, month, i);
        var dayClass = 'day';
        var check = new Date(year, month, i).toLocaleDateString('en-CA', {year: 'numeric', month: '2-digit', day: '2-digit'});
        if (currentDate.toDateString() === today.toDateString()) {
            dayClass += ' current';

        } else if (currentDate < today || currentDate > lastSelectableDate || (listDayOffValue.includes(check) && listDayOffValue.includes('clinicID=' + clinic))) {
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
            var selectedDay = document.querySelector('.selected-calendar');
            if (selectedDay) {
                selectedDay.classList.remove('selected-calendar');
            }
            day.classList.add('selected-calendar');
            document.getElementById('date-input').value = new Date(year, month, day.innerHTML).toLocaleDateString('en-CA', {year: 'numeric', month: '2-digit', day: '2-digit'});
            document.querySelectorAll('.timeslot-option').forEach(timeslot => {
                timeslot.setAttribute('data-date', document.getElementById('date-input').value);
            });
            
            document.querySelectorAll('.doctor-option').forEach(doctor => {
                doctor.setAttribute('data-date', document.getElementById('date-input').value);
            });
            
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
}

generateCalendar(new Date().getFullYear(), new Date().getMonth());



/* FUNCTION FOR BOOKING BUSINESS */
document.addEventListener('DOMContentLoaded', function () {
    let selectedFields = {};
    const bookingFields = document.querySelectorAll('.bookingfield-header');

    bookingFields.forEach(header => {
        header.addEventListener('click', function () {
            let fieldNumber = parseInt(this.querySelector('h3').getAttribute('data-number'));

            if (isFieldSelectionAllowed(fieldNumber)) {
                toggleCollapsible(this);
            } else {
                showCustomAlert('Please select the previous field.');
            }
        });
    });

    function isFieldSelectionAllowed(fieldNumber) {
        if (fieldNumber === 1) {
            return true;
        }
        return selectedFields[fieldNumber - 1] || false;
    }

    function toggleCollapsible(element) {
        const content = element.nextElementSibling;
        const isVisible = content.style.display === 'block';
        content.style.display = isVisible ? 'none' : 'block';
        element.querySelector('.material-symbols-outlined').textContent = isVisible ? 'arrow_drop_down' : 'arrow_drop_up';
    }

    function resetFields(startingFieldNumber) {
        for (let i = startingFieldNumber; i <= 6; i++) {
            selectedFields[i] = false;
            const inputElement = document.querySelector(`.input-field-${i}`);
            if (inputElement) {
                inputElement.value = '';
            }
        }
    }

    document.querySelectorAll('.clinic-option').forEach(option => {
        option.addEventListener('click', function () {
            document.getElementById('clinic-input').value = this.innerText;
            document.getElementById('clinicAddress-input').value = this.getAttribute('data-address');
            document.getElementById('clinicID-input').value = this.getAttribute('data-id');
            
            document.querySelectorAll('.timeslot-option').forEach(timeslot => {
                timeslot.setAttribute('data-clinic', document.getElementById('clinicID-input').value);
            });
            
            document.querySelectorAll('.doctor-option').forEach(timeslot => {
                timeslot.setAttribute('data-clinic', document.getElementById('clinicID-input').value);
            });
            
            selectedFields[1] = true;
            resetFields(2);
            closeCollapsible(1);
            closeCollapsible(2);
            closeCollapsible(3);
            closeCollapsible(4);
            closeCollapsible(5);
            
        });
    });

    document.querySelectorAll('.service-option').forEach(option => {
        option.addEventListener('click', function () {
            document.getElementById('service-input').value = this.innerText;
            document.getElementById('serviceID-input').value = this.getAttribute('data-address');
            document.getElementById('price-input').value = this.getAttribute('data-price');
            selectedFields[2] = true;
            resetFields(4);
            closeCollapsible(2);
            closeCollapsible(3);
            closeCollapsible(4);
            closeCollapsible(5);
        });
    });


    document.querySelectorAll('.future').forEach(function(option) {
        option.addEventListener('click', function () {
            selectedFields[3] = true;
            resetFields(5);
            closeCollapsible(3);
            closeCollapsible(4);
            closeCollapsible(5);
        });
    });

    document.querySelectorAll('.timeslot-option').forEach(option => {
        option.addEventListener('click', function () {
            document.getElementById('timeslot-input').value = this.innerText;
            document.getElementById('slotID-input').value = this.getAttribute('data-address');
            selectedFields[4] = true;
            resetFields(6);
            closeCollapsible(4);
            closeCollapsible(5);
        });
    });

    document.querySelectorAll('.doctor-option').forEach(option => {
        option.addEventListener('click', function () {
            document.getElementById('doctor-input').value = this.innerText;
            document.getElementById('doctorID-input').value = this.getAttribute('data-address');
            selectedFields[5] = true;
            closeCollapsible(5);
        });
    });

    function closeCollapsible(fieldNumber) {
        const header = document.querySelector(`.bookingfield-header h3[data-number="${fieldNumber}"]`).parentNode;
        const content = header.nextElementSibling;
        if (content.style.display === 'block') {
            content.style.display = 'none';
            header.querySelector('.material-symbols-outlined').textContent = 'arrow_drop_down';
        }
    }

    function showCustomAlert(message) {
        const modal = document.getElementById('customAlertModal');
        const modalMessage = modal.querySelector('.custom-alert-message');
        modalMessage.textContent = message;
        modal.style.display = 'block';

        const closeModal = () => {
            modal.style.display = 'none';
        };

        modal.querySelector('.custom-alert-close').onclick = closeModal;
        modal.querySelector('.custom-alert-button').onclick = closeModal;

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        };
    }
});



/* FUNCTION FOR CHECKING INPUT FIELD */
document.addEventListener('DOMContentLoaded', function () {
    const confirmButton = document.querySelector('.confirm-booking-button');

    if (confirmButton) {
        confirmButton.addEventListener('click', function (event) {
            event.preventDefault();
            const missingField = validateForm();
            if (missingField == null) {
                showConfirm('Are you sure to confirm the booking information?');
            } else {
                showCustomAlert(`Please choose ${missingField}.`);
            }
        });
    }

    function showConfirm(message) {
        const modal = document.getElementById('customConfirmModal');
        const modalMessage = modal.querySelector('.confirm-message');
        modalMessage.textContent = message;
        modal.style.display = 'block';

        const closeModal = () => {
            modal.style.display = 'none';
        };

        modal.querySelector('.button-confirm').addEventListener('click', function () {
            document.querySelector('form').submit();
        });

        modal.querySelector('.button-cancel').onclick = closeModal;

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        };
    }

    function validateForm() {
        const inputs = document.querySelectorAll('.booking-form input[required]');
        for (let i = 0; i < inputs.length; i++) {
            if (!inputs[i].value.trim()) {
                // If any required field is empty, return its label
                const label = inputs[i].closest('.booking-form').querySelector('label').textContent;
                return label;
            }
        }
        return null;
    }

    function showCustomAlert(message) {
        const modal = document.getElementById('customAlertModal');
        const modalMessage = modal.querySelector('.custom-alert-message');
        modalMessage.textContent = message;
        modal.style.display = 'block';

        const closeModal = () => {
            modal.style.display = 'none';
        };

        modal.querySelector('.custom-alert-close').onclick = closeModal;
        modal.querySelector('.custom-alert-button').onclick = closeModal;

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        };
    }
});
