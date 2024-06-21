document.addEventListener('DOMContentLoaded', function () {
    // Ensure elements exist before adding event listeners
    const closeButton = document.querySelector('#feedbackModal .close');
    const okButton = document.querySelector('#feedbackModal .ok-btn');
    const feedbackModal = document.getElementById('feedbackModal');

    if (closeButton) {
        closeButton.addEventListener('click', function () {
            console.log('Close button clicked');
            closeModal();
        });
    }

    if (okButton) {
        okButton.addEventListener('click', function () {
            console.log('OK button clicked');
            closeModal();
        });
    }

    function closeModal() {
        if (feedbackModal) {
            feedbackModal.style.display = 'none';
        }
    }
    function saveFeedbackChanges(bookingID) {
        const feedbackTextarea = document.getElementById(`feedbackText-${bookingID}`);
        const updatedFeedback = feedbackTextarea.value;
        // Send the updated feedback to the server
        fetch('/UpdateFeedbackServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({bookingID, feedback: updatedFeedback})
        })
                .then(response => {
                    if (response.ok) {
                        alert('Feedback updated successfully!');
                        closeFeedbackModal(bookingID);
                    } else {
                        alert('Failed to update the feedback. Please try again.');
                    }
                })
                .catch(error => {
                    console.error('Error updating feedback:', error);
                    alert('An error occurred while updating the feedback. Please try again later.');
                });
    }

    // Listen for outside clicks to close the modal
    window.addEventListener('click', function (event) {
        if (event.target === feedbackModal) {
            closeModal();
        }
    });
});