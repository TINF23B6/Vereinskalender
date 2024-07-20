// set em according to window width for responsive design
var windowWidth = window.innerWidth; // initial programmed for 1280px
fontSize = windowWidth / 1280;
document.body.style.fontSize = fontSize + 'em';


function showPopup(index) {
    document.getElementById(index).style.display = 'block';

    if (index === "new-event-popup") {
        checkScrollbar(document.querySelector('.new-event-popup .popup-body'));
    } else if (index === "user-management-popup") {
        checkScrollbar(document.querySelector('.user-management-popup .popup-body'));
    }
}
function hidePopup(index) {
    document.getElementById(index).style.display = 'none';


    if (index === "login_popup") {
        document.getElementById('username-input').value = "";
        document.getElementById('password-input').value = "";
        document.getElementById('login-failed').style.display = 'none';
    }
}

var newEvent = document.getElementById("new-event");
if (newEvent) {
    document.getElementById("club-events-btn").style.backgroundColor = "#FFF";
    document.getElementById("match-btn").style.backgroundColor = "#DDD";

    document.getElementById("club-events-content").style.display = "none";
    document.getElementById("match-content").style.display = "grid";
}

document.getElementById("year_input").value = Number(document.getElementById("year_input").name);

var loginFailed = document.getElementById('login-failed');
if (loginFailed) {
    document.getElementById('login_popup').style.display = 'block';
}

var dateWarning = document.getElementById('date-warning-match');
var timeWarning = document.getElementById('time-warning-match');
if (dateWarning || timeWarning) {
    document.getElementById("new-event-popup").style.display = 'block';

    document.getElementById("club-events-btn").style.backgroundColor = "#FFF";
    document.getElementById("match-btn").style.backgroundColor = "#DDD";

    document.getElementById("club-events-content").style.display = "none";
    document.getElementById("match-content").style.display = "grid";
}

var dateWarning = document.getElementById('date-warning-club-event');
var timeWarning = document.getElementById('time-warning-club-event');
if (dateWarning || timeWarning) {
    document.getElementById("new-event-popup").style.display = 'block';

    document.getElementById("club-events-btn").style.backgroundColor = "#DDD";
    document.getElementById("match-btn").style.backgroundColor = "#FFF";

    document.getElementById("club-events-content").style.display = "grid";
    document.getElementById("match-content").style.display = "none";
}

// reset year_input when the dropdown_menu is closed
document.getElementById('date-btn').addEventListener('mouseleave', () => {
    document.getElementById("year_input").value = Number(document.getElementById("year_input").name);
});

document.getElementById("year_input").addEventListener("keydown", function (e) {
    if (e.key === 38 || e.key === 40) { // Up or Down arrow
        e.preventDefault();
        var currentValue = parseInt(this.value);
        if (!isNaN(currentValue)) {
            if (e.key === 38) { // Up arrow
                this.value = currentValue + 1;
            } else if (e.key === 40) { // Down arrow
                this.value = currentValue - 1;
            }
        }
    }
});

function addToYearInput(inputNumber) {
    var yearInput = document.getElementById("year_input").value;
    if (/^[0-9]{4}$/.test(yearInput)) {
        year = Number(yearInput) + Number(inputNumber);
        if (year > 9999) {
            year = 9999;
        } else if (year < 1000) {
            year = 1000;
        }
        document.getElementById("year_input").value = year;
    } else {
        document.getElementById("year_input").value = Number(document.getElementById("year_input").name);
    }
}

function monthBtnClick(inputLink, inputMonth) {
    var yearInput = document.getElementById("year_input").value;
    if (/^[0-9]{4}$/.test(yearInput)) {
        url = inputLink + "&day=01&month=" + inputMonth + "&year=" +
            yearInput;
        window.location.href = url;
    }
}

function yearBtnClick(inputLink) {
    var yearInput = document.getElementById("year_input").value;
    if (/^[0-9]{4}$/.test(yearInput)) {
        url = inputLink + "&day=01&month=01&year=" +
            yearInput;
        window.location.href = url;
    }
}

function showNewEventFormMatch() {
    document.getElementById("club-events-btn").style.backgroundColor = "#FFF";
    document.getElementById("match-btn").style.backgroundColor = "#DDD";

    document.getElementById("club-events-content").style.display = "none";
    document.getElementById("match-content").style.display = "grid";
}

function showNewEventFormClubEvents() {
    document.getElementById("club-events-btn").style.backgroundColor = "#DDD";
    document.getElementById("match-btn").style.backgroundColor = "#FFF";

    document.getElementById("club-events-content").style.display = "grid";
    document.getElementById("match-content").style.display = "none";
}

if (document.getElementById('new-user-form') !== null) {
    document.getElementById('new-user-form').addEventListener('submit', function (event) {
        var name = document.getElementById('new-username-input').value;
        var password = document.getElementById('new-password-input').value;
        var confirmPassword = document.getElementById('confirm-new-password-input').value;
        var errorMessage = document.getElementById('new-user-password-error-message');
        var incompleteMessage = document.getElementById('new-user-password-incomplete-message');

        if (
            name === "" || password === "" || confirmPassword === ""
        ) {
            incompleteMessage.style.display = 'block';
            event.preventDefault();
        } else {
            incompleteMessage.style.display = 'none';

            if (password !== confirmPassword) {
                errorMessage.style.display = 'block';
                event.preventDefault();
            } else {
                errorMessage.style.display = 'none';
            }
        }
    });
}

if (document.getElementById('match-content') !== null) {
    document.getElementById('match-content').addEventListener('submit', function (event) {
        var inputArray = [
            document.getElementById('new-match-name-input').value,
            document.getElementById('new-match-date-input-0').value,
            document.getElementById('new-match-date-input-1').value,
            document.getElementById('new-match-date-input-2').value,
            document.getElementById('new-match-time-period-beginn').value,
            document.getElementById('new-match-place-input').value,
            document.getElementById('new-match-type-input').value,
            document.getElementById('new-match-clubs0-input').value,
            document.getElementById('new-match-clubs1-input').value];
        var inputIncomplete = false;
        var incompleteWarning = document.getElementById('new-match-incomplete-warning');

        inputArray.forEach(input => {
            if (input === "") {
                inputIncomplete = true;
            }
        });

        if (inputIncomplete) {
            incompleteWarning.style.display = 'block';
            event.preventDefault();
        } else {
            incompleteWarning.style.display = 'none';
        }
    });
}

if (document.getElementById('club-events-content') !== null) {
    document.getElementById('club-events-content').addEventListener('submit', function (event) {
        var inputArray = [
            document.getElementById('new-club-event-name-input').value,
            document.getElementById('new-club-event-date-input-0').value,
            document.getElementById('new-club-event-date-input-1').value,
            document.getElementById('new-club-event-date-input-2').value,
            document.getElementById('new-club-event-time-period-beginn').value,
            document.getElementById('new-club-event-place-input').value,
            document.getElementById('new-club-event-type-input').value];
        var inputIncomplete = false;
        var incompleteWarning = document.getElementById('new-club-event-incomplete-warning');

        inputArray.forEach(input => {
            if (input === "") {
                inputIncomplete = true;
            }
        });

        if (inputIncomplete) {
            incompleteWarning.style.display = 'block';
            event.preventDefault();
        } else {
            incompleteWarning.style.display = 'none';
        }
    });
}

if (document.getElementById('edit-event-form') !== null) {
    document.getElementById('edit-event-form').addEventListener('submit', function (event) {
        var inputArray = [
            document.getElementById('edit-event-name').value,
            document.getElementById('edit-event-date-0').value,
            document.getElementById('edit-event-date-1').value,
            document.getElementById('edit-event-date-2').value,
            document.getElementById('edit-event-time-period-beginn').value,
            document.getElementById('edit-event-place-input').value,
            document.getElementById('edit-event-type-input').value
        ];

        if (document.getElementById('edit-event-clubs0-input') !== null) {
            inputArray.push(document.getElementById('edit-event-clubs0-input').value);
            inputArray.push(document.getElementById('edit-event-clubs1-input').value);
        }

        var inputIncomplete = false;
        var incompleteWarning = document.getElementById('edit-event-incomplete-warning');

        inputArray.forEach(input => {
            if (input === "") {
                inputIncomplete = true;
            }
        });
        if (inputIncomplete) {
            incompleteWarning.style.display = 'block';
            event.preventDefault();
        } else {
            incompleteWarning.style.display = 'none';
        }
    });
}

// make expand and contract buttons
const expandButton = document.querySelectorAll('.expand-btn');


function handleExpandContract(event) {
    buttonId = event.target.id;
    id = buttonId.replace(/^expand-btn-/, '');

    rowContent = document.getElementById('user-row-content-' + id);
    if (rowContent.style.display === 'block') {
        rowContent.style.display = 'none';
        document.getElementById(buttonId).classList.remove('contract-btn');
    } else {
        rowContent.style.display = 'block';
        document.getElementById(buttonId).classList.add('contract-btn');
    }
}

// Füge jedem Button den Event-Listener hinzu
expandButton.forEach(button => {
    button.addEventListener('click', handleExpandContract);
});


// make spacing for scrollbar
var popupBodies = document.querySelectorAll('.popup-body');

// Initial check for each popup body
popupBodies.forEach(function (popupBody) {
    checkScrollbar(popupBody);
});

// Listen for window resize event
window.addEventListener('resize', function () {
    popupBodies.forEach(function (popupBody) {
        checkScrollbar(popupBody);
    });
});

function checkScrollbar(popupBody) {
    var hasVerticalScrollbar = popupBody.scrollHeight > popupBody.clientHeight;

    if (hasVerticalScrollbar) {
        popupBody.style.paddingRight = '0.5em';
        popupBody.style.marginRight = '1em';
        popupBody.style.marginLeft = '1em';
    } else {
        popupBody.style.marginRight = '0';
        popupBody.style.marginLeft = '0';
    }
}

// user löschen nachfrage
var deleteForms = document.querySelectorAll('.delete-user-form');
deleteForms.forEach(function (form) {
    form.addEventListener('submit', function (event) {

        var submitButton = form.querySelector('.delete-user-btn');

        if (submitButton.value === "Löschen") {
            event.preventDefault();

            submitButton.value = 'Wirklich Löschen?';

            setTimeout(function () {
                submitButton.value = 'Löschen';
            }, 3000); // 3000 ms = 3 s

        }
    });
});