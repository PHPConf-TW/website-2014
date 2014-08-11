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
                duration: 800,
                offset: {
                    left: 0,
                    top: -0.03 * $(window).height()
                }
            });
        }
    });  
});