(function(w, d) {
    'use strict';

    var $w = $(w);
    var $d = $(d);
    var $g = $('#gotop');
    var $b = (window.opera) ?
        (document.compatMode === 'CSS1Compat' ? $('html') : $('body')) :
        $('html,body');
    var $s = $('section');

    $(function() {
        // 點選 Navigation 連結或 Go Top 按鈕時，頁面要平滑地捲動
        $('nav a, #gotop').on('click', function(e) {
            e.preventDefault();

            var $this = $(this);
            var pageId = $this.attr('href');
            var top = $(pageId).offset().top;

            $('nav a').css('border-bottom', '0px');
            $this.css('border-bottom', '3px solid #000');

            $b.animate({
                scrollTop: top
            }, 600, function () {
                $b.scrollTop(top);
            });
        });
    });

    $w.scroll(function(event) {
        var scroll = $w.scrollTop();
        // Do something
        if (scroll > 500) {
            $g.show(200);
        } else {
            $g.hide(200);
        }
    });

})(window, document);
