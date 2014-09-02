(function(w, d) {
    'use strict';

    var $w = $(w);
    var $d = $(d);
    var $g = $('#gotop');

    $(function() {

        $('nav a').on({
            click: function(e) {
                e.preventDefault();
                return $('body').stop().scrollTo($($(this).attr('href')), {
                    duration: 800,
                    offset: {
                        left: 0,
                        top: '180px'
                    }
                });
            }
        });
    });

    $w.scroll(function(event) {
        var scroll = $(w).scrollTop();
        // Do something
        if (scroll > 500)
            $g.show();
        else
            $g.hide();
    });

})(window, document);
