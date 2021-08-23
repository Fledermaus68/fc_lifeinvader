$(document).ready(function() {
    window.addEventListener('message', function(event) {
        if (event.data.action == "open") {
            $(".main").css("display", "block");
        } else if (event.data.action == "close") {
            $(".main").css("display", "none");
        }
    });
});

$("#close").click(function() {
    $('.main').css('display', 'none');
    $.post('http://fc_lifeinvader/close', JSON.stringify({}));
});

$("#send").click(function() {
    $('.main').css('display', 'none');
    $.post('http://fc_lifeinvader/close', JSON.stringify({}));

    var $text = $("#text-form").val();

    if ($text === "") {
        $.post("http://fc_lifeinvader/empty", JSON.stringify({}));
        return;
    }

    if (new RegExp("([a-zA-Z0-9]+://)?([a-zA-Z0-9_]+:[a-zA-Z0-9_]+@)?([a-zA-Z0-9.-]+\\.[A-Za-z]{2,4})(:[0-9]+)?(/.*)?").test($text)) {
        $.post("http://fc_lifeinvader/link", JSON.stringify({ message: $text }));
        return;
    }

    $.post("http://fc_lifeinvader/send", JSON.stringify({ message: $text }));
});

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        $('.main').css('display', 'none');
        $.post('http://fc_lifeinvader/close', JSON.stringify({}));
    }
});