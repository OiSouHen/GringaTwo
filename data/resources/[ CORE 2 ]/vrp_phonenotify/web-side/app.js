$(document).ready(function () {
    window.addEventListener("message", function (event) {
        var html = `
        <div class="inGroundNotify" style="display: block;">
            <div class="notify-item">${event.data.notify}</div>
        </div>`;
        $(html).appendTo("#notify").delay(5000).fadeOut(500);
    })
});