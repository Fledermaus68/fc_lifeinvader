$(document).ready(function() {
    window.addEventListener('message', function(event) {
        if (event.data.action == "open") {
            $(".main").css("display", "block");
        } else if (event.data.action == "close") {
            $(".main").css("display", "none");
        }
    });
});

$("#send").click(function() {
    $('.main').css('display', 'none');
    $.post('http://fc_lifeinvader/close', JSON.stringify({}));

    var $text = $("#text-form").val();

    $.post("http://fc_lifeinvader/", JSON.stringify({ message: $text }));
});