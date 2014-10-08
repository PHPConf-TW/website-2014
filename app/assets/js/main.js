/*global $:false */

(function(w, d) {
  'use strict';

  var title = document.title;
  var $w = $(w);
  var $g = $('#gotop');
  var $b = (window.opera) ?
    (document.compatMode === 'CSS1Compat' ? $('html') : $('body')) :
    $('html,body');

  $(function() {
    $g.on('click', function(e) {
      $(window).trigger('hashchange');
    });

    $w.on('hashchange', function (e) {
      var hash = window.location.hash;
      var $link = $('a[href="' + hash + '"]');
      var pageId = window.location.hash.replace('-section', '');
      var subTitle = $link.text();
      var top = $(pageId).offset().top;

      $('nav a').css('border-bottom', '0px');
      $link.css('border-bottom', '3px solid #000');

      $b.animate({
        scrollTop: top
      }, 600, function () {
        $b.scrollTop(top);
      });

      document.title = subTitle + ' | ' + title;
    }).trigger('hashchange');
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
