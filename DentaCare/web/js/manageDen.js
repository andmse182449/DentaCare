document.addEventListener('DOMContentLoaded', () => {
    const viewInfoLinks = document.querySelectorAll('.view-info');
    const popup = document.getElementById('dentist-popup');
    const closeBtn = popup.querySelector('.close');
    const dentistList = document.querySelectorAll('.dentist');

    // get information
    const nameElement = document.getElementById('dentist-name');
    const specialtyElement = document.getElementById('dentist-specialty');
    const bioElement = document.getElementById('dentist-bio');
    const fullnameElement = document.getElementById('dentist-fullname');
    const dobElement = document.getElementById('dentist-dob');
    const phoneElement = document.getElementById('dentist-phone');
    const genderElement = document.getElementById('dentist-gender');
    const imageElement = document.getElementById('dentist-image');
    const emailElement = document.getElementById('dentist-email');
    const addressElement = document.getElementById('dentist-address');
    const clinicElement = document.getElementById('dentist-clinic');
    // for edit
    const editNameInput = document.getElementById('edit-name');
    const editSpecialtyInput = document.getElementById('edit-specialty');
    const editBioTextarea = document.getElementById('edit-bio');
    const editFullnameInput = document.getElementById('edit-fullname');
    const editDobInput = document.getElementById('edit-dob');
    const editPhoneInput = document.getElementById('edit-phone');
    const editID = document.getElementById('edit-id');
    const editGenderInputs = document.querySelectorAll('input[name="edit-gender"]'); // Male and Female only
    const editImageInput = document.getElementById('edit-image');
    const editClinicInput = document.getElementById('edit-clinic');
    // button
    const viewMode = document.getElementById('view-mode');
    const editMode = document.getElementById('edit-mode');

    const saveChangesButton = document.getElementById('save-changes');
    const cancelEditButton = document.getElementById('cancel-edit');
    const editInfoButton = document.getElementById('edit-info');
    const returnToViewButton = document.getElementById('return-to-view');
    const saveForm = document.getElementById('save-form');


    let currentDentist = null;

    // Ensure close button works
    if (closeBtn) {
        closeBtn.addEventListener('click', () => {
            console.log('Close button clicked');
            resetPopup();
        });
    } else {
        console.error('Close button not found');
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
        console.log('Edit button clicked');
        populateEditMode();
        viewMode.classList.add('hidden');
        editMode.classList.remove('hidden');
    });

    // Save Changes logic
    saveChangesButton.addEventListener('click', () => {
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
            console.log('Popup background clicked');
            resetPopup();
        }
    });

    function resetPopup() {
        popup.classList.add('hidden');
        viewMode.classList.remove('hidden');
        editMode.classList.add('hidden');
        currentDentist = null; // Reset the current dentist
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
            imageElement.src = currentDentist.dataset.image;
            emailElement.textContent = currentDentist.dataset.email;
            addressElement.textContent = currentDentist.dataset.address;
            clinicElement.textContent = currentDentist.dataset.clinic;
        }
    }

    function populateEditMode() {
        if (currentDentist) {
            editID.value = currentDentist.dataset.id;
           editClinicInput.value = currentDentist.dataset.name;
            editFullnameInput.value = currentDentist.dataset.fullname;
            editSpecialtyInput.value = currentDentist.dataset.specialty;
            editBioTextarea.value = currentDentist.dataset.bio;
            editDobInput.value = currentDentist.dataset.dob;
            editPhoneInput.value = currentDentist.dataset.phone;
            editImageInput.value = currentDentist.dataset.image;

            // Set the selected radio button based on the data-gender attribute
            editGenderInputs.forEach((input) => {
                input.checked = input.value === currentDentist.dataset.gender;
            });
        }
    }


    function saveChanges() {
        if (currentDentist) {
            // Collect the updated data
            const updatedData = {
                id: editID.value,
                name: editNameInput.value,
                fullname: editFullnameInput.value,
                specialty: editSpecialtyInput.value,
                bio: editBioTextarea.value,
                dob: editDobInput.value,
                phone: editPhoneInput.value,
                image: editImageInput.value,
                gender: document.querySelector('input[name="edit-gender"]:checked')?.value
            };

            // Update the dataset attributes (Optional, if you want to keep the HTML in sync)
            Object.keys(updatedData).forEach(key => {
                if (updatedData[key] !== undefined) {
                    currentDentist.dataset[key] = updatedData[key];
                }
            });

            // Update the display name in the list
            currentDentist.querySelector('h2').textContent = updatedData.name;

            // Convert the updated data to JSON
            const jsonData = JSON.stringify(updatedData);

            // Send the JSON data to the EditDentistServlet
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
                        // Handle success (e.g., update UI, show success message, etc.)
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        // Handle error (e.g., show error message, retry logic, etc.)
                    });
        }
    }
// Assuming your form ID is 'save-form' as per your initial snippet

    saveForm.addEventListener('submit', function (event) {
        event.preventDefault(); // Prevent default form submission

        if (!currentDentist) {
            console.error('No current dentist selected.');
            return;
        }

        // Prepare the data to send
        const updatedData = {
            id: editID.value,
            name: editNameInput.value,
            fullname: editFullnameInput.value,
            specialty: editSpecialtyInput.value,
            bio: editBioTextarea.value,
            dob: editDobInput.value,
            phone: editPhoneInput.value,
            image: editImageInput.value,
            gender: document.querySelector('input[name="edit-gender"]:checked')?.value
        };

        // Optional: Update the dataset attributes if needed
        Object.keys(updatedData).forEach(key => {
            if (updatedData[key] !== undefined) {
                currentDentist.dataset[key] = updatedData[key];
            }
        });

        // Update the display name in the list
        currentDentist.querySelector('h2').textContent = updatedData.name;

        // Convert the updated data to JSON
        const jsonData = JSON.stringify(updatedData);

        // Send the JSON data to the EditDentistServlet
        fetch('EditDentistServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: jsonData
        })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`Server responded with status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        // Success logic
                        console.log('Dentist information saved successfully:', data);

                        // Update UI or show success message as needed
                        updateViewMode(); // Update view mode with new data
                        viewMode.classList.remove('hidden');
                        editMode.classList.add('hidden');

                        // Optionally disable UI elements or update buttons
                    } else {
                        // Failure logic
                        console.error('Failed to save dentist information.');
                        alert('Failed to save dentist information. Please try again.');
                    }
                })
                .catch(error => {
                    console.error('Error saving dentist information:', error);
                    alert('An error occurred while saving dentist information. Please try again.');
                });
    });

});
