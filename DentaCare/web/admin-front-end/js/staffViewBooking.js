document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.querySelector('input[name="nameBooking"]');
    const bookingItems = document.querySelectorAll('.booking-item');

    searchInput.addEventListener('input', function () {
        const searchTerm = this.value.toLowerCase();

        bookingItems.forEach(booking => {
            const bookingName = booking.getAttribute('data-name').toLowerCase();
            if (bookingName.includes(searchTerm)) {
                booking.style.display = 'block';
            } else {
                booking.style.display = 'none';
            }
        });
    });
});


