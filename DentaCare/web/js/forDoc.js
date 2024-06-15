// scripts.js
document.addEventListener('DOMContentLoaded', () => {
    const sliderContainer = document.querySelector('.slider-container');
    const cards = document.querySelectorAll('.slider-card');
    let currentIndex = 0;

    // Function to calculate the number of visible cards
    function calculateVisibleCardsCount() {
        const containerWidth = sliderContainer.offsetWidth;
        const cardWidth = cards[0].offsetWidth;
        return Math.floor(containerWidth / cardWidth);
    }

    // Initialize visible cards count
    let visibleCardsCount = calculateVisibleCardsCount();

    // Update visible cards count on window resize
    window.addEventListener('resize', () => {
        visibleCardsCount = calculateVisibleCardsCount();
        updateBlurEffect(); // Update the blur effect on resize
    });

    // Function to show slides based on the current index
    function showSlides(n) {
        const cardWidth = cards[0].offsetWidth;
        const totalWidth = cardWidth * cards.length;
        const containerWidth = sliderContainer.offsetWidth;
        const maxOffset = totalWidth - containerWidth;

        // Ensure the index is within bounds
        currentIndex = Math.max(0, Math.min(n, cards.length - visibleCardsCount));
        
        // Calculate the new offset based on the index
        const offset = Math.min(maxOffset, currentIndex * cardWidth);

        // Scroll to the calculated offset
        sliderContainer.scrollTo({
            left: offset,
            behavior: 'smooth'
        });

        // Update button state and blur effect
        updateButtonState();
        updateBlurEffect();
    }

    // Function to move to the next slide
    function nextSlide() {
        if (currentIndex < cards.length - visibleCardsCount) {
            showSlides(currentIndex + 1);
        }
    }

    // Function to move to the previous slide
    function prevSlide() {
        if (currentIndex > 0) {
            showSlides(currentIndex - 1);
        }
    }

    // Function to update the state of the navigation buttons
    function updateButtonState() {
        document.querySelector('.prev').style.visibility = (currentIndex === 0) ? 'hidden' : 'visible';
        document.querySelector('.next').style.visibility = (currentIndex >= cards.length - visibleCardsCount) ? 'hidden' : 'visible';
    }

    // Function to apply blur effect to non-focused cards
    function updateBlurEffect() {
        const midIndex = Math.floor(visibleCardsCount / 2);
        cards.forEach((card, index) => {
            card.classList.remove('blur', 'focus');
            if (index !== currentIndex + midIndex) {
                card.classList.add('blur');
            } else {
                card.classList.add('focus');
            }
        });
    }

    // Add event listeners to navigation buttons
    document.querySelector('.prev').addEventListener('click', prevSlide);
    document.querySelector('.next').addEventListener('click', nextSlide);

    // Initialize button state and blur effect
    updateButtonState();
    updateBlurEffect();
});
