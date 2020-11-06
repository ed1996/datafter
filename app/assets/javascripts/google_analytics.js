document.addEventListener('turbolinks:load', function(event) {
    if (typeof gtag === 'function') {
        gtag('config', 'G-1JG82GQDQT', {
            'page_location': event.data.url
        });
    }
});