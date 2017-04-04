$(document).ready(function() {
  candidatesByJob();
});

function candidatesByJob() {
  $('#select-job').on('change', function() {
    var selected_index = this.selectedIndex;
    var job_id = $(this).val();
    var company_id = $('#company-id').val();
    if (selected_index === 0) {
      $('.all-jobs').show();
      $('.candidate-by-job').html('');
    }
    else {
      $.ajax({
        dataType: 'html',
        url: '/employer/companies/' + company_id + '/candidates',
        method: 'get',
        data: {job_id: job_id},
        success: function(data) {
          $('.candidate-by-job').html(data);
          $('.all-jobs').hide();
        },
        error: function() {
          alert(I18n.t('employer.candidates.not_found'));
        }
      })
    }
  });
}
