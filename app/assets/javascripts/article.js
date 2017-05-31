$(document).ready(function() {
  $('.dropdown-toggle').dropdown();
  $('.search-article').keypress(function(key){
    if (key.which == 13){
      var company_id = $('#company-id').val(),
        url_request = '/employer/companies/' + company_id + '/articles';
        tbody = $('.list-article');
      var params = {search: $(this).val()};
      $.ajax({
        dataType: 'json',
        url: url_request,
        method: 'GET',
        data: params,
        success: function(data) {
          tbody.html(data.html_article);
          $('.pagination-article').html(data.pagination_article);
          if ($('.btn-filter').hasClass('open')) {
            $('.btn-filter').removeClass('open');
          }
        },
      });
    };
  });
  $('.sortAlpha').click(function(){
    var typefilter = $(this).parents().eq(2).attr('data-filter'),
      sortBy = $(this).attr('data-sort-by'),
      company_id = $('#company-id').val(),
      filter_mode = $(this).parents().eq(2).attr('data-model'),
      search_title = $('.search-article').val();
    var params = {type: typefilter, sort: sortBy, search: search_title},
      url = '';
      url_request = '/employer/companies/' + company_id + '/articles';
      tbody = $('.list-article');
    $.ajax({
      dataType: 'json',
      url: url_request,
      method: 'GET',
      data: params,
      success: function(data) {
        tbody.html(data.html_article);
        $('.pagination-article').html(data.pagination_article);
        if ($('.btn-filter').hasClass('open')) {
          $('.btn-filter').removeClass('open');
        }
      },
    });
  });
  $('input[name="options"]').on('click', function (event) {
    $('#sort-item').attr('data-filter', this.value);
  });
});
