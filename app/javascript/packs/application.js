import "bootstrap";
import { initSlick } from '../components/slick'
import { initFilters } from '../components/filters'
import { initSearch } from '../components/search'

initSlick();

const loading = document.getElementById("bars");

const button = document.getElementById("load");

const bodytest = document.getElementsByTagName("body");

button.addEventListener("submit", (event) => {
	loading.style.display = "block";
	bodytest[0].style.opacity = "0.2";
});



$('.btn-search').click(function(){
  $('.searchbar').toggleClass('clicked');
  $('.stage').toggleClass('faded');


  if($('.searchbar').hasClass('clicked')){
    $('.btn-extended').focus();
  }

});
