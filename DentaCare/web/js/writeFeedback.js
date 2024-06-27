document.addEventListener('DOMContentLoaded', function () {
    // Handle initialization for all forms on the page
    document.querySelectorAll('.overlay-content').forEach(overlayContent => {
        const overlay = overlayContent.closest('.overlay');
        const bookingID = overlay.id.split('-')[1];
        const commentForm = document.getElementById(`comment-form-${bookingID}`);
        const commentText = commentForm.querySelector('.usercomment');
        const publishBtn = commentForm.querySelector('#publish');
        const userName = commentForm.querySelector('.user').value;

        // Disable publish button initially
        publishBtn.setAttribute("disabled", "disabled");

        // Enable publish button only when there is text
        commentText.addEventListener("input", () => {
            if (commentText.value.trim() === "") {
                publishBtn.setAttribute("disabled", "disabled");
                publishBtn.classList.remove("abled");
            } else {
                publishBtn.removeAttribute("disabled");
                publishBtn.classList.add("abled");
            }
        });

        // Handle form submission
        commentForm.addEventListener('submit', function (event) {
            event.preventDefault(); // Prevent default form submission

            if (commentText.value.trim() === "") {
                alert("Comment cannot be empty!");
                return;
            }

            // Prepare the data to send
            const commentData = {
                comment: commentText.value,
                author: userName,
                feedbackDate: new Date().toISOString(),
                bookingID: bookingID // Adjust this as necessary
            };

            // Send the comment to the server using fetch
            fetch('CommentServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(commentData)
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
                            console.log("Comment saved successfully.");
                            commentText.value = "";
                            publishBtn.classList.remove("abled");
                            publishBtn.setAttribute("disabled", "disabled");

                            // Replace "Give feedback" button with "View Feedback" button
                            const feedbackBtn = document.querySelector('.btnFeedBack');
                            if (feedbackBtn) {
                                const input = document.createElement('button');
                                input.id = `viewFeedbackBtn-${bookingID}`;
                                input.textContent = 'View Feedback';
                                input.className = 'btnViewFeedBack'; // Add a class for styling and event delegation
                                feedbackBtn.parentNode.replaceChild(input, feedbackBtn);
                                // Directly bind the click event handler here
                                input.addEventListener('click', showModal.bind(null, bookingID));
                            }
                        } else {
                            alert('Failed to save the comment. Please try again.');
                        }
                    })
                    .catch(error => {
                        console.error('Error saving comment:', error);
                        alert('An error occurred while saving your comment. Please try again.');
                    });
        });

        // Attach the cancel button event
        const cancelBtn = commentForm.querySelector('.cancel-btn');
        cancelBtn.addEventListener('click', function (event) {
            event.preventDefault(); // Prevent default button behavior
            toggleFeedbackForm(bookingID); // Close the specific feedback form
        });
    });

    // Use event delegation for the dynamically created buttons
    document.body.addEventListener('click', function (event) {
        if (event.target.matches('.btnViewFeedBack')) {
            const bookingID = event.target.id.split('-')[1];
            showModal(bookingID);
        }
    });

    function toggleFeedbackForm(bookingID) {
        const overlay = document.getElementById(`feedbackOverlay-${bookingID}`);
        if (overlay) {
            overlay.style.display = (overlay.style.display === 'none' || !overlay.style.display) ? 'block' : 'none';
        }
    }

    function showModal(bookingID) {
        // Check if the modal already exists
        let modal = document.getElementById(`feedbackModal-${bookingID}`);
        if (!modal) {
            // Create the modal element
            modal = document.createElement('div');
            modal.classList.add('modal');
            modal.id = `feedbackModal-${bookingID}`;

            // Create the modal content container
            const modalContent = document.createElement('div');
            modalContent.classList.add('modal-content');

            // Create the modal header
            const modalHeader = document.createElement('div');
            modalHeader.classList.add('modal-header');
            const modalTitle = document.createElement('h2');
            modalTitle.textContent = 'Feedback ' + bookingID;
            const closeBtn = document.createElement('span');
            closeBtn.classList.add('close');
            closeBtn.textContent = '×';
            closeBtn.addEventListener('click', () => {
                modal.style.display = 'none';
            });

            // Append title and close button to header
            modalHeader.appendChild(modalTitle);
            modalHeader.appendChild(closeBtn);

            // Create the feedback list container
            const feedbackList = document.createElement('ul');
            feedbackList.id = `feedbackList-${bookingID}`;
            feedbackList.classList.add('feedback-list');

            // Fetch feedback data for the specific bookingID
            fetch(`GetFeedbackServlet?bookingID=${bookingID}`)
                    .then(response => response.json())
                    .then(data => {
                        data.forEach(feedback => {
                            // Create feedback content list items
                            const feedbackItem = document.createElement('li');
                            const feedbackItem2 = document.createElement('li');
                            const feedbackItem3 = document.createElement('li');

                            // Style the feedback items
                            feedbackItem.style.color = 'black';
                            feedbackItem.style.fontWeight = 'bold';
                            feedbackItem3.style.color = 'black';
                            feedbackItem3.style.fontStyle = 'italic';

                            // Set the content for each feedback item
                            feedbackItem.textContent = feedback.feedbackContent;

                            const dateObj = new Date(feedback.feedbackDay);
                            const customDate = `${dateObj.getDate()}-${dateObj.getMonth() + 1}-${dateObj.getFullYear()}`;
                            const hours = dateObj.getHours();
                            const minutes = dateObj.getMinutes();
                            const customTime = `${hours}:${minutes < 10 ? '0' : ''}${minutes}`;

                            feedbackItem2.textContent = `${customDate} ${customTime}`;
                            feedbackItem3.textContent = `By: ${feedback.fullName}`;

                            // Append the feedback items to the feedback list
                            feedbackList.appendChild(feedbackItem3);
                            feedbackList.appendChild(feedbackItem);
                            feedbackList.appendChild(feedbackItem2);

                            console.log('Added feedback:', feedbackItem, feedbackItem2, feedbackItem3); // Log added feedback
                        });
                    })
                    .catch(error => {
                        console.error('Error fetching feedback:', error);
                    });

            // Create the modal footer for the OK button
            const modalFooter = document.createElement('div');
            modalFooter.classList.add('modal-footer');

            const okBtn = document.createElement('button');
            okBtn.classList.add('ok-btn');
            okBtn.textContent = 'OK';
            okBtn.addEventListener('click', () => {
                modal.style.display = 'none';
            });

            // Append the OK button to the footer
            modalFooter.appendChild(okBtn);

            // Append all parts to the modal content
            modalContent.appendChild(modalHeader);
            modalContent.appendChild(feedbackList);
            modalContent.appendChild(modalFooter);

            // Append the modal content to the modal
            modal.appendChild(modalContent);

            // Append the modal to the document body
            document.body.appendChild(modal);
        }

        // Show the modal
        modal.style.display = 'block';
    }

});
