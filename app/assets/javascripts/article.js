$(document).ready(function() {
  if ($('#show_time option:selected').val() === 'now'){
    $('input[name = "article[time_show]"]').addClass('hidden');
  }

  if ($('#show_time option:disabled').val() === 'now'){
    $('input[name = "article[time_show]"]').prop('disabled', true);
  }

  $('select').on('change', function() {
    if (this.value === 'now'){
      $('input[name = "article[time_show]"]').addClass('hidden');
    }
    if (this.value === 'choose_time'){
      $('input[name = "article[time_show]"]').removeClass('hidden');
    }
  });

  $('.dropdown-toggle').dropdown();

  $('.search-article').keypress(function(key){
    if (key.which === 13){
      var company_id = $('#company-id').val();
      var url_request = '/employer/companies/' + company_id + '/articles';
      var tbody = $('.list-article');
      var params = {search: $(this).val()};
      $.ajax({
        dataType: 'json',
        url: url_request,
        data: params,
        success: function(data) {
          tbody.html(data.html_article);
          $('.pagination-article').html(data.pagination_article);
          $('.btn-filter').removeClass('open');
        },
        error: function() {
          alert('error');
        },
      });
    }
  });

  $('.sort-article').click(function(){
    var typefilter = $(this).parents().eq(2).attr('data-filter');
    var sortBy = $(this).attr('data-sort-by');
    var company_id = $('#company-id').val();
    var search_title = $('.search-article').val();
    var params = {type: typefilter, sort: sortBy, search: search_title};
    var url_request = '/employer/companies/' + company_id + '/articles';
    var tbody = $('.list-article');
    $.ajax({
      dataType: 'json',
      url: url_request,
      data: params,
      success: function(data) {
        tbody.html(data.html_article);
        $('.pagination-article').html(data.pagination_article);
        $('.btn-filter').removeClass('open');
      },
    });
  });

  $('input[name="options"]').on('click', function () {
    $('#sort-item').attr('data-filter', this.value);
  });
});
