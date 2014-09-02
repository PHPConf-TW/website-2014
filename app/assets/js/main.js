(function(w, d) {
    'use strict';

    var $w = $(w);
    var $d = $(d);

    $(function() {


        $('#reg').on({
            click: function(e) {
                e.preventDefault();
                return window.open($(this).attr('href'), '_blank');
            }
        });
        $('nav a').on({
            click: function(e) {
                e.preventDefault();
                return $('body').stop().scrollTo($($(this).attr('href')), {
                    duration: ($(d).width() > 500) ? 800 : 0,
                    offset: {
                        left: 0,
                        top: -0.03 * $(w).height()
                    }
                });
            }
        });
    });

    $(w).scroll(function(event) {
        var scroll = $(w).scrollTop();
        // Do something
        if (scroll > 500)
            $('#gotop').show();
        else
            $('#gotop').hide();
    });

})(window, document);
