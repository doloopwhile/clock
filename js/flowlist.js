$(function() {
  $('a[href^=#]').click(function(){
    var href= $(this).attr("href");
    var target = $(href);
    var offset = target.offset();
    if (offset) {
      $("html, body").animate({
        scrollTop: offset.top,
        scrollLeft: offset.left
      }, 500, "swing");
      return false;
    } else {
      return true;
    }
  });
});
