jQuery(function() {
  return $('.player').autocomplete({
    source: $('.player').data('autocomplete-source')
  });
});


