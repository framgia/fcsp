$(document).ready(function() {
  draftjob.initialize();
  showCandidateByjob();
  limitPostingTime.limitDay();
  limitPostingTime.limitTime();
});

var limitPostingTime = {
  limitDay: function() {
    var minDate = Date.today();
    var maxDate = Date.today().add(30).days();
    $('.datetimepicker').datetimepicker({
      step: 15,
      onShow: function() {
        this.setOptions({
          minDate: minDate,
          maxDate: maxDate
        });
      }
    });
  },
  limitTime: function() {
    $('.datetimepicker').on('change', function() {
      var now = moment().format(I18n.t('time.formats.format_datetime_js'));
      var time = $('.datetimepicker').val();
      if(time < now) {
        swal(I18n.t('invalid_time'));
        $('.datetimepicker').val('');
      }
    });
  }
};

function showCandidateByjob() {
  $('.show-candidates').on('click', function() {
    var job_id = this.id;
    var company_id = $('#company-id').val();
    $.ajax({
      dataType: 'html',
      url: '/employer/companies/' + company_id + '/jobs/' + job_id,
      method: 'get',
      success: function(data) {
        $('.modal-show-candidates').html(data);
        $('#show-candidates-modal').modal('show');
      },
      error: function() {
        swal('', I18n.t('employer.candidates.not_found'), 'warning');
      }
    });
  });
}

var draftjob = {
  initialize: function() {
    $('body').on('click', '.close-job', function() {
      var id = $(this).attr('id');
      draftjob.close_job(id);
    });

    $('body').on('click', '.public-job', function() {
      var id = $(this).attr('id');
      draftjob.reopen_job(id);
    });

    $('body').on('click', '.draft-job', function() {
      var id = $(this).attr('id');
      draftjob.draft_job(id);
    });

    $('body').on('click', '.delete-job', function() {
      var id = $(this).attr('id');
      var arrchecked = [];
      var job_status =  $('#job_'+ id).find('#status-job_'+ id).val();
      var params = {array_id: arrchecked};
      if (job_status != 0) {
        arrchecked.push(id);
        swal({
          title: I18n.t('employer.jobs.destroy.confirm_delete'),
          text: I18n.t('employer.jobs.destroy.mess_text'),
          type: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: I18n.t('employer.jobs.destroy.confirm_text')
        }).then(function() {
          draftjob.delete_jobs(params);
        });
      }
      else {
        swal('', I18n.t('employer.jobs.destroy.message_delete_job'), 'error');
      }
    });

    $('.button-delete-job').click(function() {
      swal({
        title: I18n.t('employer.jobs.destroy.confirm_delete'),
        text: I18n.t('employer.jobs.destroy.mess_text'),
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: I18n.t('employer.jobs.destroy.confirm_text')
      }).then(function() {
        var listcheckboxjob = $('.jobs-list').find('.checkboxjob');
        var arrchecked = [];
        var check_job_active = false;
        var params = {array_id: arrchecked};

        listcheckboxjob.each(function() {
          if ($(this).is(':checked')) {
            var id = $(this).attr('data-list-job-id');
            var job_status =  $('#job_'+ id).find('#status-job_'+ id).val();
            if (job_status != 0) {
              arrchecked.push(id);
            }
            else {
              check_job_active = true;
            }
          }
        });

        if (!check_job_active && arrchecked.length > 0) {
          draftjob.delete_jobs(params);
        }
        else {
          swal('', I18n.t('employer.jobs.destroy.message_delete_jobs'), 'error');
        }
      });
    });
  },

  close_job: function(id) {
    var public_button = '<button name="button" type="submit" id="' +
      id + '" class="public-job btn btn-success btn-xs">' +
      I18n.t('employer.jobs.job.public') + '</button>';
    var close_label = '<strong class="label label-warning">'+ I18n.t('employer.jobs.job.close') +'</strong>';
    var company_id = $('#company-id').val();

    $.ajax({
      url: '/employer/companies/' + company_id +'/jobs/'+ id,
      method: 'PUT',
      data: {job: {status: 'close'}},
      success: function(data){
        $('#job_'+ id).children('.status').find('strong').replaceWith(close_label);
        $('#job_'+ id).find('.close-job').replaceWith(public_button);
        if($('#job_'+ id).find('.draft-job').length)
          $('#job_'+ id).find('.draft-job').prop('disabled', false);
        $('#job_'+ id).find('#status-job_'+ id).val(1);
        swal({
          type: 'success',
          title: I18n.t('employer.jobs.update.success_title'),
          text: I18n.t('employer.jobs.update.change_success')
        });
      },
      error: function() {
        swal({
          type: 'error',
          title: I18n.t('employer.jobs.update.error_title'),
          text: I18n.t('employer.jobs.update.change_error')
        });
      }
    });
  },

  reopen_job: function(id) {
    var close_button = '<button name="button" type="submit" id="' +
      id + '" class="close-job btn btn-warning btn-xs">' +
      I18n.t('employer.jobs.job.close') + '</button>';
    var public_label = '<strong class="label label-info">'+ I18n.t('employer.jobs.job.active') +'</strong>';
    var company_id = $('#company-id').val();

    $.ajax({
      url: '/employer/companies/' + company_id +'/jobs/'+ id,
      method: 'PUT',
      data: {job: {status: 'active'}},
      success: function(data) {
        $('#job_'+ id).children('.status').find('strong').replaceWith(public_label);
        $('#job_'+ id).find('.public-job').replaceWith(close_button);
        if($('#job_'+ id).find('.draft-job').length)
          $('#job_'+ id).find('.draft-job').prop('disabled', false);
        $('#job_'+ id).find('#status-job_'+ id).val(0);
        swal({
          type: 'success',
          title: I18n.t('employer.jobs.update.success_title'),
          text: I18n.t('employer.jobs.update.change_success')
        });
      },
      error: function() {
        swal({
          type: 'error',
          title: I18n.t('employer.jobs.update.error_title'),
          text: I18n.t('employer.jobs.update.change_error')
        });
      }
    });
  },

  delete_jobs: function(params) {
    var company_id = $('#company-id').val();
    $.ajax({
      dataType: 'json',
      url: '/employer/companies/' + company_id + '/jobs',
      method: 'DELETE',
      data: params,
      success: function(data) {
        $('table tbody').html(data.html_job);
        $('.pagination-job').html(data.pagination_job);
        swal(I18n.t('employer.jobs.destroy.success'));
      },
      error: function() {
        swal(I18n.t('employer.jobs.destroy.fail'));
      }
    });
  },

  draft_job: function(id) {
    var draft_label = '<strong class="label label-default">'+ I18n.t('employer.jobs.job.draft') +'</strong>';
    var company_id = $('#company-id').val();
    var job_status =  $('#job_'+ id).find('#status-job_'+ id).val();

    if (job_status != 0) {
      $.ajax({
        dataType: 'json',
        url: '/employer/companies/' + company_id +'/jobs/'+ id,
        method: 'PUT',
        data: {job: {status: 'draft'}},
        success: function(data) {
          $('#job_'+ id).children('.status').find('strong').replaceWith(draft_label);
          $('#job_'+ id).find('.draft-job').prop('disabled', true);
          $('#job_'+ id).find('#status-job_'+ id).val(2);
          swal({
            type: 'success',
            title: I18n.t('employer.jobs.update.success_title'),
            text: I18n.t('employer.jobs.update.change_success')
          });
        },
        error: function() {
          swal({
            type: 'error',
            title: I18n.t('employer.jobs.update.error_title'),
            text: I18n.t('employer.jobs.update.change_error')
          });
        }
      });
    } else {
      swal({
        type: 'error',
        text: I18n.t('employer.jobs.update.draft_error')
      });
    }
  }
};

$('body').on('click', '.pagination-job .pagination .page-item a', function(e){
  e.preventDefault();
  var url_request = $(this).attr('href'),
    tbody = $('.jobs-list');
  $.ajax({
    url: url_request,
    method: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    tbody.html(data.html_job);
    $('.pagination-job').html(data.pagination_job);
    if ($('.btn-filter').hasClass('open')) {
      $('.btn-filter').removeClass('open');
    }
  });

  return false;
});
