$('.btn-search').click(function(){
  console.log("test")
  $('.searchbar').toggleClass('clicked');
  $('.stage').toggleClass('faded');


  if($('.searchbar').hasClass('clicked')){
    $('.btn-extended').focus();
  }

});
