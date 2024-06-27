const feedbackModal = document.getElementById('feedbackModal');
const feedbackList = document.getElementById('feedbackList');
const viewFeedbackBtn = document.getElementById('viewFeedbackBtn');

// Simulated feedback data (replace with your actual feedback data)
let feedbackData = [
    "Great service, very helpful!",
    "Could improve response time.",
    "Excellent product quality."
];

// Function to populate feedback list
function populateFeedbackList() {
    feedbackList.innerHTML = '';

    feedbackData.forEach(function (feedback, index) {
        const li = document.createElement('li');
        li.textContent = feedback;
        li.classList.add('feedback-item');

        // Create edit button
        const editBtn = document.createElement('button');
        editBtn.textContent = 'Edit';
        editBtn.classList.add('edit-btn');
        editBtn.addEventListener('click', function () {
            enableEditMode(li, index);
        });
        li.appendChild(editBtn);

        feedbackList.appendChild(li);
    });
}

// Function to show the modal with feedback


// Function to enable edit mode for a specific feedback item
function enableEditMode(li, index) {
    // Disable edit buttons while editing
    const editBtns = document.querySelectorAll('.edit-btn');
    editBtns.forEach(btn => {
        btn.disabled = true;
    });

    // Toggle edit mode for the selected feedback item
    li.classList.add('edit-mode');
    const originalText = li.textContent.trim();
    li.innerHTML = `
                    <textarea>${originalText}</textarea>
                    <div class="edit-buttons">
                        <button class="save-btn">Save</button>
                        <button class="cancel-btn">Cancel</button>
                    </div>
                `;

    // Add event listeners to save and cancel buttons
    const saveBtn = li.querySelector('.save-btn');
    const cancelBtn = li.querySelector('.cancel-btn');

    saveBtn.addEventListener('click', function () {
        const newText = li.querySelector('textarea').value.trim();
        feedbackData[index] = newText;
        populateFeedbackList();
        enableEditButtons();
    });

    cancelBtn.addEventListener('click', function () {
        populateFeedbackList();
        enableEditButtons();
    });
}

// Function to re-enable edit buttons after editing
function enableEditButtons() {
    const editBtns = document.querySelectorAll('.edit-btn');
    editBtns.forEach(btn => {
        btn.disabled = false;
    });
}

  