var ibgeDados = artoo.scrape('tr > td > a', {file: 'href'});
ibgeDados.forEach(function(el){el.url = window.location.href});
artoo.saveCsv(ibgeDados);

