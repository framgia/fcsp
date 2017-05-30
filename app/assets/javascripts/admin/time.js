$('select').on('change', function() {
  if (this.value == 1){
    $('input[name = "article[time_show]"]').addClass('hide-time');
  }
  if (this.value == 2){
    $('input[name = "article[time_show]"]').removeClass('hide-time');
  }
})
