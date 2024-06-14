function validateDate() {
    const dobInput = document.getElementsByName('dob')[0];
    const dobError = document.getElementById('dobError');
    const dobValue = dobInput.value.trim();
    const datePattern = /^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$|^\d{4}\/(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])$|^\d{4}-\d{2}-\d{2}$/;

    if (!datePattern.test(dobValue)) {
        dobError.style.display = 'block';
        return false; // Prevent form submission
    } else {
        dobError.style.display = 'none';
        return true;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('profileForm');
    form.addEventListener('submit', function(event) {
        if (!validateDate()) {
            event.preventDefault(); // Prevent form submission
        }
    });
});
