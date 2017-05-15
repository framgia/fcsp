$(document).ready(function() {
  $('#step-2').on('click','.create-team-jobs',function() {
    $('#new_team_introduction').submit(function(e) {
      e.preventDefault();
      var form = $('#new_team_introduction')[0];
      var formData = new FormData(form);
      $.ajax({
        url: $('#new_team_introduction').attr('action'),
        cache: false,
        type: 'POST',
        dataType: 'json',
        contentType: false,
        processData: false,
        data: formData,
        success: function(result) {
          $('.step-3-content').append(result.html_team);
          $('#step-2').hide();
          $('#step-3').show();
          $('#a_step3').removeClass('disabled');
          $('#a_step3').addClass('selected');
          $('#a_step2').removeClass('selected');
          $('#a_step2').addClass('done');
        },
        error: function(result) {
          alert(result.errors);
        }
      });
    });
  });
});
