<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="stylesheet" href="css/comment.css">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>UI/UX Comment Section Design </title>
    </head>

    <body>
        <c:set var="account" value="${sessionScope.account}"/>
        <div class="container">
            <div class="head">
                <h1>Post a Comment</h1>
            </div>
            <div><span id="comment">0</span> Comments</div>
            <div class="comments">
                <div class="parents">
                    <!--                    <img src="images/user1.png">
                                        <div>
                                            <h1>${USERID.name}</h1>
                                            <p>${USERID.message}</p>
                                            <div class="engagements"><img src="images/like.png" id="like"><img src="images/share.png" alt=""></div>
                                            <span class="date">${USERID.date}</span>
                                        </div>-->
                </div>
            </div>
            <button id="showAll" class="show-all-btn">Show all comments</button>
            <div class="commentbox">
                <img src="images/user1.png" alt="">
                <div class="content">
                    <input type="text" value="${account.getUserName()}" class="user" readonly="true">

                    <div class="commentinput">
                        <input type="text" placeholder="Write a comment..." class="usercomment">
                        <div class="buttons">
                            <button type="submit" disabled id="publish">Publish</button>
                            <!--                        <div class="notify">
                                                        <input type="checkbox" class="notifyinput"> <span>Notify me</span>
                                                    </div>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const USERID = {
                    name: null,
                    identity: null,
                    image: null,
                    message: null,
                    date: null
                };

                const userComment = document.querySelector(".usercomment");
                const publishBtn = document.querySelector("#publish");
                const comments = document.querySelector(".comments");
                const showAllBtn = document.querySelector("#showAll");
                const userName = document.querySelector(".user");

                const initialDisplayLimit = 5; // Number of comments to display initially

                // Event listener to enable/disable the publish button and change its style
                userComment.addEventListener("input", e => {
                    if (!userComment.value) {
                        publishBtn.setAttribute("disabled", "disabled");
                        publishBtn.classList.remove("abled");
                    } else {
                        publishBtn.removeAttribute("disabled");
                        publishBtn.classList.add("abled");
                    }
                });

                function addPost() {
                    if (!userComment.value)
                        return;

                    USERID.name = userName.value;
                    USERID.image = USERID.name === "Anonymous" ? "images/anonymous.png" : "images/user2.png";
                    USERID.message = userComment.value;
                    USERID.date = new Date().toLocaleString();

                    let published = `
        <div class="parent">
            <div class="user-info" style="display: flex;">
                <img style="width:40px; height:40px"src="\${USERID.image}">
                <div class="message" style="border: 1px solid grey; border-radius: 10px; padding: 10px">
                    <h4 style="margin-top: 5px;text-align: justify;">\${USERID.name}</h4>
                    <p style=" word-break: break-all;overflow-wrap: break-word;">\${USERID.message}</p>
                </div>
            </div>
            <span class="date">\${USERID.date}</span>
        </div>
          `;

                    comments.innerHTML += published;
                    userComment.value = "";
                    publishBtn.classList.remove("abled");
                    publishBtn.setAttribute("disabled", "disabled");

                    updateCommentsDisplay();
                }

                publishBtn.addEventListener("click", addPost);

                function updateCommentsDisplay() {
                    const allComments = comments.querySelectorAll('.parent');
                    const commentsNum = allComments.length;
                    document.getElementById("comment").textContent = commentsNum;

                    // Hide comments exceeding the initial display limit
                    allComments.forEach((comment, index) => {
                        if (index >= initialDisplayLimit) {
                            comment.classList.add('hidden');
                        } else {
                            comment.classList.remove('hidden');
                        }
                    });

                    // Show or hide the "Show all comments" button based on the number of comments
                    if (commentsNum > initialDisplayLimit) {
                        showAllBtn.style.display = 'block';
                    } else {
                        showAllBtn.style.display = 'none';
                    }
                }

                showAllBtn.addEventListener('click', () => {
                    // Remove hidden class to show all comments
                    comments.querySelectorAll('.parent.hidden').forEach(comment => {
                        comment.classList.remove('hidden');
                    });

                    // Hide the "Show all comments" button after clicking
                    showAllBtn.style.display = 'none';
                });

                // Initial check for the number of comments to set up the display correctly
                updateCommentsDisplay();
            });
        </script>


    </body>

</html>