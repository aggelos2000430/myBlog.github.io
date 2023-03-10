const searchForm = document.querySelector('#search-form');
const searchBox = document.querySelector('#search-box');
const searchResults = document.querySelector('#search-results');
const postLinks = document.querySelectorAll('ul li a');

searchForm.addEventListener('submit', (event) => {
  event.preventDefault();
  searchResults.innerHTML = '';
  const searchTerm = searchBox.value.toLowerCase();

  let resultsFound = false;

  postLinks.forEach((link) => {
    const postTitle = link.querySelector('h3').textContent.toLowerCase();
    if (postTitle.includes(searchTerm)) {
      const resultItem = document.createElement('div');
      resultItem.innerHTML = link.outerHTML;
      searchResults.appendChild(resultItem);
      resultsFound = true;
    }
  });

  if (!resultsFound) {
    const noResults = document.createElement('div');
    noResults.textContent = 'No results found';
    searchResults.appendChild(noResults);
  }
});

searchResults.addEventListener('click', (event) => {
  const postLink = event.target.closest('a');
  if (postLink) {
    window.location.href = postLink.href;
  }
});
