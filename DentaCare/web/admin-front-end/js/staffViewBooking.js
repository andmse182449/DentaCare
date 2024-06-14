function showDetail(id) {
    // Hide all other details
    var details = document.getElementsByClassName('booking-detail');
    for (var i = 0; i < details.length; i++) {
        details[i].classList.add('hidden');
    }

    // Show the selected detail
    document.getElementById('detail-' + id).classList.remove('hidden');
}

function closeDetail(id, event) {
    event.stopPropagation(); // Prevent the click event from bubbling up to the parent div
    document.getElementById('detail-' + id).classList.add('hidden');
}

function loadBookings() {
    const bookingDate = document.getElementById('bookingDate').value;
    const bookings = document.querySelectorAll('.booking-item');
    const bookingList = document.getElementById('bookingList');

    if (!bookingDate) {
        bookingList.classList.add('hidden');
        return;
    }

    let found = false;
    bookings.forEach(booking => {
        const bookingDateAttr = booking.getAttribute('data-date');
        if (bookingDateAttr === bookingDate) {
            booking.style.display = 'block';
            found = true;
        } else {
            booking.style.display = 'none';
        }
    });

    if (found) {
        bookingList.classList.remove('hidden');
    } else {
        bookingList.classList.add('hidden');
    }
}

