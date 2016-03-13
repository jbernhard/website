$(document).ready(function() {
  // play/pause videos on click
  $('.video').click(function() {
    var video = $(this).children('video').get(0);
    video.paused ? video.play() : video.pause();
  });

  // Enable interactive plotly on large screens.
  // Really, I want to check if the browser has a mouse, i.e. can click-drag,
  // hover, etc, but there is no good way to do that.  This should work except
  // on large tablets.
  if (screen.width > 800) {
    $('.plotly')
      // add play button
      .addClass('player')
      .append('<i class="fa fa-play play-button"></i>')
      // load iframe on click of static image
      .click(function() {
        var img = $(this).children("img[src*='plot.ly']");
        var aspect = img.height()/img.width();
        var src = img.attr('src').replace('.png', '.embed') +
                   '?link=false&autosize=true';
        img.remove();
        $(this)
          // fluid iframe trick
          .css('padding-bottom', (100*aspect).toString() + '%')
          .append($('<iframe>', {
            frameborder: 0,
            scrolling: 'no',
            src: src
          }));
      });
  }

  // remove play buttons on click
  // must do this after plotly stuff to match the added class
  $('.player').click(function() {
    $(this).children('.play-button').remove();
  });
});
