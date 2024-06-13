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

    document.querySelectorAll(".details-link").forEach(link => {
        link.addEventListener("click", function (event) {
            event.preventDefault();
            const bookingID = this.getAttribute("data-booking-id");
            document.querySelector(`#bookingModal-` + bookingID).classList.add("active");
        });
    });

    document.querySelectorAll(".modal .close").forEach(closeBtn => {
        closeBtn.addEventListener("click", function () {
            const bookingID = this.getAttribute("data-booking-id");
            document.querySelector(`#bookingModal-` + bookingID).classList.remove("active");
        });
    });

    window.addEventListener("click", function (event) {
        if (event.target.classList.contains('modal')) {
            event.target.classList.remove('active');
        }
    });

    var bookingStatusElement = document.querySelectorAll('#bookingStatus');
    bookingStatusElement.forEach(function (option) {
        if (option.getAttribute('data-check') === '3') {
            option.setAttribute('style', 'border: none; background: none; color: red;');
            option.setAttribute('value', 'Cancelled');
            option.setAttribute('disabled', '');
        } else if (option.getAttribute('data-check') === '2') {
            option.setAttribute('disabled', '');
            option.setAttribute('style', 'border: none; background: none; color: green;');
            option.setAttribute('value', 'Completed');
        } else {
            option.setAttribute('style', 'background: red; color: #fff; border:none; width: 100px; border-radius: 50px; cursor: pointer;');
        }
    });

});
