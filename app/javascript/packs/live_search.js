function debounce(func, wait) {
  let timeout;
  return function (...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), wait);
  };
}

function initLiveSearch() {
  const searchForms = document.querySelectorAll('[data-live-search-form]');

  searchForms.forEach(function (form) {
    const input = form.querySelector('[data-live-search-input]');
    const clearBtn = form.querySelector('[data-live-search-clear]');
    const resultsId = form.dataset.liveSearchResults;
    const resultsContainer = resultsId ? document.getElementById(resultsId) : null;

    if (!input || !resultsContainer) return;

    function updateClearButton() {
      if (clearBtn) {
        clearBtn.style.display = input.value.trim() ? 'flex' : 'none';
      }
    }

    function fetchResults() {
      const params = new URLSearchParams();
      const inputName = input.name || 'q';
      params.set(inputName, input.value);

      const url = form.action + '?' + params.toString();

      resultsContainer.setAttribute('data-loading', 'true');

      fetch(url, {
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Accept': 'text/html'
        },
        credentials: 'same-origin'
      })
        .then(function (response) {
          if (!response.ok) throw new Error('Network response was not ok');
          return response.text();
        })
        .then(function (html) {
          resultsContainer.removeAttribute('data-loading');
          resultsContainer.innerHTML = html;
        })
        .catch(function () {
          resultsContainer.removeAttribute('data-loading');
          resultsContainer.innerHTML =
            '<p class="search-error">Search temporarily unavailable. Please try again.</p>';
        });
    }

    const debouncedFetch = debounce(fetchResults, 300);

    input.addEventListener('input', function () {
      updateClearButton();
      debouncedFetch();
    });

    if (clearBtn) {
      clearBtn.addEventListener('click', function () {
        input.value = '';
        updateClearButton();
        fetchResults();
        input.focus();
      });
    }

    // Restore clear button visibility if field has a value on page load (e.g. back navigation)
    updateClearButton();
  });
}

// Turbolinks fires this on every navigation including initial load
document.addEventListener('turbolinks:load', initLiveSearch);
