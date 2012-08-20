jQuery ->
  $('.player').autocomplete
    source: $('.player').data('autocomplete-source')