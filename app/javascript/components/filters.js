$(document).ready(function() {

  /* Every time the window is scrolled ... */
  $(window).scroll( function(){

    /* Check the location of each desired element */
    $('.hideme').each( function(i){

    //   if ($(this).scrollTop()>0)
    //  {
    //     $('.checkbox-container').fadeOut();
    //  }
    // else
    //  {
    //   $('.checkbox-container').fadeIn();
    //  }

      var bottom_of_object = $(this).position().top + $(this).outerHeight();
      console.log('bottom of object', bottom_of_object);

      var bottom_of_window = $(window).scrollTop() + $(window).height() + 600;
      console.log('bottom of window', bottom_of_window);

      /* If the object is completely visible in the window, fade it in */
      if( bottom_of_window > bottom_of_object ){

        $(this).animate({'opacity':'1'},300);


      }

    });

  });

});
