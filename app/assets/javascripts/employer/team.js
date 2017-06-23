$(document).ready(function(){
  $('.next-step-team').on('click', function(){
    var team_name = $('#team_name').val();
    if (team_name){
      $('#step-1').hide();
      $('#step-2').slideDown();
      $('#a_step1').removeClass('selected').addClass('done');
      $('#a_step2').removeClass('disabled').addClass('selected');
      swal({
        type: 'success',
        title: I18n.t('employer.jobs.new.step_1_sussess'),
        text: I18n.t('employer.jobs.new.step_1_sussess')
      });
    } else {
      swal({
        type: 'error',
        title: I18n.t('employer.jobs.new.step_1_danger'),
        text: I18n.t('employer.jobs.new.step_1_danger')
      });
    }
  });
});
