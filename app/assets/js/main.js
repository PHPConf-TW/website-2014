$(function(){


    $("#reg").on({
        click: function(e) {
            e.preventDefault();
            return window.open($(this).attr("href"), '_blank');
        }
    });
    $("nav a").on({
        click: function(e) {
            e.preventDefault();
            return $("body").stop().scrollTo($($(this).attr("href")), {
                duration: ($(document).width() > 500) ? 800 : 0,
                offset: {
                    left: 0,
                    top: -0.03 * $(window).height()
                }
            });
        }
    });
});

function toggle(name) {
    $('.' + name).toggle();
}

$(window).scroll(function (event) {
    var scroll = $(window).scrollTop();
    // Do something
    if (scroll > 500)
        $('#gotop').show();
    else
        $('#gotop').hide();
});