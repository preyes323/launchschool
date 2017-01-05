var items = document.getElementById("items");

document.querySelector("#cart h3 a").addEventListener("click", function(e) {
  e.preventDefault();
  e.stopPropagation();

  items.style.display = !items.style.display || items.style.display === "none" ? "block" : "none";
});

document.addEventListener("click", function(e) {
  items.style.display = "none";
});
