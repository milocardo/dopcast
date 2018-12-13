import "bootstrap";
import { initSlick } from '../components/slick'
import { initFilters } from '../components/filters'

initSlick();

const loading = document.getElementById("bars");

const button = document.getElementById("load");

const bodytest = document.getElementsByTagName("body");

button.addEventListener("submit", (event) => {
	loading.style.display = "block";
	bodytest[0].style.opacity = "0.2";
});