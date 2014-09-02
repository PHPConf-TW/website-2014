(function(w, d) {
    'use strict';

    var $w = $(w);
    var $d = $(d);
    var $g = $('#gotop');
    var $b = (window.opera) ?
        (document.compatMode === 'CSS1Compat' ? $('html') : $('body')) :
        $('html,body');
    var $s = $('section');
    var currentId = '#top';

    $(function() {

        $('nav a, #gotop a').on('click', function(e) {
            e.preventDefault();

            var $this = $(this);
            var pageId = $this.attr('href');
            var top = $(pageId).offset().top;

            if (currentId === pageId) {
                return false;
            }

            $b.animate({
                scrollTop: top
            }, 600, function () {
                window.location.hash = pageId;
                $b.scrollTop(top);
            });

            currentId = pageId;
        });
    });

    $w.scroll(function(event) {
        var scroll = $w.scrollTop();
        // Do something
        if (scroll > 500) {
            $g.show();
        } else {
            $g.hide();
        }
    });

})(window, document);
