import "bootstrap";
import { initSlick } from '../components/slick'
import { initFilters } from '../components/filters'
import { initSearch } from '../components/search'

initSlick();

const loading = document.getElementById("bars");

const button = document.getElementById("load");

const bodytest = document.getElementsByTagName("body");

const pop = document.getElementById("teste")

// $('.btn-search').click(function(){
//   $('.searchbar').toggleClass('clicked');
//   $('.stage').toggleClass('faded');


//   if($('.searchbar').hasClass('clicked')){
//     $('.btn-extended').focus();
//   }

// });

pop.addEventListener("submit", (event) => {
    loading.parentElement.style.display = "block";
});

